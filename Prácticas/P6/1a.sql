CREATE TABLE pedidos(
    código Char(6),
    fecha Char(10),
    importe Number(6,2),
    cliente Char(20),
    notas Char(1024),
    PRIMARY KEY(código)
);
CREATE TABLE contiene(
    pedido char(6),
    plato Char(20),
    precio Number(6,2),
    unidades Number(2,0),
    PRIMARY KEY(pedido,plato)
);
CREATE TABLE auditoría(
    operación Char(6), 
    tabla Char(50), 
    fecha Char(10), 
    hora Char(8)
);