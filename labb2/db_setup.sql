create table Författare (
    Id int primary key,
    Förnamn varchar(50) not null,
    Efternamn varchar(50) not null,
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
    Titel varchar(50) not null,
    Språk varchar(50) not null,
    Pris decimal(10, 2) not null,
    Utgivningsdatum date not null,
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
    KundId int primary key,
    Namn varchar(50) not null
);

create table Ordrar (
    OrderId int primary key,
    Kund int not null foreign key references Kunder(KundId),
    [Från butik] int not null foreign key references Butiker(Id),
    Datum date not null
);

create table Förlag (
    Id int primary key,
    Namn varchar(50) not null,
    BöckerId nvarchar(50) not null foreign key references Böcker(ISBN13),
    Kontakt varchar(50) not null
);

create table Ratings (
    Id int primary key,
    Betyg int not null,
    Kommentar varchar(50) not null,
    BokId nvarchar(50) not null foreign key references Böcker(ISBN13)
);

alter table Böcker add FörlagId int foreign key references Förlag(Id);