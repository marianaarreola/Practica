-- ========================================================
-- CASO INTEGRADOR: 20 CONSULTAS COMPLEJAS
-- ========================================================

-- Consulta 1: Obtener los nombres de los estudiantes inscritos en el curso 'Bases de Datos'
SELECT E.nombre 
FROM Estudiante E
JOIN Inscripcion I ON E.id_estudiante = I.id_estudiante
JOIN Curso C ON I.id_curso = C.id_curso
WHERE C.nombre = 'Bases de Datos';

-- Consulta 2: Listar los profesores que pertenecen al departamento de 'Sistemas Computacionales'
SELECT P.nombre 
FROM Profesor P
JOIN Departamento D ON P.id_depto = D.id_depto
WHERE D.nombre = 'Sistemas Computacionales';

-- Consulta 3: Mostrar los estudiantes que obtuvieron una calificación superior a 9.0 en el semestre '2026-1'
SELECT E.nombre, I.calificacion
FROM Estudiante E
JOIN Inscripcion I ON E.id_estudiante = I.id_estudiante
WHERE I.calificacion > 9.0 AND I.semestre = '2026-1';

-- [Agrega aquí de la Consulta 4 a la 20 siguiendo la estructura de tu entregable]
-- Consulta 4: ...