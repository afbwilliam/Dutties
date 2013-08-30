package com.gams.examples;

import java.io.PrintStream;

import com.gams.api.GAMSJob;
import com.gams.api.GAMSWorkspace;

public class ConsoleInterrupt {

    public static void main(String[] args) {

        GAMSWorkspace ws = new GAMSWorkspace(); 
        GAMSJob job = ws.addJobFromGamsLib("lop");

        Worker w  = new Worker(job, System.out);
        w.start();

        try { 
              Thread.currentThread();
              Thread.sleep(2000); }
        catch ( Exception e ) { }        
        
        System.out.println("interrupt job: " + job.getJobName()+" : starts");
        boolean interrupt = job.interrupt();
        System.out.println("interrupt job: " + job.getJobName()+" : finished : "+interrupt);
    }

    static class Worker extends Thread {
       GAMSJob job;
       PrintStream output;
       
       public Worker(GAMSJob jb, PrintStream out) { job = jb; output = out; }

       public void run() { 
           output.println("job: " + job.getJobName()+" : is starting from: "+job.getFileName());
           try {
               job.run(output);
           } catch(Exception e) {
               output.println("job: " + job.getJobName()+" : has catched an exception!");
           }
           output.println("job: " + job.getJobName()+" : finished!");
       }
    }
}
