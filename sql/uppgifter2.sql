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

-- c) chatgpt l�sning (Mikael)
	
DECLARE @report NVARCHAR(MAX) = '';
 
;WITH SeasonSummary AS (
 	SELECT
     	Season,
     	MIN([Original air date]) AS StartDate, -- H�mtar det tidigaste datumet f�r s�songen
     	MAX([Original air date]) AS EndDate, -- H�mtar det senaste datumet f�r s�songen
     	COUNT(*) AS EpisodeCount,
     	CAST(AVG(CAST([U.S. viewers(millions)] AS FLOAT)) AS DECIMAL(10,2)) AS AvgViewers -- Ber�knar genomsnittet och formaterar till tv� decimaler
 	FROM
     	GameOfThrones
 	GROUP BY
     	Season
 )
 
-- Skapar en str�ng f�r varje s�song
 SELECT @report = @report +
 	'S�song ' + CAST(Season AS VARCHAR) + ' s�ndes fr�n ' +
 	FORMAT(StartDate, 'MMMM', 'sv') + ' till ' +
 	FORMAT(EndDate, 'Y', 'sv') + '. Totalt s�ndes ' +
 	CAST(EpisodeCount AS VARCHAR) + ' avsnitt, som i genomsnitt s�gs av ' +
 	CAST(AvgViewers AS VARCHAR) + ' miljoner m�nniskor i USA.' + CHAR(13) + CHAR(10)
 FROM
 	SeasonSummary
 ORDER BY
 	Season;
 
-- Skriver ut den ackumulerade rapporten till Messages-f�nstret i SQL Server
 PRINT @report;

-- d)

