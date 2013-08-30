using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using GAMS;
using System.Data.OleDb;


namespace TransportSeq
{
    class Transport3
    {
        static void Main(string[] args)
        {
            GAMSWorkspace ws;
            if (Environment.GetCommandLineArgs().Length > 1)
                ws = new GAMSWorkspace(systemDirectory: Environment.GetCommandLineArgs()[1]);
            else
                ws = new GAMSWorkspace();
            // fill GAMSDatabase by reading from Access
            GAMSDatabase db = ReadFromAccess(ws);

            // run job
            using (GAMSOptions opt = ws.AddOptions())
            {
                GAMSJob t9 = ws.AddJobFromString(GetModelText());
                opt.Defines.Add("gdxincname", db.Name);
                opt.AllModelTypes = "xpress";
                t9.Run(opt, db);
                foreach (GAMSVariableRecord rec in t9.OutDB.GetVariable("x"))
                    Console.WriteLine("x(" + rec.Keys[0] + "," + rec.Keys[1] + "): level=" + rec.Level + " marginal=" + rec.Marginal);
            }

        }

        static void ReadSet(OleDbConnection connect, GAMSDatabase db, string strAccessSelect, string setName, int setDim, string setExp = "")
        {
            try
            {
                OleDbCommand cmd = new OleDbCommand(strAccessSelect, connect);
                connect.Open();

                OleDbDataReader reader = cmd.ExecuteReader();

                if (reader.FieldCount != setDim)
                {
                    Console.WriteLine("Number of fields in select statement does not match setDim");
                    Environment.Exit(1);
                }
                
                GAMSSet i = db.AddSet(setName, setDim, setExp);

                string[] keys = new string[setDim];
                while (reader.Read())
                {
                    for (int idx = 0; idx < setDim; idx++)
                        keys[idx] = reader.GetString(idx);

                    i.AddRecord(keys);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: Failed to retrieve the required data from the DataBase.\n{0}", ex.Message);
                Environment.Exit(1);
            }
            finally
            {
                connect.Close();
            }
        }

        static void ReadParameter(OleDbConnection connect, GAMSDatabase db, string strAccessSelect, string parName, int parDim, string parExp = "")
        {
            try
            {
                OleDbCommand cmd = new OleDbCommand(strAccessSelect, connect);
                connect.Open();

                OleDbDataReader reader = cmd.ExecuteReader();

                if (reader.FieldCount != parDim+1)
                {
                    Console.WriteLine("Number of fields in select statement does not match parDim+1");
                    Environment.Exit(1);
                }

                GAMSParameter a = db.AddParameter(parName, parDim, parExp);

                string[] keys = new string[parDim];
                while (reader.Read())
                {
                    for (int idx = 0; idx < parDim; idx++)
                        keys[idx] = reader.GetString(idx);

                    a.AddRecord(keys).Value = Convert.ToDouble(reader.GetValue(parDim));
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: Failed to retrieve the required data from the DataBase.\n{0}", ex.Message);
                Environment.Exit(1);
            }
            finally
            {
                connect.Close();
            }
        }

        static GAMSDatabase ReadFromAccess(GAMSWorkspace ws)
        {

            GAMSDatabase db = ws.AddDatabase();

            // connect to database
            string strAccessConn = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=..\..\..\..\Data\transport.accdb";
            OleDbConnection connection = null;
            try
            {
                connection = new OleDbConnection(strAccessConn);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: Failed to create a database connection. \n{0}", ex.Message);
                Environment.Exit(1);
            }

            // read GAMS sets
            ReadSet(connection, db, "SELECT Plant FROM Plant", "i", 1, "canning plants");
            ReadSet(connection, db, "SELECT Market FROM Market", "j", 1, "markets");

            // read GAMS parameters
            ReadParameter(connection, db, "SELECT Plant,Capacity FROM Plant", "a", 1, "capacity of plant i in cases");
            ReadParameter(connection, db, "SELECT Market,Demand FROM Market", "b", 1, "demand at market j in cases");
            ReadParameter(connection, db, "SELECT Plant,Market,Distance FROM Distance", "d", 2, "distance in thousands of miles");

            return db;
        }


        static String GetModelText()
        {
            String model = @"
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

  Display x.l, x.m ;
";

            return model;
        }

    }
}
