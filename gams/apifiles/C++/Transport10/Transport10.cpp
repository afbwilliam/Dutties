// Transport10.cpp : main project file.

#include "stdafx.h"


using namespace System;
using namespace System::Collections::Generic;
using namespace System::Text;
using namespace System::Linq;
using namespace System::IO;
using namespace GAMS;
using namespace System::Diagnostics;
using namespace Microsoft::Office::Interop::Excel;
#define Excel   Microsoft::Office::Interop::Excel



static String^ GetModelText()
{
	String^ model ="\n"+
		"  Sets\n"+
		"       i   canning plants\n"+
		"       j   markets\n"+
		"\n"+
		"  Parameters\n"+
		"       a(i)   capacity of plant i in cases\n"+
		"       b(j)   demand at market j in cases\n"+
		"       d(i,j) distance in thousands of miles\n"+
		"  Scalar f  freight in dollars per case per thousand miles /90/;\n"+
		"\n"+
		"$if not set gdxincname $abort 'no include file name for data file provided'\n"+
		"$gdxin %gdxincname%\n"+
		"$load i j a b d\n"+
		"$gdxin\n"+
		"\n"+
		"  Parameter c(i,j)  transport cost in thousands of dollars per case ;\n"+
		"\n"+
		"            c(i,j) = f * d(i,j) / 1000 ;\n"+
		"\n"+
		"  Variables\n"+
		"       x(i,j)  shipment quantities in cases\n"+
		"       z       total transportation costs in thousands of dollars ;\n"+
		"\n"+
		"  Positive Variable x ;\n"+
		"\n"+
		"  Equations\n"+
		"       cost        define objective function\n"+
		"       supply(i)   observe supply limit at plant i\n"+
		"       demand(j)   satisfy demand at market j ;\n"+
		"\n"+
		"  cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;\n"+
		"\n"+
		"  supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;\n"+
		"\n"+
		"  demand(j) ..   sum(i, x(i,j))  =g=  b(j) ;\n"+
		"\n"+
		"  Model transport /all/ ;\n"+
		"\n"+
		"  Solve transport using lp minimizing z ;\n"+
		"\n"+
		"  Display x.l, x.m ;";

	return model;
}

int main(array<System::String ^> ^args)
{
	// Reading input data from workbook
	Excel::Application^ excelApp = gcnew Excel::ApplicationClass();

	String^ lokal = Directory::GetCurrentDirectory();
	lokal +="..\\..\\..\\Data\\transport.xls";
	Excel::Workbook^ wb = excelApp->Workbooks->Open(lokal, Type::Missing, Type::Missing, Type::Missing, Type::Missing,
		Type::Missing, Type::Missing, Type::Missing, Type::Missing,
		Type::Missing, Type::Missing, Type::Missing, Type::Missing,
		Type::Missing, Type::Missing);

	Excel::Range^ range;

	Excel::Worksheet^ capacity;
	capacity = (Excel::Worksheet^)wb->Worksheets["capacity"];
	range = capacity->UsedRange;
	array<Object^,2>^ capacityData = (array<Object^,2>^)range->Cells->Value2;

	int iCount = capacity->UsedRange->Columns->Count;

	Excel::Worksheet^ demand = (Excel::Worksheet^)wb->Worksheets["demand"];
	range = demand->UsedRange;
	array<Object^,2>^ demandData = (array<Object^,2>^)range->Cells->Value2;
	int jCount = range->Columns->Count;

	Excel::Worksheet^ distance = (Excel::Worksheet^)wb->Worksheets["distance"];
	range = distance->UsedRange;
	array<Object^,2>^ distanceData = (array<Object^,2>^)range->Cells->Value2;

	// number of markets/plants have to be the same in all spreadsheets
	Debug::Assert((range->Columns->Count - 1) == jCount && (range->Rows->Count - 1) == iCount,
		"Size of the spreadsheets doesn't match");
	wb->Close(Type::Missing, Type::Missing, Type::Missing);

	// Creating the GAMSDatabase and fill with the workbook data
	GAMSWorkspace^ ws;
	if (args->Length > 0) 
		ws = gcnew GAMSWorkspace(nullptr,args[0],false);
	else
		ws = gcnew GAMSWorkspace(nullptr,nullptr,false);

	GAMSDatabase^ db = ws->AddDatabase(nullptr);

	GAMSSet^ i = db->AddSet("i", 1, "Plants");
	GAMSSet^ j = db->AddSet("j", 1, "Markets");
	GAMSParameter^ capacityParam = db->AddParameter("a", 1, "Capacity");
	GAMSParameter^ demandParam = db->AddParameter("b", 1, "Demand");
	GAMSParameter^ distanceParam = db->AddParameter("d", 2, "Distance");

	for (int ic = 1; ic <= iCount; ic++)
	{
		i->AddRecord((String^)capacityData->GetValue(1, ic));
		capacityParam->AddRecord((String^)capacityData->GetValue(1, ic))->Value = (double)capacityData->GetValue(2, ic);
	}
	for (int jc = 1; jc <= jCount; jc++)
	{
		j->AddRecord((String^)demandData->GetValue(1, jc));
		demandParam->AddRecord((String^)demandData->GetValue(1, jc))->Value = (double)demandData->GetValue(2, jc);
		for (int ic = 1; ic <= iCount; ic++)
		{
			distanceParam->AddRecord((String^)distanceData->GetValue(ic + 1, 1), (String^)distanceData->GetValue(1, jc + 1))->Value = (double)distanceData.GetValue(ic + 1, jc + 1);
		}
	}

	// Create and run the GAMSJob
	{
		GAMSOptions^ opt = ws->AddOptions(nullptr);
		{
			GAMSJob^ t10 = ws->AddJobFromString(GetModelText(),nullptr,nullptr);
			opt->Defines->Add("gdxincname", db->Name);
			opt->AllModelTypes = "xpress";
			t10->Run(opt, db);
			for each (GAMSVariableRecord^ rec in t10->OutDB->GetVariable("x"))
				Console::WriteLine("x(" + rec->Keys[0] + "," + rec->Keys[1] + "): level=" + rec->Level + " marginal=" + rec->Marginal);
		}
	}
	return 0;
}
