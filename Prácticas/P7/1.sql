CREATE TABLE cuentas (
numero number primary key,
 saldo number not null
 );
 
 INSERT INTO cuentas VALUES (123, 400);
INSERT INTO cuentas VALUES (456, 300);
COMMIT;

--T1
update cuentas
set saldo = saldo + 100
where numero = 123;

--T2
--Nos da saldo 400 
--Esto es porque la transaccion no se ha comprometido en T1
--Por lo tanto los cambios no son visibles para el resto de usuarios
select saldo
from cuentas
where numero = 123;

--T1
COMMIT;

--T2
--El saldo ya es 500 ya que hemos hecho COMMIT en T1
select saldo
from cuentas
where numero = 123;