--T1
ALTER SESSION SET ISOLATION_LEVEL = SERIALIZABLE;

--T1
--Da 1800
SELECT SUM(saldo) FROM cuentas;

--T2
UPDATE cuentas SET saldo=saldo +100;
COMMIT;

--T1
--La suma sigue siendo 1800
--Al ser serializable, las transacciones estan completamente aisladas
SELECT SUM(saldo) FROM cuentas;

--T1
ALTER SESSION SET ISOLATION_LEVEL = READ COMMITTED;

--T1
--Ahora ya da 2000
SELECT SUM(saldo) FROM cuentas;

--T2
UPDATE cuentas SET saldo=saldo +100;
COMMIT;

--T1
--Da 2200
--Al poner read commited los cambios son visibles por las otras transacciones
-- en cuanto se realiza el commit
SELECT SUM(saldo) FROM cuentas;