--PROCEDURES
--Basicamente son funciones de SQL

--CREAR PROCEDURE
-- Definimos el fin del SQL statement como $$
--Como ves el statement acaba al final de los curly brackets
DELIMITER $$
CREATE PROCEDURE nombres_empleado()
BEGIN
    SELECT * FROM empleado;
END $$
DELIMITER;

--Ejecutar funcion
CALL nombres_empleado();

--Eliminar procedure
DROP PROCEDURE esta_nombre_empleado;

--Voy a crear una funcion con parametros
--Que me de los empleados que de los nombre como param
--Los parametros se definen (IN nombre tipo_dato, ...)
DELIMITER $$
CREATE PROCEDURE esta_nombre_empleado(IN n_1 VARCHAR(10))
BEGIN
    SELECT * FROM empleado
    WHERE nombre = n_1;
END $$
DELIMITER;


--Pruebo
CALL esta_nombre_empleado("Robert");

select * from empleado;

--USER VARIABLES & LOCAL VARIABLES
--DECLARE variable TIPO
--es => crear variable local
--SET VARIABLE = B   es asignar un valor a la var
DELIMITER $$
CREATE PROCEDURE sumar_p+1(IN n1 INT, OUT result INT)
BEGIN
    DECLARE var1_local INT;
    SET var1_local = 1 + n1;
    SET result = var1_local;
END $$
DELIMITER;

DROP PROCEDURE suma_var_local;

--CREO MI VARIABLE USUARIO
CALL suma_var_local(1, @mi_var_usuario);
--Print de mi variable
SELECT @mi_var_usuario;

SELECT * FROM empleado;

--Funcion que devuelve los NUMERO de empleados del jefe de tabla en una user var
--Y hace un select de los nombres de los empleados
--Las variables locales las tengo que declarar antes
--Para establecer un nuevo valor a la variable puedo o utilizar set o into
DELIMITER $$
CREATE PROCEDURE empleados_jefes(IN nombre_jefe VARCHAR(20), OUT cantidad_empleados INT)
BEGIN
    DECLARE num_resultados INT;
    DECLARE nombre_apellido_empleados VARCHAR(50);
    DECLARE jefe_id INT;
    
    SELECT empleado_id INTO jefe_id FROM empleado
    WHERE nombre = nombre_jefe;

    SET num_resultados = (SELECT COUNT(nombre) FROM empleado
    WHERE superior_id = jefe_id);

    SELECT nombre, IF(num_resultados>0, "Tienes empleados! :)", "Error: este jefe no tiene empleados o no existe")
    FROM empleado
    WHERE superior_id = jefe_id;

    SET cantidad_empleados = num_resultados;
    

END $$
DELIMITER;

--delete empleados_jefes
DROP PROCEDURE empleados_jefes;


CALL empleados_jefes("Antonio", @return_func);
SELECT @return_func;