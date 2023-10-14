--CASE STATEMENTS
--Es equivalente a if elif else en Python
/*
WHEN (CONDICION) THEN (ACCION) => 
if(condicion){
accion
}

y al final de los elif =>
ELSE (ACCION) => {}
else{
accion
}
y acaba con END
*/
SELECT nombre, apellido, CASE
    WHEN nombre = "Robert" THEN "En practicas"
    WHEN nombre = "Jordi" THEN "Es un fracaso"
    ELSE "Son contratos internos"
    END AS "Estado_contrato" FROM empleado;