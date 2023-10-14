--FUNCTIONS
--Las funciones en mysql su mision es devolver un unico valor
--syntax
/*
CREATE (OBLIGATORIO)
    [DEFINER = user] 
    FUNCTION [IF NOT EXISTS] sp_name (nombre_param tipo_dato) (OBLIGATORIO)
    RETURNS type (OBLIGATORIO)
    [characteristic ...] routine_body #AQUI BEGIN Y END $$ (OBLIGATORIO)

*/
--la key DETERMINISTIC le decimos que esta función da el mismo resultado
--por el mismo input y no depende de factores externos
--si depende por ejemplo de una tabla seria:
--NOT DETERMINISTIC
DELIMITER $$
CREATE FUNCTION es_par(num INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    IF num % 2 = 0 THEN
        SET resultado = 1;
    ELSE
        SET resultado = 0;
    END IF;
    RETURN resultado;
END $$

DELIMITER ;

drop FUNCTION es_par;

--Las funciones se pueden ejecutar utilizando select o set
--a nuestra variable
select es_par(2);
SET @resultado_par = es_par(3);
SELECT @resultado_par;