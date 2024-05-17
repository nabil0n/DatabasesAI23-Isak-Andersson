delete from
    RAWbooks
where
    isbn13 is null;

with UniqueAuthors as (
    select
        author_ID as Id,
        ltrim(left(author, charindex(' ', ltrim(author)) - 1)) as Förnamn,
        substring(author, charindex(' ', ltrim(author)) + 1, len(ltrim(author)) - charindex(' ', ltrim(author))) as Efternamn,
        author_birthdate as Födelsedatum,
        row_number() over (partition by author_ID order by author_ID) as rn
    from 
        RAWbooks
    where 
        charindex(' ', ltrim(author)) > 0
)
insert into Författare (Id, Förnamn, Efternamn, Födelsedatum)
select 
    Id,
    Förnamn,
    Efternamn,
    Födelsedatum
from 
    UniqueAuthors
where 
    rn = 1;

insert into Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareId)
select
    rb.isbn13 as ISBN13,
    rb.title as Titel,
    rb.language as Språk,
    rb.price as Pris,
    rb.publish_date as Utgivningsdatum,
    f.Id as FörfattareId
from
    RAWbooks rb
join
    Författare f on rb.author_id = f.Id;

select
    author_ID
from
    RAWbooks;
