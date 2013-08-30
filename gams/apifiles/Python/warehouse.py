from gams import *
import threading
import sys
import os

def get_model_text():
    return '''
$title Warehouse.gms

$eolcom //
$SetDDList warehouse store fixed disaggregate // acceptable defines
$if not set warehouse    $set warehouse   10
$if not set store        $set store       50
$if not set fixed        $set fixed       20
$if not set disaggregate $set disaggregate 1 // indicator for tighter bigM constraint
$ife %store%<=%warehouse% $abort Increase number of stores (>%warehouse)

Sets Warehouse  /w1*w%warehouse% /
     Store      /s1*s%store%     /
Alias (Warehouse,w), (Store,s);
Scalar
     fixed        fixed cost for opening a warehouse / %fixed% /
Parameter
     capacity(WareHouse)
     supplyCost(Store,Warehouse);

$eval storeDIVwarehouse trunc(card(store)/card(warehouse))
capacity(w)     =   %storeDIVwarehouse% + mod(ord(w),%storeDIVwarehouse%);
supplyCost(s,w) = 1+mod(ord(s)+10*ord(w), 100);

Variables
    open(Warehouse)
    supply(Store,Warehouse)
    obj;
Binary variables open, supply;

Equations
    defobj
    oneWarehouse(s)
    defopen(w);

defobj..  obj =e= sum(w, fixed*open(w)) + sum((w,s), supplyCost(s,w)*supply(s,w));

oneWarehouse(s).. sum(w, supply(s,w)) =e= 1;

defopen(w)..      sum(s, supply(s,w)) =l= open(w)*capacity(w);

$ifthen %disaggregate%==1
Equations
     defopen2(s,w);
defopen2(s,w).. supply(s,w) =l= open(w);
$endif

model distrib /all/;
solve distrib min obj using mip;
abort$(distrib.solvestat<>%SolveStat.NormalCompletion% or
       distrib.modelstat<>%ModelStat.Optimal% and
       distrib.modelstat<>%ModelStat.IntegerSolution%) 'No solution!'; '''


def solve_warehouse(workspace, number_of_warehouses, result, db_lock):
    try:
        # instantiate GAMSOptions and define some scalars
        opt = workspace.add_options()
        opt.all_model_types = "Gurobi"
        opt.defines["Warehouse"] = str(number_of_warehouses)
        opt.defines["Store"] = "65"
        opt.defines["fixed"] = "22"
        opt.defines["disaggregate"] = "0"
        opt.opt_cr = 0.0 # Solve to optimality

        # create a GAMSJob from string and write results to the result database
        job = workspace.add_job_from_string(get_model_text())
        job.run(opt)

        # need to lock database write operations
        db_lock.acquire()
        result["objrep"].add_record(str(number_of_warehouses)).value = job.out_db["obj"][()].level
        db_lock.release()
        for supply_rec in job.out_db["supply"]:
            if supply_rec.level > 0.5:
                db_lock.acquire()
                result["supplyMap"].add_record((str(number_of_warehouses), supply_rec.keys[0], supply_rec.keys[1]))
                db_lock.release()
    except GamsException as e:
        print "GamsException occured: " + str(e)
        os._exit(1)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        ws = GamsWorkspace(system_directory = sys.argv[1])
    else:
        ws = GamsWorkspace()
    
    # create a GAMSDatabase for the results
    result_db = ws.add_database()
    result_db.add_parameter("objrep" ,1 ,"Objective value")
    result_db.add_set("supplyMap" ,3 ,"Supply connection with level")
    
    try:
        # run multiple parallel jobs
        db_lock = threading.Lock()
        threads = {}
        for i in range(10,22):
            threads[i] = threading.Thread(target=solve_warehouse, args=(ws, i, result_db, db_lock))
            threads[i].start()
        for t in threads.values():
            t.join()
        
        # export the result database to a GDX file
        result_db.export("/tmp/result.gdx")
    
    except GamsException as e:
        print "GamsException occured: " , e
    except Exception as e:
        print e

 


