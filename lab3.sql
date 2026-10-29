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