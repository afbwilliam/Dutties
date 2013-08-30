$ontext

  This is an example to test timeouts against SQL Server.
  The queries are artificially slowed down using a stored
  procedure.

  Warning: query takes 10 minutes to execute.

  Erwin Kalvelagen, November 2006

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$onecho > populate.sql
use testdata
go
if exists (select name from sysobjects
         where name = 'slow' and type = 'P')
   drop procedure slow
if exists (select name from sysobjects
         where name = 'data' and type = 'U')
   drop table data
go
create table data(
i1 int,
i2 int,
x  real
)
go
insert into data values(1,1,2)
insert into data values(2,2,4)
go
select * from data
go
create proc slow @@DELAYLENGTH char(9)
as
begin
print 'delay:'+@@DELAYLENGTH
waitfor delay @@DELAYLENGTH
select * from data
end
go
exec slow '000:00:01'
go
$offecho


$call =sqlcmd -S DUOLAP\SQLEXPRESS -i populate.sql



$onecho > sql.txt
t2=700
c=Provider=MSDASQL;Driver={SQL Server};Server=DUOLAP\SQLEXPRESS;Database=testdata;Uid=gams;Pwd=gams;
q=exec slow '000:10:00'
o=output2.inc
$offecho


$call sql2gms @sql.txt > %system.nullfile%;

parameter p(*,*) /
$include output2.inc
/;
display p;
