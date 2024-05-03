select * from MoonMissions

-- Gruppera uppdragen per år, och hitta hur många uppdrag det är för varje år.

select
    year([Launch date]) as 'Year',
    count(*) as 'Mission Count'
from
    MoonMissions
group by
    year([Launch date])

-- Sätt in alla år som inte är representerade ovan, och sätt antalet uppdrag till 0.

select * from generate_series(1958, 2019)

select
    year(m.[Launch date]) as 'Year',
    count(*) as 'Mission Count'
from
    MoonMissions m
    right join generate_series(1958, 2019) s on year(m.[Launch date]) = s.[value]
group by
    year(m.[Launch date])

-- sub-queries

select
    TrackId,
    Name,
    AlbumId,
    (select Title from music.albums a where a.AlbumId = t.AlbumId) as AlbumTitle -- suboptimalt. Använd join istället
from
    music.tracks t

--- Vyer

create view myview as
select
    Firstname,
    Lastname,
    Email
from
    Users
where
    FirstName like '[a-d]%'

-- Går inte att köra group by på en view

-- vyer används för att "spara" en överblick utan att skapa redundant data i databasen.
-- tillexempel om vi vill hålla koll på hur gamla folk är i en databas, så kan vi skapa en view
-- som använder en datediff för att räkna ut åldern, men att databasen bara har sparad födelsedatumet.