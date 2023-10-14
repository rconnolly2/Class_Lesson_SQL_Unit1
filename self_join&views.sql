--Self join
--Es literlamente juntar la misma tabla sobre 
--si misma por ejemplo: Quiero una tabla de los empleados
--que tengan un jefe y ponme al lado el jefe que 
--les ha contratado

--Como ves es obligatorio crear aliases de la misma tabla

SELECT * FROM empleado;

SELECT emp.nombre, CONCAT((SELECT jefe.nombre
    FROM empleado as jefe
    WHERE jefe.empleado_id = sup.superior_id),
    " ",
    (SELECT jefe.apellido
    FROM empleado as jefe
    WHERE jefe.empleado_id = sup.superior_id)) AS "Jefe empleado:"
FROM empleado as emp
JOIN empleado as sup
ON emp.empleado_id = sup.empleado_id
WHERE emp.superior_id IS NOT NULL;


--VIEWS
--Views son basicamente tablas virtuales que son generados
--desde una query de SQL los campos de la tabla
--se peude interactuar con una view como si fuese una
--tabla real pero no edita la original
--si una view viene de una query de una tabla que
--ha cambiado la view TAMBIEN cambia

--View de los jefes de los empleados
CREATE VIEW jefes_empleados AS
SELECT * FROM empleado
WHERE empleado.superior_id IS NULL;
--DELETE
DROP VIEW jefes_empleados;

--Print view
SELECT * FROM jefes_empleados;

--Nuevo campo no funciona por explicado arriba
ALTER VIEW jefes_empleados
ADD COLUMN es_jefe TINYINT DEFAULT 1;