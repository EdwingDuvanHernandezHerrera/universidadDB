# Proyecto Bases de Datos

## Universidad DB

### 1. Normalización de la base de datos

![](https://raw.githubusercontent.com/EdwingDuvanHernandezHerrera/universidadDB/main/modelo%20universidad_db.png)



### 2. Consultas

#### Consultas sobre una tabla

1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de
    todos los alumnos. El listado deberá estar ordenado alfabéticamente de
    menor a mayor por el primer apellido, segundo apellido y nombre.

  ```sql
  SELECT apellido1, apellido2, nombre
  FROM alumno
  ORDER BY apellido1, apellido2, nombre;
  
  # apellido1	apellido2	nombre
  Domínguez	Guerrero	Antonio
  Gea	Ruiz	Sonia
  Gutiérrez	López	Juan
  Heller	Pagac	Pedro
  Herman	Pacocha	Daniel
  Hernández	Martínez	Irene
  Herzog	Tremblay	Ramón
  Koss	Bayer	José
  Lakin	Yundt	Inma
  Saez	Vega	Juan
  Strosin	Turcotte	Ismael
  Sánchez	Pérez	Salvador
  ```

  

2. Averigua el nombre y los dos apellidos de los alumnos que no han dado de
    alta su número de teléfono en la base de datos.

  ```sql
  SELECT nombre, apellido1, apellido2
  FROM alumno
  WHERE id_alumno IN (SELECT id_alumno FROM telefono_alumno WHERE numero_tel IS NULL)
  ORDER BY apellido1, apellido2, nombre;
  
  # nombre	apellido1	apellido2
  Pedro	Heller	Pagac
  Ismael	Strosin	Turcotte
  ```

  

3. Devuelve el listado de los alumnos que nacieron en 1999.

   ```sql
   SELECT nombre, apellido1, apellido2
   FROM alumno
   WHERE YEAR(fecha_nacimiento) = 1999;
   
   # nombre	apellido1	apellido2
   Ismael	Strosin	Turcotte
   Antonio	Domínguez	Guerrero
   ```

   

4. Devuelve el listado de profesores que no han dado de alta su número de
    teléfono en la base de datos y además su nif termina en K.

  ```sql
  SELECT nombre_profesor, apellido1, apellido2
  FROM profesor
  WHERE id_profesor IN (SELECT id_profesor FROM telefono_profesor WHERE numero_tel IS NULL)
  AND nif LIKE '%K';
  
  # nombre_profesor	apellido1	apellido2
  Antonio	Fahey	Considine
  Guillermo	Ruecker	Upton
  ```

5. Devuelve el listado de las asignaturas que se imparten en el primer
    cuatrimestre, en el tercer curso del grado que tiene el identificador 7.

  ```sql
  SELECT nombre_asignatura
  FROM asignatura
  WHERE cuatrimestre = 1
  AND id_grado = 7
  AND id_asignatura IN (SELECT id_asignatura FROM matricula_alumno_asignatura WHERE id_curso = 3);
  
  
  No hay matriculas del curso 3, todas son del 4
  
  nombre_asignatura
  ```

  

#### Consultas multitabla (Composición interna)

1. Devuelve un listado con los datos de todas las alumnas que se han
    matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).

  ```sql
  SELECT nombre, apellido1, apellido2
  FROM alumno
  WHERE id_alumno IN (SELECT id_alumno FROM matricula_alumno_asignatura WHERE
  id_asignatura IN (SELECT id_asignatura FROM asignatura WHERE
  id_grado IN (SELECT id_grado FROM grado WHERE 
  nombre_grado = 'Grado en Ingeniería Informática (Plan 2015)')));
  
  # nombre	apellido1	apellido2
  Juan	Saez	Vega
  Salvador	Sánchez	Pérez
  José	Koss	Bayer
  
  ```

  

2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en
    Ingeniería Informática (Plan 2015).

  ```sql
  SELECT nombre_asignatura FROM asignatura WHERE
  id_grado IN (SELECT id_grado FROM grado WHERE
  nombre_grado = 'Grado en Ingeniería Informática (Plan 2015)');
  
  # nombre_asignatura
  Álgebra lineal y matemática discreta
  Cálculo
  Física para informática
  Introducción a la programación
  Organización y gestión de empresas
  Estadística
  Estructura y tecnología de computadores
  Fundamentos de electrónica
  Lógica y algorítmica
  Metodología de la programación
  Arquitectura de Computadores
  Estructura de Datos y Algoritmos I
  Ingeniería del Software
  Sistemas Inteligentes
  Sistemas Operativos
  Bases de Datos
  Estructura de Datos y Algoritmos II
  Fundamentos de Redes de Computadores
  Planificación y Gestión de Proyectos Informáticos
  Programación de Servicios Software
  Desarrollo de interfaces de usuario
  Ingeniería de Requisitos
  Integración de las Tecnologías de la Información en las Organizaciones
  Modelado y Diseño del Software 1
  Multiprocesadores
  Seguridad y cumplimiento normativo
  Sistema de Información para las Organizaciones
  Tecnologías web
  Teoría de códigos y criptografía
  Administración de bases de datos
  Herramientas y Métodos de Ingeniería del Software
  Informática industrial y robótica
  Ingeniería de Sistemas de Información
  Modelado y Diseño del Software 2
  Negocio Electrónico
  Periféricos e interfaces
  Sistemas de tiempo real
  Tecnologías de acceso a red
  Tratamiento digital de imágenes
  Administración de redes y sistemas operativos
  Almacenes de Datos
  Fiabilidad y Gestión de Riesgos
  Líneas de Productos Software
  Procesos de Ingeniería del Software 1
  Tecnologías multimedia
  Análisis y planificación de las TI
  Desarrollo Rápido de Aplicaciones
  Gestión de la Calidad y de la Innovación Tecnológica
  Inteligencia del Negocio
  Procesos de Ingeniería del Software 2
  Seguridad Informática
  Biologia celular
  Física
  Matemáticas I
  Química general
  Química orgánica
  Biología vegetal y animal
  Bioquímica
  Genética
  Matemáticas II
  Microbiología
  Botánica agrícola
  Fisiología vegetal
  Genética molecular
  Ingeniería bioquímica
  Termodinámica y cinética química aplicada
  Biorreactores
  Biotecnología microbiana
  Ingeniería genética
  Inmunología
  Virología
  Bases moleculares del desarrollo vegetal
  Fisiología animal
  Metabolismo y biosíntesis de biomoléculas
  Operaciones de separación
  Patología molecular de plantas
  Técnicas instrumentales básicas
  Bioinformática
  Biotecnología de los productos hortofrutículas
  Biotecnología vegetal
  Genómica y proteómica
  Procesos biotecnológicos
  Técnicas instrumentales avanzadas
  ```

  

3. Devuelve un listado de los profesores junto con el nombre del
    departamento al que están vinculados. El listado debe devolver cuatro
    columnas, primer apellido, segundo apellido, nombre y nombre del
    departamento. El resultado estará ordenado alfabéticamente de menor a
    mayor por los apellidos y el nombre.

  ```sql
  SELECT p.apellido1, p.apellido2, p.nombre_profesor, d.nombre_dpto
  FROM profesor AS p
  JOIN departamento AS d ON p.id_dpto = d.id_dpto
  ORDER BY p.apellido1, p.apellido2, p.nombre_profesor;
  
  # apellido1	apellido2	nombre_profesor	nombre_dpto
  Domínguez	Hernández	María	Matemáticas
  Fahey	Considine	Antonio	Economía y Empresa
  Guerrero	Martínez	Juan	Informática
  Hamill	Kozey	Manolo	Informática
  Kohler	Schoen	Alejandro	Matemáticas
  Lemke	Rutherford	Cristina	Economía y Empresa
  Monahan	Murray	Micaela	Agronomía
  Ramirez	Gea	Zoe	Informática
  Ruecker	Upton	Guillermo	Educación
  Sánchez	Ruiz	Pepe	Informática
  Schmidt	Fisher	David	Matemáticas
  Schowalter	Muller	Francesca	Química y Física
  Spencer	Lakin	Esther	Educación
  Stiedemann	Morissette	Alfredo	Química y Física
  Streich	Hirthe	Carmen	Educación
  ```

4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de
    fin del curso escolar del alumno con nif 26902806M.

  ```sql
  SELECT a.nombre_asignatura, cu.anyo_inicio, cu.anyo_fin
  FROM alumno AS al
  JOIN matricula_alumno_asignatura AS ma ON al.id_alumno = ma.id_alumno
  JOIN asignatura AS a ON ma.id_asignatura = a.id_asignatura
  JOIN curso AS cu ON ma.id_curso = cu.id_curso
  WHERE al.nif = '26902806M';
  
  # nombre_asignatura	anyo_inicio	anyo_fin
  Álgebra lineal y matemática discreta	2014	2015
  Cálculo	2014	2015
  Física para informática	2014	2015
  
  ```

5. Devuelve un listado con el nombre de todos los departamentos que tienen
    profesores que imparten alguna asignatura en el Grado en Ingeniería
    Informática (Plan 2015).

  ```sql
  SELECT DISTINCT d.nombre_dpto
  FROM departamento AS d
  JOIN profesor AS p ON d.id_dpto = p.id_dpto
  JOIN asignatura AS a ON p.id_profesor = a.id_profesor
  JOIN grado AS g ON a.id_grado = g.id_grado
  WHERE g.nombre_grado = 'Grado en Ingeniería Informática (Plan 2015)';
  
  # nombre_dpto
  Informática
  Matemáticas
  Economía y Empresa
  Educación
  Agronomía
  Química y Física
  
  ```

6. Devuelve un listado con todos los alumnos que se han matriculado en
    alguna asignatura durante el curso escolar 2018/2019.

  ```sql
  SELECT DISTINCT a.nombre, a.apellido1, a.apellido2
  FROM alumno AS a
  JOIN matricula_alumno_asignatura AS ma ON a.id_alumno = ma.id_alumno
  JOIN curso AS cu ON ma.id_curso = cu.id_curso
  WHERE cu.anyo_inicio = 2018 AND cu.anyo_fin = 2019;
  
  nombre, apellido1, apellido2
  ```

  #### Consultas multitabla (Composición externa)

  Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN. 

    1. Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. El listado también debe mostrar
       aquellos profesores que no tienen ningún departamento asociado. El listado
       debe devolver cuatro columnas, nombre del departamento, primer apellido,
       segundo apellido y nombre del profesor. El resultado estará ordenado
       alfabéticamente de menor a mayor por el nombre del departamento,
       apellidos y el nombre.

```sql
SELECT d.nombre_dpto, p.apellido1, p.apellido2, p.nombre_profesor
FROM profesor AS p
LEFT JOIN departamento AS d ON p.id_dpto = d.id_dpto
ORDER BY d.nombre_dpto, p.apellido1, p.apellido2, p.nombre_profesor;

# nombre_dpto	apellido1	apellido2	nombre_profesor
Agronomía	Monahan	Murray	Micaela
Economía y Empresa	Fahey	Considine	Antonio
Economía y Empresa	Lemke	Rutherford	Cristina
Educación	Ruecker	Upton	Guillermo
Educación	Spencer	Lakin	Esther
Educación	Streich	Hirthe	Carmen
Informática	Guerrero	Martínez	Juan
Informática	Hamill	Kozey	Manolo
Informática	Ramirez	Gea	Zoe
Informática	Sánchez	Ruiz	Pepe
Matemáticas	Domínguez	Hernández	María
Matemáticas	Kohler	Schoen	Alejandro
Matemáticas	Schmidt	Fisher	David
Química y Física	Schowalter	Muller	Francesca
Química y Física	Stiedemann	Morissette	Alfredo
```

  2. Devuelve un listado con los profesores que no están asociados a un departamento.

```sql
SELECT p.apellido1, p.apellido2, p.nombre_profesor
FROM profesor AS p
LEFT JOIN departamento AS d ON p.id_dpto = d.id_dpto
WHERE p.id_dpto IS NULL;

apellido1, apellido2, nombre_profesor

```

  3. Devuelve un listado con los departamentos que no tienen profesores asociados.

```sql
SELECT DISTINCT d.nombre_dpto
FROM departamento d
LEFT JOIN profesor p ON d.id_dpto = p.id_dpto
WHERE p.id_profesor IS NULL;

# nombre_dpto
Filología
Derecho
Biología y Geología
```

  4. Devuelve un listado con los profesores que no imparten ninguna asignatura.

```sql
SELECT p.apellido1, p.apellido2, p.nombre_profesor
FROM profesor AS p
LEFT JOIN asignatura AS a ON  p.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL;

apellido1, apellido2, nombre_profesor
```

  5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.

```sql
SELECT a.nombre_asignatura
FROM asignatura AS a
LEFT JOIN profesor AS p ON a.id_profesor = p.id_profesor
WHERE p.id_profesor IS NULL;

# nombre_asignatura
Herramientas y Métodos de Ingeniería del Software
Informática industrial y robótica
Ingeniería de Sistemas de Información
Modelado y Diseño del Software 2
Negocio Electrónico
Periféricos e interfaces
Sistemas de tiempo real
Tecnologías de acceso a red
Tratamiento digital de imágenes
Administración de redes y sistemas operativos
Almacenes de Datos
Fiabilidad y Gestión de Riesgos
Líneas de Productos Software
Procesos de Ingeniería del Software 1
Tecnologías multimedia
Análisis y planificación de las TI
Desarrollo Rápido de Aplicaciones
Gestión de la Calidad y de la Innovación Tecnológica
Inteligencia del Negocio
Procesos de Ingeniería del Software 2
Seguridad Informática
Biologia celular
Física
Matemáticas I
Química general
Química orgánica
Biología vegetal y animal
Bioquímica
Genética
Matemáticas II
Microbiología
Botánica agrícola
Fisiología vegetal
Genética molecular
Ingeniería bioquímica
Termodinámica y cinética química aplicada
Biorreactores
Biotecnología microbiana
Ingeniería genética
Inmunología
Virología
Bases moleculares del desarrollo vegetal
Fisiología animal
Metabolismo y biosíntesis de biomoléculas
Operaciones de separación
Patología molecular de plantas
Técnicas instrumentales básicas
Bioinformática
Biotecnología de los productos hortofrutículas
Biotecnología vegetal
Genómica y proteómica
Procesos biotecnológicos
Técnicas instrumentales avanzadas
```

    6. Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. El resultado
       debe mostrar el nombre del departamento y el nombre de la asignatura que
       no se haya impartido nunca.

```sql
SELECT d.nombre_dpto, a.nombre_asignatura
FROM departamento AS d
LEFT JOIN profesor AS p ON d.id_dpto = p.id_dpto
LEFT JOIN asignatura AS a ON p.id_profesor = a.id_profesor
LEFT JOIN matricula_alumno_asignatura AS ma ON a.id_asignatura = ma.id_asignatura
WHERE ma.id_asignatura IS NULL;

# nombre_dpto	nombre_asignatura
Informática	Bases de Datos
Informática	Ingeniería de Requisitos
Informática	Ingeniería del Software
Informática	Tecnologías web
Informática	Sistemas Inteligentes
Informática	Teoría de códigos y criptografía
Matemáticas	Estructura de Datos y Algoritmos II
Matemáticas	Integración de las Tecnologías de la Información en las Organizaciones
Matemáticas	Sistemas Operativos
Matemáticas	Administración de bases de datos
Economía y Empresa	Fundamentos de Redes de Computadores
Economía y Empresa	Modelado y Diseño del Software 1
Educación	Planificación y Gestión de Proyectos Informáticos
Educación	Programación de Servicios Software
Educación	Multiprocesadores
Agronomía	Arquitectura de Computadores
Agronomía	Seguridad y cumplimiento normativo
Química y Física	Desarrollo de interfaces de usuario
Química y Física	Estructura de Datos y Algoritmos I
Química y Física	Sistema de Información para las Organizaciones

```


​    

#### Consultas resumen

1. Devuelve el número total de alumnas que hay.

   ```sql
   SELECT COUNT(id_alumno)
   FROM alumno
   WHERE id_tipo_sexo = 2;
   
   # COUNT(id_alumno)
   3
   ```

2. Calcula cuántos alumnos nacieron en 1999.

   ```sql
   SELECT COUNT(id_alumno)
   FROM alumno
   WHERE YEAR(fecha_nacimiento) = 1999;
   
   # COUNT(id_alumno)
   2
   ```

3. Calcula cuántos profesores hay en cada departamento. El resultado sólo
   debe mostrar dos columnas, una con el nombre del departamento y otra
   con el número de profesores que hay en ese departamento. El resultado
   sólo debe incluir los departamentos que tienen profesores asociados y
   deberá estar ordenado de mayor a menor por el número de profesores.

   ```sql
   SELECT d.nombre_dpto, COUNT(p.id_profesor) AS num_profesores
   FROM departamento d
   LEFT JOIN profesor p ON d.id_dpto = p.id_dpto
   GROUP BY d.nombre_dpto
   ORDER BY num_profesores DESC;
   
   # nombre_dpto	num_profesores
   Informática	4
   Matemáticas	3
   Educación	3
   Economía y Empresa	2
   Química y Física	2
   Agronomía	1
   Filología	0
   Derecho	0
   Biología y Geología	0
   ```
   
4. Devuelve un listado con todos los departamentos y el número de profesores
   que hay en cada uno de ellos. Tenga en cuenta que pueden existir
   departamentos que no tienen profesores asociados. Estos departamentos
   también tienen que aparecer en el listado.

   ```sql
   SELECT d.nombre_dpto, COUNT(p.id_profesor) AS num_profesores
   FROM departamento d
   LEFT JOIN profesor p ON d.id_dpto = p.id_dpto
   GROUP BY d.nombre_dpto;
   
   # nombre_dpto	num_profesores
   Informática	4
   Matemáticas	3
   Economía y Empresa	2
   Educación	3
   Agronomía	1
   Química y Física	2
   Filología	0
   Derecho	0
   Biología y Geología	0
   ```
   
5. Devuelve un listado con el nombre de todos los grados existentes en la base
   de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta

   que pueden existir grados que no tienen asignaturas asociadas. Estos grados
   también tienen que aparecer en el listado. El resultado deberá estar
   ordenado de mayor a menor por el número de asignaturas.

   ```sql
   SELECT g.nombre_grado, COUNT(a.id_asignatura) AS num_asignaturas
   FROM grado g
   LEFT JOIN asignatura a ON g.id_grado = a.id_grado
   GROUP BY g.nombre_grado
   ORDER BY num_asignaturas DESC;
   
   # nombre_grado	num_asignaturas
   Grado en Ingeniería Informática (Plan 2015)	83
   Grado en Ingeniería Agrícola (Plan 2015)	0
   Grado en Ingeniería Eléctrica (Plan 2014)	0
   Grado en Ingeniería Electrónica Industrial (Plan 2010)	0
   Grado en Ingeniería Mecánica (Plan 2010)	0
   Grado en Ingeniería Química Industrial (Plan 2010)	0
   Grado en Biotecnología (Plan 2015)	0
   Grado en Ciencias Ambientales (Plan 2009)	0
   Grado en Matemáticas (Plan 2010)	0
   Grado en Química (Plan 2009)	0
   ```
   
6. Devuelve un listado con el nombre de todos los grados existentes en la base
   de datos y el número de asignaturas que tiene cada uno, de los grados que
   tengan más de 40 asignaturas asociadas.

   ```sql
   SELECT g.nombre_grado, COUNT(a.id_asignatura) AS num_asignaturas
   FROM grado g
   LEFT JOIN asignatura a ON g.id_grado = a.id_grado
   GROUP BY g.nombre_grado
   HAVING num_asignaturas > 40;
   
   # nombre_grado	num_asignaturas
   Grado en Ingeniería Informática (Plan 2015)	83
   ```
   
7. Devuelve un listado que muestre el nombre de los grados y la suma del
   número total de créditos que hay para cada tipo de asignatura. El resultado
   debe tener tres columnas: nombre del grado, tipo de asignatura y la suma
   de los créditos de todas las asignaturas que hay de ese tipo. Ordene el
   resultado de mayor a menor por el número total de crédidos.

   ```sql
   SELECT g.nombre_grado, ta.nombre_tipo_asignatura, SUM(a.creditos) AS total_creditos
   FROM grado g
   LEFT JOIN asignatura a ON g.id_grado = a.id_grado
   LEFT JOIN tipo_asignatura ta ON a.id_tipo_asignatura = ta.id_tipo_asignatura
   GROUP BY g.nombre_grado, a.id_tipo_asignatura
   ORDER BY total_creditos DESC;
   
   # nombre_grado	nombre_tipo_asignatura	total_creditos
   Grado en Ingeniería Informática (Plan 2015)	obligatoria	168
   Grado en Ingeniería Informática (Plan 2015)	básica	168
   Grado en Ingeniería Informática (Plan 2015)	optativa	162
   Grado en Ingeniería Agrícola (Plan 2015)		
   Grado en Ingeniería Eléctrica (Plan 2014)		
   Grado en Ingeniería Electrónica Industrial (Plan 2010)		
   Grado en Ingeniería Mecánica (Plan 2010)		
   Grado en Ingeniería Química Industrial (Plan 2010)		
   Grado en Biotecnología (Plan 2015)		
   Grado en Ciencias Ambientales (Plan 2009)		
   Grado en Matemáticas (Plan 2010)		
   Grado en Química (Plan 2009)		
   ```
   
8. Devuelve un listado que muestre cuántos alumnos se han matriculado de
   alguna asignatura en cada uno de los cursos escolares. El resultado deberá
   mostrar dos columnas, una columna con el año de inicio del curso escolar y
   otra con el número de alumnos matriculados.

   ```sql
   SELECT c.anyo_inicio AS ano_inicio_curso, COUNT(ma.id_alumno) AS num_alumnos_matriculados
   FROM curso AS c
   LEFT JOIN matricula_alumno_asignatura ma ON c.id_curso = ma.id_curso
   GROUP BY c.anyo_inicio;
   
   # ano_inicio_curso	num_alumnos_matriculados
   2014	16
   2015	13
   2016	3
   2017	3
   ```
   
9. Devuelve un listado con el número de asignaturas que imparte cada
   profesor. El listado debe tener en cuenta aquellos profesores que no
   imparten ninguna asignatura. El resultado mostrará cinco columnas: id,
   nombre, primer apellido, segundo apellido y número de asignaturas. El
   resultado estará ordenado de mayor a menor por el número de asignaturas.

   ```sql
   SELECT p.id_profesor, p.nombre_profesor, p.apellido1, p.apellido2, COUNT(a.id_asignatura) AS num_asignaturas_impartidas
   FROM profesor p
   LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
   GROUP BY p.id_profesor, p.nombre_profesor, p.apellido1, p.apellido2
   ORDER BY num_asignaturas_impartidas DESC;
   
   # id_profesor	nombre_profesor	apellido1	apellido2	num_asignaturas_impartidas
   1	Zoe	Ramirez	Gea	2
   2	David	Schmidt	Fisher	2
   3	Cristina	Lemke	Rutherford	2
   4	Esther	Spencer	Lakin	2
   5	Carmen	Streich	Hirthe	2
   6	Alfredo	Stiedemann	Morissette	2
   7	Manolo	Hamill	Kozey	2
   8	Alejandro	Kohler	Schoen	2
   9	Antonio	Fahey	Considine	2
   10	Guillermo	Ruecker	Upton	2
   11	Micaela	Monahan	Murray	2
   12	Francesca	Schowalter	Muller	2
   13	Pepe	Sánchez	Ruiz	2
   14	Juan	Guerrero	Martínez	2
   15	María	Domínguez	Hernández	2
   ```

#### Subconsultas

1. Devuelve todos los datos del alumno más joven.

   ```sql
   SELECT id_alumno, NIF, nombre, apellido1, apellido2, id_ciudad, fecha_nacimiento, id_tipo_sexo
   FROM alumno
   WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM alumno);
   
   # id_alumno	NIF	nombre	apellido1	apellido2	id_ciudad	fecha_nacimiento	id_tipo_sexo
   3	17105885A	Pedro	Heller	Pagac	1	2000-10-05	1
   ```

2. Devuelve un listado con los profesores que no están asociados a un
   departamento.

   ```sql
   SELECT nombre_profesor
   FROM profesor
   WHERE id_dpto IS NULL;
   
   nombre_profesor
   ```
   
3. Devuelve un listado con los departamentos que no tienen profesores
   asociados.

   ```sql
   SELECT id_dpto, nombre_dpto
   FROM departamento
   WHERE id_dpto NOT IN (SELECT id_dpto FROM profesor);
   
   # id_dpto	nombre_dpto
   7	Filología
   8	Derecho
   9	Biología y Geología
   ```
   
4. Devuelve un listado con los profesores que tienen un departamento
   asociado y que no imparten ninguna asignatura.

   ```sql
   SELECT nombre_profesor
   FROM profesor
   WHERE id_dpto IS NOT NULL
   AND id_profesor NOT IN (SELECT id_profesor FROM asignatura);
   
   nombre_profesor
   ```
   
5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.

   ```sql
   SELECT id_asignatura, nombre_asignatura
   FROM asignatura
   WHERE id_profesor IS NULL;
   
   # id_asignatura	nombre_asignatura
   31	Herramientas y Métodos de Ingeniería del Software
   32	Informática industrial y robótica
   33	Ingeniería de Sistemas de Información
   34	Modelado y Diseño del Software 2
   35	Negocio Electrónico
   36	Periféricos e interfaces
   37	Sistemas de tiempo real
   38	Tecnologías de acceso a red
   39	Tratamiento digital de imágenes
   40	Administración de redes y sistemas operativos
   41	Almacenes de Datos
   42	Fiabilidad y Gestión de Riesgos
   43	Líneas de Productos Software
   44	Procesos de Ingeniería del Software 1
   45	Tecnologías multimedia
   46	Análisis y planificación de las TI
   47	Desarrollo Rápido de Aplicaciones
   48	Gestión de la Calidad y de la Innovación Tecnológica
   49	Inteligencia del Negocio
   50	Procesos de Ingeniería del Software 2
   51	Seguridad Informática
   52	Biologia celular
   53	Física
   54	Matemáticas I
   55	Química general
   56	Química orgánica
   57	Biología vegetal y animal
   58	Bioquímica
   59	Genética
   60	Matemáticas II
   61	Microbiología
   62	Botánica agrícola
   63	Fisiología vegetal
   64	Genética molecular
   65	Ingeniería bioquímica
   66	Termodinámica y cinética química aplicada
   67	Biorreactores
   68	Biotecnología microbiana
   69	Ingeniería genética
   70	Inmunología
   71	Virología
   72	Bases moleculares del desarrollo vegetal
   73	Fisiología animal
   74	Metabolismo y biosíntesis de biomoléculas
   75	Operaciones de separación
   76	Patología molecular de plantas
   77	Técnicas instrumentales básicas
   78	Bioinformática
   79	Biotecnología de los productos hortofrutículas
   80	Biotecnología vegetal
   81	Genómica y proteómica
   82	Procesos biotecnológicos
   83	Técnicas instrumentales avanzadas
   ```

6. Devuelve un listado con todos los departamentos que no han impartido
   asignaturas en ningún curso escolar.

   ```sql
   SELECT nombre_dpto
   FROM departamento
   WHERE id_dpto IN (
       SELECT id_dpto
       FROM profesor
       WHERE id_profesor IN (
           SELECT id_profesor
           FROM asignatura
           WHERE id_asignatura NOT IN (
           SELECT id_asignatura
           FROM matricula_alumno_asignatura
       )
       )
   );
   
   # nombre_dpto
   Informática
   Matemáticas
   Economía y Empresa
   Educación
   Agronomía
   Química y Física
   ```
   
   
