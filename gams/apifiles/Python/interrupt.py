from gams import *
import sys
import threading
import time

def interrupt_gams(job):
    time.sleep(2)
    job.interrupt()

if __name__ == "__main__":
    ws = GamsWorkspace()

    # Use a MIP that needs some time to solve
    ws.gamslib("lop")
    job = ws.add_job_from_file("lop.gms")

    # start thread asynchronously that interrupts the GamsJob after 2 seconds
    threading.Thread(target=interrupt_gams, args=(job,)).start()

    # start GamsJob
    job.run(output=sys.stdout)
