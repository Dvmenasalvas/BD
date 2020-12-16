CREATE OR REPLACE TRIGGER trigger_pedidos 
AFTER INSERT OR DELETE OR UPDATE ON pedidos
BEGIN 
    IF DELETING THEN
        INSERT INTO auditoría 
            VALUES ('DELETE', 'pedidos', 
                to_char(sysdate,'dd/mm/yyyy'), to_char(sysdate,'hh:mi:ss'));
    ELSIF INSERTING THEN
        INSERT INTO auditoría 
            VALUES ('INSERT', 'pedidos', 
                to_char(sysdate,'dd/mm/yyyy'), to_char(sysdate,'hh:mi:ss'));
    ELSIF UPDATING THEN
        INSERT INTO auditoría 
            VALUES ('UPDATE', 'pedidos', 
                to_char(sysdate,'dd/mm/yyyy'), to_char(sysdate,'hh:mi:ss'));
    END IF;    
END;