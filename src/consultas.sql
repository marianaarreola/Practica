-- =============================================================================
-- MATRIZ DE 20 CONSULTAS COMPLEJAS EN LOS 4 LENGUAJES FORMALES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- GRUPO 1: OPERADORES BÁSICOS (5 CONSULTAS)
-- -----------------------------------------------------------------------------

-- CONSULTA 1: Estudiantes mayores de 20 años inscritos en la carrera de ISC.
-- AR:  \sigma_{edad > 20 \wedge carrera = 'ISC'}(Estudiantes)
-- CRT: { t | Estudiantes(t) \wedge t.edad > 20 \wedge t.carrera = 'ISC' }
-- CRD: { <i, n, c, e, d> | Estudiantes(i, n, c, e, d) \wedge e > 20 \wedge c = 'ISC' }
SELECT * FROM estudiantes WHERE edad > 20 AND carrera = 'ISC';

-- CONSULTA 2: Nombres y especialidades de profesores del departamento de id 1.
-- AR:  \pi_{nombre, especialidad}(\sigma_{id_depto = 1}(Profesores))
-- CRT: { t.nombre, t.especialidad | Profesores(t) \wedge t.id_depto = 1 }
-- CRD: { <n, es> | \exists i, d, tel (Profesores(i, n, es, d, tel) \wedge d = 1) }
SELECT nombre, especialidad FROM profesores WHERE id_depto = 1;

-- CONSULTA 3: Nombres de todos los miembros de la comunidad que están registrados en el depto 1 (Estudiantes y Profesores).
-- AR:  \pi_{nombre}(\sigma_{id_depto=1}(Estudiantes)) \cup \pi_{nombre}(\sigma_{id_depto=1}(Profesores))
-- CRT: { t.nombre | \exists e (Estudiantes(e) \wedge e.id_depto = 1 \wedge t.nombre = e.nombre) \vee \exists p (Profesores(p) \wedge p.id_depto = 1 \wedge t.nombre = p.nombre) }
-- CRD: { <n> | \exists i, c, ed, d (Estudiantes(i, n, c, ed, d) \wedge d = 1) \vee \exists ip, es, tel (Profesores(ip, n, es, d, tel) \wedge d = 1) }
SELECT nombre FROM estudiantes WHERE id_depto = 1 
UNION 
SELECT nombre FROM profesores WHERE id_depto = 1;

-- CONSULTA 4: Claves de departamentos que tienen asignados tanto cursos como estudiantes.
-- AR:  \pi_{id_depto}(Cursos) \cap \pi_{id_depto}(Estudiantes)
-- CRT: { t.id_depto | \exists c (Cursos(c) \wedge c.id_depto = t.id_depto) \wedge \exists e (Estudiantes(e) \wedge e.id_depto = t.id_depto) }
-- CRD: { <d> | \exists ic, n, cr, h (Cursos(ic, n, cr, h, d)) \wedge \exists ie, ne, ca, ed (Estudiantes(ie, ne, ca, ed, d)) }
SELECT id_depto FROM cursos 
INTERSECT 
SELECT id_depto FROM estudiantes;

-- CONSULTA 5: Identificadores de alumnos que están inscritos en el sistema pero no poseen ninguna beca.
-- AR:  \pi_{id_estudiante}(Estudiantes) - \pi_{id_estudiante}(Becas)
-- CRT: { t.id_estudiante | Estudiantes(t) \wedge \neg \exists b (Becas(b) \wedge b.id_estudiante = t.id_estudiante) }
-- CRD: { <ie> | \exists n, c, e, d (Estudiantes(ie, n, c, e, d)) \wedge \neg \exists ib, p, tb (Becas(ib, ie, p, tb)) }
SELECT id_estudiante FROM estudiantes 
EXCEPT 
SELECT id_estudiante FROM becas;


-- -----------------------------------------------------------------------------
-- GRUPO 2: REUNIONES (JOIN) (5 CONSULTAS)
-- -----------------------------------------------------------------------------

-- CONSULTA 6: Nombre de alumnos junto al nombre del curso en el que están inscritos (Natural / Inner Join).
-- AR:  \pi_{Estudiantes.nombre, Cursos.nombre}(Estudiantes \bowtie Inscripciones \bowtie Clases \bowtie Cursos)
-- CRT: { t.nom_est, t.nom_cur | \exists e \exists i \exists cl \exists c (Estudiantes(e) \wedge Inscripciones(i) \wedge Clases(cl) \wedge Cursos(c) \wedge e.id_estudiante = i.id_estudiante \wedge i.id_clase = cl.id_clase \wedge cl.id_curso = c.id_curso \wedge t.nom_est = e.nombre \wedge t.nom_cur = c.nombre) }
-- CRD: { <ne, nc> | \exists ie,ca,ed,d,ii,ic,ca,id_c,id_p,id_a,h,cr,ht (Estudiantes(ie,ne,ca,ed,d) \wedge Inscripciones(ii,ie,ic,ca) \wedge Clases(ic,id_c,id_p,id_a,h) \wedge Cursos(id_c,nc,cr,ht,d)) }
SELECT e.nombre AS nom_est, c.nombre AS nom_cur 
FROM estudiantes e 
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN clases cl ON i.id_clase = cl.id_clase
JOIN cursos c ON cl.id_curso = c.id_curso;

-- CONSULTA 7: Lista completa de todos los estudiantes y los porcentajes de sus becas (Muestra Left Outer Join).
-- AR:  \pi_{Estudiantes.nombre, Becas.porcentaje}(Estudiantes \ Becas)
-- CRT: { t.nombre, t.porcentaje | \exists e (Estudiantes(e) \wedge t.nombre = e.nombre \wedge (\exists b (Becas(b) \wedge b.id_estudiante = e.id_estudiante \wedge t.porcentaje = b.porcentaje) \vee (\neg \exists b (Becas(b) \wedge b.id_estudiante = e.id_estudiante) \wedge t.porcentaje = NULL))) }
-- CRD: { <ne, p> | \exists ie,ca,ed,d (Estudiantes(ie,ne,ca,ed,d) \wedge (\exists ib,tb (Becas(ib,ie,p,tb)) \vee (\neg \exists ib,p2,tb (Becas(ib,ie,p2,tb)) \wedge p = NULL))) }
SELECT e.nombre, b.porcentaje 
FROM estudiantes e 
LEFT JOIN becas b ON e.id_estudiante = b.id_estudiante;

-- CONSULTA 8: Lista completa de profesores y los nombres de las clases que imparten (Muestra Right Outer Join).
-- AR:  \pi_{Profesores.nombre, Clases.id_clase}(Profesores \ Clases)
-- CRT: { t.nom_prof, t.id_clase | \exists cl (Clases(cl) \wedge t.id_clase = cl.id_clase \wedge (\exists p (Profesores(p) \wedge p.id_profesor = cl.id_profesor \wedge t.nom_prof = p.nombre))) }
-- CRD: { <np, ic> | \exists id_p,es,d,tel,id_c,id_a,h (Profesores(id_p,np,es,d,tel) \ Clases(ic,id_c,id_p,id_a,h)) }
SELECT p.nombre, cl.id_clase 
FROM clases cl 
RIGHT JOIN profesores p ON cl.id_profesor = p.id_profesor;

-- CONSULTA 9: Alumnos que tienen la misma edad que otros alumnos de la carrera de ISC (Self Join).
-- AR:  \pi_{E1.nombre, E2.nombre}(\sigma_{E1.id_estudiante \neq E2.id_estudiante}(Estudiantes \bowtie_{E1.edad=E2.edad} Estudiantes))
-- CRT: { t.nom1, t.nom2 | \exists e1 \exists e2 (Estudiantes(e1) \wedge Estudiantes(e2) \wedge e1.id_estudiante \neq e2.id_estudiante \wedge e1.edad = e2.edad \wedge t.nom1 = e1.nombre \wedge t.nom2 = e2.nombre) }
-- CRD: { <n1, n2> | \exists ie1,c1,ed1,d1,ie2,c2,d2 (Estudiantes(ie1,n1,c1,ed1,d1) \wedge Estudiantes(ie2,n2,c2,ed1,d2) \wedge ie1 \neq ie2) }
SELECT e1.nombre AS est1, e2.nombre AS est2, e1.edad 
FROM estudiantes e1 
JOIN estudiantes e2 ON e1.edad = e2.edad AND e1.id_estudiante <> e2.id_estudiante;

-- CONSULTA 10: Datos de las clases asignadas en laboratorios (Muestra Semi-Join conceptual).
-- AR:  Clases \ltimes_{Clases.id_aula = Aulas.id_aula} (\sigma_{tipo='Laboratorio'}(Aulas))
-- CRT: { t | Clases(t) \wedge \exists a (Aulas(a) \wedge a.id_aula = t.id_aula \wedge a.tipo = 'Laboratorio') }
-- CRD: { <ic,id_c,id_p,id_a,h> | Clases(ic,id_c,id_p,id_a,h) \wedge \exists cod,cap,tip,ed (Aulas(id_a,cod,cap,tip,ed) \wedge tip = 'Laboratorio') }
SELECT * FROM clases 
WHERE id_aula IN (SELECT id_aula FROM aulas WHERE tipo = 'Laboratorio');


-- -----------------------------------------------------------------------------
-- GRUPO 3: AGRUPACIÓN Y AGREGACIÓN (5 CONSULTAS)
-- -----------------------------------------------------------------------------

-- CONSULTA 11: Total de dinero destinado al presupuesto de todos los departamentos académicos.
-- AR:  \mathcal{F}_{SUM(presupuesto)}(Departamentos)
-- CRT: { t.total | t.total = SUM(d.presupuesto) \wedge Departamentos(d) }
-- CRD: { <tot> | tot = SUM(p) \wedge \exists id, n, ed (Departamentos(id, n, ed, p)) }
SELECT SUM(presupuesto) AS total_presupuesto FROM departamentos;

-- CONSULTA 12: Cantidad total de estudiantes inscritos específicamente en la carrera de 'ISC'.
-- AR:  \mathcal{F}_{COUNT(id_estudiante)}(\sigma_{carrera='ISC'}(Estudiantes))
-- CRT: { t.cant | t.cant = COUNT(e) \wedge Estudiantes(e) \wedge e.carrera = 'ISC' }
-- CRD: { <cant> | cant = COUNT(ie) \wedge \exists n, c, ed, d (Estudiantes(ie, n, c, ed, d) \wedge c = 'ISC') }
SELECT COUNT(id_estudiante) AS total_isc FROM estudiantes WHERE carrera = 'ISC';

-- CONSULTA 13: Número de estudiantes asignados por cada departamento académico.
-- AR:  _{id_depto} \gamma_{COUNT(id_estudiante)}(Estudiantes)
-- CRT: { t.id_depto, t.total | \exists d (Estudiantes(d) \wedge t.id_depto = d.id_depto \wedge t.total = COUNT(e.id_estudiante | e.id_depto = d.id_depto)) }
-- CRD: { <d, tot> | tot = COUNT(ie) \wedge \exists n, c, ed (Estudiantes(ie, n, c, ed, d)) GROUP BY d }
SELECT id_depto, COUNT(id_estudiante) AS total_estudiantes FROM estudiantes GROUP BY id_depto;

-- CONSULTA 14: Promedio de calificaciones por cada alumno con un promedio superior a 8.5.
-- AR:  \sigma_{promedio > 8.5}(_{id_estudiante} \gamma_{AVG(calificacion)}(Inscripciones))
-- CRT: { t.id_estudiante, t.prom | \exists i (Inscripciones(i) \wedge t.id_estudiante = i.id_estudiante \wedge t.prom = AVG(ins.calificacion) > 8.5) }
-- CRD: { <ie, prom> | prom = AVG(cal) \wedge \exists id_i, id_cl (Inscripciones(id_i, ie, id_cl, cal)) GROUP BY ie HAVING AVG(cal) > 8.5 }
SELECT id_estudiante, AVG(calificacion) AS promedio FROM inscripciones GROUP BY id_estudiante HAVING AVG(calificacion) > 8.5;

-- CONSULTA 15: Edad promedio de los estudiantes de la carrera de 'ISC' agrupados por departamento.
-- AR:  _{id_depto} \gamma_{AVG(edad)}(\sigma_{carrera='ISC'}(Estudiantes))
-- CRT: { t.id_depto, t.prom_edad | \exists e (Estudiantes(e) \wedge e.carrera = 'ISC' \wedge t.id_depto = e.id_depto) }
SELECT id_depto, AVG(edad) AS promedio_edad FROM estudiantes WHERE carrera = 'ISC' GROUP BY id_depto;


-- -----------------------------------------------------------------------------
-- GRUPO 4: DIVISIÓN RELACIONAL (3 CONSULTAS)
-- -----------------------------------------------------------------------------

-- CONSULTA 16: Alumnos inscritos en ABSOLUTAMENTE TODAS las clases impartidas en el Edificio 1.
-- AR:  (\pi_{id_estudiante, id_clase}(Inscripciones)) \div (\pi_{id_clase}(\sigma_{edificio='Edificio 1'}(Clases \bowtie Aulas)))
-- CRT: { t | \exists e (Estudiantes(e) \wedge t.id_estudiante = e.id_estudiante \wedge \forall cl (Clases(cl) \wedge \exists a (Aulas(a) \wedge cl.id_aula = a.id_aula \wedge a.edificio = 'Edificio 1') \rightarrow \exists i (Inscripciones(i) \wedge i.id_estudiante = e.id_estudiante \wedge i.id_clase = cl.id_clase))) }
-- CRD: { <ie> | \exists ne,ca,ed,d (Estudiantes(ie,ne,ca,ed,d)) \wedge \forall ic,id_c,id_p,id_a,h (Clases(ic,id_c,id_p,id_a,h) \wedge \exists cod,cap,tip (Aulas(id_a,cod,cap,tip,'Edificio 1') \rightarrow \exists id_i,cal (Inscripciones(id_i,ie,ic,cal)))) }
SELECT id_estudiante FROM estudiantes e 
WHERE NOT EXISTS (
    SELECT cl.id_clase FROM clases cl 
    JOIN aulas a ON cl.id_aula = a.id_aula WHERE a.edificio = 'Edificio 1'
    EXCEPT
    SELECT i.id_clase FROM inscripciones i WHERE i.id_estudiante = e.id_estudiante
);

-- CONSULTA 17: Profesores que dan clase en TODAS las aulas de tipo 'Laboratorio'.
-- AR:  (\pi_{id_profesor, id_aula}(Clases)) \div (\pi_{id_aula}(\sigma_{tipo='Laboratorio'}(Aulas)))
-- CRT: { t | \exists p (Profesores(p) \wedge t.id_profesor = p.id_profesor \wedge \forall a (Aulas(a) \wedge a.tipo = 'Laboratorio' \rightarrow \exists cl (Clases(cl) \wedge cl.id_profesor = p.id_profesor \wedge cl.id_aula = a.id_aula))) }
-- CRD: { <ip> | \exists np,es,d,tel (Profesores(ip,np,es,d,tel)) \wedge \forall id_a,cod,cap,ed (Aulas(id_a,cod,cap,'Laboratorio',ed) \rightarrow \exists ic,id_c,h (Clases(ic,id_c,ip,id_a,h))) }
SELECT id_profesor FROM profesores p 
WHERE NOT EXISTS (
    SELECT id_aula FROM aulas WHERE tipo = 'Laboratorio'
    EXCEPT
    SELECT id_aula FROM clases cl WHERE cl.id_profesor = p.id_profesor
);

-- CONSULTA 18: Departamentos que ofrecen materias para TODAS las carreras registradas (ISC, LCD, MEC, ELEC).
-- AR:  (\pi_{id_depto, carrera}(Cursos \bowtie Estudiantes)) \div (\pi_{carrera}(Estudiantes))
-- CRT: { t | \exists d (Departamentos(d) \wedge t.id_depto = d.id_depto \wedge \forall c ( \exists e (Estudiantes(e) \wedge e.carrera = c.carrera) \rightarrow \exists cur \exists est (Cursos(cur) \wedge Estudiantes(est) \wedge cur.id_depto = d.id_depto \wedge est.id_depto = d.id_depto \wedge est.carrera = c.carrera))) }
SELECT d.id_depto FROM departamentos d
WHERE NOT EXISTS (
    SELECT DISTINCT carrera FROM estudiantes
    EXCEPT
    SELECT DISTINCT e.carrera FROM estudiantes e WHERE e.id_depto = d.id_depto
);


-- -----------------------------------------------------------------------------
-- GRUPO 5: CUANTIFICADORES UNIVERSALES (\forall) (2 CONSULTAS)
-- -----------------------------------------------------------------------------

-- CONSULTA 19: Profesores para los cuales TODAS sus clases asignadas tienen una capacidad de aula mayor a 30 alumnos.
-- AR:  \pi_{id_profesor}(Profesores) - \pi_{id_profesor}(Clases \bowtie \sigma_{capacidad \le 30}(Aulas))
-- CRT: { t | Profesores(t) \wedge \forall cl (Clases(cl) \wedge cl.id_profesor = t.id_profesor \rightarrow \exists a (Aulas(a) \wedge cl.id_aula = a.id_aula \wedge a.capacidad > 30)) }
-- CRD: { <ip,np,es,d,tel> | Profesores(ip,np,es,d,tel) \wedge \forall ic,id_c,id_a,h (Clases(ic,id_c,ip,id_a,h) \rightarrow \exists cod,cap,tip,ed (Aulas(id_a,cod,cap,tip,ed) \wedge cap > 30)) }
SELECT * FROM profesores p 
WHERE NOT EXISTS (
    SELECT * FROM clases cl 
    JOIN aulas a ON cl.id_aula = a.id_aula 
    WHERE cl.id_profesor = p.id_profesor AND a.capacidad <= 30
);

-- CONSULTA 20: Estudiantes con una beca que NO tienen ninguna otra beca asignada inferior al 100% (Solo becados totales).
-- AR:  \pi_{id_estudiante}(\sigma_{porcentaje=100}(Becas)) - \pi_{id_estudiante}(\sigma_{porcentaje < 100}(Becas))
-- CRT: { t | Estudiantes(t) \wedge \exists b (Becas(b) \wedge b.id_estudiante = t.id_estudiante \wedge b.porcentaje = 100) \wedge \forall b2 (Becas(b2) \wedge b2.id_estudiante = t.id_estudiante \rightarrow b2.porcentaje = 100) }
-- CRD: { <ie,n,c,e,d> | Estudiantes(ie,n,c,e,d) \wedge \exists ib,tb (Becas(ib,ie,100,tb)) \wedge \forall ib2,p2,tb2 (Becas(ib2,ie,p2,tb2) \rightarrow p2 = 100) }
SELECT * FROM estudiantes e 
WHERE EXISTS (
    SELECT 1 FROM becas b WHERE b.id_estudiante = e.id_estudiante AND b.porcentaje = 100
) 
AND NOT EXISTS (
    SELECT 1 FROM becas b2 WHERE b2.id_estudiante = e.id_estudiante AND b2.porcentaje < 100
);