// Transport9.cpp : main project file.

#include "stdafx.h"

using namespace System;
using namespace System::Collections::Generic;
using namespace System::Text;
using namespace System::IO;
using namespace GAMS;
using namespace System::Data::OleDb;

static String^ GetModelText()
{
	String^ model = "\n"+
		"   Sets\n"+
		"   i   canning plants\n"+
		"   j   markets\n"+
		"\n"+
		"   Parameters\n"+
		"   a(i)   capacity of plant i in cases\n"+
		"   b(j)   demand at market j in cases\n"+
		"   d(i,j) distance in thousands of miles\n"+
		"   Scalar f  freight in dollars per case per thousand miles /90/;\n"+
		"\n"+
		"$if not set gdxincname $abort 'no include file name for data file provided'\n"+
		"$gdxin %gdxincname%\n"+
		"$load i j a b d\n"+
		"$gdxin\n"+
		"\n"+
		"   Parameter c(i,j)  transport cost in thousands of dollars per case ;\n"+
		"\n"+
		"c(i,j) = f * d(i,j) / 1000 ;\n"+
		"\n"+
		"Variables\n"+
		"   x(i,j)  shipment quantities in cases\n"+
		"   z       total transportation costs in thousands of dollars ;\n"+
		"\n"+
		"Positive Variable x ;\n"+
		"\n"+
		"Equations\n"+
		"   cost        define objective function\n"+
		"   supply(i)   observe supply limit at plant i\n"+
		"   demand(j)   satisfy demand at market j ;\n"+
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

static void ReadSet(OleDbConnection^ connect, GAMSDatabase^ db, String^ strAccessSelect, String^ setName, int setDim, String^ setExp = "")
{
	try
	{
		OleDbCommand^ cmd = gcnew OleDbCommand(strAccessSelect, connect);
		connect->Open();

		OleDbDataReader^ reader = cmd->ExecuteReader();

		if (reader->FieldCount != setDim)
		{
			Console::WriteLine("Number of fields in select statement does not match setDim");
			Environment::Exit(1);
		}

		GAMSSet^ i = db->AddSet(setName, setDim, setExp);

		array <String^>^ keys = gcnew array <String^>(setDim);
		while (reader->Read())
		{
			for (int idx = 0; idx < setDim; idx++)
				keys[idx] = reader->GetString(idx);

			i->AddRecord(keys);
		}
	}
	catch (IO::IOException^ ex)
	{
		Console::WriteLine("Error: Failed to retrieve the required data from the DataBase.\n{0}", ex->Message);
		Environment::Exit(1);
	}
	finally
	{
		connect->Close();
	}
}

static void ReadParameter(OleDbConnection^ connect, GAMSDatabase^ db, String^ strAccessSelect, String^ parName, int parDim, String^ parExp = "")
{
	try
	{
		OleDbCommand^ cmd = gcnew OleDbCommand(strAccessSelect, connect);
		connect->Open();

		OleDbDataReader^ reader = cmd->ExecuteReader();

		if (reader->FieldCount != parDim+1)
		{
			Console::WriteLine("Number of fields in select statement does not match parDim+1");
			Environment::Exit(1);
		}

		GAMSParameter^ a = db->AddParameter(parName, parDim, parExp);

		array <String^>^ keys = gcnew array <String^>(parDim);
		while (reader->Read())
		{
			for (int idx = 0; idx < parDim; idx++)
				keys[idx] = reader->GetString(idx);

			a->AddRecord(keys)->Value = Convert::ToDouble(reader->GetValue(parDim));
		}
	}
	catch (IO::IOException^ ex)
	{
		Console::WriteLine("Error: Failed to retrieve the required data from the DataBase.\n{0}", ex->Message);
		Environment::Exit(1);
	}
	finally
	{
		connect->Close();
	}
}

static GAMSDatabase^ ReadFromAccess(GAMSWorkspace^ ws)
{

	GAMSDatabase^ db = ws->AddDatabase(nullptr);

	// connect to database
	//need to adjust Source if executed e.g. in bin\debug
	String^ strAccessConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=..\\..\\Data\\transport.accdb";
	OleDbConnection^ connection = nullptr;
	try
	{
		connection = gcnew OleDbConnection(strAccessConn);
	}
	catch (IO::IOException^ ex)
	{
		Console::WriteLine("Error: Failed to create a database connection. \n{0}", ex->Message);
		Environment::Exit(1);
	}

	// read GAMS sets
	ReadSet(connection, db, "SELECT Plant FROM Plant", "i", 1, "canning plants");
	ReadSet(connection, db, "SELECT Market FROM Market", "j", 1, "markets");

	// read GAMS parameters
	ReadParameter(connection, db, "SELECT Plant,Capacity FROM Plant", "a", 1, "capacity of plant i in cases");
	ReadParameter(connection, db, "SELECT Market,Demand FROM Market", "b", 1, "demand at market j in cases");
	ReadParameter(connection, db, "SELECT Plant,Market,Distance FROM Distance", "d", 2, "distance in thousands of miles");

	return db;
}

int main(array<String ^> ^args)
{

	GAMSWorkspace^ ws;
	if (args->Length > 0) 
		ws = gcnew GAMSWorkspace(nullptr,args[0],false);
	else
		ws = gcnew GAMSWorkspace(nullptr,nullptr,false);

	// fill GAMSDatabase by reading from Access
	GAMSDatabase^ db = ReadFromAccess(ws);

	// run job
	{
		GAMSOptions^ opt = ws->AddOptions(nullptr);
		{
			GAMSJob^ t9 = ws->AddJobFromString(GetModelText(),nullptr,nullptr);
			opt->Defines->Add("gdxincname", db->Name);
			opt->AllModelTypes = "xpress";
			t9->Run(opt, db);
			for each (GAMSVariableRecord^ rec in t9->OutDB->GetVariable("x"))
				Console::WriteLine("x(" + rec->Keys[0] + "," + rec->Keys[1] + "): level=" + rec->Level + " marginal=" + rec->Marginal);
		}
	}
	return 0;
}
