CREATE OR REPLACE PROCEDURE comprobar_NULL AS
	excepcionNulo    EXCEPTION;
    v_CódigoPostal    VARCHAR(5);
    v_Población       VARCHAR(50);
    v_Provincia       VARCHAR(50);
	CURSOR cursorCP IS
		SELECT *
		FROM "Códigos postales I"
		WHERE   "Código postal" is null or
                población is null or
                provincia is null;
BEGIN
	OPEN cursorCP;
	LOOP
		fetch cursorCP into v_CódigoPostal, v_Población, v_Provincia;
		EXIT WHEN cursorCP%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE (v_CódigoPostal || ';' || v_Población  || ';' ||  v_Provincia);
	END LOOP;
	IF(cursorCP%ROWCOUNT > 0) then
		RAISE excepcionNulo;
	END IF;
	CLOSE cursorCP;
EXCEPTION
	WHEN excepcion_nulo THEN
		IF(codigos%ROWCOUNT > 1) THEN 
			DBMS_OUTPUT.put_line('Hay ' || codigos%ROWCOUNT || ' tuplas nulas.');
		ELSE 
			DBMS_OUTPUT.put_line('Hay ' || codigos%ROWCOUNT || ' tupla nula.');
		END IF;
END;

execute comprobar_NULL();