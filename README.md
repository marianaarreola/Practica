\# 🎓 Sistema de Control Escolar Universitario - Caso Integrador



\## 👥 Integrantes

\* \*Flores Carlos Hunab Ku\*

\* \*Jose Sandoval Kevin Jael\*

\* \*Mariana Martinez Arreola\*

\* \*Monica Abril Vallejo Santiago\*



\## 📝 Descripción del Dominio

Este proyecto implementa un sistema relacional completo para la gestión y control escolar de una institución de educación superior. El diseño contempla el seguimiento integral de la estructura académica, administrando la jerarquía de departamentos, la asignación del cuerpo docente, el catálogo de cursos con sus respectivas unidades de crédito, la distribución física en aulas, la planeación de clases estructuradas, el historial de inscripciones y calificaciones de los alumnos, así como el control de estímulos económicos mediante un sistema acotado de becas institucionales.



\---



\## 🗺️ Modelo Relacional del Esquema



El sistema se compone de las siguientes 8 relaciones interconectadas de manera sólida:



1\. \*DEPARTAMENTOS\* ($\\underline{\\text{id\\\_depto}}$, nombre, edificio, presupuesto)

2\. \*PROFESORES\* ($\\underline{\\text{id\\\_profesor}}$, nombre, especialidad, id\_depto, telefono)

3\. \*CURSOS\* ($\\underline{\\text{id\\\_curso}}$, nombre, creditos, horas\_totales, id\_depto)

4\. \*ESTUDIANTES\* ($\\underline{\\text{id\\\_estudiante}}$, nombre, carrera, edad, id\_depto)

5\. \*AULAS\* ($\\underline{\\text{id\\\_aula}}$, codigo, capacidad, tipo, edificio)

6\. \*CLASES\* ($\\underline{\\text{id\\\_clase}}$, id\_curso, id\_profesor, id\_aula, horario)

7\. \*INSCRIPCIONES\* ($\\underline{\\text{id\\\_inscripcion}}$, id\_estudiante, id\_clase, calificacion)

8\. \*BECAS\* ($\\underline{\\text{id\\\_beca}}$, id\_estudiante, porcentaje, tipo\_beca)





