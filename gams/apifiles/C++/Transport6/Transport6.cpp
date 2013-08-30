// Transport6.cpp : main project file.

#include "stdafx.h"
#include "Lock.h"

using namespace System;
using namespace System::Collections::Generic;
using namespace System::Text;
using namespace System::IO;
using namespace GAMS;


static System::String^ GetModelText()
{
	String^ model ="\n"+
		"Sets\n"+
		"    i   canning plants   / seattle, san-diego /\n"+
		"    j   markets          / new-york, chicago, topeka / ;\n"+
		"\n"+
		"Parameters\n"+
		"\n"+
		"    a(i)  capacity of plant i in cases\n"+
		"      /    seattle     350\n"+
		"           san-diego   600  /\n"+
		"\n"+
		"    b(j)  demand at market j in cases\n"+
		"      /    new-york    325\n"+
		"           chicago     300\n"+
		"           topeka      275  / ;\n"+
		"\n"+
		"Table d(i,j)  distance in thousands of miles\n"+
		"                  new-york       chicago      topeka\n"+
		"    seattle          2.5           1.7          1.8\n"+
		"    san-diego        2.5           1.8          1.4  ;\n"+
		"\n"+
		"Scalar f      freight in dollars per case per thousand miles  /90/ ;\n"+
		"Scalar bmult  demand multiplier /1/;\n"+
		"\n"+
		"Parameter c(i,j)  transport cost in thousands of dollars per case ;\n"+
		"\n"+
		"          c(i,j) = f * d(i,j) / 1000 ;\n"+
		"\n"+
		"Variables\n"+
		"     x(i,j)  shipment quantities in cases\n"+
		"     z       total transportation costs in thousands of dollars ;\n"+
		"\n"+
		"Positive Variable x ;\n"+
		"\n"+
		"Equations\n"+
		"     cost        define objective function\n"+
		"     supply(i)   observe supply limit at plant i\n"+
		"     demand(j)   satisfy demand at market j ;\n"+
		"\n"+
		"cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;\n"+
		"\n"+
		"supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;\n"+
		"\n"+
		"demand(j) ..   sum(i, x(i,j))  =g=  bmult*b(j) ;\n"+
		"\n"+
		"Model transport /all/ ;\n"+
		"Scalar ms 'model status', ss 'solve status';";

	return model;
}

ref class RefClass
{
	GAMSWorkspace^ ws;
	GAMSCheckpoint^ cp;
	Object^ ioMutex;
public: 
	RefClass(array<String^>^args)
	{
			
		if (args->Length > 0) 
			ws = gcnew GAMSWorkspace(nullptr,args[0],false);
		else
			ws = gcnew GAMSWorkspace(nullptr,nullptr,false);

		cp = ws->AddCheckpoint(nullptr);
		ioMutex = gcnew Object();

		// initialize a GAMSCheckpoint by running a GAMSJob
		ws->AddJobFromString(GetModelText(),nullptr,nullptr)->Run(cp);

		// run multiple parallel jobs using the created GAMSCheckpoint
		System::Threading::Tasks::Parallel::For(0, 8, gcnew Action<int> (this, &RefClass::RunScenario));
	}

	~RefClass(){
	}

	void RunScenario(int i)
	{
		static double bmultlist []= { 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3 };
		GAMSJob^ t6 = ws->AddJobFromString("bmult=" + bmultlist[i] + "; solve transport min z us lp; ms=transport.modelstat; ss=transport.solvestat;", cp,nullptr);
		t6->Run();
		// we need to make the ouput a critical section to avoid messed up report information
		Lock xlock(ioMutex);
		{
			Console::WriteLine("Scenario bmult=" + bmultlist[i] + ":");
			Console::WriteLine("  Modelstatus: " + t6->OutDB->GetParameter("ms")->FindRecord()->Value);
			Console::WriteLine("  Solvestatus: " + t6->OutDB->GetParameter("ss")->FindRecord()->Value);
			Console::WriteLine("  Obj: " + t6->OutDB->GetVariable("z")->FindRecord()->Level);
		}
	}
};


int main(array<String^>^  args)
{
	RefClass^ x = gcnew RefClass(args);
	return 0;
}