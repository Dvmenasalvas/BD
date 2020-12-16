--Tema 2

--Ej3
--sede(nom_comp, ciudad)
--trabaja(nom_emp, nom_comp, sueldo)
--vive(nom_emp, calle, ciudad)
--tiene-jefe(nom_emp, nom_jefe) 

--a
trabajaIBM := project nom_emp(select nom_comp = 'IBM' (trabaja))

--b
noTrabajaIBM := project nom_emp(trabaja) difference trabajaIBM

--c
auxC := project nom_emp(select nom_comp = 'IBM' and sueldo > 2000 (trabaja))
vistaC := auxC njoin vive

--d
auxD1 := rename auxD1(nom_comp, comp_ciudad, nom_emp, sueldo) (sede njoin trabaja) 
vistaD := select ciudad = comp_ciudad (auxD1 njoin vive)

