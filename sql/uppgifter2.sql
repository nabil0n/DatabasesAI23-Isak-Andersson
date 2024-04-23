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

-- d)

