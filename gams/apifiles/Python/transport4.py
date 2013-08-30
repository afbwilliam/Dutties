from gams import *
import sys

def get_model_text():
    return '''
  Sets
       i   canning plants
       j   markets

  Parameters
       a(i)   capacity of plant i in cases
       b(j)   demand at market j in cases
       d(i,j) distance in thousands of miles
  Scalar f  freight in dollars per case per thousand miles;

$if not set gdxincname $abort 'no include file name for data file provided'
$gdxin %gdxincname%
$load i j a b d f
$gdxin

  Parameter c(i,j)  transport cost in thousands of dollars per case ;

            c(i,j) = f * d(i,j) / 1000 ;

  Variables
       x(i,j)  shipment quantities in cases
       z       total transportation costs in thousands of dollars ;

  Positive Variable x ;

  Equations
       cost        define objective function
       supply(i)   observe supply limit at plant i
       demand(j)   satisfy demand at market j ;

  cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;

  supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;

  demand(j) ..   sum(i, x(i,j))  =g=  b(j) ;

  Model transport /all/ ;

  Solve transport using lp minimizing z ;

  Display x.l, x.m ; '''


if __name__ == "__main__":
    if len(sys.argv) > 1:
        ws = GamsWorkspace(system_directory = sys.argv[1])
    else:
        ws = GamsWorkspace()

    plants   = [ "Seattle", "San-Diego" ]
    markets  = [ "New-York", "Chicago", "Topeka" ]
    capacity = { "Seattle": 350.0, "San-Diego": 600.0 } 
    demand   = { "New-York": 325.0, "Chicago": 300.0, "Topeka": 275.0 }
    distance = { ("Seattle",   "New-York") : 2.5,
                 ("Seattle",   "Chicago")  : 1.7,
                 ("Seattle",   "Topeka")   : 1.8,
                 ("San-Diego", "New-York") : 2.5,
                 ("San-Diego", "Chicago")  : 1.8,
                 ("San-Diego", "Topeka")   : 1.4
               }
    
    db = ws.add_database()

    i = db.add_set("i", 1, "canning plants")
    for p in plants:
        i.add_record(p)
    
    j = GamsSet(db, "j", 1, "markets")
    for m in markets:
        j.add_record(m)
        
    a = GamsParameter(db, "a", 1, "capacity of plant i in cases")
    for p in plants:
        a.add_record(p).value = capacity[p]
    
    b = GamsParameter(db, "b", 1, "demand at market j in cases")
    for m in markets:
        b.add_record(m).value = demand[m]
    
    d = GamsParameter(db, "d", 2, "distance in thousands of miles")
    for k, v in distance.iteritems():
        d.add_record(k).value = v
    
    f = GamsParameter(db, "f", 0, "freight in dollars per case per thousand miles")
    f.add_record().value = 90
    
    t4 = GamsJob(ws, source=get_model_text())
    opt = GamsOptions(ws)
    
    opt.defines["gdxincname"] = db.name
    opt.all_model_types = "xpress"

    t4.run(opt, databases = db)
    for rec in t4.out_db["x"]:
        print "x(" + rec.keys[0] + "," + rec.keys[1] + "): level=" + str(rec.level) + " marginal=" + str(rec.marginal)
    
