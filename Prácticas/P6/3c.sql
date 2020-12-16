SET TIMING ON;
SELECT * FROM pedidos WHERE cliente = 'C50000';

--Hemos tenido que buscar el cliente C50000 (que obviamente tarda mucho
--menos en buscarse ya que no teníamos permisos y el admin estaba bloqueado)

--Con indice
-->>Query Run In:Resultado de la Consulta 4
--Transcurrido: 00:00:00.099

drop index index_pedidos;

--Sin indice
-->>Query Run In:Resultado de la Consulta 5
--Transcurrido: 00:00:00.347

