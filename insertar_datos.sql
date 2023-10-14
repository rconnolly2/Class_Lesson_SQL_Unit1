--Insertamos datos

--Primero datos TUI Spain y sucursal TUI Spain
INSERT INTO empleado
VALUES(100, "Antonio", "Martorell", "1976-11-12", "M", 60000, NULL, NULL);
--Creo la sucursal TUI Spain
INSERT INTO sucursal
VALUES(1, "TUI Spain", 100, "2000-01-20");
--Actualizo manager con su sucursal
/*
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;*/
UPDATE empleado
SET sucursal_id = 1
WHERE empleado.nombre = "Antonio";

--Esclavos xD
INSERT INTO empleado(empleado_id, nombre, apellido, fecha_nacimiento, sexo, salario, superior_id, sucursal_id)
VALUES(101, "Robert", "Connolly", "2001-10-20", "M", 21000, 100, 1);
INSERT INTO empleado
VALUES(102, "Jordi", "Bestard", "2005-04-10", "M", 15000, 100, 1);
INSERT INTO empleado
VALUES(103, "David", "Adam", "1985-06-03", "M", 24000, 100, 1);
--Todo bien
SELECT * FROM empleado;
SELECT * FROM sucursal;

DELETE FROM sucursal
WHERE nombre_sucursal = "Hotelbeds";

--Ahora Hotelbeds
INSERT INTO empleado
VALUES(104, "Juanjo", "Calafell", "1970-10-08", "M", 50000, NULL, NULL);
--Creo la sucursal TUI Spain
INSERT INTO sucursal
VALUES(2, "Hotelbeds", 104, "2004-05-05");
--Actualizo manager con su sucursal
UPDATE empleado
SET empleado.sucursal_id = 2
WHERE empleado.nombre = "Juanjo";
--Empleados
INSERT INTO empleado(empleado_id, nombre, apellido, fecha_nacimiento, sexo, salario, superior_id, sucursal_id)
VALUES(105, "Jaume", "Palmer", "2000-05-02", "M", 17000, 104, 2);
INSERT INTO empleado
VALUES(106, "Daniel", "Yela", "2003-04-10", "M", 30000, 104, 2);
INSERT INTO empleado
VALUES(107, "Sebastian", "Pastor", "1976-06-03", "M", 22000, 104, 2);



--Insertar clientes de TUI y Hotelbeds
INSERT INTO cliente
VALUES(500, "Mariluz Travel", 1);
INSERT INTO cliente
VALUES(501, "Brighton trips", 1);
INSERT INTO cliente
VALUES(502, "Getaways", 1);
INSERT INTO cliente
VALUES(503, "Expedia", 2);
INSERT INTO cliente
VALUES(504, "Airberlin", 2);
SELECT * FROM cliente;

--Valor ventas por empleado (trabaja_con)
INSERT INTO trabaja_con
VALUES(100, 500, 55000);
INSERT INTO trabaja_con
VALUES(102, 501, 120000);
INSERT INTO trabaja_con
VALUES(106, 501, 21400);
INSERT INTO trabaja_con
VALUES(107, 502, 243000);
INSERT INTO trabaja_con
VALUES(104, 503, 130000);
INSERT INTO trabaja_con
VALUES(103, 503, 90000);
INSERT INTO trabaja_con
VALUES(102, 504, 87900);
SELECT * FROM trabaja_con;

--Proveedores para nuestro servicio
INSERT INTO proveedores
VALUES(1, "Dell PC", "Componentes y sistemas");
INSERT INTO proveedores
VALUES(1, "Puerto Buses Palma", "Transfers en Baleares");
INSERT INTO proveedores
VALUES(1, "Melia", "Hoteles en España");
INSERT INTO proveedores
VALUES(2, "Apple", "IPads");
INSERT INTO proveedores
VALUES(2, "Intercruises", "Cruceros");
INSERT INTO proveedores
VALUES(2, "RIU", "Hoteles en Baleares");
SELECT * FROM proveedores;
