--Un trigger es un objeto SQL el cual realiza acciones automaticamente
--como por ejemplo insert datos cuando se realiza otra accion CRUD


CREATE TABLE sucursal_log(
    ID INT NOT NULL AUTO_INCREMENT,
    fecha_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    nota_log VARCHAR(20),
    nombre_sucursal_new VARCHAR(20),
    UNIQUE(ID)
);
--Cambio que el constraint AUTO_INCREMENT empieze por 5
--esto solo funciona en mysql
ALTER TABLE sucursal_log AUTO_INCREMENT=5;

DROP TABLE sucursal_log;

SELECT * FROM sucursal_log;
DESCRIBE sucursal_log;

--Inserto datos prueba
INSERT INTO sucursal_log(nota_log) VALUES("Prueba");

--Elimino todos los datos de la tabla sucursal_log
DELETE FROM
sucursal_log;



--Trigger :)
--NOTA: Tenemos que ejecutar el trigger directamente en la 
--Consola sino no funcionara.

Syntax:

create trigger [trigger_name] 

[before | after]  

{insert | update | delete}  

on [table_name]  

[for each row]  

[trigger_body] 
 

--Ejemplo:
--En este ejemplo voy a crear una tabla que hace un log cuando se 
--mete una nueva sucursal
--DELIMITER $$ Y DELMITER; es necesario por que cerramos un
--statement de sql con ;
--BEGIN Y END$$ es lo mismo que => {} text curly brackets
DELIMITER $$
CREATE TRIGGER nueva_sucursal
BEFORE INSERT
ON sucursal
    FOR EACH ROW BEGIN
    INSERT INTO sucursal_log(nota_log, nombre_sucursal_new) VALUES("Nueva sucursal!", NEW.nombre_sucursal);
    END$$
DELIMITER;

--Probamos si funciona nuestro trigger
INSERT INTO sucursal VALUES(3, "TUI UK", 100, "2020-10-20");
select * from sucursal;
--Elimino TUI UK
DELETE FROM sucursal
WHERE nombre_sucursal = "TUI UK";
--Print Triggers = nueva_sucursal
SHOW CREATE TRIGGER nueva_sucursal;

--Eliminar trigger :(
DROP TRIGGER nueva_sucursal;