package com.gams.examples;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import com.gams.api.GAMSGlobals;
import com.gams.api.GAMSVariable;
import com.gams.api.GAMSVariableRecord;
import com.gams.api.GAMSWorkspace;
import com.gams.api.GAMSJob;
import com.gams.api.GAMSOptions;

public class Transport2 {  
    
     public static void main(String[] args)  {
         GAMSWorkspace ws = new GAMSWorkspace(); 
         try { 
            BufferedWriter file = new BufferedWriter(new FileWriter(ws.workingDirectory() + GAMSGlobals.FILE_SEPARATOR + "tdata.gms"));
            file.write(data);
            file.close();          
         } catch(IOException e) {
             e.printStackTrace();
             System.exit(-1);
         }

         GAMSJob t2 = ws.addJobFromString(model);
         GAMSOptions opt = ws.addOptions();
         {
             opt.defines("incname", "tdata");
             t2.run(opt);
         
             GAMSVariable var = t2.OutDB().getVariable("x");        
             for (GAMSVariableRecord rec : var)
                     System.out.println("x(" + rec.getKeys()[0] + ", " + rec.getKeys()[1] + "): level=" + rec.getLevel() + " marginal=" + rec.getMarginal());
         }
     }

    // java String is immutable, cannot be changed once constructed.
    // standard java library (until jdk1.7, so far) does not support multi-line string 
    // here, data and model string are compile-time concatenated strings 
    static String data =  
                   "Sets                                                   \n" + 
                   "  i   canning plants   / seattle, san-diego /          \n" + 
                   "  j   markets          / new-york, chicago, topeka / ; \n" +
                   "Parameters                                             \n" +
                   "                                                       \n" +
                   "  a(i)  capacity of plant i in cases                   \n" +
                   "                     /    seattle     350              \n" +
                   "                          san-diego   600  /           \n" +
                   "                                                       \n" +
                   "  b(j)  demand at market j in cases                    \n" +
                   "                     /    new-york    325              \n" + 
                   "                          chicago     300              \n" +
                   "                          topeka      275  / ;         \n" +
                   "                                                       \n" +
                   "Table d(i,j)  distance in thousands of miles           \n" +
                   "               new-york       chicago      topeka      \n" +
                   "  seattle          2.5           1.7          1.8      \n" +
                   "  san-diego        2.5           1.8          1.4  ;   \n" +
                   "                                                       \n" +
                   "Scalar f  freight in dollars per case per thousand miles  /90/ \n " +
                   "                                                               \n";

    static String model = 
        "Sets                                                                    \n" +
        "      i   canning plants                                                \n" +
        "      j   markets                                                       \n" +
        "                                                                        \n" +
        "Parameters                                                              \n" +
        "      a(i)   capacity of plant i in cases                               \n" +
        "      b(j)   demand at market j in cases                                \n" +
        "      d(i,j) distance in thousands of miles                             \n" +
        "Scalar f  freight in dollars per case per thousand miles;               \n" +
        "                                                                        \n" +
        "$if not set incname $abort 'no include file name for data file provided'\n" +
        "$include %incname%                                                      \n" +
        "                                                                        \n" +
        " Parameter c(i,j)  transport cost in thousands of dollars per case ;    \n" +
        "                                                                        \n" +
        "            c(i,j) = f * d(i,j) / 1000 ;                                \n" +
        "                                                                        \n" +
        " Variables                                                              \n" +
        "       x(i,j)  shipment quantities in cases                             \n" +
        "       z       total transportation costs in thousands of dollars ;     \n" +
        "                                                                        \n" +
        " Positive Variable x ;                                                  \n" +
        "                                                                        \n" +
        " Equations                                                              \n" +
        "                                                                        \n" +
        "      cost        define objective function                             \n" +
        "      supply(i)   observe supply limit at plant i                       \n" +
        "       demand(j)   satisfy demand at market j ;                         \n" +
        "                                                                        \n" +
        "  cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;                    \n" +
        "                                                                        \n" +
        "  supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;                            \n" +
        "                                                                        \n" +
        "  demand(j) ..   sum(i, x(i,j))  =g=  b(j) ;                            \n" +
        "                                                                        \n" +
        " Model transport /all/ ;                                                \n" +
        "                                                                        \n" +
        " Solve transport using lp minimizing z ;                                \n" +
        "                                                                        \n" +
        "Display x.l, x.m ;                                                      \n" +
        "                                                                        \n";

}

