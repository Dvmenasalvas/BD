-- Para procesar este archivo (se puede especificar tambi�n la ruta): /process datos.ra
-- Antes deb�is crear las relaciones (tablas).
-- Falta la �ltima tupla de cada tabla y deb�is escribir vosotros la instrucci�n de inserci�n en cada caso

/abolish
/sql

create or replace table programadores(dni string primary key, nombre string, direcci�n string, tel�fono string);

insert into programadores(dni, nombre, direcci�n, tel�fono) values('1','Jacinto','Jazm�n 4','91-8888888');
insert into programadores(dni, nombre, direcci�n, tel�fono) values('2','Herminia','Rosa 4','91-7777777');
insert into programadores(dni, nombre, direcci�n, tel�fono) values('3','Calixto','Clavel 3','91-1231231');
insert into programadores(dni, nombre, direcci�n, tel�fono) values('4','Teodora','Petunia 3','91-6666666');

create or replace table analistas(dni string primary key, nombre string, direcci�n string, tel�fono string);

insert into analistas(dni, nombre, direcci�n, tel�fono) values('4','Teodora','Petunia 3','91-6666666');
insert into analistas(dni, nombre, direcci�n, tel�fono) values('5','Evaristo','Luna 1','91-1111111');
insert into analistas(dni, nombre, direcci�n, tel�fono) values('6','Luciana','J�piter 2','91-8888888');
insert into analistas(dni, nombre, direcci�n, tel�fono) values('7','Nicodemo','Plut�n 3',NULL);

-- Para crear una clave primaria de m�s de un atributo hay que a�adir al final como si fuese otro campo lo siguiente: primary key (c�digopr, dniemp)

create or replace table distribuci�n(c�digopr string, dniemp string, horas int, primary key(c�digopr, dniemp));

insert into distribuci�n(c�digopr, dniemp, horas) values('P1','1',10);
insert into distribuci�n(c�digopr, dniemp, horas) values('P1','2',40);
insert into distribuci�n(c�digopr, dniemp, horas) values('P1','4',5);
insert into distribuci�n(c�digopr, dniemp, horas) values('P2','4',10);
insert into distribuci�n(c�digopr, dniemp, horas) values('P3','1',10);
insert into distribuci�n(c�digopr, dniemp, horas) values('P3','3',40);
insert into distribuci�n(c�digopr, dniemp, horas) values('P3','4',5);
insert into distribuci�n(c�digopr, dniemp, horas) values('P3','5',30);
insert into distribuci�n(c�digopr, dniemp, horas) values('P4','4',20);
insert into distribuci�n(c�digopr, dniemp, horas) values('P4','5',10);

create or replace table proyectos(c�digo string primary key, descripci�n string, dnidir string);

insert into proyectos(c�digo, descripci�n, dnidir) values('P1','N�mina','4');
insert into proyectos(c�digo, descripci�n, dnidir) values('P2','Contabilidad','4');
insert into proyectos(c�digo, descripci�n, dnidir) values('P3','Producci�n','5');
insert into proyectos(c�digo, descripci�n, dnidir) values('P4','Clientes','5');
insert into proyectos(c�digo, descripci�n, dnidir) values('P5','Ventas','6');


--Ejercicio 1
create view vista1 as select dni from select * from analistas union select * from programadores

--Ejercicio 2
create view vista2 as select dni from (select * from analistas intersect select * from programadores)

--Ejercicio 3
create view vista3 as select * from vista1 where dni not in (select dniemp from distribuci�n union select dnidir from proyectos)

--Ejercicio 4
create view prAnalistas as select c�digopr from distribuci�n where dniemp in select dni from analistas

create view vista4 as select c�digo from proyectos  where c�digo not in select * from prAnalistas 

--Ejercicio 5
create view vista5 as select dnidir from proyectos where dnidir not in select dni from programadores

--Ejercicio 6 - No coincide con soluci�n
create view empleados as select * from analistas union select * from programadores

create view nombres as select programadores.nombre, distribuci�n.* from distribuci�n join programadores on distribuci�n.dniemp = programadores.dni

create view vista6 as select proyectos.descripci�n, nombres.nombre, nombres.horas from nombres join proyectos on proyectos.c�digo = nombres.c�digopr

--Ejercicio7
create view vista7 as select e1.tel�fono from empleados e1, empleados e2 where e1.dni <> e2.dni and e1.tel�fono = e2.tel�fono

--Ejercicio 8
create view vista8 as select programadores.dni from programadores join analistas on analistas.dni = programadores.dni

--Ejercicio9
create view vista9 as select dniemp, sum(horas) from distribuci�n group by dniemp

--Ejercicio10
create view vista10 as select empleados.dni, empleados.nombre, distribuci�n.c�digopr from empleados left outer join distribuci�n on empleados.dni = distribuci�n.dniemp

--Ejercicio11
create view vista11 as select dni, nombre from empleados where tel�fono is null

--Ejercicio12
create view avgPrAux as select avg(horas) as media from distribuci�n group by c�digopr
create view avgPr as select avg(media) as promedio from avgPrAux 
create view avgEmp as select distribuci�n.dniemp, avg(distribuci�n.horas) as mediaEmp from distribuci�n group by dniemp

create view vista12 as select avgEmp.dniemp from avgEmp left outer join avgPr on true where avgEmp.mediaEmp < avgPr.promedio

--Ejercicio13
create view prEvaristo as select c�digopr from distribuci�n where dniemp = '5'
create view vista13 as select dniemp from (select dniemp,c�digopr from distribuci�n) division prEvaristo

--Ejercicio14
create view nEvaristo as select count(c�digopr) as num from prEvaristo

create view conEvaristo as select distribuci�n.dniemp as dni, distribuci�n.c�digopr from distribuci�n join prEvaristo on distribuci�n.c�digopr = prEvaristo.c�digopr

create view nEmpleados as select dni, count(c�digopr) as num from conEvaristo group by dni

create view vista14 as select dni from nEmpleados join nEvaristo on nEmpleados.num >= nEvaristo.num

--Ejercicio15
create view vista15 as select c�digopr, dniemp as dni, horas * 1,2 from distribuci�n where dniemp in (select dniemp from distribuci�n where c�digopr not in select * from prEvaristo)



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
create view dniEva as select dniemp as dni from distribuci�n where dniemp = '5'

create view proyDirJefe as (select c�digo from dniEva natural join proyectos on dni = dnidir)
create view empleDepJefe as (select dniemp from proyDirJefe natural join distribuci�n on c�digo = c�digopr)


create view recursion(depen) as select dniemp from empleDepJefe union all select dniemp from (select c�digo from recursion natural join proyectos on depen = dnidir) natural join distribuci�n on c�digo = c�digopr

create view vista16aux as (select * from recursion except select * from dniEva)

create view vista16 as (select nombre from empleados natural join vista16aux on dni = depen)

select * from vista16
