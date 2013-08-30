from gams import *
import os
import sys

if __name__ == "__main__":
    if len(sys.argv) > 1:
        ws = GamsWorkspace(system_directory = sys.argv[1])
    else:
        ws = GamsWorkspace()

    ws.gamslib("trnsport")
    
    t1 = ws.add_job_from_file("trnsport.gms")
    t1.run()
    print "Ran with Default:"

    for rec in t1.out_db["x"]:
        print "x(" + rec.keys[0] + "," + rec.keys[1] + "): level=" + str(rec.level) + " marginal=" + str(rec.marginal)
    
    opt = ws.add_options()
    opt.all_model_types = "xpress"
    t1.run(opt)
    
    print "Ran with XPRESS:"
    for rec in t1.out_db["x"]:
        print "x(" + rec.keys[0] + "," + rec.keys[1] + "): level=" + str(rec.level) + " marginal=" + str(rec.marginal)
       
    file = open(os.path.join(ws.working_directory, "xpress.opt"), "w")
    file.write("algorithm=barrier")
    file.close()
    
    opt.opt_file = 1
    t1.run(opt)
    
    print "Ran with XPRESS with non-default option:"
    for rec in t1.out_db["x"]:
        print "x(" + rec.keys[0] + "," + rec.keys[1] + "): level=" + str(rec.level) + " marginal=" + str(rec.marginal)
