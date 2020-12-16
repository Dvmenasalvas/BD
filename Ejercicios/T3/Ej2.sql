--Tema 3
--Ej2

--a
select distinct nombre
from programadores, distribución 
where 	dni = dniEmp and
		códigoPr in (select códigoPr
					from distribución, analistas
					where 	dniEmp = dni and
							nombre = 'Teodora')
							
--b ??????????
with 
	candidatos as
		(select nombre
		from programadores),
	producto as
		(candidatos product
		)
		
--c ?????????
select distinct nombre
from programadores P
where  exists 	(select *
				from programadores, distribución
				where	programadores.dni = distribución.dniEmp and
						)