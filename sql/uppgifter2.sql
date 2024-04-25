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

-- d) lite hj�lp fr�n chatgpt

select
	concat(FirstName, ' ', LastName) as 'Namn',
	floor((datediff(day, convert(date, left(ID, 6)), getdate())) / 365.25) as '�lder',
	case
		when substring(right(ID,2), 1, 1) % 2 = 0 then 'Kvinna'
		else 'Man'
	end as 'K�n'
from
	Users
order by
	FirstName,
	LastName;

-- e) WOOPS. Denna tog jag visst bort (p� datorn hemma). Men h�r �r asajds l�sning:

update countries
set [Infant mortality (per 1000 births)] = replace([Infant mortality (per 1000 births)], ',', '.');

SELECT
    [Region],
    count([Country]) as 'Number of Countries',
    SUM(convert(bigint, [Population])) as 'Total Population',
    sum([Area (sq# mi#)]) as 'Total Area',
    sum(convert(bigint, [Population]))/sum([Area (sq# mi#)]) as 'Population Density',
    round(avg(convert(float, [Infant mortality (per 1000 births)])), 2) as 'Average Infant Mortality'
from
    countries
group by
    [Region];

-- f) (med hj�lp fr�n stackoverflow)

select
	right(rtrim([Location served]), charindex(',', reverse(rtrim([Location served]))+',')-1) as Country,
	count(IATA) as 'number of airports',
	sum(case when ICAO is null then 1 else 0 end) as 'number of ICAO nulls',
	format((sum(case when ICAO is null then 1 else 0 end) / cast(count(IATA) as float)), 'p') as '% of airports is ICAO nulls'
from
	Airports
group by
	right(rtrim([Location served]), charindex(',', reverse(rtrim([Location served]))+',')-1)
