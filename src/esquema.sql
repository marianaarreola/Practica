-- ========================================================
-- SCRIPT DE CREACIÓN: SISTEMA UNIVERSITARIO
-- ========================================================
CREATE DATABASE IF NOT EXISTS SistemaUniversitario;
USE SistemaUniversitario;

-- 1. Tabla: Departamento
CREATE TABLE Departamento (
    id_depto INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    edificio VARCHAR(20)
);

-- 2. Tabla: Profesor
CREATE TABLE Profesor (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(50),
    id_depto INT,
    FOREIGN KEY (id_depto) REFERENCES Departamento(id_depto) ON UPDATE CASCADE
);

-- 3. Tabla: Estudiante
CREATE TABLE Estudiante (
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    carrera VARCHAR(50) NOT NULL,
    id_depto INT,
    FOREIGN KEY (id_depto) REFERENCES Departamento(id_depto) ON UPDATE CASCADE
);

-- 4. Tabla: Curso
CREATE TABLE Curso (
    id_curso INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos INT NOT NULL,
    id_depto INT,
    FOREIGN KEY (id_depto) REFERENCES Departamento(id_depto) ON UPDATE CASCADE
);

-- 5. Tabla: Inscripcion
CREATE TABLE Inscripcion (
    id_estudiante INT,
    id_curso INT,
    semestre VARCHAR(10),
    calificacion DECIMAL(4,2),
    PRIMARY KEY (id_estudiante, id_curso, semestre),
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso) ON DELETE CASCADE
);

-- ========================================================
-- INSERCIÓN DE DATOS DE PRUEBA (DML)
-- ========================================================
INSERT INTO Departamento VALUES 
(1, 'Sistemas Computacionales', 'Edificio 3'),
(2, 'Ciencias Básicas', 'Edificio 1'),
(3, 'Electrónica', 'Edificio Mini');

INSERT INTO Profesor VALUES 
(101, 'Dr. Armando Silva', 'Inteligencia Artificial', 1),
(102, 'M. en C. Laura Peña', 'Cálculo Vectorial', 2);

INSERT INTO Estudiante VALUES 
(202101, 'Mariana Arreola', 'ISC', 1),
(202102, 'Carlos Mendoza', 'ISC', 1);

INSERT INTO Curso VALUES 
(501, 'Bases de Datos', 5, 1),
(502, 'Matemáticas Discretas', 4, 2);

INSERT INTO Inscripcion VALUES 
(202101, 501, '2026-1', 9.5),
(202102, 501, '2026-1', 8.0);