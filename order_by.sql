--Ordenar empleados por nombre descendente

SELECT * FROM empleado;
--Concatenar en sql es similar a Python
--nombre + " " + apellido => CONCAT(nombre, " ", apellido)
SELECT empleado_id, CONCAT(nombre, " ", apellido), salario
FROM empleado
ORDER BY nombre ASC;
--Por salario
SELECT empleado_id, nombre, salario
FROM empleado
ORDER BY salario ASC;
--Por nombre en caso de empate por salario
SELECT empleado_id, nombre, salario
FROM empleado
ORDER BY nombre, salario ASC;