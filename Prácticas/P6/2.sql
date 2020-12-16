CREATE OR REPLACE TRIGGER trigger_contiene
AFTER INSERT OR DELETE OR UPDATE ON CONTIENE
FOR EACH ROW
BEGIN 
    IF INSERTING THEN
        UPDATE pedidos 
        SET importe = importe + :NEW.precio * :NEW.unidades 
        WHERE :NEW.pedido = código;
    ELSIF DELETING THEN
        UPDATE pedidos 
        SET importe = importe - :OLD.precio * :OLD.unidades 
        WHERE :OLD.pedido = código;
    ELSIF UPDATING THEN
        UPDATE pedidos 
        SET importe = importe + :NEW.precio * :NEW.unidades - :OLD.precio * :OLD.unidades 
        WHERE :NEW.pedido = código;
    END IF;    
END;