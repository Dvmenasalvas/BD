--1
create or replace procedure empleados_CP(p_Referencia Contratos.Referencia%TYPE)
	v_Trayectos int;
	e_sin_trayectos EXCEPTION;
begin
	SELECT count(*) into v_Trayectos
	from Trayectos
	where Referencia = p_Referencia);
	UPDATE Contratos SET numTrayectos := v_Trayectos;
	if v_trayectos = 0 then
		raise ex_sin_trayectos;
	end if;
	DBMS_OUTPUT.PUT_LINE('Para la referencia ' || p_Referencia || ' hay ' ||v_Trayectos || ' trayectos.');
EXCEPTION
	WHEN e_sin_trayectos then	
		DBMS_OUTPUT.PUT_LINE('No hay trayectos.');
	end;
end;
