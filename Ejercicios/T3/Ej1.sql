--Tema 3
--Ej 1

--clases(clase, tipo, país, númArmas, calibre, desplazamiento)
--barcos(nombre, clase, botado)
--batallas(nombre, fecha)
--resultados(barco, batalla, resultado) 

--a
select clase, pais
from clases
where calibre >= 16

--b
select nombre, desplazamiento, númArmas
from barcos, clases, resultados
where 	barcos.nombre = resultados.barco and 
		barcos.clase = clases.clase and
		resultado.batalla = 'Guadalcanal'
		
--c
select clase
from clases
where exists 	(select * 
				from barcos
				where barcos.clase = clases.clase)
				
--Forma mejor
select distinct clase
from barcos

--d
with
	resFecha as 
	(select barco, resultado, fecha
	from batallas, resultados
	where batallas.nombre = resultado.batalla)
select distinct b1.barco
from resFecha b1, resFecha b2
where 	b1.barco = b2.barco and
		b1.resultado = 'averiado' and
		b1.fecha < b2.fecha;
		
--e 
select nombre
from clases natural join barcos 
where desplazamiento > 35000;



--f
with 
	b as (select batalla, barco, pais
			from clases, barcos, resultados
			where 	clases.clase = barcos.clase and
					resultados.barco = barcos.nombre)

select distinct b1.batalla
from b b1, b b2, b b3
where 	b1.batalla = b2.batalla and	
		b1.batalla = b3.batalla and
		b1.pais = b2.pais and
		b1.pais = b3.pais and
		b1.barco <> b2.barco and
		b2.barco <> b3.barco and
		b1.barco <> b3.barco
		

--Otra forma
select distinct batalla 
from resultados inner join barcos
	on barco = nombre natural join clases
group by batalla, pais
	having count(pais) >= 3
--Tambien valdría count(*)
		
		
--h
select distinct clase
from resultados, barcos
where resultados.barco = barcos.nombre and
		resultados.resultado = 'hundido';
		
--Otra forma
select clase
from clases C 
where exists (select *
				from resultado, barcos
				where nombre = barco and
				resultado = 'hundido' and
				C.clase = clase)
				
--i
select count(clase)
from 	(select distinct clase
		from clases)
		
--j 
select botado
from barcos B
where not exists 	(select *
					from barcos
					where 	B.clase = clase and
							botado < B.botado)

--Otra forma, no seguro que funcione
select min(botado)
from barcos
group by clase