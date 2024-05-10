insert into
    Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareId)
select
    isbn13,
    title,
    language,
    price,
    publish_date,
    author_id
from
    RAWbooks;

select
    *
from
    Rawbooks;