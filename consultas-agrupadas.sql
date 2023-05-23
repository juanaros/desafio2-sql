    -- Creando la base de datos
CREATE DATABASE "desafio2-Juan-Aros-128";

    -- Ingresando a la base de datos
\c desafio2-Juan-Aros-128

    -- Creando la tabla
CREATE TABLE IF NOT EXISTS INSCRITOS(
cantidad INT,
fecha DATE,
fuente VARCHAR
);

    -- Insertando datos a la tabla
INSERT INTO inscritos(cantidad, fecha, fuente)
VALUES 
( 44, '01/01/2021', 'Blog' ),
( 56, '01/01/2021', 'Página' ),
( 39, '01/02/2021', 'Blog' ),
( 81, '01/02/2021', 'Página' ),
( 12, '01/03/2021', 'Blog' ),
( 91, '01/03/2021', 'Página' ),
( 48, '01/04/2021', 'Blog' ),
( 45, '01/04/2021', 'Página' ),
( 55, '01/05/2021', 'Blog' ),
( 33, '01/05/2021', 'Página' ),
( 18, '01/06/2021', 'Blog' ),
( 12, '01/06/2021', 'Página' ),
( 34, '01/07/2021', 'Blog' ),
( 24, '01/07/2021', 'Página' ),
( 83, '01/08/2021', 'Blog' ),
( 99, '01/08/2021', 'Página' );

    -- ¿Cuántos registros hay?
SELECT COUNT(*) AS registros FROM inscritos;

    -- ¿Cuántos inscritos hay en total?
SELECT SUM(cantidad) AS "total_inscritos" FROM inscritos;

    -- ¿Cuál o cuáles son los registros de mayor antigüedad? 
SELECT * FROM inscritos WHERE fecha = (SELECT MIN(fecha) FROM inscritos);

    -- ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)
SELECT fecha, SUM(cantidad) AS "total_inscritos" FROM inscritos GROUP BY fecha ORDER BY fecha ASC;

    -- ¿Cuántos inscritos hay por fuente?
SELECT fuente, SUM(cantidad) AS "total_inscritos" FROM inscritos GROUP BY fuente ORDER BY SUM(cantidad) ASC;

    -- ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?
SELECT fecha, SUM(cantidad) AS "total_inscritos" FROM inscritos GROUP BY fecha ORDER BY SUM(cantidad) DESC LIMIT 1;

    -- ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog y cuántas personas fueron?
SELECT fecha, SUM(cantidad) AS "total_inscritos_blog"
FROM inscritos 
WHERE fuente = 'Blog' 
GROUP BY fecha 
ORDER BY SUM(cantidad) DESC LIMIT 1;

    -- ¿Cuántas personas en promedio se inscriben en un día?
SELECT SUM(t.total_inscritos) AS "total", ROUND(AVG(t.total_inscritos), 2) AS "promedio_inscritos_diario" 
FROM (SELECT fecha, SUM(cantidad) AS "total_inscritos" FROM inscritos GROUP BY fecha) 
AS "t";

    -- ¿Qué días se inscribieron más de 50 personas?
SELECT fecha, SUM(cantidad) AS "total_inscritos" 
FROM inscritos 
GROUP BY fecha 
HAVING SUM(cantidad) >= 50 
ORDER BY fecha;

    -- ¿Cuántas personas se registraron en promedio cada día a partir del tercer día?
SELECT fecha, SUM(cantidad) AS "cantidad_total", ROUND(AVG(cantidad), 2) AS "promedio" 
FROM inscritos 
GROUP BY fecha 
HAVING fecha >= '01/03/2021' 
ORDER BY fecha;
