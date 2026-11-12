create table pracownik (
id_pracownika int auto_increment primary key,
imie varchar(40) not null,
nazwisko varchar(60) not null,
data_urodzenia date not null
);
insert into pracownik
values 
(1, 'Adam', 'Kaplityn', '1998.05.25'),
(2, 'Krystyna', 'Poprawna', '1991.11.3'),
(3, 'Maksymilian', 'Uprwniak', '2003.1.1');

update pracownik
set data_urodzenia = '1988.05.25'
where id_pracownika = 1;

select * from pracownik;

create table zadanie (
id_zadania int auto_increment primary key,
nazwa_zadania varchar(150) not null,
priorytet enum('normal', 'wysoki', 'niski'),
opis longtext,
id_pracownik int,
foreign key (id_pracownik)
    references pracownik(id_pracownika)
    on delete set null
);

alter table zadanie
modify priorytet enum('normal', 'wysoki', 'niski') default 'normal';

insert into zadanie (nazwa_zadania, priorytet, opis, id_pracownik)
values
('zmywanie podłogi', 'wysoki', 'umyj podłoge', 3),
('rozpakowanie towaru', 'niski', 'odbierz dostawe i rozpakuj', 2),
('zaparzenie kawy', 'normal', 'zaparz kawe', 1);

select * from zadanie;


create table projekt (
id_projektu int auto_increment primary key,
nazwa_projektu varchar(150) not null,
data_rozpoczęcia date not null,
data_zakończenia date
);
alter table projekt
add menadzer_projektu int,
add foreign key (menadzer_projektu)
	references pracownik(id_pracownika);
    
    insert into projekt 
    values 
    (1, 'rozbudowa sieci','2025.6.23','2025.7.1',2),
    (2, 'modernizacja sys', '2026.10.25',null, 1);
    
select * from projekt;

alter table zadanie
add projekt int,
add foreign key (projekt)
	references projekt(id_projektu)
    on delete cascade;
    
    update zadanie
    set projekt = 1
    where id_pracownik = 2;
    
    update zadanie
    set projekt = 2
    where id_pracownik = 1;
    
create table sprint(
id_sprintu int primary key auto_increment,
numer_sprintu int check (numer_sprintu>=0),
data_rozpoczęcia date,
data_zakończenia date
);

alter table zadanie
add sprint int,
add foreign key (sprint)
	references sprint(id_sprintu)
    on delete set null;
    
insert into sprint
values
(1, 3, '2026.11.22', '2026.11.24');

select * from sprint;

select * from zadanie;

update zadanie
set sprint=1
where id_zadania = 3;

update zadanie
set sprint=1
where id_zadania = 2;

create table status(
id_statusu int primary key auto_increment,
nazwa_statusu varchar(20)
);

insert into status (nazwa_statusu)
values
('zakończone'),
('w realizacji'),
('przerwane');

select * from status;

create table zadanie_has_status(
id_zdarzenia int primary key auto_increment,
id_zadania int,
id_statusu int,
data_zdarzenia timestamp default current_timestamp
);

alter table zadanie_has_status
add foreign key (id_zadania)
	references zadanie(id_zadania)
    on delete set null;
    
alter table zadanie_has_status
add foreign key (id_statusu)
	references status(id_statusu)
    on delete set null;
    
    
insert into zadanie_has_status (id_zadania, id_statusu)
values
(1, 2),
(2, 1),
(3, 3);

set foreign_key_checks = 0;

select * from projekt;
delete from projekt where id_projektu=2;

drop table if exists sprint;

set foreign_key_checks = 1;