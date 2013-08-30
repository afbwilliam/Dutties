from gams import *
import sys

def get_data_text():
    return '''
Sets
   i factories                                   /f1*f3/
   j distribution centers                        /d1*d5/

Parameter
   capacity(i) unit capacity at factories
                 /f1 500, f2 450, f3 650/
   demand(j)   unit demand at distribution centers
                 /d1 160, d2 120, d3 270, d4 325, d5 700 /
   prodcost    unit production cost                   /14/
   price       sales price                            /24/
   wastecost   cost of removal of overstocked products /4/

Table transcost(i,j) unit transportation cost
       d1    d2    d3    d4    d5
  f1   2.49  5.21  3.76  4.85  2.07
  f2   1.46  2.54  1.83  1.86  4.76
  f3   3.26  3.08  2.60  3.76  4.45;

$ifthen not set useBig
Set
  s scenarios /lo,mid,hi/

table ScenarioData(s,*) possible outcomes for demand plus probabilities
     d1  d2  d3  d4  d5 prob
lo  150 100 250 300 600 0.25
mid 160 120 270 325 700 0.50
hi  170 135 300 350 800 0.25;
$else
$if not set nrScen $set nrScen 10
Set       s                 scenarios                        /s1*s%nrScen%/;
parameter ScenarioData(s,*) possible outcomes for demand plus probabilities;
option seed=1234;
ScenarioData(s,'prob') = 1/card(s);
ScenarioData(s,j)      = demand(j)*uniform(0.6,1.4);
$endif
'''
    
def get_master_text():
    return '''
Sets
   i factories
   j distribution centers

Parameter
   capacity(i)    unit capacity at factories
   prodcost       unit production cost
   transcost(i,j) unit transportation cost

$if not set datain $abort 'datain not set'
$gdxin %datain%
$load i j capacity prodcost transcost

* Benders master problem
$if not set maxiter $set maxiter 25
Set
   iter             max Benders iterations /1*%maxiter%/

Parameter
   cutconst(iter)   constants in optimality cuts
   cutcoeff(iter,j) coefficients in optimality cuts

Variables
   ship(i,j)        shipments
   product(i)       production
   received(j)      quantity sent to market
   zmaster          objective variable of master problem
   theta            future profit
Positive Variables ship;

Equations
   masterobj        master objective function
   production(i)    calculate production in each factory
   receive(j)       calculate quantity to be send to markets
   optcut(iter)     Benders optimality cuts;

masterobj..
    zmaster =e=  theta -sum((i,j), transcost(i,j)*ship(i,j))
                       - sum(i,prodcost*product(i));

receive(j)..       received(j) =e= sum(i, ship(i,j));

production(i)..    product(i) =e= sum(j, ship(i,j));
product.up(i) = capacity(i);

optcut(iter)..  theta =l= cutconst(iter) +
                           sum(j, cutcoeff(iter,j)*received(j));

model masterproblem /all/;

* Initialize cut to be non-binding
cutconst(iter) = 1e15;
cutcoeff(iter,j) = eps;
'''

def get_sub_text():
    return '''
Sets
   i factories
   j distribution centers

Parameter
   demand(j)   unit demand at distribution centers
   price       sales price
   wastecost   cost of removal of overstocked products
   received(j) first stage decision units received

$if not set datain $abort 'datain not set'
$gdxin %datain%
$load i j demand price wastecost

* Benders' subproblem

Variables
   sales(j)         sales (actually sold)
   waste(j)         overstocked products
   zsub             objective variable of sub problem
Positive variables sales, waste

Equations
   subobj           subproblem objective function
   selling(j)       part of received is sold
   market(j)        upperbound on sales
;

subobj..
   zsub =e= sum(j, price*sales(j)) - sum(j, wastecost*waste(j));

selling(j)..  sales(j) + waste(j) =e= received(j);

market(j)..   sales(j) =l= demand(j);

model subproblem /subobj,selling,market/;

* Initialize received
received(j) = demand(j);
'''
 

if __name__ == "__main__":
    if len(sys.argv) > 1:
        ws = GamsWorkspace(system_directory = sys.argv[1])
    else:
        ws = GamsWorkspace()

    data = ws.add_job_from_string(get_data_text())

    opt_data = ws.add_options()
    opt_data.defines["useBig"] = "1"
    opt_data.defines["nrScen"] = "100"
    data.run(opt_data)
    del opt_data
    
    scenario_data = data.out_db["ScenarioData"]
    opt = ws.add_options()
    opt.defines["datain"] = data.out_db.name
    maxiter = 40
    opt.defines["maxiter"] = str(maxiter)
    opt.all_model_types = "cplexd"
    
    cp_master = ws.add_checkpoint()
    cp_sub = ws.add_checkpoint()
    
    master = ws.add_job_from_string(get_master_text())
    master.run(opt, cp_master, databases=data.out_db)
    
    masteri = cp_master.add_modelinstance()
    cutconst = masteri.sync_db.add_parameter("cutconst", 1, "Benders optimality cut constant")
    cutcoeff = masteri.sync_db.add_parameter("cutcoeff", 2, "Benders optimality coefficients")
    theta = masteri.sync_db.add_variable("theta", 0, VarType.Free, "Future profit function variable")
    theta_fix = masteri.sync_db.add_parameter("thetaFix", 0, "")
    masteri.instantiate("masterproblem max zmaster using lp", [GamsModifier(cutconst), GamsModifier(cutcoeff), GamsModifier(theta, UpdateAction.Fixed, theta_fix)], opt)

    sub = ws.add_job_from_string(get_sub_text())
    sub.run(opt, cp_sub, databases=data.out_db)
    subi = cp_sub.add_modelinstance()
    received = subi.sync_db.add_parameter("received", 1, "units received from master")
    demand = subi.sync_db.add_parameter("demand", 1, "stochastic demand")
    subi.instantiate("subproblem max zsub using lp", [GamsModifier(received), GamsModifier(demand)], opt)

    del opt
    
    lowerbound = float('-inf')
    upperbound = float('inf')
    objmaster  = float('inf')
    iter = 1
    
    while True:
        print "Iteration: " + str(iter)
        
        # Solve master
        if 1 == iter:  # fix theta for first iteration
            theta_fix.add_record().value = 0
        else:
            theta_fix.clear()

        masteri.solve(SymbolUpdateType.BaseCase)
        print " Master " + str(masteri.model_status) + " : obj=" + str(masteri.sync_db.get_variable("zmaster").first_record().level)
        if 1 < iter:
            upperbound = masteri.sync_db.get_variable("zmaster").first_record().level
        objmaster = masteri.sync_db.get_variable("zmaster").first_record().level - theta.first_record().level

        # Set received from master
        received.clear()
        for r in masteri.sync_db["received"]:
            received.add_record(r.keys).value = r.level
            cutcoeff.add_record((str(iter), r.keys[0]))

        cutconst.add_record(str(iter))
        objsub = 0.0
        for s in data.out_db["s"]:
            demand.clear()
            for j in data.out_db["j"]:
                demand.add_record(j.keys).value = scenario_data.find_record((s.keys[0], j.keys[0])).value

            subi.solve(SymbolUpdateType.BaseCase)
            print " Sub " + str(subi.model_status) + " : obj=" + str(subi.sync_db["zsub"].first_record().level)
            
            probability = scenario_data.find_record((s.keys[0], "prob")).value
            objsub += probability * subi.sync_db["zsub"].first_record().level
            for j in data.out_db["j"]:
                cutconst.find_record(str(iter)).value += probability * subi.sync_db["market"].find_record(j.keys).marginal * demand.find_record(j.keys).value
                cutcoeff.find_record((str(iter), j.keys[0])).value += probability * subi.sync_db["selling"].find_record(j.keys).marginal
        
        lowerbound = max(lowerbound, objmaster + objsub)
        iter += 1
        if iter == maxiter + 1:
            raise Exception("Benders out of iterations")

        print " lowerbound: " + str(lowerbound) + " upperbound: " + str(upperbound) + " objmaster: " + str(objmaster)
        if not ((upperbound - lowerbound) >= 0.001 * (1 + abs(upperbound))):
            break;

    del masteri
    del subi
