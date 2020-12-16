--Ejercicio 1
create view vista1 as (select Nombre, Calle, "Codigo postal"  from Empleados natural join Domicilios   order by "Codigo postal", Nombre);
select true(vista1);

--Ejercicio 2
create view vista2 as (select Nombre, DNI, Calle, "Codigo postal", Telefono from Empleados natural join Telefonos natural left outer join Domicilios order by Nombre);

select true(vista2);

--Ejercicio 3 Pablito es un fiera
Joder con el JC, como curra el cabron
Le va a pasar al steve jobs por la derecha
Es una mala bestia


create view vista3 as select Nombre, ED.DNI, Calle, "Codigo postal", Telefono from (Empleados left outer join Domicilios on Empleados.DNI = Domicilios.DNI) ED Left outer join Telefonos on ED.DNI = Telefonos.DNI;


--Ejercicio 4
create view vista4 as (select Nombre, DNI, Calle, Poblacion, Provincia, "Codigo postal" from Empleados natural left outer join Domicilios natural left outer join "Codigos postales" order by Nombre);
 select true(vista4);


--Ejercicio 5
create view vista5 as (select Nombre, DNI, Calle, Poblacion, Provincia, "Codigo postal", Telefono from (Empleados natural left outer join Telefonos) natural left outer join (Domicilios natural join "Codigos postales")  order by Nombre);

select true (vista5);


--Ejercicio 6
Update Empleados set Sueldo = Sueldo*1.1 where Sueldo*1.1 < 1900.00;

--Ejercicio 7
Update Empleados set Sueldo = Sueldo*(1/1.1) where Sueldo*1.1 < 1900.00;

--Ejercicio 8
Update Empleados set Sueldo = Sueldo*1.1 where Sueldo*1.1 < 1600.00;
Update Empleados set Sueldo = Sueldo*(1/1.1) where Sueldo*1.1 < 1600.00;

A diferencia del ejercicio del ejercicio 6, aquí hay un empleado que tiene un sueldo inferior al límite pero que al aumentarlo un 10% el sueldo resultante supera el límite.
Por lo tanto, no hay que modificar el sueldo de dicho empleado

--Ejercicio 9
create view vista9 as 
select count(Sueldo) as Empleados, min(Sueldo) as "Sueldo mínimo", max(Sueldo) as "Sueldo máximo", avg(Sueldo) as "Sueldo medio"
from Empleados;

--Ejercicio 10
create view vista10 as 
select avg(Sueldo) as "Sueldo medio", count(Nombre) as "Número empleados", Poblacion 
from Empleados natural left outer join Domicilios natural left outer join "Codigos postales" 
group by Poblacion
order by Poblacion;
select true(vista10);

--Ejercicio 11
create view aux11 as (select Nombre, Emp1.DNI, Telefono from Empleados Emp1, Telefonos Tel1 where (Emp1.DNI = Tel1.DNI and exists  (select * from Empleados, Telefonos where Empleados.DNI = Telefonos.DNI and Emp1.DNI = Empleados.DNI and Tel1.Telefono <> Telefonos.Telefono)));

create view vista11 as select * from aux11 order by Nombre;
select true (vista11);
