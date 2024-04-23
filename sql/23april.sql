-- JOINS

-- primary key --> foreign key

-- JOIN beh�ver bara tv� relaterade (med lika v�rden?) kolumner i olika tabeller, beh�ver allts� inte n�dv�ndigtvis vara primary/foreign key

-- typer av joins:
-- CROSS JOIN
--		Ovanligaste typen, men ala typer bygger p� den
--		F� ut alla m�jliga kombinatoner mellan tv� tabeller
--		select (tabellx3) CROSS JOIN (tabellx3) skulle bli en 9 rader l�ng tabell

-- INNER/FULL JOIN
--		Inner: F� ut alla som matchar, utesluter de utan matchning
--		Full: Som ovan, men ger ut NULL f�r de som inte matchade.

-- LEFT/RIGHT JOIN
--		Som FULL fast ger NULL den v�nstra (f�rsta) eller h�gra (sista)

-- Syntax (exempel):
--		Select * from [l�nder] l
--		join [st�der] s on s.landsID = l.landsID;

drop table countries;

create table countries (
	id int,
	name nvarchar(max)
);

insert into countries values (1, 'Sverige');
insert into countries values (2, 'Norge');
insert into countries values (3, 'Danmark');
insert into countries values (4, 'Finland');

drop table cities;

create table cities (
	id int,
	name nvarchar(max),
	countryId int
)

insert into cities values (1, 'Stockholm', 1);
insert into cities values (2, 'G�teborg', 1);
insert into cities values (3, 'Malm�', 1);
insert into cities values (4, 'Oslo', 2);
insert into cities values (5, 'Bergen', 2);
insert into cities values (6, 'K�penhamn', 3);
insert into cities values (7, 'London', 5);

select * from countries;
select * from cities;


select * from countries cross join cities; -- 4x7 (makes no sense)

select
	cities.id,
	cities.name as 'Cities',
	countries.name as 'Countries',
	countries.id,
	cities.countryId
from
	countries
	join cities on countries.id = cities.countryId; -- Tolkas auto som inner om bara join

select
	cities.name as 'Cities',
	countries.name as 'Countries',
	countries.id,
	cities.countryId
from
	countries
	full join cities on countries.id = cities.countryId;

select
	cities.name as 'Cities',
	countries.name as 'Countries',
	countries.id,
	cities.countryId
from
	countries
	right join cities on countries.id = cities.countryId;

select
	cities.name as 'Cities',
	countries.name as 'Countries',
	countries.id,
	cities.countryId
from
	countries
	left join cities on countries.id = cities.countryId;

-- uppgift 1

select
	isnull(countries.name, '-') as 'Country',
	count(cities.name) as 'Number of cities',
	isnull(string_agg(cities.name, ', '), '-') as 'Cities'
from
	countries full outer join cities on countries.id = cities.countryId
group by
	countries.name;

--

