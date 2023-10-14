--GROUP BY
--Group by nos permite agrupar informacion de una tabla
--Por ejemplo: El numero de empleados de cada jefe
--Se suele juntar con funciones matematicas
/*
Syntaxis:
SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1;
*/
--Basicamente group by busca valores repetidos y los agrupa
--NADA MAS !
SELECT * FROM empleado;

SELECT COUNT(nombre) AS "Numero empleados", superior_id AS "Jefe"
FROM empleado
GROUP BY superior_id;

--ROLLUP => Es basicamente el total del los datos AGRUPADOS
--Se añade a group by => GROUP BY campo WITH ROLLUP;

SELECT COUNT(nombre) AS "Numero empleados", superior_id AS "Jefe"
FROM empleado
GROUP BY superior_id WITH ROLLUP;