-- create database backupdemo;

create table testdata (
	id int primary key identity(1,1),
	uniqueid uniqueidentifier,
	timestamp datetime2
)

insert into testdata values(newid(), getdate())
go 10000

select * from testdata;

