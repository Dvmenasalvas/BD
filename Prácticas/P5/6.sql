CREATE OR REPLACE PROCEDURE comprobar_FK (maxerrores number) as
	max_alcanzado   EXCEPTION;
    v_DNI                VARCHAR(9);
    v_CALLE              VARCHAR(50);
    v_CódigoPostal       VARCHAR(5);
    v_aux                number := 0;
	CURSOR cursorCP2 IS
		SELECT *
		FROM "Domicilios I" D
		where not exists 
			(select "Código postal"
			from "Códigos postales I" C
			where D."Código postal" = C."Código postal");
BEGIN
	OPEN cursorCP2;
	LOOP
		FETCH cursorCP2 into v_DNI, v_CALLE, v_CódigoPostal;
        EXIT WHEN cursorCP2%NOTFOUND or v_aux >= maxerrores;
		DBMS_OUTPUT.PUT_LINE (v_DNI || ';' || v_CALLE || ';' || v_CódigoPostal);
        v_aux := v_aux + 1;
	END LOOP;
	if (cursorCP2%ROWCOUNT > 0) then
		DBMS_OUTPUT.put('Se ha producido una violación de la integridad referencial en ' || codigos%ROWCOUNT || ' tuplas, de las cuales se muestran ' || maxerrores ||'.');
	end if;
	CLOSE cursorCP2;
END;

execute comprobar_FK(4);

