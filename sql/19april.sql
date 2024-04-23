-- aggregering

-- count()

select * from Airports

select count(*) from Airports

select count(IATA) from Airports where IATA like 'a%'

select count(*) - count(Meltingpoint) from Elements

-- andra aggregeringar

select
	sum(mass),
	min(meltingpoint),
	max(meltingpoint),
	avg(meltingpoint)
from Elements

-- group by

select
	sum(mass),
	min(meltingpoint),
	max(meltingpoint),
	avg(meltingpoint),
	string_agg(Symbol, ', ')
from
	Elements
group by
	Period;

-- uppgift 1
-- Skriv en query som ger en kolumn med alla olika länder, samt en klolumn med antalet ordrar till vardera land. sortera på antal ordrar
-- company.orders

select * from company.orders

select
	ShipCountry as 'Country',
	count(ShipCountry) as 'Orders'
from
	company.orders
group by
	ShipCountry
order by
	'Orders'

-- uppgift 2
-- skriv en query som listar de olika regionerna samt två kolumner som visar första respektive senaste order som lagts i regionen.

select
	ShipRegion,
	min(OrderDate) as 'First Order',
	max(OrderDate) as 'Last Order'
from
	company.orders
group by
	ShipRegion
order by
	'First Order'

select
	ShipRegion,
	ShipCountry,
	ShipCity,
	count(*) as 'Number of orders'
from
	company.orders
group by
	ShipRegion,
	ShipCountry,
	ShipCity

-- having

select
	ShipCountry as 'Country',
	count(ShipCountry) as 'Orders'
from
	company.orders
group by
	ShipCountry
having
	count(*) between 10 and 20
order by
	'Orders' desc