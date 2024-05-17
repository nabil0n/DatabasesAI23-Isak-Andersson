create table Författare (
    Id int primary key,
    Förnamn nvarchar(max) not null,
    Efternamn nvarchar(max) not null,
    Födelsedatum date not null
);

create function CheckISBN13 (@ISBN13 nvarchar(50))
returns bit
as
begin
    if @ISBN13 like '[0-9][0-9][0-9]-[0-9]-[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9]'
        return 1
    return 0
end;

create table Böcker (
    ISBN13 nvarchar(50) primary key,
    constraint chk_ISBN13 check (dbo.CheckISBN13(ISBN13) = 1),
    Titel nvarchar(max) not null,
    Språk nvarchar(50),
    Pris decimal(10, 2),
    Utgivningsdatum date,
    FörfattareId int not null foreign key references Författare(Id)
);

create table Butiker (
    Id int primary key,
    Namn varchar(50) not null,
    Adress varchar(50) not null
);

create table LagerSaldo (
    ButikId int not null foreign key references Butiker(Id),
    ISBN13 nvarchar(50) not null foreign key references Böcker(ISBN13),
    Antal int not null,
    primary key (ButikId, ISBN13)
);

create table Kunder (
    Id int primary key,
    Namn nvarchar(50) not null
);

create table Ordrar (
    Id int primary key,
    KundId int not null foreign key references Kunder(KundId),
    ButikId int not null foreign key references Butiker(Id),
    Datum date not null
);

create table Förlag (
    Id int primary key,
    Namn nvarchar(50) not null,
    Adress varchar(50)
);

create table Personal (
    Id int primary key,
    Namn nvarchar(50) not null,
    Telefonnummer varchar(50),
    ButikId int not null foreign key references Butiker(Id)
);

alter table Böcker add FörlagId int foreign key references Förlag(Id);

-- skapa fiktiva bokhandlar

select * from Butiker;

insert into Butiker values (1, 'Fredriks gamla böcker', 'Fejkplatsen 11');
insert into Butiker values (2, 'Everybooks', 'Hittepågatan 23');
insert into Butiker values (3, 'Johanssons script & pergament', 'Fantasivägen 42');

-- skapa fiktiva förlag

select * from Förlag;

insert into Förlag values (1, 'Bokförlaget BokTok', 'Kontaktvägen 1');
insert into Förlag values (2, 'Förlegat förlaget', 'Generiska gatan 2');
insert into Förlag values (3, 'Läsen Lörnd', 'Kreativitetet 404');

-- och länka varje bok till ett random förlag

update Böcker
set FörlagId = abs(checksum(newid())) % 3 + 1;

-- skapa personal

select * from Personal;

insert into Personal values (1, 'Kalle', '070-123 123 123', 1);
insert into Personal values (2, 'Anna', '070-321 321 321', 2);
insert into Personal values (3, 'Johan', '070-111 222 333', 3);
insert into Personal values (4, 'Lisa', '070-222 333 111', 1);
insert into Personal values (5, 'Pelle', '070-333 111 222', 2);
insert into Personal values (6, 'Sara', '070-231 123 321', 3);

-- skapa lagersaldo

select * from Böcker;

insert into LagerSaldo (ButikId, ISBN13, Antal)
select
    b.Id as ButikId,
    k.ISBN13,
    abs(checksum(newid())) % 11 as Antal
from
    Butiker b
cross join
    Böcker k;

-- skapa vy (obligatorisk)

create view TitlarPerFörfattare as 
select
    concat(f.Förnamn, ' ', f.Efternamn) as Namn,
    concat(datediff(year, f.Födelsedatum, getdate()), ' år') as Ålder,
    count(distinct b.ISBN13) as Titlar,
    concat(sum(ls.Antal * b.Pris), ' kr') as Lagervärde
from
    Författare f
join
    Böcker b on f.Id = b.FörfattareId
join
    LagerSaldo ls on b.ISBN13 = ls.ISBN13
group by
    f.Id, f.Förnamn, f.Efternamn, f.Födelsedatum;
