--1
create or replace trigger validar_parejas
before insert on Parejas
for each row
	v_H Participantes.sexo%TYPE;
	v_M Participantes.sexo%TYPE;
	p_E EXCEPTION;
begin
	select sexo int v_H
	from Participantes
	where Participantes.nick = :NEW.hombre;
	
	select sexo into v_M
	from Participantes
	where Participantes.nick = :NEW.mujer;
	
	if v_H = 'M' or v_M = 'H' then
		raise p_E
	end if;
exception
	when p_E then
		DBMS_OUTPUT.PUT_LINE('Error!!!!');
END;

--2
create or replace trigger actualizar_maestro
before update on Partidas
for each row
	v_Partidas int;
	v_nick Juegos.nick%TYPE;
	--p_E EXCEPTION;
begin
	if :NEW.resultado = 1 then
	select count(*) into v_Partidas
	from Partida
	where 	nickRetador = :OLD.nickRetador and
			juego = :OLD.juego;
	v_nick = :OLD.nickRetador;
	
	elsif :NEW.resultado = 2 then 
	select count(*) into v_Partidas
	from Partida
	where 	nickRetado = :OLD.nickRetado and
			juego = :OLD.juego;
	v_nick = :OLD.nickRetado;
	end if;
END;