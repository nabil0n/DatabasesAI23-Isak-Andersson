-- select * from [server name].[database name].[schema name].[table name]

-- rad kommentar

/*
	blockkommentar
*/

SELECT FirstName, ID, LastName, FirstName, 'Fredrik' as 'Fredrik', Firstname + ' ' + LastName as 'Full name' from users;

-- T-SQL:
select top 5 * from users;			-- Första fem
select top 5 percent * from users;  -- Fem procent av raderna

-- ISO-SQL (funkar ej i windows, men annars standard):
select * from users limit 5;

-- [projection] är när vi försöker få ut något specifikt, och [selection] är när vi begränsar hur mycket vi får ut, men all information (?)

-- == skrivs som = 
-- != skrivs som <>, dock funkar detta i T-SQL

select * from users where FirstName = 'Johanna' or FirstName = 'Johan';

select * from GameOfThrones

-- uppgift 1

select Season, Title, [U.S. viewers(millions)]*1000000 as Viewers from GameOfThrones where EpisodeInSeason = 1;

-- uppgift 2

select * from GameOfThrones where Season not in (2,5,7);

-- uppgift 3

select Season as Säsong, EpisodeInSeason as Avsnitt, Title as Titel, [U.S. viewers(millions)] from GameOfThrones where 4 < [U.S. viewers(millions)] and [U.S. viewers(millions)] < 5;

-- Like

select * from GameOfThrones where Title like '[a-c]%'

-- order by

select * from GameOfThrones order by Title;

-- distinct

select distinct [Directed by] from GameOfThrones;

-- aliases (denna förstod jag ej)

select Title, Episode as key from GameOfThrones -- fel

-- union



-- Case whebn

select
	City,
	case
		when population < 1500 then 'Village'
		when population < 50000 then 'Town'
		else City
		end as ’Classification’
From UScities;