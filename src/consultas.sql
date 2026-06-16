-- ========================================================
-- CASO INTEGRADOR: 20 CONSULTAS PARA POSTGRESQL
-- ========================================================
SET search_path TO universidad;

-- BLOQUE 1: OPERADORES BÁSICOS
-- 1. Selección y Proyección
SELECT nombre, carrera FROM Estudiante WHERE id_depto = 1;

-- 2. Unión
SELECT nombre FROM Estudiante WHERE carrera = 'ISC'
UNION
SELECT nombre FROM Profesor WHERE id_depto = 1;

-- 3. Intersección
SELECT id_curso FROM Curso WHERE id_depto = 1
INTERSECT
SELECT id_curso FROM Inscripcion;

-- 4. Diferencia (En Postgres se usa EXCEPT en lugar de MINUS)
SELECT id_curso FROM Curso
EXCEPT
SELECT id_curso FROM Inscripcion;

-- 5. Operación Combinada
SELECT nombre FROM Estudiante 
WHERE id_estudiante IN (SELECT id_estudiante FROM Beca WHERE tipo_beca = 'Excelencia');


-- BLOQUE 2: REUNIONES / JOINS
-- 6. Inner Join
SELECT E.nombre, C.nombre AS curso, I.calificacion 
FROM Estudiante E
INNER JOIN Inscripcion I ON E.id_estudiante = I.id_estudiante
INNER JOIN Curso C ON I.id_curso = C.id_curso;

-- 7. Left Outer Join
SELECT C.nombre, H.dia, H.hora_inicio 
FROM Curso C
LEFT JOIN Horario H ON C.id_curso = H.id_curso;

-- 8. Right Outer Join
SELECT A.codigo, H.id_curso, H.dia 
FROM Horario H
RIGHT JOIN Aula A ON H.id_aula = A.id_aula;

-- 9. Anti-Join
SELECT P.nombre FROM Profesor P
WHERE NOT EXISTS (
    SELECT 1 FROM Horario H WHERE H.id_profesor = P.id_profesor
);

-- 10. Self-Join
SELECT E1.nombre AS Estudiante_A, E2.nombre AS Estudiante_B, E1.carrera
FROM Estudiante E1
INNER JOIN Estudiante E2 ON E1.carrera = E2.carrera
WHERE E1.id_estudiante < E2.id_estudiante;


-- BLOQUE 3: AGRUPACIÓN Y AGREGACIÓN
-- 11. Conteo
SELECT id_curso, COUNT(id_estudiante) AS total_alumnos 
FROM Inscripcion 
GROUP BY id_curso;

-- 12. Promedio
SELECT E.carrera, AVG(I.calificacion) AS promedio_carrera
FROM Estudiante E
INNER JOIN Inscripcion I ON E.id_estudiante = I.id_estudiante
GROUP BY E.carrera;

-- 13. Suma
SELECT edificio, SUM(presupuesto) AS presupuesto_total 
FROM Departamento 
GROUP BY edificio;

-- 14. Condición de Agrupación (HAVING)
SELECT id_estudiante, COUNT(id_curso) AS total_materias 
FROM Inscripcion
GROUP BY id_estudiante
HAVING COUNT(id_curso) > 2;

-- 15. Múltiples Funciones
SELECT id_curso, MAX(calificacion) AS nota_max, MIN(calificacion) AS nota_min 
FROM Inscripcion
WHERE semestre = '2026-1'
GROUP BY id_curso;


-- BLOQUE 4: DIVISIÓN RELACIONAL
-- 16. División 1
SELECT E.nombre FROM Estudiante E
WHERE NOT EXISTS (
    SELECT C.id_curso FROM Curso C WHERE C.id_depto = 1
    EXCEPT
    SELECT I.id_curso FROM Inscripcion I WHERE I.id_estudiante = E.id_estudiante
);

-- 17. División 2
SELECT P.nombre FROM Profesor P
WHERE NOT EXISTS (
    SELECT A.id_aula FROM Aula A
    EXCEPT
    SELECT H.id_aula FROM Horario H WHERE H.id_profesor = P.id_profesor
);

-- 18. División 3
SELECT E.nombre FROM Estudiante E
WHERE NOT EXISTS (
    SELECT C.id_curso FROM Curso C WHERE C.id_depto = 3
    EXCEPT
    SELECT I.id_curso FROM Inscripcion I WHERE I.id_estudiante = E.id_estudiante
);


-- BLOQUE 5: CUANTIFICADORES UNIVERSALES
-- 19. Cuantificador Universal 1
SELECT C.nombre FROM Curso C
WHERE NOT EXISTS (
    SELECT 1 FROM Inscripcion I 
    WHERE I.id_curso = C.id_curso AND I.calificacion < 8.0
) AND EXISTS (SELECT 1 FROM Inscripcion I WHERE I.id_curso = C.id_curso);

-- 20. Cuantificador Universal 2
SELECT E.nombre FROM Estudiante E
WHERE EXISTS (SELECT 1 FROM Beca B WHERE B.id_estudiante = E.id_estudiante)
  AND NOT EXISTS (
    SELECT 1 FROM Beca B2 
    WHERE B2.id_estudiante = E.id_estudiante AND B2.porcentaje < 100
);