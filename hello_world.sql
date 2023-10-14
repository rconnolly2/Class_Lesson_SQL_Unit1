CREATE TABLE estudiante (
    estudiante_id INT,
    nombre VARCHAR(20),
    grado VARCHAR(20),
    PRIMARY KEY(estudiante_id)
);

DESCRIBE estudiante; --Esto es el equivalente de un print type en SQL


--Editar tabla (añado atributo)
ALTER TABLE estudiante ADD nota DECIMAL(2, 2);
--Elimino atributo de la tabla creada
ALTER TABLE estudiante DROP nota;

--Eliminar tabla

DROP TABLE estudiante;

--Seleccionar todos los datos de la tabla
SELECT * FROM estudiante;

--Insertar datos tabla
INSERT INTO estudiante VALUES(2, "Francesc", "DAW Presencial");

--Podemos especificar informacion tabla(datos) a insertar
INSERT INTO estudiante(estudiante_id, nombre) VALUES(3, "Raul");





--Reglas para datos   (Empiezo de cero)
DROP TABLE estudiante;
DESCRIBE estudiante;

--NOT NULL Este valor no puede ser null
--UNIQUE Este valor tiene que ser unico
--DEFAULT(dato) Valor por defecto
--AUTO_INCREMENT incrementa automaticamente como enum ;)
CREATE TABLE estudiante (
    estudiante_id INT AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    grado VARCHAR(20) DEFAULT('Grado Superior'),
    PRIMARY KEY(estudiante_id)
);

DESCRIBE estudiante;
--Pruebo las reglas (keywords)
-- INSERT INTO estudiante VALUES(NULL, "Francesc", "DAW Presencial");
-- Funciona levanta la excepcion Error: Column 'estudiante_id' cannot be null

-- Test unique
--INSERT INTO estudiante VALUES(2, "Francesc", "DAW Presencial");
--INSERT INTO estudiante VALUES(1, "Robert", "DAW Presencial");
--Error: Duplicate entry 'DAW Presencial' for key 'estudiante.grado'

--Test DEFAULT
INSERT INTO estudiante(estudiante_id, nombre) VALUES(1, "Robert");
SELECT * FROM estudiante;
--Funciona :) tengo grado superior por defecto

--Test AUTO_INCREMENT
INSERT INTO estudiante(nombre) VALUES("Francesc");
INSERT INTO estudiante(nombre, grado) VALUES("Pedro", "ASIX Intensivo");


--ACTUALIZAR Y ELIMINAR DATOS
UPDATE estudiante
SET grado = "Desarrollo Web"
WHERE grado = "ASIX Intensivo";
/* Esto es equivalente a py:
if (grado in estudiante == "ASIX Intensivo"):
    grado = "Desarrollo Web"
*/
/*Operadores de comparacion: 
= igual
<> no igual
>= mayor o igual
<= menor o igual
< menor
> mayor */

--TODOS
UPDATE estudiante
SET grado = "Desarrollo Web";

--ELIMINAR
DELETE FROM estudiante
WHERE nombre = "Pedro";
--En este caso elimino las columnas que tengan una fila con el
--valor "Pedro" en el campo nombre

--Consultas de informacion queries basicas
--SELECT * hace la consulta a todo
--Y el FROM estudiante seria todo de la tabla estudiante
SELECT *
FROM estudiante;

--Ahora voy a seleccionar solo el nombre y curso de todos
SELECT nombre, grado
FROM estudiante;
--Funciona ;)
--tambien es valido asi:
SELECT estudiante.nombre, estudiante.grado
FROM estudiante;

--Y ordenar datos consulta CON asc y desc
SELECT estudiante.nombre, estudiante.grado
FROM estudiante
ORDER BY estudiante.nombre ASC;

--Limitar resultado consulta
SELECT estudiante.nombre, estudiante.grado
FROM estudiante
ORDER BY estudiante.nombre ASC
LIMIT 2;


--Filtrando con where y in
SELECT estudiante.nombre, estudiante.grado
FROM estudiante
WHERE nombre = "Robert" OR nombre = "Pedro";

--Con IN
SELECT estudiante.nombre, estudiante.grado
FROM estudiante

WHERE nombre IN ("Robert", "Pedro");


-- Ejercicio con BD para compañia TUI
DROP TABLE estudiante;
CREATE TABLE empleado(
    empleado_id INT PRIMARY KEY,
    nombre VARCHAR(15),
    apellido VARCHAR(15),
    fecha_nacimiento DATE,
    sexo VARCHAR(1),
    salario INT,
    superior_id INT,
    sucursal_id INT
);

CREATE TABLE sucursal(
    sucursal_id INT(10) PRIMARY KEY,
    nombre_sucursal VARCHAR(20),
    manager_id INT,
    manager_fecha_inicio DATE,
    FOREIGN KEY(manager_id) REFERENCES empleado(empleado_id) ON DELETE SET NULL
);


--Ahora que tenemos la tabla sucursal creamos foreign keys
--en la tabla empleados

ALTER TABLE empleado
ADD FOREIGN KEY(sucursal_id)
REFERENCES sucursal(sucursal_id)
ON DELETE SET NULL;

ALTER TABLE empleado
ADD FOREIGN KEY(superior_id)
REFERENCES empleado(empleado_id)
ON DELETE SET NULL;

DESCRIBE empleado;

--Creo tabla clientes de TUI

CREATE TABLE cliente(
    cliente_id INT PRIMARY KEY,
    nombre_cliente VARCHAR(30),
    sucursal_id INT,
    FOREIGN KEY(sucursal_id) REFERENCES sucursal(sucursal_id) ON DELETE SET NULL
);
DESCRIBE cliente;

--Tabla trabaja con

CREATE TABLE trabaja_con(
    empleado_id INT,
    cliente_id INT,
    ventas_totales INT,
    PRIMARY KEY(empleado_id, cliente_id),
    FOREIGN KEY(empleado_id) REFERENCES empleado(empleado_id) ON DELETE CASCADE,
    FOREIGN KEY(cliente_id) REFERENCES cliente(cliente_id) ON DELETE CASCADE
);

--Tabla Proveedores

CREATE TABLE proveedores(
    sucursal_id INT,
    proveedor_nombre VARCHAR(30),
    tipo_producto VARCHAR(30),
    PRIMARY KEY(sucursal_id, proveedor_nombre),
    FOREIGN KEY(sucursal_id) REFERENCES sucursal(sucursal_id) ON DELETE CASCADE
);