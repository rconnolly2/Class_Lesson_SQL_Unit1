--INDEXES
--Los index se utilizan cuando queremos encontrar una columna especifica mas rapio
--Por ejemplo: la columna es muy larga y no lo actualizamos mucho.
--Mysql hace una buscqueda secuencial de toda la columna

--Syntax:

--create index [index_name] 

--on [table](column)

--Print indexes
SHOW INDEXES FROM empleado;

--CREAR INDEX
CREATE INDEX apellido_empleado
ON empleado(apellido);

--Eliminar index
ALTER TABLE empleado
DROP INDEX apellido_empleado;

--Ahora si busco un empleado desde su apellido sera mas rapido
--0,1s
SELECT * FROM empleado
WHERE apellido = "Connolly";

--Indexes multicolumna, esto nos deja tener dos campos como index
--Por ejempl si busco por el nombre o por el apellido al formar
--parte del index se hara mas rapida la query

CREATE INDEX nombre_apellido_empleado
ON empleado(nombre, apellido);