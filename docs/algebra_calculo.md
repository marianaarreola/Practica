\# 🧮 Modelado Matemático: Álgebra y Cálculo Relacional



Este documento detalla la equivalencia matemática para las operaciones del sistema universitario, demostrando el comportamiento del Cálculo Relacional de Tuplas (CRT) y Dominios (CRD).



\## 📑 Ejemplos de Equivalencia Estructural



\### Consulta 1: Estudiantes en el curso 'Bases de Datos'

\* \*\*Álgebra Relacional:\*\*

&#x20; $$\\pi\_{nombre}(\\sigma\_{Curso.nombre='Bases de Datos'}(Estudiante \\bowtie Inscripcion \\bowtie Curso))$$

\* \*\*Cálculo Relacional de Tuplas (CRT):\*\*

&#x20; $$\\{ t \\,|\\, \\exists e \\in Estudiante \\, \\exists i \\in Inscripcion \\, \\exists c \\in Curso \\, (e.id\\\_estudiante = i.id\\\_estudiante \\wedge i.id\\\_curso = c.id\\\_curso \\wedge c.nombre = 'Bases\\ de\\ Datos' \\wedge t.nombre = e.nombre) \\}$$



\### Operadores Básicos Utilizados (Práctica 7 y 8)

1\. \*\*Selección ($\\sigma$):\*\* Filtra filas bajo una condición.

2\. \*\*Proyección ($\\pi$):\*\* Extrae columnas específicas para eliminar redundancia.

3\. \*\*División ($\\div$):\*\* Utilizado en consultas del tipo "obtener los alumnos que se inscribieron a \*todos\* los cursos del departamento X".

