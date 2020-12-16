--T1
update cuentas
set saldo = saldo + 100
where numero = 123;

--T2
--Se bloquea
update cuentas
set saldo = saldo + 200
where numero = 123;

--T1
--Al hacer COMMIT, la transacción de T2 se desbloquea
COMMIT;

--T1
--Da 600, aun no se ha comprometido la transacción de T2
select saldo
from cuentas
where numero = 123;

--T2
COMMIT;

--T1
--Da 800, ya se ha comprometido la transacción de T2
select saldo
from cuentas
where numero = 123;