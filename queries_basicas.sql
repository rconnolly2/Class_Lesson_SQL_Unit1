--Todo
SELECT * FROM empleado;
--Todo ordenador por SALARIO y NOMBRE
SELECT * FROM empleado
ORDER BY empleado.salario DESC, empleado.nombre DESC;
--Encuentra los primero cinco empleado
SELECT * FROM empleado
LIMIT 5;
--Encuentra el primer nombre y ultimo nombre de cada empleado
--En vez de seleccionar todo selecciono campos y creo 2 Alias
SELECT nombre AS "Primer nombre", apellido AS "Segundo nombre"
FROM empleado;
--Sacar valores no repetidos (unicos)
SELECT DISTINCT superior_id
FROM empleado;


--Consultas + operaciones
--Cuanta cuantos nombre hay
SELECT COUNT(nombre)
FROM empleado;
--Cuenta cuantos empleados han nacido despues de 2000
SELECT COUNT(nombre)
FROM empleado
WHERE empleado.fecha_nacimiento >= "2000-01-01";
--Dame la media de todos los salarios
SELECT AVG(salario)
FROM empleado;
--Si no lo quiero float:
SELECT ROUND(AVG(salario))
FROM empleado;
--Cuanto nos gastamos en salarios
SELECT SUM(salario)
FROM empleado;
--Cuantos empleados tiene cada jefe? (AGREGACION EN SQL)
SELECT COUNT(superior_id), superior_id
FROM empleado
GROUP BY superior_id;
--Otro ejemplo: Cuantos $ maneja cada empleado
SELECT SUM(ventas_totales), empleado_id
FROM trabaja_con
GROUP BY empleado_id;



--Wildcards sirven para encontrar patrones, es como regex pero simplificado


--Encuentra los clientes que acaben en travel con keyword LIKE
/*% cualquier cosa
_ 1 caracter cualquiera
[AB] dice que puede aparecer un caracter A o B
[^AB] ^ sirve para escluir caracteres y en mi ejemplo para escluir que mepieze
por A  o por B
[A-Z] o tambien muy similar a regex una letra de la A la Z
tambien podemos utilizar UPPER(nombre_cliente) para hacerlo mayus antes
*/
--Me devuelve si acaba en trips o travel 
SELECT *
FROM cliente
WHERE cliente.nombre_cliente LIKE "%travel" 
OR cliente.nombre_cliente LIKE "%trips";

--Los empleados que han nacido el dia 10
SELECT *
from empleado
WHERE empleado.fecha_nacimiento LIKE "____-__-10";

--Unions es un operador para combinar varios SELECTS en una query
SELECT empleado.nombre
FROM empleado
UNION
SELECT empleado.apellido
FROM empleado;
--Encuentra una lista de todos los nombres de clientes y sucursales
SELECT sucursal.nombre_sucursal
FROM sucursal
UNION
SELECT cliente.nombre_cliente
FROM cliente;
--Consulta cuanto dinero gasto y ingreso por valor
SELECT empleado.salario
FROM empleado
UNION
SELECT trabaja_con.ventas_totales
FROM trabaja_con;

--Joins combina informacion de distintas tablas relacionadas
--Con unas columnas comunes juntar dos tablas
--Esto es un INNER JOIN
SELECT * FROM empleado;
SELECT * FROM sucursal;
--Aqui pido: empleado_id, nombre del empleado, y la sucursal
--Y Solo enseñare los datos que tenga empleado_id y manager_id en COMUN
SELECT empleado.empleado_id, empleado.nombre, sucursal.nombre_sucursal
FROM empleado
JOIN sucursal
ON empleado.empleado_id = sucursal.manager_id;

--Left join, ok basicamente es muy facil como estamos uniendo
--FROM empleado => sucursal   TODOS LOS DATOS DE EMPLEADO SERAN DEVUELTOS
--+ Los datos que comparten entre las 2 tablas ON empleado.empleado_id = sucursal.manager_id
SELECT empleado.empleado_id, empleado.nombre, sucursal.nombre_sucursal
FROM empleado
LEFT JOIN sucursal
ON empleado.empleado_id = sucursal.manager_id;

--RIGHT JOIN basicamente saldrian todos los cursos aunque la relacion
--Entre las dos tablas sea igual
SELECT empleado.empleado_id, empleado.nombre, sucursal.nombre_sucursal
FROM empleado
RIGHT JOIN sucursal
ON empleado.empleado_id = sucursal.manager_id;

--FULL JOIN = LEFT JOIN + RIGHT JOIN, mysql no lo tiene :(


--Nested queries ;) utilizar varios selects dentro de selects
--EL NESTED FOR LOOP DE SQL
SELECT * FROM trabaja_con;
SELECT * FROM empleado;

--Dame la lista de empleados que manejan un valor mayor a 50k
--Query 1 que me da los ids de los empleados
SELECT trabaja_con.empleado_id
FROM trabaja_con
WHERE trabaja_con.ventas_totales >= 50000;
--Query 2 que consigue los nombre a partir de los ids
SELECT empleado.nombre
FROM D1_A_RELACIONAR empleado
WHERE IN (DATOS QUE SE DEVUELVEN Q1);
--Resultado
SELECT empleado.nombre
FROM empleado
WHERE empleado.empleado_id IN (SELECT trabaja_con.empleado_id
FROM trabaja_con
WHERE trabaja_con.ventas_totales >= 50000);

--Ej 2 encuentra todas las empresas que manejan los empleados de Toni en TUI España
--Q1
SELECT empleado.empleado_id
FROM empleado
WHERE empleado.superior_id = 100

--Q2 
SELECT trabaja_con.cliente_id
FROM trabaja_con
WHERE trabaja_con.empleado_id IN (Q1)

--Q3
SELECT cliente.nombre_cliente
FROM cliente
WHERE cliente.cliente_id IN (Q2);

--RESULTADO:
SELECT cliente.nombre_cliente
FROM cliente
WHERE cliente.cliente_id IN (SELECT trabaja_con.cliente_id
FROM trabaja_con
WHERE trabaja_con.empleado_id IN (SELECT empleado.empleado_id
FROM empleado
WHERE empleado.superior_id = 100));


