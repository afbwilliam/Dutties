from gams import *
import sys
import pyodbc

def get_model_text():
    return '''
  Sets
       i   canning plants
       j   markets

  Parameters
       a(i)   capacity of plant i in cases
       b(j)   demand at market j in cases
       d(i,j) distance in thousands of miles
  Scalar f  freight in dollars per case per thousand miles /90/;

$if not set gdxincname $abort 'no include file name for data file provided'
$gdxin %gdxincname%
$load i j a b d
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


def read_set(connection, db, query_string, set_name, set_dim, set_exp=""):
    try:
        cursor = connection.cursor()
        cursor.execute(query_string)
        data = cursor.fetchall()

        if len(data[0]) != set_dim:
            print "Number of fields in select statement does not match setDim"
            sys.exit(1)
        
        i = db.add_set(set_name, set_dim, set_exp)
        
        for row in data:
            keys = []
            for key in row:
                keys.append(str(key))
            i.add_record(keys)

    except Exception as ex:
        print "Error: Failed to retrieve the required data from the DataBase.\n{0}".format(ex)
        sys.exit(1)
    finally:
        cursor.close()
        

def read_parameter(connection, db, query_string, par_name, par_dim, par_exp=""):
    try:
        cursor = connection.cursor()
        cursor.execute(query_string)
        data = cursor.fetchall()
        
        if len(data[0]) != par_dim+1:
            print "Number of fields in select statement does not match par_dim+1"
            sys.exit(1)
        
        a = db.add_parameter(par_name, par_dim, par_exp)
        
        for row in data:
            keys = []
            for idx in range(len(row)-1):
                keys.append(str(row[idx]))
            a.add_record(keys).value = row[par_dim]
            
    except Exception as ex:
        print "Error: Failed to retrieve the required data from the DataBase.\n{0}".format(ex)
        sys.exit(1)
    finally:
        cursor.close()


def read_from_access(ws):
    db = ws.add_database()

    # connect to database
    str_access_conn = 'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=..\\Data\\transport.accdb'
    
    try:
        connection = pyodbc.connect(str_access_conn)
    except Exception as ex:
        print "Error: Failed to create a database connection. \n{0}".format(ex)
        sys.exit(1)

    # read GAMS sets
    read_set(connection, db, "SELECT Plant FROM plant", "i", 1, "canning plants")
    read_set(connection, db, "SELECT Market FROM Market", "j", 1, "markets")

    # read GAMS parameters
    read_parameter(connection, db, "SELECT Plant,Capacity FROM Plant", "a", 1, "capacity of plant i in cases")
    read_parameter(connection, db, "SELECT Market,Demand FROM Market", "b", 1, "demand at market j in cases")
    read_parameter(connection, db, "SELECT Plant,Market,Distance FROM Distance", "d", 2, "distance in thousands of miles")
    
    connection.close()
    return db
  
if __name__ == "__main__":
    if len(sys.argv) > 1:
        ws = GamsWorkspace(system_directory = sys.argv[1])
    else:
        ws = GamsWorkspace()

    # fill GAMSDatabase by reading from Access
    db = read_from_access(ws)

    # run job
    t9 = ws.add_job_from_string(get_model_text())
    opt = ws.add_options()
    opt.defines["gdxincname"] =  db.name
    opt.all_model_types = "xpress"
    t9.run(opt, databases=db)
    for rec in t9.out_db["x"]:
        print "x(" + rec.keys[0] + "," + rec.keys[1] + "): level=" + str(rec.level) + " marginal=" + str(rec.marginal)   

