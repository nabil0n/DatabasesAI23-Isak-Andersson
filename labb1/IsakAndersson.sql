-- MoonMissions

-- select * from MoonMissions order by Outcome

select
    Spacecraft,
    [Launch date],
    [Carrier rocket],
    Operator,
    [Mission type]
into
    SuccessfulMissions
from
    MoonMissions
where
    Outcome = 'Success' or Outcome = 'Successful';

GO

update
    SuccessfulMissions
set
    Operator = ltrim(Operator);

GO

-- VG UPPGIFT
-- select
--     left(rtrim([Spacecraft]), charindex('(', reverse(rtrim([Spacecraft]))+'('))
-- from
--     SuccessfulMissions

GO

select * from SuccessfulMissions

select
    Operator,
    [Mission type],
    count(*) as 'Mission Count'
from
    SuccessfulMissions 
group by
    Operator,
    [Mission type]
having
    count(*) > 1
order by
    Operator,
    [Mission type];

GO

-- Users

select
    *,
    concat(Firstname, ' ', Lastname) as 'Name',
    case
		when substring(right(ID,2), 1, 1) % 2 = 0 then 'Female'
		else 'Male'
	end as 'Gender'
into
    NewUsers
from
    Users;

GO

select * from NewUsers order by UserName

select
    UserName,
    count(*) as 'Number of duplicates'
from
    NewUsers
group by
    UserName
having
    count(*) > 1
order by
    count(*) desc;

GO

update
    NewUsers
set
    UserName = stuff(UserName, len(UserName), 1, '1')
where
    ID = '630303-4894';

update
    NewUsers
set
    UserName = stuff(UserName, len(UserName), 1, '2')
where
    ID = '580802-4175';

update
    NewUsers
set
    UserName = stuff(UserName, len(UserName), 1, '1')
where
    ID = '880706-3713';

select * from NewUsers order by UserName

GO

delete from
    NewUsers
where
    Gender = 'Female' and
    convert(date, left(ID, 6)) <= dateadd(year, -70, sysdatetime());

GO

insert into
    NewUsers
values
    ('990706-3713', 'karkar', '004m46abd464041efd309gf550f72652', 'Karl', 'Karlsson', 'kalleballe@gmail.com', '070-2525252', 'Karl Karlsson', 'Male');

GO

--
-- VG UPPGIFT
--

GO

-- Company (Joins)

select * from company.products
select * from company.categories
select * from company.suppliers
select * from company.regions
select * from company.employees
select * from company.employee_territory
select * from company.territories

select
    p.id,
    p.productname,
    s.companyname as 'Supplier',
    c.categoryname as 'Category'
from
    Company.products p join
    Company.categories c on p.categoryid = c.id join
    Company.suppliers s on p.supplierid = s.id;

GO

select
    r.RegionDescription,
    count(e.Id) as 'Number of employees'
from
    company.employees e join
    company.employee_territory et on e.id = et.employeeid join
    company.territories t on et.territoryid = t.id join
    company.regions r on t.RegionId = r.Id
group by
    r.RegionDescription;

GO

--
-- VG UPPGIFT
--
