-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`Ciutat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Ciutat` (
  `id_ciutat` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_ciutat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Proveidor` (
  `id_proveidor` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `carrer` VARCHAR(100) NOT NULL,
  `numero` INT NOT NULL,
  `pis` INT NULL,
  `porta` VARCHAR(10) NULL,
  `ciutat_id` INT NOT NULL,
  `codi_postal` CHAR(5) NOT NULL,
  `pais_id` INT NOT NULL,
  `telefon` CHAR(9) NOT NULL,
  `fax` CHAR(9) NULL,
  `nif` CHAR(9) NOT NULL,
  PRIMARY KEY (`id_proveidor`),
  INDEX `fk_ciutat_proveidor_idx` (`ciutat_id` ASC) ,
  INDEX `fk_pais_proveidor_idx` (`pais_id` ASC) ,
  CONSTRAINT `fk_ciutat_proveidor`
    FOREIGN KEY (`ciutat_id`)
    REFERENCES `optica`.`Ciutat` (`id_ciutat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pais_proveidor`
    FOREIGN KEY (`pais_id`)
    REFERENCES `optica`.`Pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Colors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Colors` (
  `id_color` INT NOT NULL AUTO_INCREMENT,
  `descripcio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_color`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Tipus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Tipus` (
  `id_tip` INT NOT NULL AUTO_INCREMENT,
  `descripcio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tip`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Ulleres` (
  `id_ulleres` INT NOT NULL AUTO_INCREMENT,
  `graduacio_id` INT NOT NULL,
  `tipus_id` INT NOT NULL,
  `color_montura_id` INT NOT NULL,
  `color_vidre_id` INT NOT NULL,
  `preu` DECIMAL(8,2) NOT NULL,
  `proveidor_id` INT NULL,
  INDEX `fk_color_cristal_idx` (`color_vidre_id` ASC) ,
  INDEX `fk_color_montura_idx` (`color_montura_id` ASC) ,
  INDEX `fk_tipus_ullera_idx` (`tipus_id` ASC) ,
  INDEX `fk_proveidor_ullera_idx` (`proveidor_id` ASC) ,
  PRIMARY KEY (`id_ulleres`),
  CONSTRAINT `fk_color_vidrel`
    FOREIGN KEY (`color_vidre_id`)
    REFERENCES `optica`.`Colors` (`id_color`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_color_montura`
    FOREIGN KEY (`color_montura_id`)
    REFERENCES `optica`.`Colors` (`id_color`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipus_ullera`
    FOREIGN KEY (`tipus_id`)
    REFERENCES `optica`.`Tipus` (`id_tip`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveidor_ullera`
    FOREIGN KEY (`proveidor_id`)
    REFERENCES `optica`.`Proveidor` (`id_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Clients` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `direccio` VARCHAR(45) NOT NULL,
  `telefon` CHAR(9) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`id_client`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Recomendacions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Recomendacions` (
  `id_recomendacio` INT NOT NULL AUTO_INCREMENT,
  `client1_id` INT NOT NULL,
  `client_id2` INT NOT NULL,
  PRIMARY KEY (`id_recomendacio`),
  INDEX `fk_client1_recomendacio_idx` (`client1_id` ASC) ,
  INDEX `fk_client2_recomendacio_idx` (`client_id2` ASC) ,
  CONSTRAINT `fk_client1_recomendacio`
    FOREIGN KEY (`client1_id`)
    REFERENCES `optica`.`Clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client2_recomendacio`
    FOREIGN KEY (`client_id2`)
    REFERENCES `optica`.`Clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Empleats` (
  `id_empleat` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `direccio` VARCHAR(45) NOT NULL,
  `telefon` CHAR(9) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Ventes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Ventes` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `empleat_id` INT NOT NULL,
  `total` DECIMAL(8,2) NOT NULL,
  `data_venta` DATETIME NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `fk_client_venta_idx` (`client_id` ASC) ,
  INDEX `fk_empleat_venta_idx` (`empleat_id` ASC) ,
  CONSTRAINT `fk_client_venta`
    FOREIGN KEY (`client_id`)
    REFERENCES `optica`.`Clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleat_venta`
    FOREIGN KEY (`empleat_id`)
    REFERENCES `optica`.`Empleats` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Venta_detalls`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Venta_detalls` (
  `id_venta_detalls` INT NOT NULL AUTO_INCREMENT,
  `ullera_id` INT NOT NULL,
  `unitats` INT NOT NULL,
  `preu` DECIMAL(8,2) NOT NULL,
  `subtotal` DECIMAL(8,2) NOT NULL,
  `venta_id` INT NULL,
  PRIMARY KEY (`id_venta_detalls`),
  INDEX `fk_venta_venta_detall_idx` (`venta_id` ASC) ,
  INDEX `fk_ullera_venta_detall_idx` (`ullera_id` ASC) ,
  CONSTRAINT `fk_venta_venta_detall`
    FOREIGN KEY (`venta_id`)
    REFERENCES `optica`.`Ventes` (`id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ullera_venta_detall`
    FOREIGN KEY (`ullera_id`)
    REFERENCES `optica`.`Ulleres` (`id_ulleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
