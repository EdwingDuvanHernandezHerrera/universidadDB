# Proyecto Bases de Datos

## Universidad DB

### 1. Normalización de la base de datos

![modelo universidad_db](C:\Users\edwin\Downloads\modelo universidad_db.png)

### 2. Creación de la base de datos

```sql

-- -----------------------------------------------------
-- Schema universidad_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `universidad_db` DEFAULT CHARACTER SET utf8 ;
USE `universidad_db` ;

-- -----------------------------------------------------
-- Table `universidad_db`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`departamento` (
  `id_dpto` INT NOT NULL AUTO_INCREMENT,
  `nombre_dpto` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_dpto`))

-- -----------------------------------------------------
-- Table `universidad_db`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`ciudad` (
  `id_ciudad` INT NOT NULL AUTO_INCREMENT,
  `nombre_ciudad` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_ciudad`))


CREATE TABLE `direccion_alumno` (
  `id_direccion` int NOT NULL AUTO_INCREMENT,
  `barrio` varchar(45) DEFAULT NULL,
  `calle` int DEFAULT NULL,
  `carrera` int DEFAULT NULL,
  `id_ciudad` int NOT NULL,
  `id_alumno` int NOT NULL,
  PRIMARY KEY (`id_direccion`),
  KEY `fk_alumno_dir_idx` (`id_alumno`),
  KEY `fk_ciudad_diralumno_idx` (`id_ciudad`),
  CONSTRAINT `fk_alumno_dir` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`),
  CONSTRAINT `fk_ciudad_diralumno` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;


CREATE TABLE `direccion_profesor` (
  `id_direccion` int NOT NULL AUTO_INCREMENT,
  `barrio` varchar(45) DEFAULT NULL,
  `calle` int DEFAULT NULL,
  `carrera` int DEFAULT NULL,
  `id_ciudad` int NOT NULL,
  `id_profesor` int NOT NULL,
  PRIMARY KEY (`id_direccion`),
  KEY `fk_profesor_dir_idx` (`id_profesor`),
  KEY `fk_ciudad_dirprofe_idx` (`id_ciudad`),
  CONSTRAINT `fk_ciudad_dirprofe` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`),
  CONSTRAINT `fk_profesor_dir` FOREIGN KEY (`id_profesor`) REFERENCES `profesor` (`id_profesor`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;


-- -----------------------------------------------------
-- Table `universidad_db`.`tipo_telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`tipo_telefono` (
  `id_tipo_tel` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_tel` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_tipo_tel`))


-- -----------------------------------------------------
-- Table `universidad_db`.`tipo_sexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`tipo_sexo` (
  `id_tipo_sexo` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_sexo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_tipo_sexo`))


-- -----------------------------------------------------
-- Table `universidad_db`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`alumno` (
  `id_alumno` INT NOT NULL AUTO_INCREMENT,
  `nif` VARCHAR(9) NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  `apellido1` VARCHAR(50) NOT NULL,
  `apellido2` VARCHAR(50) NULL,
  `id_ciudad` INT NOT NULL,
  `id_direccion` INT NULL,
  `fecha_nacimiento` DATE NULL,
  `id_tipo_sexo` INT NOT NULL,
  PRIMARY KEY (`id_alumno`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_ciudad_alumno_idx` (`id_ciudad` ASC) VISIBLE,
  INDEX `fk_dir_alumno_idx` (`id_direccion` ASC) VISIBLE,
  INDEX `fk_tiposexo_alumno_idx` (`id_tipo_sexo` ASC) VISIBLE,
  CONSTRAINT `fk_ciudad_alumno`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `universidad_db`.`ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dir_alumno`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `universidad_db`.`direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tiposexo_alumno`
    FOREIGN KEY (`id_tipo_sexo`)
    REFERENCES `universidad_db`.`tipo_sexo` (`id_tipo_sexo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

-- -----------------------------------------------------
-- Table `universidad_db`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`profesor` (
  `id_profesor` INT NOT NULL AUTO_INCREMENT,
  `nif` VARCHAR(9) NOT NULL,
  `nombre_profesor` VARCHAR(25) NOT NULL,
  `apellido1` VARCHAR(50) NOT NULL,
  `apellido2` VARCHAR(50) NULL,
  `id_ciudad` INT NOT NULL,
  `id_direccion` INT NULL,
  `fecha_nacimiento` DATE NULL,
  `id_tipo_sexo` INT NOT NULL,
  `id_dpto` INT NULL,
  PRIMARY KEY (`id_profesor`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_ciudad_profe_idx` (`id_ciudad` ASC) VISIBLE,
  INDEX `fk_dir_profe_idx` (`id_direccion` ASC) VISIBLE,
  INDEX `id_tiposex_profe_idx` (`id_tipo_sexo` ASC) VISIBLE,
  INDEX `id_dpto_profe_idx` (`id_dpto` ASC) VISIBLE,
  CONSTRAINT `fk_ciudad_profe`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `universidad_db`.`ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dir_profe`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `universidad_db`.`direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_tiposex_profe`
    FOREIGN KEY (`id_tipo_sexo`)
    REFERENCES `universidad_db`.`tipo_sexo` (`id_tipo_sexo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_dpto_profe`
    FOREIGN KEY (`id_dpto`)
    REFERENCES `universidad_db`.`departamento` (`id_dpto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

-- -----------------------------------------------------
-- Table `universidad_db`.`grado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`grado` (
  `id_grado` INT NOT NULL AUTO_INCREMENT,
  `nombre_grado` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_grado`))


-- -----------------------------------------------------
-- Table `universidad_db`.`tipo_asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`tipo_asignatura` (
  `id_tipo_asignatura` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_asignatura` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_tipo_asignatura`))


-- -----------------------------------------------------
-- Table `universidad_db`.`asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`asignatura` (
  `id_asignatura` INT NOT NULL,
  `nombre_asignatura` VARCHAR(100) NOT NULL,
  `creditos` FLOAT NOT NULL,
  `id_tipo_asignatura` INT NOT NULL AUTO_INCREMENT,
  `cuatrimestre` TINYINT(3) NULL,
  `id_profesor` INT NULL,
  `id_grado` INT NULL,
  PRIMARY KEY (`id_asignatura`),
  INDEX `fk_tipo_asignatura_idx` (`id_tipo_asignatura` ASC) VISIBLE,
  INDEX `fk_profe_asignatura_idx` (`id_profesor` ASC) VISIBLE,
  INDEX `fk_grado_asign_idx` (`id_grado` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_asignatura`
    FOREIGN KEY (`id_tipo_asignatura`)
    REFERENCES `universidad_db`.`tipo_asignatura` (`id_tipo_asignatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profe_asignatura`
    FOREIGN KEY (`id_profesor`)
    REFERENCES `universidad_db`.`profesor` (`id_profesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grado_asign`
    FOREIGN KEY (`id_grado`)
    REFERENCES `universidad_db`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `universidad_db`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`curso` (
  `id_curso` INT NOT NULL AUTO_INCREMENT,
  `anyo_inicio` YEAR(4) NULL,
  `anyo_fin` YEAR(4) NULL,
  PRIMARY KEY (`id_curso`))



-- -----------------------------------------------------
-- Table `universidad_db`.`matricula_alumno_asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`matricula_alumno_asignatura` (
  `id_alumno` INT NOT NULL,
  `id_asignatura` INT NOT NULL,
  `id_curso` INT NOT NULL,
  PRIMARY KEY (`id_alumno`, `id_asignatura`, `id_curso`),
  INDEX `fk_asignatura_matricula_idx` (`id_asignatura` ASC) VISIBLE,
  INDEX `fk_curso_matricula_idx` (`id_curso` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_matricula`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `universidad_db`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asignatura_matricula`
    FOREIGN KEY (`id_asignatura`)
    REFERENCES `universidad_db`.`asignatura` (`id_asignatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_matricula`
    FOREIGN KEY (`id_curso`)
    REFERENCES `universidad_db`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


CREATE TABLE `telefono_alumno` (
  `id_telefono` int NOT NULL AUTO_INCREMENT,
  `numero_tel` varchar(15) DEFAULT NULL,
  `id_tipo_tel` int NOT NULL,
  `id_alumno` int NOT NULL,
  PRIMARY KEY (`id_telefono`),
  KEY `fk_tipo_telalumno_idx` (`id_alumno`),
  KEY `fk_tipo_telalumno_idx1` (`id_tipo_tel`),
  CONSTRAINT `fk_alumno_tel` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`),
  CONSTRAINT `fk_tipo_telalumno` FOREIGN KEY (`id_tipo_tel`) REFERENCES `tipo_telefono` (`id_tipo_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


CREATE TABLE `telefono_profesor` (
  `id_telefono` int NOT NULL AUTO_INCREMENT,
  `numero_tel` varchar(15) DEFAULT NULL,
  `id_tipo_tel` int NOT NULL,
  `id_profesor` int NOT NULL,
  PRIMARY KEY (`id_telefono`),
  KEY `fk_tipo_telprofe_idx` (`id_tipo_tel`),
  KEY `fk_profe_tel_idx` (`id_profesor`),
  CONSTRAINT `fk_profe_tel` FOREIGN KEY (`id_profesor`) REFERENCES `profesor` (`id_profesor`),
  CONSTRAINT `fk_tipo_telprofe` FOREIGN KEY (`id_tipo_tel`) REFERENCES `tipo_telefono` (`id_tipo_tel`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

```







### 3. Población de la base de datos

#### Tabla grado:

```sql
INSERT INTO grado VALUES (1, 'Grado en Ingeniería Agrícola (Plan 2015)');
INSERT INTO grado VALUES (2, 'Grado en Ingeniería Eléctrica (Plan 2014)');
INSERT INTO grado VALUES (3, 'Grado en Ingeniería Electrónica Industrial (Plan 2010)');
INSERT INTO grado VALUES (4, 'Grado en Ingeniería Informática (Plan 2015)');
INSERT INTO grado VALUES (5, 'Grado en Ingeniería Mecánica (Plan 2010)');
INSERT INTO grado VALUES (6, 'Grado en Ingeniería Química Industrial (Plan 2010)');
INSERT INTO grado VALUES (7, 'Grado en Biotecnología (Plan 2015)');
INSERT INTO grado VALUES (8, 'Grado en Ciencias Ambientales (Plan 2009)');
INSERT INTO grado VALUES (9, 'Grado en Matemáticas (Plan 2010)');
INSERT INTO grado VALUES (10, 'Grado en Química (Plan 2009)');
```

#### Tabla Curso

```sql
INSERT INTO curso VALUES (1, 2014, 2015);
INSERT INTO curso VALUES (2, 2015, 2016);
INSERT INTO curso VALUES (3, 2016, 2017);
INSERT INTO curso VALUES (4, 2017, 2018);
```

#### Tabla Departamento

```sql
INSERT INTO departamento VALUES (1, 'Informática');
INSERT INTO departamento VALUES (2, 'Matemáticas');
INSERT INTO departamento VALUES (3, 'Economía y Empresa');
INSERT INTO departamento VALUES (4, 'Educación');
INSERT INTO departamento VALUES (5, 'Agronomía');
INSERT INTO departamento VALUES (6, 'Química y Física');
INSERT INTO departamento VALUES (7, 'Filología');
INSERT INTO departamento VALUES (8, 'Derecho');
INSERT INTO departamento VALUES (9, 'Biología y Geología');
```

#### Tabla Ciudad

```sql
INSERT INTO ciudad VALUES (1, "Almería")
```

#### Tablas Dirección

```sql
INSERT INTO direccion_alumno (barrio, calle, carrera, id_ciudad, id_alumno) VALUES
('Mercurio', 123, 456, 1, 1),
('Real del barrio alto', 234, 567, 1, 2),
('Estrella fugaz', 345, 678, 1, 3),
('Júpiter', 456, 789, 1, 4),
('Neptuno', 567, 890, 1, 5),
('Urano', 678, 901, 1, 6),
('Andarax', 789, 123, 1, 7),
('Picos de Europa', 890, 234, 1, 8),
('Los pinos', 901, 345, 1, 9),
('Cabo de Gata', 112, 456, 1, 10),
('Zapillo', 223, 567, 1, 11),
('Marte', 334, 678, 1, 12);

INSERT INTO direccion_profesor (barrio, calle, carrera, id_ciudad, id_profesor) VALUES
('Saturno', 556, 890, 1, 1),
('Plutón', 667, 901, 1, 2),
('Almanzora', 778, 123, 1, 3),
('Guadalquivir', 889, 234, 1, 4),
('Duero', 900, 345, 1, 5),
('Tajo', 111, 456, 1, 6),
('Sierra de los Filabres', 222, 567, 1, 7),
('Sierra de Gádor', 333, 678, 1, 8),
('Veleta', 444, 789, 1, 9),
('Quinto pino', 555, 890, 1, 10),
('Almanzora', 778, 123, 1, 11),
('Guadalquivir', 889, 234, 1, 12),
('Duero', 900, 345, 1, 13),
('Tajo', 111, 456, 1, 14),
('Sierra de los Filabres', 222, 567, 1, 15);
```

#### Tabla Tipo_Sexo

```sql
INSERT INTO tipo_sexo (nombre_tipo_sexo) VALUES
('H'),
('M'); 
```

#### Tabla Profesor

```sql
INSERT INTO profesor (nif, nombre_profesor, apellido1, apellido2, fecha_nacimiento, id_tipo_sexo, id_ciudad, id_direccion, id_dpto) VALUES
('11105554G', 'Zoe', 'Ramirez', 'Gea', '1979-08-19', 2, 1, 1, 1),
('38223286T', 'David', 'Schmidt', 'Fisher', '1978-01-19', 1, 1, 2, 2),
('79503962T', 'Cristina', 'Lemke', 'Rutherford', '1977-08-21', 2, 1, 3, 3),
('61142000L', 'Esther', 'Spencer', 'Lakin', '1977-05-19', 2, 1, 4, 4),
('85366986W', 'Carmen', 'Streich', 'Hirthe', '1971-04-29', 2, 1, 5, 4),
('73571384L', 'Alfredo', 'Stiedemann', 'Morissette', '1980-02-01', 1, 1, 6, 6),
('82937751G', 'Manolo', 'Hamill', 'Kozey', '1977-01-02', 1, 1, 7, 1),
('80502866Z', 'Alejandro', 'Kohler', 'Schoen', '1980-03-14', 1, 1, 8, 2),
('10485008K', 'Antonio', 'Fahey', 'Considine', '1982-03-18', 1, 1, 9, 3),
('85869555K', 'Guillermo', 'Ruecker', 'Upton', '1973-05-05', 1, 1, 10, 4),
('04326833G', 'Micaela', 'Monahan', 'Murray', '1976-02-25', 1, 1, 11, 5),
('79221403L', 'Francesca', 'Schowalter', 'Muller', '1980-10-31', 1, 1, 12, 6),
('13175769N', 'Pepe', 'Sánchez', 'Ruiz', '1980-10-16', 1, 1, 13, 1),
('98816696W', 'Juan', 'Guerrero', 'Martínez', '1980-11-21', 1, 1, 14, 1),
('77194445M', 'María', 'Domínguez', 'Hernández', '1980-12-13', 2, 1, 15, 2);

```

#### Tabla Alumno

```sql
INSERT INTO alumno (nif, nombre, apellido1, apellido2, id_ciudad, id_direccion, fecha_nacimiento, id_tipo_sexo) VALUES
('89542419S', 'Juan', 'Saez', 'Vega', 1, 1, '1992-08-08', 1),
('26902806M', 'Salvador', 'Sánchez', 'Pérez', 1, 2, '1991-03-28', 1),
('17105885A', 'Pedro', 'Heller', 'Pagac', 1, 3, '2000-10-05', 1),
('04233869Y', 'José', 'Koss', 'Bayer', 1, 4, '1998-01-28', 1),
('97258166K', 'Ismael', 'Strosin', 'Turcotte', 1, 5, '1999-05-24', 1),
('82842571K', 'Ramón', 'Herzog', 'Tremblay', 1, 6, '1996-11-21', 1),
('46900725E', 'Daniel', 'Herman', 'Pacocha', 1, 7, '1997-04-26', 1),
('11578526G', 'Inma', 'Lakin', 'Yundt', 1, 8, '1998-09-01', 2),
('79089577Y', 'Juan', 'Gutiérrez', 'López', 1, 9, '1998-01-01', 1),
('41491230N', 'Antonio', 'Domínguez', 'Guerrero', 1, 10, '1999-02-11', 1),
('64753215G', 'Irene', 'Hernández', 'Martínez', 1, 11, '1996-03-12', 2),
('85135690V', 'Sonia', 'Gea', 'Ruiz', 1, 12, '1995-04-13', 2);
```

#### Tabla Tipo_telefono

```sql
INSERT INTO tipo_telefono (nombre_tipo_tel) VALUES
('celular'),
('fijo');
```

#### Tabla Telefono_profesor

```sql
INSERT INTO telefono_profesor (numero_tel, id_tipo_tel, id_profesor) VALUES
('618223876', 1, 1),
('678516294', 2, 2),
('669162534', 1, 3),
(NULL, 2, 4),
(NULL, 1, 5),
('950896725', 2, 6),
('950263514', 1, 7),
('668726354', 2, 8),
(NULL, 1, 9),
(NULL, 2, 10),
('662765413', 1, 11),
(NULL, 2, 12),
(NULL, 1, 13),
(NULL, 2, 14),
(NULL, 1, 15);
```

#### Tabla Telefono_alumno

```sql
INSERT INTO telefono_alumno (numero_tel, id_tipo_tel, id_alumno) VALUES
('618253876', 1, 1),
('950254837', 2, 2),
(NULL, 1, 3),
('628349590', 2, 4),
(NULL, 1, 5),
('626351429', 2, 6),
('679837625', 1, 7),
('678652431', 2, 8),
('678652431', 1, 9),
('626652498', 2, 10),
('628452384', 1, 11),
('678812017', 2, 12);
```

#### Tabla Tipo_asignatura

```sql
INSERT INTO tipo_asignatura (nombre_tipo_asignatura) VALUES
('básica'),
('obligatoria'),
('optativa');
```

#### Tabla Asignatura

```sql
INSERT INTO asignatura (id_asignatura, nombre_asignatura, creditos, id_tipo_asignatura, cuatrimestre, id_profesor, id_grado) VALUES
(1, 'Álgebra lineal y matemática discreta', 6, 1, 1, 1, 4),
(2, 'Cálculo', 6, 2, 1, 2, 4),
(3, 'Física para informática', 6, 3, 1, 3, 4),
(4, 'Introducción a la programación', 6, 1, 1, 4, 4),
(5, 'Organización y gestión de empresas', 6, 2, 1, 5, 4),
(6, 'Estadística', 6, 3, 1, 6, 4),
(7, 'Estructura y tecnología de computadores', 6, 1, 1, 7, 4),
(8, 'Fundamentos de electrónica', 6, 2, 1, 8, 4),
(9, 'Lógica y algorítmica', 6, 3, 1, 9, 4),
(10, 'Metodología de la programación', 6, 1, 1, 10, 4),
(11, 'Arquitectura de Computadores', 6, 2, 1, 11, 4),
(12, 'Estructura de Datos y Algoritmos I', 6, 3, 1, 12, 4),
(13, 'Ingeniería del Software', 6, 1, 1, 13, 4),
(14, 'Sistemas Inteligentes', 6, 2, 1, 14, 4),
(15, 'Sistemas Operativos', 6, 3, 1, 15, 4),
(16, 'Bases de Datos', 6, 1, 2, 1, 4),
(17, 'Estructura de Datos y Algoritmos II', 6, 2, 2, 2, 4),
(18, 'Fundamentos de Redes de Computadores', 6, 3, 2, 3, 4),
(19, 'Planificación y Gestión de Proyectos Informáticos', 6, 1, 2, 4, 4),
(20, 'Programación de Servicios Software', 6, 2, 2, 5, 4),
(21, 'Desarrollo de interfaces de usuario', 6, 3, 2, 6, 4),
(22, 'Ingeniería de Requisitos', 6, 1, 2, 7, 4),
(23, 'Integración de las Tecnologías de la Información en las Organizaciones', 6, 2, 2, 8, 4),
(24, 'Modelado y Diseño del Software 1', 6, 3, 2, 9, 4),
(25, 'Multiprocesadores', 6, 1, 2, 10, 4),
(26, 'Seguridad y cumplimiento normativo', 6, 2, 2, 11, 4),
(27, 'Sistema de Información para las Organizaciones', 6, 3, 2, 12, 4),
(28, 'Tecnologías web', 6, 1, 3, 13, 4),
(29, 'Teoría de códigos y criptografía', 6, 2, 3, 14, 4),
(30, 'Administración de bases de datos', 6, 3, 3, 15, 4),
(31, 'Herramientas y Métodos de Ingeniería del Software', 6, 1, 3, NULL, 4),
(32, 'Informática industrial y robótica', 6, 2, 3, NULL, 4),
(33, 'Ingeniería de Sistemas de Información', 6, 3, 3, NULL, 4),
(34, 'Modelado y Diseño del Software 2', 6, 1, 3, NULL, 4),
(35, 'Negocio Electrónico', 6, 2, 3, NULL, 4),
(36, 'Periféricos e interfaces', 6, 3, 3, NULL, 4),
(37, 'Sistemas de tiempo real', 6, 1, 4, NULL, 4),
(38, 'Tecnologías de acceso a red', 6, 2, 4, NULL, 4),
(39, 'Tratamiento digital de imágenes', 6, 3, 4, NULL, 4),
(40, 'Administración de redes y sistemas operativos', 6, 1, 4, NULL, 4),
(41, 'Almacenes de Datos', 6, 2, 4, NULL, 4),
(42, 'Fiabilidad y Gestión de Riesgos', 6, 3, 4, NULL, 4),
(43, 'Líneas de Productos Software', 6, 1, 4, NULL, 4),
(44, 'Procesos de Ingeniería del Software 1', 6, 2, 4, NULL, 4),
(45, 'Tecnologías multimedia', 6, 3, 4, NULL, 4),
(46, 'Análisis y planificación de las TI', 6, 1, 1, NULL, 4),
(47, 'Desarrollo Rápido de Aplicaciones', 6, 2, 1, NULL, 4),
(48, 'Gestión de la Calidad y de la Innovación Tecnológica', 6, 3, 1, NULL, 4),
(49, 'Inteligencia del Negocio', 6, 1, 1, NULL, 4),
(50, 'Procesos de Ingeniería del Software 2', 6, 2, 1, NULL, 4),
(51, 'Seguridad Informática', 6, 3, 1, NULL, 4),
(52, 'Biologia celular', 6, 1, 1, NULL, 4),
(53, 'Física', 6, 2, 1, NULL, 4),
(54, 'Matemáticas I', 6, 3, 1, NULL, 4),
(55, 'Química general', 6, 1, 1, NULL, 4),
(56, 'Química orgánica', 6, 2, 1, NULL, 4),
(57, 'Biología vegetal y animal', 6, 3, 1, NULL, 4),
(58, 'Bioquímica', 6, 1, 1, NULL, 4),
(59, 'Genética', 6, 2, 1, NULL, 4),
(60, 'Matemáticas II', 6, 3, 1, NULL, 4),
(61, 'Microbiología', 6, 1, 2, NULL, 4),
(62, 'Botánica agrícola', 6, 2, 2, NULL, 4),
(63, 'Fisiología vegetal', 6, 3, 2, NULL, 4),
(64, 'Genética molecular', 6, 1, 2, NULL, 4),
(65, 'Ingeniería bioquímica', 6, 2, 2, NULL, 4),
(66, 'Termodinámica y cinética química aplicada', 6, 3, 2, NULL, 4),
(67, 'Biorreactores', 6, 1, 2, NULL, 4),
(68, 'Biotecnología microbiana', 6, 2, 2, NULL, 4),
(69, 'Ingeniería genética', 6, 3, 2, NULL, 4),
(70, 'Inmunología', 6, 1, 2, NULL, 4),
(71, 'Virología', 6, 2, 2, NULL, 4),
(72, 'Bases moleculares del desarrollo vegetal', 6, 3, 2, NULL, 4),
(73, 'Fisiología animal', 6, 1, 3, NULL, 4),
(74, 'Metabolismo y biosíntesis de biomoléculas', 6, 2, 3, NULL, 4),
(75, 'Operaciones de separación', 6, 3, 3, NULL, 4),
(76, 'Patología molecular de plantas', 6, 1, 3, NULL, 4),
(77, 'Técnicas instrumentales básicas', 6, 2, 3, NULL, 4),
(78, 'Bioinformática', 6, 3, 3, NULL, 4),
(79, 'Biotecnología de los productos hortofrutículas', 6, 1, 3, NULL, 4),
(80, 'Biotecnología vegetal', 6, 2, 3, NULL, 4),
(81, 'Genómica y proteómica', 6, 3, 3, NULL, 4),
(82, 'Procesos biotecnológicos', 6, 1, 3, NULL, 4),
(83, 'Técnicas instrumentales avanzadas', 6, 2, 3, NULL, 4);
```

#### Tabla Matricula_alumno_asignatura

```sql
INSERT INTO matricula_alumno_asignatura (id_alumno, id_asignatura, id_curso) VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 1),
(1, 4, 1),
(1, 5, 1),
(1, 6, 1),
(1, 7, 1),
(1, 8, 1),
(1, 9, 1),
(1, 10, 1),
(1, 1, 2),
(1, 2, 2),
(1, 3, 2),
(1, 1, 3),
(1, 2, 3),
(1, 3, 3),
(1, 1, 4),
(1, 2, 4),
(1, 3, 4),
(2, 1, 1),
(2, 2, 1),
(2, 3, 1),
(4, 1, 1),
(4, 2, 1),
(4, 3, 1),
(4, 1, 2),
(4, 2, 2),
(4, 3, 2),
(4, 4, 2),
(4, 5, 2),
(4, 6, 2),
(4, 7, 2),
(4, 8, 2),
(4, 9, 2),
(4, 10, 2);
```

