-- Med tabellerna fr�n schema �company�, svara p� f�ljande fr�gor:


-- 1. F�retagets totala produktkatalog best�r av 77 unika produkter.
-- Om vi kollar bland v�ra ordrar, hur stor andel av dessa produkter har vi n�gon g�ng leverarat till London?

select * from company.products
select * from company.orders
select * from company.order_details

select
	--od.OrderId,
	--od.ProductId,
	count(distinct(od.ProductId)) as nbrProd,
	count(distinct(od.ProductId))/77.0 as Ratio
	-- count(distinct(od.ProductId))/77.0 cast((select count(*) from company.products) as float) as Ratio
from
	company.order_details od
	inner join company.orders o on od.OrderId = o.Id
where
	o.ShipCity = 'London'


-- 2. Till vilken stad har vi levererat flest unika produkter?

SELECT
    ShipCity,
    count(distinct(ProductID)) as 'Number of Products'
FROM    
    company.orders
right join
    company.order_details
on
    company.orders.ID = company.order_details.OrderID
group by
    ShipCity
order by
    'Number of Products' desc;


-- 3. Av de produkter som inte l�ngre finns I v�rat sortiment, hur mycket har vi s�lt f�r totalt till Tyskland?

select 
	--*
	sum((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * od.Discount)) as 'Amount in currency for discontinued products sold in total to Germany'
from
	company.order_details od
	join company.orders o on od.OrderId = o.Id
	join company.products p on od.ProductId = p.Id
where
	ShipCountry='Germany' and p.Discontinued=1


-- 4. F�r vilken produktkategori har vi h�gst lagerv�rde?

select
    company.categories.CategoryName,
    sum(company.products.UnitsInStock * company.products.UnitPrice) as 'Total Stock Value'
from
    company.products
	right join company.categories
on
    company.products.CategoryID = company.categories.ID
group by
    company.categories.CategoryName
order by
    'Total Stock Value' desc;


-- 5. Fr�n vilken leverant�r har vi s�lt flest produkter totalt under sommaren 2013?

select
    company.suppliers.CompanyName,
    sum(company.order_details.Quantity) as 'Total Quantity'
from
    company.orders
right join
    company.order_details
on
    company.orders.ID = company.order_details.OrderID
right join
    company.products
on
    company.order_details.ProductID = company.products.ID
right join
    company.suppliers
on
    company.products.SupplierID = company.suppliers.ID
where
    company.orders.OrderDate between '2013-06-01' and '2013-08-31'
group by
    company.suppliers.CompanyName
order by
    'Total Quantity' desc;


-- MUSIC

select * from music.playlists
select * from music.tracks
select * from music.genres
select * from music.albums
select * from music.playlist_track

declare @playlist varchar(max) = 'Classical';

SELECT
    g.Name as 'Genre',
    ar.Name as 'Artist',
    a.Title as 'Album',
    t.Name as 'Track',
    format(dateadd(MILLISECOND, t.Milliseconds, 0), 'mm:ss') as 'Duration',
    format(bytes / power(1024.0, 2), '0.0')+' MiB' as 'Size',
    isnull(Composer, '-') as 'Composer',
    p.Name as 'Playlist'
From
    music.tracks t
    join music.genres g on g.GenreId = t.GenreId
    join music.albums a on a.AlbumId = t.AlbumId
    join music.artists ar on ar.ArtistId = a.ArtistId
    join music.playlist_track pt on pt.TrackId = t.TrackId
    join music.playlists p on p.PlaylistId = pt.PlaylistId
WHERE
    p.Name = @playlist
order BY
    g.Name, ar.Name, a.Title, t.Name;

-- 1. Av alla audiospår, vilken artist har längst total speltid?

select * from music.tracks where MediaTypeId <> 3

select
    ar.Name,
    sum(tr.Milliseconds)/1000 as total_track_time_s,
    count(TrackId) as total_nbr_tracks,

-- 2. Vad är den genomsnittliga speltiden på den artistens låtar?
    (sum(tr.Milliseconds)/count(TrackId))/1000 as avg_track_time_sec
from music.tracks tr
    left join music.albums al on tr.AlbumId = al.AlbumId
    left join music.artists ar on al.ArtistId = ar.ArtistId
where 
    MediaTypeId <> 3
group by 
    ar.Name
order by 
    total_track_time_s desc


-- 3. Vad är den sammanlagda filstorleken för all video?

SELECT
    concat(round(convert(float, sum(convert(bigint, t.bytes))) / power(1024.0, 3), 1), ' GiB') as 'Total Size'
FROM
    music.tracks t
where 
    MediaTypeId = 3
order by
    'Total Size' desc;


-- 4. Vilket är det högsta antal artister som finns på en enskild spellista?




-- 5. Vilket är det genomsnittliga antalet artister per spellista?

