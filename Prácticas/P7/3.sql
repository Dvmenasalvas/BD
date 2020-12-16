--T1
update cuentas
set saldo = saldo + 100
where numero = 123;

--T2
update cuentas
set saldo = saldo + 200
where numero = 456;

--T1
--La transaccion se bloquea ya que no se ha comprometido la de T2
update cuentas
set saldo = saldo + 300
where numero = 456;

--T2
--La transaccion se bloquea ya que no se ha comprometido la de T1
--Esto genera un interbloqueo(deadlock) que se resuelve en el usuario T1 con
--el siguiente error:
--ERROR en lÝnea 1:
--ORA-00060: detectado interbloqueo mientras se esperaba un recurso
update cuentas
set saldo = saldo + 400
where numero = 123;