// Transport4.cpp : main project file.

#include "stdafx.h"

using namespace System;
using namespace System::Collections::Generic;
using namespace System::Linq;
using namespace System::Text;
using namespace System::IO;
using namespace GAMS;


static System::String^ GetModelText()
{
	String^ model = "\n"+
		"Sets\n"+
		"     i   canning plants\n"+
		"     j   markets\n"+
		"\n"+
		"Parameters\n"+
		"     a(i)   capacity of plant i in cases\n"+
		"     b(j)   demand at market j in cases\n"+
		"     d(i,j) distance in thousands of miles\n"+
		"Scalar f  freight in dollars per case per thousand miles;\n"+
		"\n"+
		"$if not set gdxincname $abort 'no include file name for data file provided'\n"+
		"$gdxin %gdxincname%\n"+
		"$load i j a b d f\n"+
		"$gdxin\n"+
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
		"demand(j) ..   sum(i, x(i,j))  =g=  b(j) ;\n"+
		"\n"+
		"Model transport /all/ ;\n"+
		"\n"+
		"Solve transport using lp minimizing z ;\n"+
		"\n"+
		"Display x.l, x.m ;";

	return model;
}


int main(array<String ^> ^args)
{
	GAMSWorkspace^ ws;
	if (args->Length > 0) 
		ws = gcnew GAMSWorkspace(nullptr,args[0],false);
	else
		ws = gcnew GAMSWorkspace(nullptr,nullptr,false);


	// define some data by using C++ data structures
	List<String^>^ plants = gcnew List<String^>();
	plants->Add("Seattle");
	plants->Add("San-Diego");

	List<String^>^ markets = gcnew List<String^>();
	markets->Add("New-York");
	markets->Add("Chicago");
	markets->Add("Topeka");

	Dictionary<String^, double>^ capacity;
	capacity = gcnew Dictionary<String^, double>();
	capacity->Add("Seattle", 350.0);
	capacity->Add("San-Diego", 600.0);

	Dictionary<String^, double>^ demand = gcnew Dictionary<String^, double>();
	demand->Add("New-York", 325.0);
	demand->Add("Chicago", 300.0);
	demand->Add("Topeka", 275.0);

	Dictionary<Tuple<String^,String^>^, double>^ distance = gcnew Dictionary<Tuple<String^,String^>^, double>();
	distance->Add(gcnew Tuple<String^,String^> ("Seattle",   "New-York"), 2.5);
	distance->Add(gcnew Tuple<String^,String^> ("Seattle",   "Chicago"),  1.7);
	distance->Add(gcnew Tuple<String^,String^> ("Seattle",   "Topeka"),   1.8);
	distance->Add(gcnew Tuple<String^,String^> ("San-Diego", "New-York"), 2.5);
	distance->Add(gcnew Tuple<String^,String^> ("San-Diego", "Chicago"),  1.8);
	distance->Add(gcnew Tuple<String^,String^> ("San-Diego", "Topeka"),   1.4);


	// prepare a GAMSDatabase with data from the C++ data structures
	GAMSDatabase^ db = ws->AddDatabase(nullptr);

	GAMSSet^ i = db->AddSet("i", 1, "canning plants");
	for each (String^ p in plants)
		i->AddRecord(p);

	GAMSSet^ j = db->AddSet("j", 1, "markets");
	for each (String^ m in markets)
		j->AddRecord(m);

	GAMSParameter^ a = db->AddParameter("a", 1, "capacity of plant i in cases");
	for each (String^ p in plants)
		a->AddRecord(p)->Value = capacity[p];

	GAMSParameter^ b = db->AddParameter("b", 1, "demand at market j in cases");
	for each (String^ m in markets)
		b->AddRecord(m)->Value = demand[m];

	GAMSParameter^ d = db->AddParameter("d", 2, "distance in thousands of miles");
	for each(Tuple<String^,String^>^ t in distance->Keys)
		d->AddRecord(t->Item1,t->Item2)->Value = distance[t];

	GAMSParameter^ f = db->AddParameter("f", 0, "freight in dollars per case per thousand miles");
	f->AddRecord()->Value = 90;

	// run a job using data from the created GAMSDatabase
	GAMSJob^ t4 = ws->AddJobFromString(GetModelText(),nullptr,nullptr);
	{ 
		GAMSOptions^ opt = ws->AddOptions(nullptr);
		{
			opt->Defines->Add("gdxincname", db->Name);
			opt->AllModelTypes = "xpress";
			t4->Run(opt, db);
			for each (GAMSVariableRecord^ rec in t4->OutDB->GetVariable("x"))
				Console::WriteLine("x(" + rec->Keys[0] + "," + rec->Keys[1] + "): level=" + rec->Level + " marginal=" + rec->Marginal);
		}
	}
	return 0;
}

