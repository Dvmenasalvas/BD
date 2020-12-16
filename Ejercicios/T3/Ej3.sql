--Tema 2
--Ej 3

--marcas(cifM, nombre, ciudad)
--coches(codCoche, nombre, modelo)
--concesionarios(cifC, nombre, ciudad)
--clientes(dni, nombre, apellidos, ciudad)
--distribución(cifC, codCoche, cantidad)
--ventas(cifC, dni, codCoche, color)
--fabricado(cifM, codCoche)

--a
select ventas.codCoche
from concesionarios, clientes, ventas
where 	ventas.cifC = concesionarios.cifC and
		ventas.dni = clientes.dni and
		clientes.ciudad = 'Madrid' and
		concesionarios.ciudad = 'Madrid'

		
--Otra forma
select codCoche
from (coches natural join ventas) natural join concesionarios using (cifC, ciudad)
where ciudad = 'Madrid'

--b
select distinct dni 
from ventas, concesionarios
where 	ventas.cifC = concesionarios.cifC and
		concesionarios.ciudad = 'Madrid'
		
--c 
select C1.nombre, C1.apellidos
from clientes C1, clientes C2
where 	C2.nombre = 'Juan' and
		C2.apellidos = 'Martín Martín' and
		C1.dni < C2.dni;

--d
select nombre, apellidos
from clientes C
where 	ciudad = 'Barcelona' and
		not exists 	(select * 
					from clientes
					where 	clientes.ciudad = 'Barcelona' and
							clientes.dni <= C.dni)
		
--e
select nombre, apellidos
from clientes C
where 	exists 	(select *
				from ventas
				where 	ventas.dni = C.dni and
						ventas.color = 'blanco')
		and exists (select *
				from ventas
				where 	ventas.dni = C.dni and
						ventas.color = 'rojo')

--f
select dni
from clientes
where ciudad in 	(select max(ciudad)
					from concesionarios)
		
--g) ***
select cifC
from concesionarios C
where ciudad <> 'Madrid' AND 
			(select avg(cantidad)
			from distribución D
			where C.cifC = D.cifC) = 
			(select max(media)
			from 	(select avg(cantidad) media
					from distribución
					where ciudad <> 'Madrid' 
					group by cifC)
			)
						
--h)
select DISTINCT codCoche 
from ventas NATURAL JOIN concesionarios
where ciudad = 'Madrid'

--i)
select dni
from ventas V
where 	cifC = '0001' and
		not exists 	(select *
					from ventas
					where 	V.dni = ventas.dni and
							cifC <> '0001')

select cifC
from concesionarios C
where exists (select codCoche
				from ventas
				where 	C.cifC = ventas.cifC and
						)







							
--j **
select cifC from  ventas v1
where exists(select codCoche
			from ventas v2
			where not exists 	(select dni 
								from clientes C
								where not exists 	(select *
													from ventas v3
													where v3.cifC = v1.cifC and 
															v3.codCoche = v2.codCoche and
															v3.dni = C.dni)));

			