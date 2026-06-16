-- ========================================================
-- VERSION POSTGRESQL: SISTEMA UNIVERSITARIO COMPLETO
-- ========================================================

-- Limpiamos el esquema por si ya existe y lo creamos de cero
DROP SCHEMA IF EXISTS universidad CASCADE;
CREATE SCHEMA universidad;
SET search_path TO universidad;

-- 1. Departamento
CREATE TABLE Departamento (
    id_depto INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    edificio VARCHAR(20) NOT NULL,
    presupuesto DECIMAL(12,2)
);

-- 2. Profesor
CREATE TABLE Profesor (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(50),
    id_depto INT,
    telefono VARCHAR(15),
    FOREIGN KEY (id_depto) REFERENCES Departamento(id_depto) ON UPDATE CASCADE
);

-- 3. Estudiante
CREATE TABLE Estudiante (
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    carrera VARCHAR(50) NOT NULL,
    id_depto INT,
    fecha_ingreso DATE NOT NULL,
    FOREIGN KEY (id_depto) REFERENCES Departamento(id_depto) ON UPDATE CASCADE
);

-- 4. Curso
CREATE TABLE Curso (
    id_curso INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos INT NOT NULL,
    id_depto INT,
    horas_totales INT NOT NULL,
    FOREIGN KEY (id_depto) REFERENCES Departamento(id_depto) ON UPDATE CASCADE
);

-- 5. Aula
CREATE TABLE Aula (
    id_aula INT PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL UNIQUE,
    capacidad INT NOT NULL,
    tipo VARCHAR(30) DEFAULT 'Teoría'
);

-- 6. Horario
CREATE TABLE Horario (
    id_horario INT PRIMARY KEY,
    id_curso INT,
    id_profesor INT,
    id_aula INT,
    dia VARCHAR(15) NOT NULL,
    hora_inicio TIME NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso) ON DELETE CASCADE,
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor) ON DELETE SET NULL,
    FOREIGN KEY (id_aula) REFERENCES Aula(id_aula) ON DELETE SET NULL
);

-- 7. Inscripcion
CREATE TABLE Inscripcion (
    id_estudiante INT,
    id_curso INT,
    semestre VARCHAR(10),
    calificacion DECIMAL(4,2),
    PRIMARY KEY (id_estudiante, id_curso, semestre),
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso) ON DELETE CASCADE
);

-- 8. Beca
CREATE TABLE Beca (
    id_beca INT PRIMARY KEY,
    id_estudiante INT,
    tipo_beca VARCHAR(30) NOT NULL,
    porcentaje INT NOT NULL,
    estado VARCHAR(15) DEFAULT 'Activa',
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante) ON DELETE CASCADE
);

-- ========================================================
-- POBLADO DE DATOS (10+ TUPLAS POR TABLA)
-- ========================================================

INSERT INTO Departamento VALUES 
(1, 'Sistemas Computacionales', 'Edificio 3', 500000.00),
(2, 'Ciencias Básicas', 'Edificio 1', 350000.00),
(3, 'Electrónica', 'Edificio Mini', 400000.00),
(4, 'Ciencias Sociales', 'Edificio 5', 200000.00),
(5, 'Idiomas', 'Edificio 4', 150000.00),
(6, 'Física', 'Edificio 2', 300000.00),
(7, 'Matemáticas Avanzadas', 'Edificio 1', 280000.00),
(8, 'Innovación Tecnológica', 'Edificio 3', 450000.00),
(9, 'Humanidades', 'Edificio 5', 120000.00),
(10, 'Vinculación', 'Edificio Central', 100000.00);

INSERT INTO Profesor VALUES 
(101, 'Dr. Armando Silva', 'Inteligencia Artificial', 1, '5551112223'),
(102, 'M. en C. Laura Peña', 'Cálculo Vectorial', 2, '5552223334'),
(103, 'Ing. Roberto Gómez', 'Circuitos Lógicos', 3, '5553334445'),
(104, 'Dra. Elena Rostova', 'Sistemas Operativos', 1, '5554445556'),
(105, 'Lic. Sofía Mireles', 'Inglés Técnico', 5, '5555556667'),
(106, 'Dr. Carlos Fuentes', 'Mecánica Cuántica', 6, '5556667778'),
(107, 'M. en C. Pedro Pascal', 'Álgebra Lineal', 7, '5557778889'),
(108, 'Ing. Diana Prince', 'Microcontroladores', 3, '5558889990'),
(109, 'Dr. Alan Turing', 'Teoría de la Computación', 1, '5559990001'),
(110, 'Dra. Marie Curie', 'Termodinámica', 6, '5550001112');

INSERT INTO Estudiante VALUES 
(202101, 'Mariana Arreola', 'ISC', 1, '2024-08-12'),
(202102, 'Carlos Mendoza', 'ISC', 1, '2024-08-12'),
(202103, 'Diana Laura Cruz', 'ISC', 1, '2024-08-12'),
(202104, 'Alejandro Ruiz', 'Biónica', 3, '2025-01-20'),
(202105, 'Beatriz Pinzón', 'Mecatrónica', 3, '2023-08-15'),
(202106, 'Fernando Mendiola', 'Gestión', 4, '2023-08-15'),
(202107, 'Gabriela Solís', 'ISC', 1, '2025-01-20'),
(202108, 'Hugo Sánchez', 'Licenciatura', 4, '2024-08-12'),
(202109, 'Ignacio López', 'Biónica', 3, '2025-01-20'),
(202110, 'Julia Roberts', 'Idiomas', 5, '2025-08-11');

INSERT INTO Curso VALUES 
(501, 'Bases de Datos', 5, 1, 90),
(502, 'Matemáticas Discretas', 4, 2, 72),
(503, 'Estructuras de Datos', 5, 1, 90),
(504, 'Análisis de Circuitos', 4, 3, 72),
(505, 'Programación Orientada a Objetos', 5, 1, 90),
(506, 'Cálculo Diferencial', 4, 2, 72),
(507, 'Electrónica Digital', 5, 3, 90),
(508, 'Física General', 4, 6, 72),
(509, 'Inglés Avanzado', 3, 5, 54),
(510, 'Ecuaciones Diferenciales', 4, 7, 72);

INSERT INTO Aula VALUES 
(1, 'A-301', 40, 'Laboratorio de Cómputo'),
(2, 'A-102', 35, 'Teoría'),
(3, 'A-Mini', 20, 'Laboratorio de Electrónica'),
(4, 'A-302', 40, 'Laboratorio de Cómputo'),
(5, 'A-501', 50, 'Teoría'),
(6, 'A-401', 30, 'Audiovisual'),
(7, 'A-201', 35, 'Teoría'),
(8, 'A-105', 45, 'Teoría'),
(9, 'A-305', 40, 'Teoría'),
(10, 'A-Cen', 100, 'Auditorio');

INSERT INTO Horario VALUES 
(1, 501, 101, 1, 'Lunes', '07:00:00'),
(2, 502, 102, 2, 'Martes', '08:30:00'),
(3, 503, 104, 4, 'Miércoles', '10:30:00'),
(4, 504, 103, 3, 'Jueves', '07:00:00'),
(5, 505, 109, 1, 'Viernes', '12:00:00'),
(6, 506, 102, 8, 'Lunes', '10:30:00'),
(7, 507, 108, 3, 'Martes', '12:00:00'),
(8, 508, 106, 7, 'Miércoles', '08:30:00'),
(9, 509, 105, 6, 'Jueves', '15:00:00'),
(10, 510, 107, 2, 'Viernes', '07:00:00');

INSERT INTO Inscripcion VALUES 
(202101, 501, '2026-1', 9.50),
(202101, 502, '2026-1', 8.50),
(202101, 503, '2026-1', 10.00),
(202102, 501, '2026-1', 8.00),
(202102, 503, '2026-1', 7.50),
(202103, 501, '2026-1', 9.00),
(202103, 505, '2026-1', 9.20),
(202104, 504, '2026-1', 5.50),
(202105, 504, '2026-1', 8.80),
(202105, 507, '2026-1', 9.00),
(202106, 509, '2026-1', 10.00),
(202107, 501, '2026-1', 6.00),
(202107, 502, '2026-1', 4.50),
(202108, 509, '2026-1', 8.30),
(202109, 507, '2026-1', 7.90),
(202110, 509, '2026-1', 9.10),
(202101, 505, '2026-1', 9.00),
(202102, 505, '2026-1', 8.20),
(202103, 503, '2026-1', 8.80),
(202104, 507, '2026-1', 6.50),
(202107, 503, '2026-1', 7.00);

INSERT INTO Beca VALUES 
(1, 202101, 'Excelencia', 100, 'Activa'),
(2, 202103, 'Manutención', 50, 'Activa'),
(3, 202104, 'Deportiva', 30, 'Activa'),
(4, 202105, 'Institucional', 40, 'Suspendida'),
(5, 202107, 'Manutención', 50, 'Activa'),
(6, 202108, 'Transporte', 25, 'Activa'),
(7, 202102, 'Institucional', 40, 'Activa'),
(8, 202106, 'Excelencia', 100, 'Activa'),
(9, 202109, 'Deportiva', 30, 'Activa'),
(10, 202110, 'Transporte', 25, 'Activa');