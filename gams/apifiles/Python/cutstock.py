from gams import *
from collections import OrderedDict
import sys

def get_master_model():
    return '''
$Title Cutting Stock - Master problem

Set  i    widths
Parameter
     w(i) width
     d(i) demand
Scalar
     r    raw width;
$gdxin csdata
$load i w d r

$if not set pmax $set pmax 1000
Set  p        possible patterns  /1*%pmax%/
     pp(p)    dynamic subset of p
Parameter
     aip(i,p) number of width i in pattern growing in p;

* Master model
Variable xp(p)     patterns used
         z         objective variable
Integer variable xp; xp.up(p) = sum(i, d(i));

Equation numpat;    numpat..    z =e= sum(pp, xp(pp));
Equation demand(i); demand(i).. sum(pp, aip(i,pp)*xp(pp)) =g= d(i);

model master /numpat, demand/;'''
    
def get_sub_model():
    return '''
$Title Cutting Stock - Pricing problem is a knapsack model

Set  i    widths
Parameter
     w(i) width;
Scalar
     r    raw width;

$gdxin csdata
$load i w r

Parameter
     demdual(i) duals of master demand constraint /#i eps/;

Variable  z, y(i) new pattern;
Integer variable y; y.up(i) = ceil(r/w(i));

Equation defobj;   defobj..   z =e= 1 - sum(i, demdual(i)*y(i));
Equation knapsack; knapsack.. sum(i, w(i)*y(i)) =l= r;
model pricing /defobj, knapsack/;'''



if __name__ == "__main__":
    if len(sys.argv) > 1:
        ws = GamsWorkspace(system_directory = sys.argv[1])
    else:
        ws = GamsWorkspace()

    opt = ws.add_options()
    cutstock_data = ws.add_database("csdata")
    opt.all_model_types = "Cplex"
    opt.opt_cr = 0.0  # Solve to optimality
    maxpattern = 35
    
    opt.defines["pmax"] = str(maxpattern)
    opt.defines["solveMasterAs"] = "RMIP"
    
    d = OrderedDict([ ("i1", 97), ("i2", 610), ("i3", 395), ("i4", 211) ])
    w = OrderedDict([ ("i1", 47), ("i2",  36), ("i3",  31), ("i4",  14) ])
    r = 100  # raw width

    widths = cutstock_data.add_set("i", 1, "widths")
    raw_width = cutstock_data.add_parameter("r", 0, "raw width")
    demand = cutstock_data.add_parameter("d", 1, "demand")
    width = cutstock_data.add_parameter("w", 1, "width")
      
    raw_width.add_record().value = 100
    for i in d:
        widths.add_record(i)
    for k,v in d.iteritems():
        demand.add_record(k).value = v
    for k,v in w.iteritems():
        width.add_record(k).value = v
            
    master_cp = ws.add_checkpoint()
    master_init_job = ws.add_job_from_string(get_master_model())
    master_init_job.run(opt, master_cp, databases=cutstock_data)
    master_job = ws.add_job_from_string("execute_load 'csdata', aip, pp; solve master min z using %solveMasterAs%;", master_cp)
    
    pattern = cutstock_data.add_set("pp", 1, "pattern index")
    pattern_data = cutstock_data.add_parameter("aip", 2, "pattern data")
    
    # Initial pattern: pattern i hold width i
    pattern_count = 0
    for k, v in w.iteritems():
        pattern_count += 1
        pattern_data.add_record((k, pattern.add_record(str(pattern_count)).keys[0])).value = (int)(r / v)

    sub_cp = ws.add_checkpoint()
    sub_job = ws.add_job_from_string(get_sub_model())
    sub_job.run(opt, sub_cp, databases=cutstock_data)
    sub_mi = sub_cp.add_modelinstance()
    
    # define modifier demdual
    demand_dual = sub_mi.sync_db.add_parameter("demdual", 1, "dual of demand from master")
    sub_mi.instantiate("pricing min z using mip", GamsModifier(demand_dual), opt)
    
    # find new pattern
    pattern_added = True
    
    while pattern_added:
        master_job.run(opt, master_cp, databases=cutstock_data)
        # Copy duals into sub_mi.sync_db DB
        demand_dual.clear()
        for dem in master_job.out_db["demand"]:
            demand_dual.add_record(dem.keys[0]).value = dem.marginal
        sub_mi.solve()
        if sub_mi.sync_db["z"][()].level < -0.00001:
            if pattern_count == maxpattern:
                print "Out of pattern. Increase maxpattern (currently " + str(maxpattern) + ")."
                pattern_added = False
            else:
                print "New pattern! Value: " + str(sub_mi.sync_db["z"][()].level)
                pattern_count += 1
                s = pattern.add_record(str(pattern_count))
                for y in sub_mi.sync_db["y"]:
                    if y.level > 0.5:
                        pattern_data.add_record((y.keys[0], s.keys[0])).value = round(y.level)

        else:
            pattern_added = False

    # solve final MIP
    opt.defines["solveMasterAs"] = "MIP"
    master_job.run(opt, databases=cutstock_data)
    print "Optimal Solution: " + str(master_job.out_db["z"][()].level)
    for xp in master_job.out_db["xp"]:
        if xp.level > 0.5:
            print "  pattern " + xp.keys[0] + " " + str(xp.level) + " times: ",
            aip = master_job.out_db["aip"].first_record((" ", xp.keys[0]))
            while True:
                print aip.keys[0] + ": " + str(aip.value),
                if not aip.move_next():
                    break
            print ""
            
    # clean up of unmanaged resources
    del cutstock_data
    del sub_mi
    del opt
    