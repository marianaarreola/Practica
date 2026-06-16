🎓 Sistema Universitario - Prácticas 7, 8 y 9



Este repositorio contiene el desarrollo integral de las prácticas 7, 8 y 9 para la materia de Bases de Datos. El objetivo es modelar un \*Sistema Universitario\* y resolver consultas de alta complejidad utilizando tres enfoques teóricos y prácticos: \*Álgebra Relacional, \*\*Cálculo Relacional (Tuplas/Dominios)\* y su implementación en \*SQL\*.



\## 🛠️ Tecnologías y Conceptos Aplicados

\* \*Lenguaje:\* SQL (MySQL / PostgreSQL)

\* \*Teoría Relacional:\* Álgebra Relacional (Selección, Proyección, Unión, Intersección, Diferencia, Producto Cartesiano, Joins y División).

\* \*Cálculo Relacional:\* Expresiones de Cálculo Relacional de Tuplas (CRT) y Cálculo Relacional de Dominios (CRD).



\## 📊 Modelo Relacional (5 Entidades Principales)

El sistema universitario está fundamentado en las siguientes tablas:

1\. Departamento: Información de las facultades o áreas académicas.

2\. Profesor: Datos del personal docente adscrito a un departamento.

3\. Estudiante: Registro de alumnos matriculados y sus carreras.

4\. Curso: Catálogo de asignaturas disponibles, créditos y departamento que las imparte.

5\. Inscripcion: Relación intermedia (N:M) que vincula a los estudiantes con los cursos, incluyendo el semestre y la calificación obtenida.



\## 📁 Contenido del Repositorio

\* src/esquema.sql: Script de definición de datos (DDL) y manipulación de datos (DML) con registros de prueba.

\* src/consultas.sql: Solución en SQL de las 20 consultas complejas del caso integrador.

\* docs/algebra\_calculo.md: Documentación matemática y formal de las consultas traducidas a Álgebra y Cálculo Relacional.

