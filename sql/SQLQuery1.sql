-- select * from [server name].[database name].[schema name].[table name]

-- rad kommentar

/*
	blockkommentar
*/

SELECT FirstName, ID, LastName, FirstName, 'Fredrik' as 'Fredrik', Firstname + ' ' + LastName as 'Full name' from users;

-- T-SQL:
select top 5 * from users;			-- F�rsta fem
select top 5 percent * from users;  -- Fem procent av raderna

-- ISO-SQL (funkar ej i windows, men annars standard):
select * from users limit 5;

-- [projection] �r n�r vi f�rs�ker f� ut n�got specifikt, och [selection] �r n�r vi begr�nsar hur mycket vi f�r ut, men all information (?)

-- == skrivs som = 
-- != skrivs som <>, dock funkar detta i T-SQL

select * from users where FirstName = 'Johanna' or FirstName = 'Johan';

select * from GameOfThrones

-- uppgift 1

select Season, Title, [U.S. viewers(millions)]*1000000 as Viewers from GameOfThrones where EpisodeInSeason = 1;

-- uppgift 2

select * from GameOfThrones where Season not in (2,5,7);

-- uppgift 3

select Season as S�song, EpisodeInSeason as Avsnitt, Title as Titel, [U.S. viewers(millions)] from GameOfThrones where 4 < [U.S. viewers(millions)] and [U.S. viewers(millions)] < 5;