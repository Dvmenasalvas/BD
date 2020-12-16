--1
insert into Empleados values('Stephen', '65289122H', '1000');
insert into Empleados values('Michael', '65289122H', '1200');
/*
Error que empieza en la línea: 31 del comando :
insert into Empleados values('Michael', '65289122H', '1200')
Informe de error -
ORA-00001: restricción única (DG08.SYS_C0012730) violada
*/

--2
insert into Empleados values('Stephen', '65289122H');
/*
Error que empieza en la línea: 33 del comando -
insert into Empleados values('Stephen', '65289122H')
Error en la línea de comandos : 33 Columna : 13
Informe de error -
Error SQL: ORA-00947: no hay suficientes valores
00947. 00000 -  "not enough values"
*/

--3
insert into Empleados values('Stephen', '65289122H', '6000');
/*
Error que empieza en la línea: 34 del comando :
insert into Empleados values('Stephen', '65289122H', '6000')
Informe de error -
ORA-02290: restricción de control (DG08.SYS_C0012729) violada
*/

--4
insert into "Códigos postales" values('48291', 'Aranjuez', 'Madrid');
insert into Domicilios values('65289122J','Avenida Leonardo','48291'); --El código postal es válido, pero el dni no
/*
Error que empieza en la línea: 36 del comando :
insert into Domicilios values('65289122J','Avenida Leonardo','48291')
Informe de error -
ORA-02291: restricción de integridad (DG08.SYS_C0012739) violada - clave principal no encontrada
*/

--5
insert into Domicilios values('65289122H','Avenida Leonardo','48291');
delete from "Códigos postales" where "Código postal" = '48291';
/*
Error que empieza en la línea: 38 del comando :
delete from "Códigos postales" where "Código postal" = '48291'
Informe de error -
ORA-02292: restricción de integridad (DG08.SYS_C0012768) violada - registro secundario encontrado
*/

--6
insert into Teléfonos values('65289122H','111111111');
delete from Empleados where DNI = '65289122H';
/*
El empleado con dni 65289122H, tenía ya su domicilio insertado y además hemos insertado
su teléfono, a continuación hemos eliminado al empleado pero además se han eliminado
su teléfono y también su domicilio
*/

--7 
drop table Teléfonos;
CREATE TABLE Teléfonos(
    DNI Char(9) NOT NULL REFERENCES Empleados ON DELETE Set null, 
    Teléfono Char(9) NOT NULL,
    PRIMARY KEY (DNI, Teléfono)
);
insert into Teléfonos values('12345678C','111111111');
delete from Empleados where dni = '12345678C';

/* Borramos la tabla Teléfonos para crear una con las especificaciones pedidas
Insertamos un elemento que referencie a Empleados
Borramos ese empleado

Informe de error -
ORA-01407: no se puede actualizar ("CC08"."TELÉFONOS"."DNI") a un valor NULL

Nos da un error ya que se ha especificado que DNI no puede ser nulo(NOT NULL)
*/

