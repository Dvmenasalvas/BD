--1
create or replace procedure empleaos_tlf(p_teléfono in Teléfonos.teléfono%TYPE)
	v_DNI 		Empleados.DNI%TYPE;
	v_Nombre	Empleados.Nombre%TYPE;
BEGIN	
	SELECT DNI, Nombre INTO V_DNI, V_Nombre
	FROM Empleados NATURAL JOIN Teléfonos
	WHERE Teléfono = p_Teléfono;
	DBMS_OUTPUT.PUT_LINE('El empleado con el teléfono ' p_teléfono || ' es: ' || v_Nombre || 'con DNI: ' v_DNI);
EXCEPTION	
	WHEN NO_DATA_FOUND
		DBMS_OUTPUT.PUT_LINE('No se encontró el empleado con el teléfono ' p_teléfono || '.');
	WHEN MANY_ROWS
		DBMS_OUTPUT.PUT_LINE('Hay más de un empleado con el teléfono ' || p_teléfono || '.');
END;

--2
create or replace procedure comprobar_poblaciones
	v_Pob "Códigos postales"	Población %TYPE;
	ex_pob_repe					exception;
BEGIN 
	select Población into v_Pob
	from "Códigos postales"
	group by Población
	having count(distinct Provincia) > 1;
	raise ex_pob_repe;
exception
	when NO_DATA_FOUND	
		DBMS_OUTPUT.PUT_LINE('No hay dos o más provincias que compartan la misma población.');
	when ex_pob_repe
		DBMS_OUTPUT.PUT_LINE('A la población ' v_Pob ' no le corresponde siempre la misma provincia.');

--3
create or replace procedure empleados_CP
	cursor C_CPs is 
		select cp, avg(sueldo) media, count(*) recuento
		from Empleados NATURAL INNER JOIN Domicilios
		group by CP;
	v_fileCP	c.CPS%TYPE;
	v_total int := 0;
	CURSOR C_Empleados(p_CP) is	
		select Nombre, Sueldo, Dirección
		from Empleados
		where CP = p_CP;
BEGIN 
	FOR v_fileCP in c_CPs LOOP	
		DBMS_OUTPUT.PUT_LINE('Código postal: ' || v_fileCP.CP);
		OPEN c_Empleados(v_fileCP.CP);
		LOOP
			FETCH c.Empleados INTO v_filaEmp;
			EXIT WHEN c_Empleados%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE(v_filaEMp.Nombre ||' ' || v_filaEMp.Dirección || ' ' || v_filaEMp.Sueldo);
		END LOOP;
		close c_Empleados;
		v_total := v_total + v_filaCP.recuento;
		DBMS_OUTPUT.PUT_LINE('Nº empleados: ' || v_filesCP.recuento || 'Sueldo medio: ' || v_fileCP.media);
	End loop
	dbms_output.put_line('Total empleados: ' || v_total);
end;
