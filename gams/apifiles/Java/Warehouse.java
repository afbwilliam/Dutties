package com.gams.examples;

import java.util.HashMap;
import java.util.Map;

import com.gams.api.GAMSException;
import com.gams.api.GAMSExecutionException;
import com.gams.api.GAMSGlobals;
import com.gams.api.GAMSDatabase;
import com.gams.api.GAMSJob;
import com.gams.api.GAMSOptions;
import com.gams.api.GAMSVariableRecord;
import com.gams.api.GAMSWorkspace;

public class Warehouse {

    static int numberOfThreads = 16;
    static int status = 0;
    
    public static void main(String[] args) {

        GAMSWorkspace ws = new GAMSWorkspace();
        
        // create a GAMSDatabase for the results
        GAMSDatabase resultDB = ws.addDatabase();
        resultDB.addParameter("objrep",1,"Objective value");
        resultDB.addSet("supplyMap",3,"Supply connection with level");

        try {
            // run multiple parallel jobs
            Object dbLock = new Object();
            Map<String, WarehouseThread> warehousesMap = new HashMap<String, WarehouseThread>();
            for (int i=10; i<=numberOfThreads; i++) { 
                 WarehouseThread wh = new WarehouseThread(ws, i, resultDB, dbLock);
                 warehousesMap.put(Integer.toString(i), wh);
                 wh.start();
            }
        
            // join all threads
            for (WarehouseThread wh : warehousesMap.values()) {  
                 try {
                     wh.join();
                 } catch (InterruptedException e) {
                    e.printStackTrace();
                 }
            }
        
            // export the result database to a GDX file
            resultDB.export(ws.workingDirectory() + GAMSGlobals.FILE_SEPARATOR + "result.gdx");
        } catch (Exception e) {
             e.printStackTrace();
        } finally {
             resultDB.dispose();
        }
        
        System.exit(status);
    }
    
    public static void notifyException(GAMSException e) {
        if (e instanceof GAMSExecutionException) 
            status = ((GAMSExecutionException)e).getExitCode();
        else 
            status = -1;
    }
    
    static class WarehouseThread extends Thread {
        GAMSWorkspace workspace;
        GAMSDatabase result;
        Object lockObject;
        int numberOfWarehouses;
   
        public WarehouseThread(GAMSWorkspace ws, int number, GAMSDatabase db, Object lockObj) {
              workspace = ws;
              numberOfWarehouses = number;
              result = db;
              lockObject = lockObj;
        }
  
        public void run() {
            try {
               // instantiate GAMSOptions and define some scalars
               GAMSOptions opt = workspace.addOptions();
               opt.setAllModelTypes( "Gurobi" );
               opt.defines("Warehouse", Integer.toString(numberOfWarehouses));
               opt.defines("Store", "65");
               opt.defines("fixed", "22");
               opt.defines("disaggregate", "0");
               opt.setOptCR( 0.0 ); // Solve to optimality

               // create a GAMSJob from string and write results to the result database
               GAMSJob job = workspace.addJobFromString(model);
               job.run(opt, System.out);   // job.run(opt);

               // need to lock database write operations
               synchronized (lockObject) {
                   result.getParameter("objrep").addRecord(Integer.toString(numberOfWarehouses)).setValue( job.OutDB().getVariable("obj").findRecord().getLevel() );
               }   
                
               for (GAMSVariableRecord supplyRec : job.OutDB().getVariable("supply")) {
                 if (supplyRec.getLevel() > 0.5)
                    synchronized (lockObject) {
                         String[] keys = new String[] { Integer.toString(numberOfWarehouses), supplyRec.getKeys()[0], supplyRec.getKeys()[1] };
                         result.getSet("supplyMap").addRecord( keys );
                    }
              }
            } catch (GAMSException e) {
                e.printStackTrace();
                Warehouse.notifyException(e) ;
            }
        }
    }
    
    static String model =  
            "$title Warehouse.gms                                                      \n" +
            "                                                                          \n" +
            "$eolcom //                                                                \n" +
            "$SetDDList warehouse store fixed disaggregate // acceptable defines       \n" +
            "$if not set warehouse    $set warehouse   10                              \n" +
            "$if not set store        $set store       50                              \n" +  
            "$if not set fixed        $set fixed       20                              \n" +
            "$if not set disaggregate $set disaggregate 1 // indicator for tighter bigM constraint \n" +
            "$ife %store%<=%warehouse% $abort Increase number of stores (>%warehouse)  \n" +
            "                                                                          \n" +
            "Sets Warehouse  /w1*w%warehouse% /                                        \n" +  
            "     Store      /s1*s%store%     /                                        \n" +
            "Alias (Warehouse,w), (Store,s);                                           \n" +
            "Scalar                                                                    \n" +
            "     fixed        fixed cost for opening a warehouse / %fixed% /          \n" +
            "Parameter                                                                 \n" +
            "     capacity(WareHouse)                                                  \n" +
            "     supplyCost(Store,Warehouse);                                         \n" +
            "                                                                          \n" +
            "$eval storeDIVwarehouse trunc(card(store)/card(warehouse))                \n" + 
            "capacity(w)     =   %storeDIVwarehouse% + mod(ord(w),%storeDIVwarehouse%);\n" +
            "supplyCost(s,w) = 1+mod(ord(s)+10*ord(w), 100);                           \n" +
            "                                                                          \n" +
            "Variables                                                                 \n" +
            "    open(Warehouse)                                                       \n" +      
            "    supply(Store,Warehouse)                                               \n" +
            "    obj;                                                                  \n" +    
            "Binary variables open, supply;                                            \n" +
            "                                                                          \n" +
            "Equations                                                                 \n" +
            "    defobj                                                                \n" +  
            "    oneWarehouse(s)                                                       \n" +
            "    defopen(w);                                                           \n" +   
            "                                                                          \n" +
            "defobj..  obj =e= sum(w, fixed*open(w)) + sum((w,s), supplyCost(s,w)*supply(s,w));  \n" +
            "                                                                          \n" +
            "oneWarehouse(s).. sum(w, supply(s,w)) =e= 1;                              \n" +
            "                                                                          \n" +
            "defopen(w)..      sum(s, supply(s,w)) =l= open(w)*capacity(w);            \n" +
            "                                                                          \n" +
            "$ifthen %disaggregate%==1                                                 \n" +   
            "Equations                                                                 \n" +  
            "     defopen2(s,w);                                                       \n" +
            "defopen2(s,w).. supply(s,w) =l= open(w);                                  \n" +  
            "$endif                                                                    \n" +
            "                                                                          \n" +
            "model distrib /all/;                                                      \n" +
            "solve distrib min obj using mip;                                          \n" + 
            "abort$(distrib.solvestat<>%SolveStat.NormalCompletion% or                 \n" +   
            "       distrib.modelstat<>%ModelStat.Optimal% and                         \n" +
            "       distrib.modelstat<>%ModelStat.IntegerSolution%) 'No solution!';    \n" +
            "                                                                          \n";
}
