create table produkt (
id_produktu int auto_increment primary key,
nazwa varchar(100) not null,
data_dodania date,
id_kategorii int,
foreign key(id_kategorii)
	references kategoria(id_kategorii)
);

insert into kategoria 
values (1, 'komputery');

insert into kategoria 
values 
(2, 'akcesoria'),
(3, 'sprzęt peryferyjny');

select * from kategoria;

update kategoria
set nazwa = 'ogród'
where id_kategorii = 3;

delete from kategoria where id_kategorii=3;

insert into produkt (nazwa, data_dodania, id_kategorii)
values('mysz', '2026-10-29', 2);

select * from produkt;

alter table produkt
drop foreign key produkt_ibfk_1,
add foreign key(id_kategorii)
	references kategoria(id_kategorii)
    on delete set null;

delete from kategoria where id_kategorii = 2;

drop table kategoria, produkt;