CREATE OR REPLACE PROCEDURE comprobar_PK AS
	excepcion_repetido   EXCEPTION;
    v_CódigoPostal       VARCHAR(5);
    v_Cuenta             NUMBER;
	CURSOR cursorCP2 IS
		SELECT "Código postal", COUNT("Código postal")
		FROM "Códigos postales I"
        group by "Código postal"
        having count("Código postal") > 1 or "Código postal" is null;
BEGIN
	OPEN cursorCP2;
	LOOP
		FETCH cursorCP2 into v_CódigoPostal, v_Cuenta;
        EXIT WHEN cursorCP2%NOTFOUND;
		RAISE excepcion_repetido;
	END LOOP;
	CLOSE cursorCP2;

EXCEPTION
	WHEN excepcion_repetido then 
        if ("Código postal" is null) then
		DBMS_OUTPUT.PUT_LINE ('Hay una tupla sin código postal');
        else
		DBMS_OUTPUT.PUT_LINE ('Código postal repetido: ' || v_CódigoPostal);
        end if;
END;

execute comprobar_PK();