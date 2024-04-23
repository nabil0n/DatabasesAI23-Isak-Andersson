select * from GameOfThrones

-- a)

select
	Title,
	concat('S', format(Season, '00'), 'E', format(EpisodeInSeason, '00'))
as
	'Episode' 
from
	GameOfThrones -- får inte e10 att funka...

-- b)

select * into users2 from users

update users2 set UserName = lower(concat(left(firstname, 2), left(lastname, 2)))
update users2 set UserName = lower(concat(left(firstname, 3), left(lastname, 3))) -- reset

select * from users2

-- c)

select * into airports2 from Airports

update airports2
set
	dst = isnull(dst, '-'),
	Time = isnull(Time, '-')

select * from airports2

-- d)

select * into elements2 from Elements

delete from
	elements2
where
	Name like '[dkmou]%' or Name in ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium')

select * from elements2

-- e)

drop table elements3

select
	symbol,
	[name],
	case
		when Name like concat(Symbol, '%') then 'Yes'
	else 'No'
	end as 'First letter match'
--into
--	elements3
from
	[Elements];

-- f)

select
	name,
	red,
	green,
	blue
into
	colors2
from
	colors

alter table colors2
add code as '#' + format(red, 'X2') + format(green, 'X2') + format(blue, 'X2');

select * from colors2

-- g)

select
	String,
	Integer * 0.01 as 'float',
	DateAdd(minute, integer, DATEADD(day, integer, '2019-01-01 09:01')) as 'DateTime',
	integer % 2 as bool
from
	[Types]