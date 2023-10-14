--Vamos a editar ID de la tabla sucursal_log 
--Para que sea solo un int primary key

DESCRIBE sucursal_log;

ALTER TABLE sucursal_log
ADD COLUMN ID INT DEFAULT 2,
ADD PRIMARY KEY (fecha_inicio);

ALTER TABLE sucursal_log
ADD PRIMARY KEY(fecha_inicio);

ALTER TABLE sucursal_log
DROP PRIMARY KEY;

--FK
select * from sucursal_log;
select * from sucursal;
--new fk
ALTER TABLE sucursal_log
ADD COLUMN sucursal_id INT UNIQUE,
ADD FOREIGN KEY(sucursal_id) REFERENCES sucursal(sucursal_id);
--Haciendolo bien poniendo un nombre al constraint foreign key
--para poderlo eliminar mas facil
ALTER TABLE sucursal_log
ADD COLUMN sucursal_id INT UNIQUE,
ADD CONSTRAINT mi_fk_sucursal_id FOREIGN KEY(sucursal_id) REFERENCES sucursal(sucursal_id);

--PARA VER EN NOMBRE DEL CONSTRAINT FOREIGN KEY
--SI NO LE HEMOS PUESTO NOMBRE AL CONSTRAINT
SHOW CREATE TABLE sucursal_log;
--Ahora que tenemos el nombre :)
ALTER TABLE sucursal_log
DROP FOREIGN KEY mi_fk_sucursal_id;

ALTER TABLE sucursal_log
DROP COLUMN sucursal_id;

ALTER TABLE sucursal_log
MODIFY fecha_inicio DATETIME
AFTER nota_log;

SHOW INDEX FROM sucursal_log;

--ELIMINO
ALTER TABLE sucursal_log
DROP COLUMN ID;

--Cambiar nombre
ALTER TABLE sucursal_log
RENAME COLUMN nota_log TO note_log;
