create table testdata (
    a int,
    b int,
    c int
);

-- insert into testdata select value, 1000001 - value, abs(checksum(newid())) % 10 from generate_series(1, 1000000);

select * from testdata;

create table testdata_pk (
    a int primary key,
    b int,
    c int
);

-- insert into testdata_pk select value, 1000001 - value, abs(checksum(newid())) % 10 from generate_series(1, 1000000);

select * from testdata_pk;