from gdxcc import *
from gamsxcc import *
from optcc import *
import sys
import os


def terminate(gdxHandle, gamsxHandle, optHandle, rc):
    optFree(optHandle)
    gdxFree(gdxHandle)
    gamsxFree(gamsxHandle)
    os._exit(rc)

def reportGDXError(gdxhandle, s):
    ret = gdxErrorStr(gdxHandle, gdxGetLastError(gdxHandle))
    print "*** Error "+ s +": " + ret[1]

def writeModelData(gdxHandle, fngdxfile):
    ret, errNr = gdxOpenWrite(gdxHandle, fngdxfile, "xp_Example1")
    if errNr:
        print "*** Error gdxOpenWrite: " + gdxErrorStr(gdxHandle, errNr)[1]
        return False
    
    if not gdxDataWriteStrStart(gdxHandle, "Demand", "Demand data", 1, GMS_DT_PAR, 0):
        reportGDXError(gdxHandle, "DataWriteStrStart")
    
    values = doubleArray(GMS_VAL_MAX)
    values[GMS_VAL_LEVEL] = 324.0
    gdxDataWriteStr(gdxHandle, ["New-York"], values)
    values[GMS_VAL_LEVEL] = 299.0
    gdxDataWriteStr(gdxHandle, ["Chicago"], values)
    values[GMS_VAL_LEVEL] = 274.0
    gdxDataWriteStr(gdxHandle, ["Topeka"], values)
    
    if not gdxDataWriteDone(gdxHandle):
        reportGDXError(gdxHandle, "WriteData")
    
    errNr = gdxGetLastError(gdxHandle)
    if errNr:
        print "*** Error while writing GDX File: " + gdxErrorStr(gdxHandle, errNr)[1]
        return False
    
    errNr = gdxClose(gdxHandle)
    if errNr:
        print "*** Error gdxClose: " + gdxErrorStr(gdxHandle, errNr)[1]
        return False
    
    return True


def callGams(gamsxHandle, optHandle, sysDir):
    deffile = sysDir + "/optgams.def"
    
    if optReadDefinition(optHandle, deffile):
        print "*** Error ReadDefinition, cannot read def file:" + deffile
        return False
    
    optSetStrStr(optHandle, "SysDir",    sysDir)
    optSetStrStr(optHandle, "Input",     "../GAMS/model2.gms")
    optSetIntStr(optHandle, "LogOption", 3)    
    ret = gamsxRunExecDLL(gamsxHandle, optHandleToPtr(optHandle), sysDir, 1)
    if ret[0] != 0:
        print "*** Error RunExecDLL: Error in GAMS call = " + str(ret[1])
        return False
    
    return True

def readSolutionData(gdxHandle, fngdxfile):
    errNr = gdxOpenRead(gdxHandle, fngdxfile)[1]
    if errNr:
        print "**** Error OpenRead: " + gdxErrorStr(gdxHandle, errNr)[1]
        return False
    
    ret, varNr = gdxFindSymbol(gdxHandle, "result")
    if not ret:
        print "*** Error FindSymbol: Could not find variable result"
        return False
    
    ret, symName, dim, varType = gdxSymbolInfo(gdxHandle, varNr)
    if dim != 2 or varType != GMS_DT_VAR:
        print "**** Error SymbolInfo: result is not a a two dimensional variable"
        return False
    
    ret, nrRecs =  gdxDataReadStrStart(gdxHandle, varNr)
    if not ret:
        reportGDXError(gdxHandle, "DataReadStrStart")
        return False
    
    for i in range(nrRecs):
        ret, elements, values, afdim = gdxDataReadStr(gdxHandle)
        if not ret:
            print "**** Error gdxDataReadStr: " + gdxErrorStr(gdxHandle, ret)[1]
            return False
        if 0 == values[GMS_VAL_LEVEL]: continue
        for d in range(dim):
            print elements[d],
            if d < dim-1:
                print ".",
        print " = " + str(values[GMS_VAL_LEVEL])
    print "All solution values shown"
    gdxDataReadDone(gdxHandle)
    gdxClose(gdxHandle)

    return True


if __name__ == "__main__":
    
    numberParams = len(sys.argv)
    if numberParams != 2 :
        print "Usage:", sys.argv[0], "sysDir"
        os._exit(1)
    
    gdxHandle   = new_gdxHandle_tp()
    optHandle   = new_optHandle_tp()
    gamsxHandle = new_gamsxHandle_tp()
    
    ok = True
    sysDir = sys.argv[1]
    print sys.argv[0], "using GAMS system directory:", sys.argv[1]

    rc = gamsxCreateD(gamsxHandle, sysDir, GMS_SSSIZE)
    assert rc[0], rc[1]
    rc = gdxCreateD  (gdxHandle,   sysDir, GMS_SSSIZE)
    assert rc[0], rc[1]
    rc = optCreateD  (optHandle,   sysDir, GMS_SSSIZE)
    assert rc[0], rc[1]

    status = writeModelData(gdxHandle, "demanddata.gdx")
    if not status:
        print("Model data not written")
        terminate(gdxHandle, gamsxHandle, optHandle, 1)
    
    status = callGams(gamsxHandle, optHandle, sysDir)
    if not status:
        print("Call to GAMS failed")
        terminate(gdxHandle, gamsxHandle, optHandle, 1)

    status = readSolutionData(gdxHandle, "results.gdx")
    if not status:
        print("Could not read solution back")
    
    terminate(gdxHandle, gamsxHandle, optHandle, 0)

