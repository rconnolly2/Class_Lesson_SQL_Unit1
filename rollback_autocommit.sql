--Por defecto las transacciones que hacemos se guardan sin ningun tipo
--de control esto lo controla la variable de sistema AUTOCOMMIT.

--Para desacticar autocommit
SET AUTOCOMMIT = OFF;

--Para crear un punto de guardado parecido cuando jugamos un juego
--y hacemos un savepoint :)
COMMIT;


SELECT * FROM empleado;
--accion de muy becario jaja
DELETE FROM empleado;

--Por suerte hemos "guardado la partida" con COMMIT;
--Podemos volver para atras con ROLLBACK;
ROLLBACK;

--ha vuelto la tabla el becario no suspende sus practicas :(
SELECT * FROM empleado;


--que es un "TRANSACTION" =>Suele ser un cambio a la BD
--Una transaccion es una unidad indivisible de trabajo
--Es un conjunto de ordenes que TIENEN QUE EJECUTARSE SIN ERRORES
--y en caso de error NO EJECUTARSE para evitar datos duplicados

--Procedure con control de excepciones:

--Preguntar porque no me deja asignar MESSAGE_TEXT a variable local o variable out de user directamente
--Es porque es una variable de sistema? o porque tiene que ser dato?=>TEXT
--error handler mysql https://dev.mysql.com/doc/refman/8.0/en/declare-handler.html
--get diagnostics https://dev.mysql.com/doc/refman/8.0/en/get-diagnostics.html
--database transactions & ACID: https://www.youtube.com/watch?v=AcqtAEzuoj0

DELIMITER $$
CREATE PROCEDURE existe_empleado(IN nombre_empleado VARCHAR(20), OUT error_sql VARCHAR(100))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @msg = MESSAGE_TEXT;
        SET error_sql = CONCAT("Error en ejecución, ROLLBACK EFECTUADO: ", @msg);
        ROLLBACK;
    END;

    SELECT * FROM empleados
    WHERE nombre = nombre_empleado;
    COMMIT;


END $$
DELIMITER;


DROP PROCEDURE existe_empleado;

CALL existe_empleado("Roberto", @msg_error);

SELECT @msg_error;
