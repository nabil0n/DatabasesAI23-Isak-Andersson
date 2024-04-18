-- insert into

-- syntax:
-- INSERT INTO (tabellnamn(k1,k2,k3)) (values(v1,v2,v3))

select * from ITHS.dbo.students

insert into ITHS.dbo.students(id,name,birthdate) values(6, 'Fredrik', 1999-09-20);
insert into ITHS.dbo.students(id,name,birthdate) values(7, 'RättFredrik', '1999-09-20');

-- select into  - skapa ny tabell från prompten

select Title as ' Titel', Episode as 'Avsnitt' into GOT from everyloop.dbo.GameOfThrones where Season = 1;

select * from GOT

-- Uppgift 1

select * into everyloop.dbo.Users2 from everyloop.dbo.Users;

select * from everyloop.dbo.Users
select * from everyloop.dbo.Users2

-- insert into select from

select * from everyloop.dbo.GOT;

insert into
	everyloop.dbo.GOT ([ Titel], Avsnitt)
select
	Title,
	episode
from
	everyloop.dbo.GameOfThrones
where
	season = 2;

-- Uppgift 2

select * from ITHS.dbo.students;

-- a

select
	name as 'namn',
	birthdate as 'födelsedatum'
into
	ITHS.dbo.studenter
from
	ITHS.dbo.students;

select * from ITHS.dbo.studenter;

-- b

insert into
	ITHS.dbo.studenter(namn, födelsedatum)
values
	('Isak', '1989-07-18');

-- c

insert into
	ITHS.dbo.studenter(namn)
select
	FirstName
from
	everyloop.dbo.Users
where
	FirstName like 'a%';


-- Update

update ITHS.dbo.studenter set födelsedatum = '1999-09-09' where namn = 'David'; -- where är viktigt, annars ändras allt!

select * from ITHS.dbo.studenter

-- Delete

delete from ITHS.dbo.studenter where namn like 'a%';

-- Upsert, en mix av update och insert
-- En rad uppdateras om den finns, och skapas om den inte finns

-- create table

create table ITHS.dbo.teachers (
	id int primary key,
	name nvarchar(max) not null,
	birthdate date
)