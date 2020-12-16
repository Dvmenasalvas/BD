--SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET serveroutput ON size 1000000;
set define on;
SET echo OFF;
SET verify OFF;
def v_evento='Circo';
def v_fila='1';
def v_columna='2';
variable v_error char(20)
/
declare
  v_existe varchar(20) default null;
begin
  select count(*) into v_existe from butacas where evento='&v_evento' and fila='&v_fila' and columna='&v_columna';
  if v_existe='0' then 
    dbms_output.put_line('ERROR: No existe esa localidad.');
    :v_error:='true';
  else 
    :v_error:='false';
  end if;
end;
/
col SCRIPT_COL new_val SCRIPT
select decode(:v_error,'false','"preguntar.sql"','"no_preguntar.sql"') as SCRIPT_COL from dual;
print :v_error
--prompt 'Valor script: '&SCRIPT
@preguntar.sql
prompt &v_confirmar
/
declare
  v_exist varchar(20) default null;
begin
  if '&v_confirmar'='s' and :v_error='false' then
    select count(*) into v_exist from reservas where evento='&v_evento' and fila='&v_fila' and columna='&v_columna';
    if v_exist='0' then
        insert into reservas values (Seq_Reservas.NEXTVAL,'&v_evento','&v_fila','&v_columna');
    dbms_output.put_line('INFO: Localidad reservada.');
    else
        dbms_output.put_line('ERROR: La localidad ya está reservada.');
    end if;
  else
    dbms_output.put_line('INFO: No se ha reservado la localidad.');
  end if;
end;
/
COMMIT;

/*
Comprobamos si la butaca esta reservada despues de pedir confirmación,
de esta forma evitamos que, mientras damos la confirmación, otra transacción
pueda reservar la butaca y, por lo tanto, se terminen haciendo dos reservas.
*/