SELECT es_par(2);

--Creo un tabla con numeros y si es par vacio
CREATE TABLE Numeros_Par_Impar(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    numero INT,
    tipo_numero VARCHAR(20) DEFAULT(NULL)
);

DROP TABLE Numeros_Par_Impar;

DESCRIBE Numeros_Par_Impar;

--https://www.mysqltutorial.org/mysql-stored-procedure/mysql-while-loop/
--Yo voy a utilizar bucles WHILE como un bucle for
--Syntaxis (los bucles while tienen que estan en curly brackets):
--Como hago un break en mysql => LEAVE nombre_bucle;
--https://dev.mysql.com/doc/refman/8.0/en/leave.html

WHILE a <= 5 DO
    CALL funcion(a);
    SET a = a+1;
    IF a = 3 THEN
        SELECT "Hago un break";
        LEAVE;
    END IF;
END WHILE;
--PONIENDOLO A PRUEBA
DELIMITER $$
CREATE PROCEDURE test_bucle_for()
BEGIN
DECLARE a INT;
SET a = 1;

mi_primer_forloop: WHILE a <= 5 DO
    IF a = 3 THEN
        SELECT "break!";
        LEAVE mi_primer_forloop;
    END IF;

    SET a = a+1;
END WHILE;

END $$
DELIMITER;

--EJECUTAR test_bucle_for
CALL test_bucle_for();

--DELETE test_bucle_for
DROP PROCEDURE test_bucle_for;

--Populate tablas
--voy a meter numeros del 1 al 10 con un PROCEDURE
--y un bucle for utilizando=> (while)

--PREPARE
--https://dev.mysql.com/doc/refman/8.0/en/prepare.html
--SYNTAX: PREPARE stmt_name FROM preparable_stmt
DELIMITER $$
CREATE PROCEDURE insertar_numeros(
    IN numero_max INT,
    IN nombre_tabla VARCHAR(50),
    IN nombre_fila VARCHAR(50)
)
BEGIN
    DECLARE iterador INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @msg = MESSAGE_TEXT;
    END;

    SET iterador = 1;
    WHILE iterador <= numero_max DO
        SET @sql_statement = CONCAT("INSERT INTO ", nombre_tabla, "(", nombre_fila, ") ", " VALUES(", CONVERT(iterador, CHAR), ")");
        PREPARE stmt FROM @sql_statement;
        EXECUTE stmt;
        SET iterador = iterador+1;
    END WHILE;


END $$
DELIMITER ;

--EJECUTANDO insertar_numeros con mi tabla nueva :)
--Elimino todos los datos de la tabla
DELETE FROM Numeros_Par_Impar;
CALL insertar_numeros(20, "Numeros_Par_Impar", "numero");
--porfavor que funcione! :(
SELECT * FROM Numeros_Par_Impar;
SELECT @msg;

--DELETE
DROP PROCEDURE insertar_numeros;


--Actualizar Columna CON FUNCION es_par
UPDATE Numeros_Par_Impar
SET tipo_numero = "Es par"
WHERE es_par(numero) = 0;


