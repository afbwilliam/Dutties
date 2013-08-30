// Transport8.cpp : main project file.

#include "stdafx.h"
#include "Lock.h"
#include <cliext/queue>

using namespace System;
using namespace System::Collections::Generic;
using namespace System::Text;
using namespace System::IO;
using namespace GAMS;

static String^ GetModelText()
{
	String^ model = "\n"+
		"Sets\n"+
		"     i   canning plants   / seattle, san-diego /\n"+
		"     j   markets          / new-york, chicago, topeka / ;\n"+
		"\n"+
		"Parameters\n"+
		"\n"+
		"     a(i)  capacity of plant i in cases\n"+
		"       /    seattle     350\n"+
		"            san-diego   600  /\n"+
		"\n"+
		"     b(j)  demand at market j in cases\n"+
		"       /    new-york    325\n"+
		"            chicago     300\n"+
		"            topeka      275  / ;\n"+
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
		"Model transport /all/ ;";
	return model;
}

ref class RefClass
{
	GAMSWorkspace^ ws; 
	GAMSCheckpoint^ cp;
	Object^ queueMutex;
	Object^ ioMutex;
	typedef cliext::queue<double>  DQUEUE;
	DQUEUE bmultQueue;
public:
	RefClass(array<String^>^ args)
	{
		if (args->Length > 0) 
			ws = gcnew GAMSWorkspace(nullptr,args[0],false);
		else
			ws = gcnew GAMSWorkspace(nullptr,nullptr,false);
	
		cp = ws->AddCheckpoint(nullptr);
		queueMutex = gcnew Object();
		ioMutex    = gcnew Object();

		// initialize a GAMSCheckpoint by running a GAMSJob
		ws->AddJobFromString(GetModelText(),nullptr,nullptr)->Run(cp);
		double barray [] = { 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3 };
		//DQUEUE bmultQueue asignment array;
		for (int i=0; i<8; i++)
		{
			bmultQueue.push(barray[i]);
		}
		// solve multiple model instances in parallel
		System::Threading::Tasks::Parallel::For(0, 2, gcnew Action<int> (this, &RefClass::ScenSolve));
	}

	void ScenSolve(int i)
	{
		GAMSModelInstance^ mi = cp->AddModelInstance(nullptr);
		GAMSParameter^ bmult = mi->SyncDB->AddParameter("bmult", 0, "demand multiplier");
		GAMSOptions^ opt = ws->AddOptions(nullptr);
		opt->AllModelTypes = "cplexd";
		// instantiate the GAMSModelInstance and pass a model definition and GAMSModifier to declare bmult mutable
		mi->Instantiate("transport us lp min z", opt, gcnew GAMSModifier(bmult));

		bmult->AddRecord()->Value = 1.0;
		while (true)
		{
			double b;
			// dynamically get a bmult value from the queue instead of passing it to the different threads at creation time
			Lock xlock(queueMutex);
			{
				if(0 == bmultQueue.size())
					return;
				b = bmultQueue.front();
				bmultQueue.pop();
			}
			bmult->FirstRecord()->Value = b;
			mi->Solve(mi->SymbolUpdateType::BaseCase,nullptr,nullptr);
			// we need to make the ouput a critical section to avoid messed up report informations
			Lock lock(ioMutex);
			{
				Console::WriteLine("Scenario bmult=" + b + ":");
				Console::WriteLine("  Modelstatus: {0}", mi->ModelStatus);
				Console::WriteLine("  Solvestatus: {0}", mi->SolveStatus);
				Console::WriteLine("  Obj: " + mi->SyncDB->GetVariable("z")->FindRecord()->Level);
			}
		}
	}
};

int main(array<String ^> ^args)
{
	RefClass^ x = gcnew RefClass(args);
	return 0;
}
