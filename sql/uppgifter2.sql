-- a)

select * from Elements

select
	Period,
	min(Number) as 'from',
	max(Number) as 'to',
	format(avg(convert(float, Stableisotopes)), 'N2') as 'average isotopes',
	string_agg(Symbol, ', ')
from
	Elements
group by
	Period;

-- b)

select * from company.customers

select
	Region,
	Country,
	City,
	count(city) as 'Number of Customers'
from
	company.customers
group by
	Region,
	Country,
	City
having
	count(city) > 1;

-- c) chatgpt lösning (Mikael)
	
DECLARE @report NVARCHAR(MAX) = '';
 
;WITH SeasonSummary AS (
 	SELECT
     	Season,
     	MIN([Original air date]) AS StartDate, -- Hämtar det tidigaste datumet för säsongen
     	MAX([Original air date]) AS EndDate, -- Hämtar det senaste datumet för säsongen
     	COUNT(*) AS EpisodeCount,
     	CAST(AVG(CAST([U.S. viewers(millions)] AS FLOAT)) AS DECIMAL(10,2)) AS AvgViewers -- Beräknar genomsnittet och formaterar till två decimaler
 	FROM
     	GameOfThrones
 	GROUP BY
     	Season
 )
 
-- Skapar en sträng för varje säsong
 SELECT @report = @report +
 	'Säsong ' + CAST(Season AS VARCHAR) + ' sändes från ' +
 	FORMAT(StartDate, 'MMMM', 'sv') + ' till ' +
 	FORMAT(EndDate, 'Y', 'sv') + '. Totalt sändes ' +
 	CAST(EpisodeCount AS VARCHAR) + ' avsnitt, som i genomsnitt sågs av ' +
 	CAST(AvgViewers AS VARCHAR) + ' miljoner människor i USA.' + CHAR(13) + CHAR(10)
 FROM
 	SeasonSummary
 ORDER BY
 	Season;
 
-- Skriver ut den ackumulerade rapporten till Messages-fönstret i SQL Server
 PRINT @report;

-- d) lite hjälp från gpt

select
	concat(FirstName, ' ', LastName) as 'Namn',
	(datediff(day, convert(date, left(ID, 6)), convert(date, getdate()))) / 365.25 as 'Ålder',
	case
		when substring(right(ID,2), 1, 1) % 2 = 0 then 'Kvinna'
		else 'Man'
	end as 'Kön'
from
	Users
order by
	FirstName,
	LastName;

-- e) finns denna ens? (som jag inte gjort själv med bara fyra länder?)

select
	*

from
	countries;

-- f)

select
	right(rtrim([Location served]), charindex(',', reverse(rtrim([Location served]))+',')-1) as Country,
	count(IATA) as 'number of airports',
	sum(case when ICAO is null then 1 else 0 end) num_ICAO_nulls
from
	Airports
group by
	right(rtrim([Location served]), charindex(',', reverse(rtrim([Location served]))+',')-1)

select * from Airports;