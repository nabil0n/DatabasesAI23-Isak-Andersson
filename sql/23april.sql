-- JOINS

-- primary key --> foreign key

-- JOIN behöver bara två relaterade (med lika värden?) kolumner i olika tabeller, behöver alltså inte nödvändigtvis vara primary/foreign key

-- typer av joins:
-- CROSS JOIN
--		Ovanligaste typen, men ala typer bygger på den
--		Få ut alla möjliga kombinatoner mellan två tabeller
--		select (tabellx3) CROSS JOIN (tabellx3) skulle bli en 9 rader lång tabell

-- INNER/FULL JOIN
--		Inner: Få ut alla som matchar, utesluter de utan matchning
--		Full: Som ovan, men ger ut NULL för de som inte matchade.

-- LEFT/RIGHT JOIN
--		Som FULL fast ger NULL den vänstra (första) eller högra (sista)

-- Syntax (exempel):
--		Select * from [länder] l
--		join [städer] s on s.landsID = l.landsID;

drop table iths.dbo.countries;

create table iths.dbo.countries (
	id int,
	name nvarchar(max)
);

insert into iths.dbo.countries values (1, 'Sverige');
insert into iths.dbo.countries values (2, 'Norge');
insert into iths.dbo.countries values (3, 'Danmark');
insert into iths.dbo.countries values (4, 'Finland');

drop table iths.dbo.cities;

create table iths.dbo.cities (
	id int,
	name nvarchar(max),
	countryId int
)

insert into iths.dbo.cities values (1, 'Stockholm', 1);
insert into iths.dbo.cities values (2, 'Göteborg', 1);
insert into iths.dbo.cities values (3, 'Malmö', 1);
insert into iths.dbo.cities values (4, 'Oslo', 2);
insert into iths.dbo.cities values (5, 'Bergen', 2);
insert into iths.dbo.cities values (6, 'Köpenhamn', 3);
insert into iths.dbo.cities values (7, 'London', 5);

select * from iths.dbo.countries;
select * from iths.dbo.cities;


select * from iths.dbo.countries cross join iths.dbo.cities; -- 4x7 (makes no sense)

select
	cities.id,
	cities.name as 'Cities',
	countries.name as 'Countries',
	countries.id,
	cities.countryId
from
	iths.dbo.countries
	join iths.dbo.cities on iths.dbo.countries.id = iths.dbo.cities.countryId; -- Tolkas auto som inner om bara join

select
	cities.name as 'Cities',
	countries.name as 'Countries',
	countries.id,
	cities.countryId
from
	iths.dbo.countries
	full join iths.dbo.cities on iths.dbo.countries.id = iths.dbo.cities.countryId;

select
	cities.name as 'Cities',
	countries.name as 'Countries',
	countries.id,
	cities.countryId
from
	iths.dbo.countries
	right join iths.dbo.cities on iths.dbo.countries.id = iths.dbo.cities.countryId;

select
	cities.name as 'Cities',
	countries.name as 'Countries',
	countries.id,
	cities.countryId
from
	iths.dbo.countries
	left join iths.dbo.cities on iths.dbo.countries.id = iths.dbo.cities.countryId;

-- uppgift 1

select
	isnull(countries.name, '-') as 'Country',
	count(cities.name) as 'Number of cities',
	isnull(string_agg(cities.name, ', '), '-') as 'Cities'
from
	iths.dbo.countries full outer join iths.dbo.cities on iths.dbo.countries.id = iths.dbo.cities.countryId
group by
	iths.dbo.countries.name;

--

