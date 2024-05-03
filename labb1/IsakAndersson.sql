-- MoonMissions

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

select
    case
        when charindex('(', Spacecraft) > 0 and charindex(')', Spacecraft) > 0
            then stuff(Spacecraft, charindex('(', Spacecraft), charindex(')', Spacecraft) - charindex('(', Spacecraft) + 1, '')
        else Spacecraft
    end as Spacecraft
from
    SuccessfulMissions;

GO

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
-- Denna blev lite rörig då jag utgick från lite gpt stöd (ärlighet varar längst? :P).
-- Tips på praxis för att få det mer lättläst? Ska varje parentes ha en egen rad typ?
select
    Gender,
    avg(datediff(year, convert(datetime, case 
                                            when
                                                cast(substring(ID, 1, 2) as int) > cast(right(year(getdate()), 2) as int)
                                            then
                                                '19' + substring(ID, 1, 2) 
                                            else
                                                '20' + substring(ID, 1, 2)
                                        end + '-' + substring(ID, 3, 2) + '-' + substring(ID, 5, 2)), getdate())
    ) as 'Average Age'
from
    NewUsers
group by
    Gender;

GO

-- Company (Joins)

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

select
    e.Id,
    concat(e.TitleOfCourtesy, ' ', e.FirstName, ' ', e.LastName) as 'Name',
    case
        when e.ReportsTo is null then 'Nobody!'
        else concat(m.TitleOfCourtesy, ' ', m.FirstName, ' ', m.LastName)
    end as 'Reports To'
from
    company.employees e
    left join company.employees m on e.reportsTo = m.id

GO

