\# 🎓 Sistema Universitario - Caso Integrador (Prácticas 7, 8 y 9)



\## 📝 Información General

\* \*\*Institución:\*\* Instituto Politécnico Nacional (IPN)

\* \*\*Programa:\*\* Ingeniería en Sistemas Computacionales (ISC)

\* \*\*Desarrollador:\*\* Mariana Arreola

\* \*\*Asignatura:\*\* Bases de Datos



\---



\## 🏛️ Descripción del Dominio

El presente proyecto implementa el núcleo de un \*\*Sistema Universitario\*\* diseñado para gestionar el control escolar, la asignación docente y los estímulos económicos de la comunidad estudiantil. El esquema modela la interacción entre estudiantes, los profesores adscritos a departamentos académicos, la oferta de cursos, los horarios de clases vinculados a aulas físicas, el registro transaccional de inscripciones académicas con sus respectivas evaluaciones, y el seguimiento de becas institucionales.



\---



\## 🗺️ Diseño del Esquema Relacional



El sistema está compuesto por \*\*8 relaciones interconectadas\*\* con llaves primarias ($PK$) y llaves foráneas ($FK$):



1\. \*\*Departamento\*\* ($\\underline{id\\\_depto}$, nombre, edificio, presupuesto)

2\. \*\*Profesor\*\* ($\\underline{id\\\_profesor}$, nombre, especialidad, \*id\\\_depto\*, telefono) $\\rightarrow$ \*FK: id\_depto\*

3\. \*\*Estudiante\*\* ($\\underline{id\\\_estudiante}$, nombre, carrera, \*id\\\_depto\*, fecha\\\_ingreso) $\\rightarrow$ \*FK: id\_depto\*

4\. \*\*Curso\*\* ($\\underline{id\\\_curso}$, nombre, creditos, \*id\\\_depto\*, horas\\\_totales) $\\rightarrow$ \*FK: id\_depto\*

5\. \*\*Aula\*\* ($\\underline{id\\\_aula}$, codigo, capacidad, tipo)

6\. \*\*Horario\*\* ($\\underline{id\\\_horario}$, \*id\\\_curso\*, \*id\\\_profesor\*, \*id\\\_aula\*, dia, hora\\\_inicio) $\\rightarrow$ \*FKs: id\_curso, id\_profesor, id\_aula\*

7\. \*\*Inscripcion\*\* ($\\underline{id\\\_estudiante, id\\\_curso, semestre}$, calificacion) $\\rightarrow$ \*FKs: id\_estudiante, id\_curso\*

8\. \*\*Beca\*\* ($\\underline{id\\\_beca}$, \*id\\\_estudiante\*, tipo\\\_beca, porcentaje, estado) $\\rightarrow$ \*FK: id\_estudiante\*



\---



\## 🧮 Modelado Teórico y Equivalencia de Lenguajes

A continuación se demuestran formalmente los comportamientos matemáticos para las consultas clave del Caso Integrador.



\### Consulta 1: Selección y Proyección Básica (Bloque 1)

\* \*\*Descripción:\*\* Obtener el nombre y la carrera de los alumnos adscritos al departamento 1.

\* \*\*Álgebra Relacional (AR):\*\*

&#x20; $$\\pi\_{nombre, carrera}(\\sigma\_{id\\\_depto = 1}(Estudiante))$$

\* \*\*Cálculo Relacional de Tuplas (CRT):\*\*

&#x20; $$\\{ t \\,|\\, \\exists e \\in Estudiante \\, (e.id\\\_depto = 1 \\wedge t.nombre = e.nombre \\wedge t.carrera = e.carrera) \\}$$

\* \*\*Cálculo Relacional de Dominios (CRD):\*\*

&#x20; $$\\{ \\langle nom, car \\rangle \\,|\\, \\exists id\\\_e, id\\\_d, f \\, (\\langle id\\\_e, nom, car, id\\\_d, f \\rangle \\in Estudiante \\wedge id\\\_d = 1) \\}$$



\### Consulta 6: Reunión Natural / Inner Join (Bloque 2)

\* \*\*Descripción:\*\* Listar el nombre del estudiante, el nombre del curso y la calificación final de todas las inscripciones.

\* \*\*Álgebra Relacional (AR):\*\*

&#x20; $$\\pi\_{Estudiante.nombre, Curso.nombre, Inscripcion.calificacion}(Estudiante \\bowtie Inscripcion \\bowtie Curso)$$

\* \*\*Cálculo Relacional de Tuplas (CRT):\*\*

&#x20; $$\\{ t \\,|\\, \\exists e \\in Estudiante \\, \\exists i \\in Inscripcion \\, \\exists c \\in Curso \\, (e.id\\\_estudiante = i.id\\\_estudiante \\wedge i.id\\\_curso = c.id\\\_curso \\wedge t.nombre = e.nombre \\wedge t.curso = c.nombre \\wedge t.calificacion = i.calificacion) \\}$$



\### Consulta 16: División Relacional Estricta (Bloque 4)

\* \*\*Descripción:\*\* Encontrar los nombres de los estudiantes inscritos en TODOS los cursos correspondientes al departamento 1.

\* \*\*Álgebra Relacional (AR):\*\*

&#x20; $$\\pi\_{id\\\_estudiante, id\\\_curso}(Inscripcion) \\div \\pi\_{id\\\_curso}(\\sigma\_{id\\\_depto = 1}(Curso))$$

\* \*\*Cálculo Relacional de Tuplas (CRT):\*\*

&#x20; $$\\{ t \\,|\\, \\exists e \\in Estudiante \\, (t.nombre = e.nombre \\wedge \\forall c \\in Curso \\, (c.id\\\_depto = 1 \\Rightarrow \\exists i \\in Inscripcion \\, (i.id\\\_estudiante = e.id\\\_estudiante \\wedge i.id\\\_curso = c.id\\\_curso))) \\}$$



\---



\## 🚀 Instrucciones de Instalación y Ejecución



\### Requisitos Previos

\* MySQL Server (Versión 8.0 o superior) o MySQL Workbench.

\* Cliente Git instalado localmente.



\### Pasos para Despliegue

1\. \*\*Clonar el repositorio:\*\*

&#x20;  ```bash

&#x20;  git clone \[https://github.com/marianaarreola/Practica.git](https://github.com/marianaarreola/Practica.git)

&#x20;  cd Practica

