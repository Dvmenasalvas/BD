create view vista as
    select * 
    from pedidos;

create index i_vista
on vista (código);

/*
Error que empieza en la línea: 5 del comando :
create index i_vista
on vista (código)
Informe de error -
ORA-01702: una vista no es apropiada aquí
01702. 00000 -  "a view is not appropriate here"
*Cause:    Among other possible causes, this message will be produced if an
           attempt was made to define an Editioning View over a view.
*Action:   An Editioning View may only be created over a base table.


Al ser una vista(no se guarda en memoria el resultado de la consulta)
no tiene sentido crear un índice en ella.
*/

create materialized view mVista as
    select * 
    from pedidos;

create index i_mVista
on mVista (código);

--Al ser una vista materializada(el resultado de la consulta se guarda en memoria)
--el índice se creó correctamente