-- Para procesar este archivo (se puede especificar también la ruta): /process datos.ra
-- Antes debéis crear las relaciones (tablas).
-- Falta la última tupla de cada tabla y debéis escribir vosotros la instrucción de inserción en cada caso

/abolish
/sql

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


--Ejercicio 1
create view vista1 as select dni from select * from analistas union select * from programadores

--Ejercicio 2
create view vista2 as select dni from (select * from analistas intersect select * from programadores)

--Ejercicio 3
create view vista3 as select * from vista1 where dni not in (select dniemp from distribución union select dnidir from proyectos)

--Ejercicio 4
create view prAnalistas as select códigopr from distribución where dniemp in select dni from analistas

create view vista4 as select código from proyectos  where código not in select * from prAnalistas 

--Ejercicio 5
create view vista5 as select dnidir from proyectos where dnidir not in select dni from programadores

--Ejercicio 6 - No coincide con solución
create view empleados as select * from analistas union select * from programadores

create view nombres as select programadores.nombre, distribución.* from distribución join programadores on distribución.dniemp = programadores.dni

create view vista6 as select proyectos.descripción, nombres.nombre, nombres.horas from nombres join proyectos on proyectos.código = nombres.códigopr

--Ejercicio7
create view vista7 as select e1.teléfono from empleados e1, empleados e2 where e1.dni <> e2.dni and e1.teléfono = e2.teléfono

--Ejercicio 8
create view vista8 as select programadores.dni from programadores join analistas on analistas.dni = programadores.dni

--Ejercicio9
create view vista9 as select dniemp, sum(horas) from distribución group by dniemp

--Ejercicio10
create view vista10 as select empleados.dni, empleados.nombre, distribución.códigopr from empleados left outer join distribución on empleados.dni = distribución.dniemp

--Ejercicio11
create view vista11 as select dni, nombre from empleados where teléfono is null

--Ejercicio12
create view avgPrAux as select avg(horas) as media from distribución group by códigopr
create view avgPr as select avg(media) as promedio from avgPrAux 
create view avgEmp as select distribución.dniemp, avg(distribución.horas) as mediaEmp from distribución group by dniemp

create view vista12 as select avgEmp.dniemp from avgEmp left outer join avgPr on true where avgEmp.mediaEmp < avgPr.promedio

--Ejercicio13
create view prEvaristo as select códigopr from distribución where dniemp = '5'
create view vista13 as select dniemp from (select dniemp,códigopr from distribución) division prEvaristo

--Ejercicio14
create view nEvaristo as select count(códigopr) as num from prEvaristo

create view conEvaristo as select distribución.dniemp as dni, distribución.códigopr from distribución join prEvaristo on distribución.códigopr = prEvaristo.códigopr

create view nEmpleados as select dni, count(códigopr) as num from conEvaristo group by dni

create view vista14 as select dni from nEmpleados join nEvaristo on nEmpleados.num >= nEvaristo.num

--Ejercicio15
create view vista15 as select códigopr, dniemp as dni, horas * 1,2 from distribución where dniemp in (select dniemp from distribución where códigopr not in select * from prEvaristo)



select * from vista1
select * from vista2
select * from vista3
select * from vista4
select * from vista5
select * from vista6
select * from vista7
select * from vista8
select * from vista9
select * from vista10
select * from vista11
select * from vista12
select * from vista13
select * from vista14
select * from vista15
select * from vista16


--Ejercicio16
create view dniEva as select dniemp as dni from distribución where dniemp = '5'

create view proyDirJefe as (select código from dniEva natural join proyectos on dni = dnidir)
create view empleDepJefe as (select dniemp from proyDirJefe natural join distribución on código = códigopr)


create view recursion(depen) as select dniemp from empleDepJefe union all select dniemp from (select código from recursion natural join proyectos on depen = dnidir) natural join distribución on código = códigopr

create view vista16aux as (select * from recursion except select * from dniEva)

create view vista16 as (select nombre from empleados natural join vista16aux on dni = depen)

select * from vista16
