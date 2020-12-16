/abolish
/sql
/multiline on

create or replace table programadores(dni string primary key, nombre string, dirección string, teléfono string);

insert into programadores(dni, nombre, dirección, teléfono) values('1','Jacinto','Jazmín 4','91-8888888');
insert into programadores(dni, nombre, dirección, teléfono) values('2','Herminia','Rosa 4','91-7777777');
insert into programadores(dni, nombre, dirección, teléfono) values('3','Calixto','Clavel 3','91-1231231');
insert into programadores(dni, nombre, dirección, teléfono) values('4','Teodora','Petunia 3','91-6666666');

create or replace table analistas(dni string primary key, nombre string, dirección string, teléfono string);

insert into analistas(dni, nombre, dirección, teléfono) values('4','Teodora','Petunia 3','91-6666666');
insert into analistas(dni, nombre, dirección, teléfono) values('5','Evaristo','Luna 1','91-1111111');
insert into analistas(dni, nombre, dirección, teléfono) values('6','Luciana','Júpiter 2','91-8888888');
insert into analistas(dni, nombre, dirección, teléfono) values('7','Nicodemo','Plutón 3',NULL);

-- Para crear una clave primaria de más de un atributo hay que añadir al final como si fuese otro campo lo siguiente: primary key (códigopr, dniemp)

create or replace table distribución(códigopr string, dniemp string, horas int, primary key(códigopr, dniemp));

insert into distribución(códigopr, dniemp, horas) values('P1','1',10);
insert into distribución(códigopr, dniemp, horas) values('P1','2',40);
insert into distribución(códigopr, dniemp, horas) values('P1','4',5);
insert into distribución(códigopr, dniemp, horas) values('P2','4',10);
insert into distribución(códigopr, dniemp, horas) values('P3','1',10);
insert into distribución(códigopr, dniemp, horas) values('P3','3',40);
insert into distribución(códigopr, dniemp, horas) values('P3','4',5);
insert into distribución(códigopr, dniemp, horas) values('P3','5',30);
insert into distribución(códigopr, dniemp, horas) values('P4','4',20);
insert into distribución(códigopr, dniemp, horas) values('P4','5',10);

create or replace table proyectos(código string primary key, descripción string, dnidir string);

insert into proyectos(código, descripción, dnidir) values('P1','Nómina','4');
insert into proyectos(código, descripción, dnidir) values('P2','Contabilidad','4');
insert into proyectos(código, descripción, dnidir) values('P3','Producción','5');
insert into proyectos(código, descripción, dnidir) values('P4','Clientes','5');
insert into proyectos(código, descripción, dnidir) values('P5','Ventas','6');