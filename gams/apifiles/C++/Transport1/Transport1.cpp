// Transport1.cpp : main project file.

#include "stdafx.h"

using namespace System;
using namespace System::IO;
using namespace GAMS;

int main(array<String ^> ^args)
{
	GAMSWorkspace^ ws;
	if (args->Length > 0) 
		ws = gcnew GAMSWorkspace(nullptr,args[0],false);
	else
		ws = gcnew GAMSWorkspace(nullptr,nullptr,false);
	
	ws->GamsLib("trnsport");
	GAMSJob^ t1 = ws->AddJobFromFile("trnsport.gms",nullptr,nullptr);

	t1->Run();
	Console::WriteLine(L"Ran with Default:");

	for each (GAMSVariableRecord^ rec in t1->OutDB->GetVariable("x"))
		Console::WriteLine("x(" + rec->Keys[0] + "," + rec->Keys[1] + "): level=" + rec->Level + " marginal=" + rec->Marginal);

	// run the job again with another solver
	{
		GAMSOptions^ opt = ws->AddOptions(nullptr);
		{
			opt->AllModelTypes = "xpress";
			t1->Run(opt);
		}
	}

	Console::WriteLine("Ran with XPRESS:");
	for each (GAMSVariableRecord^ rec in t1->OutDB->GetVariable("x"))
		Console::WriteLine("x(" + rec->Keys[0] + "," + rec->Keys[1] + "): level=" + rec->Level + " marginal=" + rec->Marginal);

	// run the job with a solver option file
	{
		StreamWriter^ optFile = gcnew StreamWriter(Path::Combine(ws->WorkingDirectory, "xpress.opt"));
		GAMSOptions^ opt = ws->AddOptions(nullptr);
		{
			optFile->WriteLine("algorithm=barrier");
			optFile->Close();
			opt->AllModelTypes = "xpress";
			opt->OptFile = 1;
			t1->Run(opt);
		}
	}

	Console::WriteLine("Ran with XPRESS with non-default option:");
	for each (GAMSVariableRecord^ rec in t1->OutDB->GetVariable("x"))
		Console::WriteLine("x(" + rec->Keys[0] + "," + rec->Keys[1] + "): level=" + rec->Level + " marginal=" + rec->Marginal);
	return 0;
}
