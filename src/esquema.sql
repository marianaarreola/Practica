Aquí tienes el código completo y listo para copiar y pegar en tu archivo src/esquema.sql. Incluye la creación de las 8 tablas estructuradas con sus llaves primarias y foráneas, y las 108 tuplas reales para cumplir con el requisito de la práctica.
```sql
-- =============================================================================
-- SCRIPT DE CREACIÓN DE BASE DE DATOS Y CARGA MASIVA DE DATOS (100+ TUPLAS)
-- =============================================================================

-- DROPS EN CASO DE RE-EJECUCIÓN (ORDEN ESTRICTO POR LLAVES FORÁNEAS)
DROP TABLE IF EXISTS becas CASCADE;
DROP TABLE IF EXISTS inscripciones CASCADE;
DROP TABLE IF EXISTS clases CASCADE;
DROP TABLE IF EXISTS aulas CASCADE;
DROP TABLE IF EXISTS estudiantes CASCADE;
DROP TABLE IF EXISTS cursos CASCADE;
DROP TABLE IF EXISTS profesores CASCADE;
DROP TABLE IF EXISTS departamentos CASCADE;

-- 1. TABLA DEPARTAMENTOS
CREATE TABLE departamentos (
    id_depto INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    edificio VARCHAR(50) NOT NULL,
    presupuesto NUMERIC(12,2) NOT NULL
);

-- 2. TABLA PROFESORES
CREATE TABLE profesores (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    id_depto INT REFERENCES departamentos(id_depto),
    telefono VARCHAR(20)
);

-- 3. TABLA CURSOS
CREATE TABLE cursos (
    id_curso INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos INT NOT NULL,
    horas_totales INT NOT NULL,
    id_depto INT REFERENCES departamentos(id_depto)
);

-- 4. TABLA ESTUDIANTES
CREATE TABLE estudiantes (
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    carrera VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    id_depto INT REFERENCES departamentos(id_depto)
);

-- 5. TABLA AULAS
CREATE TABLE aulas (
    id_aula INT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL,
    capacidad INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    edificio VARCHAR(50) NOT NULL
);

-- 6. TABLA CLASES
CREATE TABLE clases (
    id_clase INT PRIMARY KEY,
    id_curso INT REFERENCES cursos(id_curso),
    id_profesor INT REFERENCES profesores(id_profesor),
    id_aula INT REFERENCES aulas(id_aula),
    horario VARCHAR(50) NOT NULL
);

-- 7. TABLA INSCRIPCIONES
CREATE TABLE inscripciones (
    id_inscripcion INT PRIMARY KEY,
    id_estudiante INT REFERENCES estudiantes(id_estudiante),
    id_clase INT REFERENCES clases(id_clase),
    calificacion NUMERIC(4,2)
);

-- 8. TABLA BECAS
CREATE TABLE becas (
    id_beca INT PRIMARY KEY,
    id_estudiante INT REFERENCES estudiantes(id_estudiante),
    porcentaje INT NOT NULL,
    tipo_beca VARCHAR(50) NOT NULL
);

-- =============================================================================
-- INSERCIÓN EN BLOQUE DE DATOS REALES (108 TUPLAS TOTALES)
-- =============================================================================

-- Departamentos (5)
INSERT INTO departamentos VALUES (1, 'Sistemas Computacionales', 'Edificio 1', 750000.00);
INSERT INTO departamentos VALUES (2, 'Ciencias Básicas', 'Edificio 2', 450000.00);
INSERT INTO departamentos VALUES (3, 'Ingeniería Mecánica', 'Edificio 3', 600000.00);
INSERT INTO departamentos VALUES (4, 'Electrónica', 'Edificio 1', 520000.00);
INSERT INTO departamentos VALUES (5, 'Ciencias Sociales', 'Edificio 4', 300000.00);

-- Profesores (12)
INSERT INTO profesores VALUES (101, 'Dr. Gómez Russo', 'Bases de Datos', 1, '555-0101');
INSERT INTO profesores VALUES (102, 'Dra. Beatriz Juárez', 'Inteligencia Artificial', 1, '555-0102');
INSERT INTO profesores VALUES (103, 'M. en C. Carlos Mendoza', 'Cálculo Vectorial', 2, '555-0103');
INSERT INTO profesores VALUES (104, 'Ing. Diana Silva', 'Termodinámica', 3, '555-0104');
INSERT INTO profesores VALUES (105, 'Dr. Eduardo Rivas', 'Sistemas Digitales', 4, '555-0105');
INSERT INTO profesores VALUES (106, 'Dra. Elena Rostova', 'Álgebra Lineal', 2, '555-0106');
INSERT INTO profesores VALUES (107, 'Ing. Fernando Mendiola Sr', 'Redes de Computadoras', 1, '555-0107');
INSERT INTO profesores VALUES (108, 'Gabriela Luna', 'Estructuras de Datos', 1, NULL);
INSERT INTO profesores VALUES (109, 'Dr. Hugo Sánchez', 'Mecánica de Fluidos', 3, '555-0109');
INSERT INTO profesores VALUES (110, 'Ing. Isabel Torres', 'Microcontroladores', 4, '555-0110');
INSERT INTO profesores VALUES (111, 'Jorge Luis Borges', 'Compiladores', 1, '555-0111');
INSERT INTO profesores VALUES (112, 'Karla Castillejos', 'Ética Profesional', 5, '555-0112');

-- Cursos (15)
INSERT INTO cursos VALUES (201, 'Fundamentos de Bases de Datos', 5, 80, 1);
INSERT INTO cursos VALUES (202, 'Inteligencia Artificial Avanzada', 5, 80, 1);
INSERT INTO cursos VALUES (203, 'Cálculo Diferencial e Integral', 4, 64, 2);
INSERT INTO cursos VALUES (204, 'Álgebra Lineal Aplicada', 4, 64, 2);
INSERT INTO cursos VALUES (205, 'Mecánica Clásica', 5, 80, 3);
INSERT INTO cursos VALUES (206, 'Circuitos Eléctricos', 5, 80, 4);
INSERT INTO cursos VALUES (207, 'Programación Orientada a Objetos', 5, 80, 1);
INSERT INTO cursos VALUES (208, 'Estructuras de Datos Avanzadas', 5, 80, 1);
INSERT INTO cursos VALUES (209, 'Física Electromecánica', 4, 64, 3);
INSERT INTO cursos VALUES (210, 'Sistemas Operativos Modernos', 5, 80, 1);
INSERT INTO cursos VALUES (211, 'Ecuaciones Diferenciales', 4, 64, 2);
INSERT INTO cursos VALUES (212, 'Diseño Digital', 5, 80, 4);
INSERT INTO cursos VALUES (213, 'Administración de Proyectos', 3, 48, 5);
INSERT INTO cursos VALUES (214, 'Redes Avanzadas IP', 5, 80, 1);
INSERT INTO cursos VALUES (215, 'Taller de Ética', 2, 32, 5);

-- Estudiantes (25)
INSERT INTO estudiantes VALUES (1, 'Mariana Arreola', 'ISC', 21, 1);
INSERT INTO estudiantes VALUES (2, 'Fernando Mendiola', 'ISC', 22, 1);
INSERT INTO estudiantes VALUES (3, 'Alejandro Delgado', 'ISC', 20, 1);
INSERT INTO estudiantes VALUES (4, 'Cecilia Galliano', 'LCD', 19, 1);
INSERT INTO estudiantes VALUES (5, 'David Copperfield', 'MEC', 23, 3);
INSERT INTO estudiantes VALUES (6, 'Elena Poniatowska', 'MEC', 21, 3);
INSERT INTO estudiantes VALUES (7, 'Fabián Chávez', 'ELEC', 22, 4);
INSERT INTO estudiantes VALUES (8, 'Gisela Valcárcel', 'ELEC', 20, 4);
INSERT INTO estudiantes VALUES (9, 'Héctor Bonilla', 'ISC', 24, 1);
INSERT INTO estudiantes VALUES (10, 'Iris Chacón', 'LCD', 18, 1);
INSERT INTO estudiantes VALUES (11, 'Juan Gabriel', 'ISC', 21, 1);
INSERT INTO estudiantes VALUES (12, 'Kevin Mitnick', 'ISC', 22, 1);
INSERT INTO estudiantes VALUES (13, 'Laura Pausini', 'MEC', 20, 3);
INSERT INTO estudiantes VALUES (14, 'Mauricio Garcés', 'ELEC', 23, 4);
INSERT INTO estudiantes VALUES (15, 'Natalia Lafourcade', 'ISC', 21, 1);
INSERT INTO estudiantes VALUES (16, 'Omar Chaparro', 'ISC', 19, 1);
INSERT INTO estudiantes VALUES (17, 'Patricia Manterola', 'LCD', 22, 1);
INSERT INTO estudiantes VALUES (18, 'Quentin Tarantino', 'MEC', 25, 3);
INSERT INTO estudiantes VALUES (19, 'Roberto Carlos', 'ELEC', 21, 4);
INSERT INTO estudiantes VALUES (20, 'Silvia Pinal', 'ISC', 20, 1);
INSERT INTO estudiantes VALUES (21, 'Thalía Sodi', 'ISC', 22, 1);
INSERT INTO estudiantes VALUES (22, 'Úrsula Corberó', 'LCD', 20, 1);
INSERT INTO estudiantes VALUES (23, 'Vicente Fernández', 'MEC', 24, 3);
INSERT INTO estudiantes VALUES (24, 'Wendy Sulca', 'ELEC', 19, 4);
INSERT INTO estudiantes VALUES (25, 'Ximena Sariñana', 'ISC', 21, 1);

-- Aulas (8)
INSERT INTO aulas VALUES (401, 'L-101', 35, 'Laboratorio', 'Edificio 1');
INSERT INTO aulas VALUES (402, 'A-201', 40, 'Teoría', 'Edificio 1');
INSERT INTO aulas VALUES (403, 'A-202', 40, 'Teoría', 'Edificio 1');
INSERT INTO aulas VALUES (404, 'L-BD', 30, 'Laboratorio', 'Edificio 1');
INSERT INTO aulas VALUES (405, 'B-105', 45, 'Teoría', 'Edificio 2');
INSERT INTO aulas VALUES (406, 'M-301', 35, 'Teoría', 'Edificio 3');
INSERT INTO aulas VALUES (407, 'E-204', 30, 'Laboratorio', 'Edificio 4');
INSERT INTO aulas VALUES (408, 'Audiovisual 1', 60, 'Especial', 'Edificio 2');

-- Clases (15)
INSERT INTO clases VALUES (501, 201, 101, 404, 'Lu-Mi 07:00-09:00');
INSERT INTO clases VALUES (502, 202, 102, 401, 'Ma-Ju 09:00-11:00');
INSERT INTO clases VALUES (503, 203, 103, 405, 'Lu-Mi-Vi 11:00-13:00');
INSERT INTO clases VALUES (504, 204, 106, 405, 'Ma-Ju 07:00-09:00');
INSERT INTO clases VALUES (505, 205, 104, 406, 'Lu-Mi 13:00-15:00');
INSERT INTO clases VALUES (506, 206, 105, 407, 'Ma-Ju 11:00-13:00');
INSERT INTO clases VALUES (507, 207, 108, 402, 'Lu-Mi 09:00-11:00');
INSERT INTO clases VALUES (508, 208, 101, 404, 'Ma-Ju 13:00-15:00');
INSERT INTO clases VALUES (509, 214, 107, 401, 'Lu-Mi 11:00-13:00');
INSERT INTO clases VALUES (510, 201, 111, 403, 'Ma-Ju 15:00-17:00');
INSERT INTO clases VALUES (511, 215, 112, 408, 'Viernes 09:00-13:00');
INSERT INTO clases VALUES (512, 210, 102, 402, 'Lu-Mi 15:00-17:00');
INSERT INTO clases VALUES (513, 212, 110, 407, 'Ma-Ju 09:00-11:00');
INSERT INTO clases VALUES (514, 205, 109, 406, 'Ma-Ju 15:00-17:00');
INSERT INTO clases VALUES (515, 207, 108, 403, 'Ma-Ju 11:00-13:00');

-- Inscripciones (23)
INSERT INTO inscripciones VALUES (601, 1, 501, 9.5);
INSERT INTO inscripciones VALUES (602, 1, 502, 10.0);
INSERT INTO inscripciones VALUES (603, 2, 501, 8.8);
INSERT INTO inscripciones VALUES (604, 2, 502, 9.2);
INSERT INTO inscripciones VALUES (605, 3, 501, 7.5);
INSERT INTO inscripciones VALUES (606, 4, 503, 8.0);
INSERT INTO inscripciones VALUES (607, 5, 505, 6.5);
INSERT INTO inscripciones VALUES (608, 6, 505, 9.0);
INSERT INTO inscripciones VALUES (609, 7, 506, 8.3);
INSERT INTO inscripciones VALUES (610, 8, 506, 7.8);
INSERT INTO inscripciones VALUES (611, 9, 508, 9.0);
INSERT INTO inscripciones VALUES (612, 10, 504, 8.5);
INSERT INTO inscripciones VALUES (613, 11, 507, 6.0);
INSERT INTO inscripciones VALUES (614, 12, 509, 10.0);
INSERT INTO inscripciones VALUES (615, 13, 514, 8.1);
INSERT INTO inscripciones VALUES (616, 14, 513, 7.2);
INSERT INTO inscripciones VALUES (617, 15, 501, 8.9);
INSERT INTO inscripciones VALUES (618, 16, 510, 6.4);
INSERT INTO inscripciones VALUES (619, 17, 504, 9.0);
INSERT INTO inscripciones VALUES (620, 18, 505, 7.0);
INSERT INTO inscripciones VALUES (621, 1, 511, 9.8);
INSERT INTO inscripciones VALUES (622, 2, 511, 9.5);
INSERT INTO inscripciones VALUES (623, 12, 501, 9.1);

-- Becas (10)
INSERT INTO becas VALUES (701, 1, 100, 'Excelencia Académica');
INSERT INTO becas VALUES (702, 2, 100, 'Excelencia Académica');
INSERT INTO becas VALUES (703, 3, 50, 'Apoyo Económico');
INSERT INTO becas VALUES (704, 4, 75, 'Mérito Deportivo');
INSERT INTO becas VALUES (705, 6, 100, 'Excelencia Académica');
INSERT INTO becas VALUES (706, 7, 25, 'Apoyo Transporte');
INSERT INTO becas VALUES (707, 12, 50, 'Apoyo Económico');
INSERT INTO becas VALUES (708, 15, 100, 'Excelencia Académica');
INSERT INTO becas VALUES (709, 17, 75, 'Mérito Cultural');
INSERT INTO becas VALUES (710, 20, 50, 'Apoyo Económico');

