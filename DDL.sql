-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema universidad_db
-- -----------------------------------------------------

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
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad_db`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`ciudad` (
  `id_ciudad` INT NOT NULL AUTO_INCREMENT,
  `nombre_ciudad` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_ciudad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad_db`.`tipo_telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`tipo_telefono` (
  `id_tipo_tel` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_tel` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_tipo_tel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad_db`.`tipo_sexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`tipo_sexo` (
  `id_tipo_sexo` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_sexo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_tipo_sexo`))
ENGINE = InnoDB;


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
  `fecha_nacimiento` DATE NULL,
  `id_tipo_sexo` INT NOT NULL,
  `id_dpto` INT NULL,
  PRIMARY KEY (`id_profesor`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_ciudad_profe_idx` (`id_ciudad` ASC) VISIBLE,
  INDEX `id_tiposex_profe_idx` (`id_tipo_sexo` ASC) VISIBLE,
  INDEX `id_dpto_profe_idx` (`id_dpto` ASC) VISIBLE,
  CONSTRAINT `fk_ciudad_profe`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `universidad_db`.`ciudad` (`id_ciudad`)
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
ENGINE = InnoDB;


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
  `fecha_nacimiento` DATE NULL,
  `id_tipo_sexo` INT NOT NULL,
  PRIMARY KEY (`id_alumno`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_ciudad_alumno_idx` (`id_ciudad` ASC) VISIBLE,
  INDEX `fk_tiposexo_alumno_idx` (`id_tipo_sexo` ASC) VISIBLE,
  CONSTRAINT `fk_ciudad_alumno`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `universidad_db`.`ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tiposexo_alumno`
    FOREIGN KEY (`id_tipo_sexo`)
    REFERENCES `universidad_db`.`tipo_sexo` (`id_tipo_sexo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad_db`.`grado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`grado` (
  `id_grado` INT NOT NULL AUTO_INCREMENT,
  `nombre_grado` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_grado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad_db`.`tipo_asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`tipo_asignatura` (
  `id_tipo_asignatura` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_asignatura` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_tipo_asignatura`))
ENGINE = InnoDB;


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
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad_db`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`curso` (
  `id_curso` INT NOT NULL AUTO_INCREMENT,
  `anyo_inicio` YEAR(4) NULL,
  `anyo_fin` YEAR(4) NULL,
  PRIMARY KEY (`id_curso`))
ENGINE = InnoDB;


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
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad_db`.`telefono_alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`telefono_alumno` (
  `id_telefono` INT NOT NULL AUTO_INCREMENT,
  `numero_tel` VARCHAR(15) NULL,
  `id_tipo_tel` INT NOT NULL,
  `id_alumno` INT NOT NULL,
  PRIMARY KEY (`id_telefono`),
  INDEX `fk_tipo_telalumno_idx` (`id_alumno` ASC) VISIBLE,
  INDEX `fk_tipo_telalumno_idx1` (`id_tipo_tel` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_tel`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `universidad_db`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_telalumno`
    FOREIGN KEY (`id_tipo_tel`)
    REFERENCES `universidad_db`.`tipo_telefono` (`id_tipo_tel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad_db`.`telefono_profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`telefono_profesor` (
  `id_telefono` INT NOT NULL AUTO_INCREMENT,
  `numero_tel` VARCHAR(15) NULL,
  `id_tipo_tel` INT NOT NULL,
  `id_profesor` INT NOT NULL,
  PRIMARY KEY (`id_telefono`),
  INDEX `fk_tipo_telprofe_idx` (`id_tipo_tel` ASC) VISIBLE,
  INDEX `fk_profe_tel_idx` (`id_profesor` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_telprofe`
    FOREIGN KEY (`id_tipo_tel`)
    REFERENCES `universidad_db`.`tipo_telefono` (`id_tipo_tel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profe_tel`
    FOREIGN KEY (`id_profesor`)
    REFERENCES `universidad_db`.`profesor` (`id_profesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad_db`.`direccion_profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`direccion_profesor` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `barrio` VARCHAR(45) NULL,
  `calle` INT NULL,
  `carrera` INT NULL,
  `id_ciudad` INT NOT NULL,
  `id_profesor` INT NOT NULL,
  PRIMARY KEY (`id_direccion`),
  INDEX `fk_profesor_dir_idx` (`id_profesor` ASC) VISIBLE,
  INDEX `fk_ciudad_dirprofe_idx` (`id_ciudad` ASC) VISIBLE,
  CONSTRAINT `fk_profesor_dir`
    FOREIGN KEY (`id_profesor`)
    REFERENCES `universidad_db`.`profesor` (`id_profesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ciudad_dirprofe`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `universidad_db`.`ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad_db`.`direccion_alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad_db`.`direccion_alumno` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `barrio` VARCHAR(45) NULL,
  `calle` INT NULL,
  `carrera` INT NULL,
  `id_ciudad` INT NOT NULL,
  `id_alumno` INT NOT NULL,
  PRIMARY KEY (`id_direccion`),
  INDEX `fk_alumno_dir_idx` (`id_alumno` ASC) VISIBLE,
  INDEX `fk_ciudad_diralumno_idx` (`id_ciudad` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_dir`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `universidad_db`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ciudad_diralumno`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `universidad_db`.`ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
