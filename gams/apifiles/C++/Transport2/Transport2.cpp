// Transport2.cpp : main project file.

#include "stdafx.h"
#include <iostream>

using namespace System;
using namespace System::IO;
using namespace GAMS;


static System::String^ GetDataText()
{
	System::String^ data ="Sets\n"+
		"    i   canning plants   / seattle, san-diego /\n"+
		"    j   markets          / new-york, chicago, topeka /;\n"+
		"\nParameters \n \n"+
		"    a(i)  capacity of plant i in cases\n    /   seattle     350\n        san-diego   600  /\n\n"+
		"    b(j)  demand at market j in cases\n    /   new-york    325\n        chicago     300\n        topeka      275  /;\n\n"+
		"Table d(i,j)  distance in thousands of miles \n"+
		"                new-york       chicago       topeka\n"+
		"    seattle          2.5           1.7          1.8\n"+
		"    san-diego        2.5           1.8          1.4 ;\n\n"+
		"Scalar f  freight in dollars per case per thousand miles  /90/;\n";
	return data;
}

static System::String^ GetModelText()
{
	System::String^ model ="Sets \n"+
		"    i   canning plants \n"+
		"    j   markets \n"+
		"\n"+
		"Parameters \n"+
		"    a(i)   capacity of plant i in cases \n"+
		"    b(j)   demand at market j in cases \n"+
		"    d(i,j) distance in thousands of miles \n"+
		"    Scalar f  freight in dollars per case per thousand miles; \n"+
		"\n"+
		"$if not set incname $abort 'no include file name for data file provided'\n"+
		"$include %incname% \n"+
		"\n"+
		"Parameter c(i,j)  transport cost in thousands of dollars per case ; \n"+
		"\n"+
		"    c(i,j) = f * d(i,j) / 1000 ; \n"+
		"\n"+
		"Variables \n"+
		"    x(i,j)  shipment quantities in cases \n"+
		"    z       total transportation costs in thousands of dollars ; \n"+
		"\n"+
		"Positive Variable x ; \n"+
		"\n"+
		"Equations \n"+
		"    cost        define objective function \n"+
		"    supply(i)   observe supply limit at plant i \n"+
		"    demand(j)   satisfy demand at market j ; \n"+
		"\n"+
		"cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ; \n"+
		"\n"+
		"supply(i) ..   sum(j, x(i,j))  =l=  a(i) ; \n"+
		"\n"+
		"demand(j) ..   sum(i, x(i,j))  =g=  b(j) ; \n"+
		"\n"+
		"Model transport /all/ ; \n"+
		"\n"+
		"Solve transport using lp minimizing z ; \n"+
		"\n"+
		"Display x.l, x.m ;\n";

	return model;
}



int main(array<String ^> ^args)
{
	GAMSWorkspace^ ws;
	if (args->Length > 0) 
		ws = gcnew GAMSWorkspace(nullptr,args[0],false);
	else
		ws = gcnew GAMSWorkspace(nullptr,nullptr,false);

	// write an include file containing data with GAMS syntax
	{
		StreamWriter^ writer = gcnew StreamWriter(ws->WorkingDirectory + Path::DirectorySeparatorChar + "tdata.gms");
		{
			writer->Write(GetDataText());
			writer->Close();
		}
	}
	// run a job using an instance of GAMSOptions that defines the data include file
	{
		GAMSOptions^ opt = ws->AddOptions(nullptr);
		{
			GAMSJob^ t2 = ws->AddJobFromString(GetModelText(),nullptr,nullptr);
			opt->Defines->Add("incname", "tdata");
			t2->Run(opt);
			for each (GAMSVariableRecord^ rec in t2->OutDB->GetVariable("x"))
				Console::WriteLine("x(" + rec->Keys[0] + "," + rec->Keys[1] + "): level=" + rec->Level + " marginal=" + rec->Marginal);
		}
	}
	return 0;
}

