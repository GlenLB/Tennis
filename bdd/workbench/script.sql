-- MySQL Script generated by MySQL Workbench
-- jeu. 21 mars 2019 11:12:21 CET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema clubTennis
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema clubTennis
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clubTennis` DEFAULT CHARACTER SET utf8 ;
USE `clubTennis` ;

-- -----------------------------------------------------
-- Table `clubTennis`.`CLUB`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`CLUB` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`CLUB` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NOM` VARCHAR(200) NOT NULL,
  `HORAIRES` VARCHAR(1000) NOT NULL,
  `TEL` CHAR(10) NOT NULL,
  `EMAIL` VARCHAR(400) NOT NULL,
  `ADRESSE` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`ENTRAINEMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`ENTRAINEMENT` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`ENTRAINEMENT` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `HEURE_DEBUT` DATETIME NOT NULL,
  `HEURE_FIN` DATETIME NOT NULL,
  `NIVEAU` ENUM('D', 'I', 'A') NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`AVATAR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`AVATAR` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`AVATAR` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CONTENT` BLOB NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`ABONNE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`ABONNE` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`ABONNE` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `PRENOM` VARCHAR(100) NOT NULL,
  `NOM` VARCHAR(100) NOT NULL,
  `PSEUDO` VARCHAR(100) NULL,
  `EMAIL` VARCHAR(200) NOT NULL,
  `MDP` VARCHAR(255) NOT NULL,
  `REDUCTION` TINYINT(1) NOT NULL DEFAULT 0,
  `DESCRIPTION` VARCHAR(2000) NULL,
  `NIVEAU` ENUM('D', 'I', 'A') NOT NULL DEFAULT 'D',
  `CLUB_ID` INT UNSIGNED NOT NULL DEFAULT 1,
  `ENTRAINEMENT_ID` INT UNSIGNED NOT NULL DEFAULT 1,
  `AVATAR_ID` INT UNSIGNED NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_ABONNE_CLUB1_idx` (`CLUB_ID` ASC),
  INDEX `fk_ABONNE_ENTRAINEMENT1_idx` (`ENTRAINEMENT_ID` ASC),
  INDEX `fk_ABONNE_AVATAR1_idx` (`AVATAR_ID` ASC),
  CONSTRAINT `fk_ABONNE_CLUB1`
    FOREIGN KEY (`CLUB_ID`)
    REFERENCES `clubTennis`.`CLUB` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ABONNE_ENTRAINEMENT1`
    FOREIGN KEY (`ENTRAINEMENT_ID`)
    REFERENCES `clubTennis`.`ENTRAINEMENT` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ABONNE_AVATAR1`
    FOREIGN KEY (`AVATAR_ID`)
    REFERENCES `clubTennis`.`AVATAR` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`TERRAIN`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`TERRAIN` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`TERRAIN` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `COUVERT` TINYINT(1) NOT NULL DEFAULT 0,
  `TYPE` ENUM('TERRE BATTUE', 'GAZON', 'SYNTHETIQUE') NOT NULL,
  `CLUB_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_TERRAIN_CLUB1_idx` (`CLUB_ID` ASC),
  CONSTRAINT `fk_TERRAIN_CLUB1`
    FOREIGN KEY (`CLUB_ID`)
    REFERENCES `clubTennis`.`CLUB` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`MATCH`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`MATCH` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`MATCH` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `HEURE_DEBUT` DATETIME NOT NULL,
  `HEURE_FIN` DATETIME NOT NULL,
  `COMPETITION` TINYINT(1) NOT NULL DEFAULT 0,
  `ABONNE_ID_GAGNANT` INT UNSIGNED NOT NULL,
  `ABONNE_ID_PERDANT` INT UNSIGNED NOT NULL,
  `TERRAIN_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_MATCH_ABONNE1_idx` (`ABONNE_ID_GAGNANT` ASC),
  INDEX `fk_MATCH_ABONNE2_idx` (`ABONNE_ID_PERDANT` ASC),
  INDEX `fk_MATCH_TERRAIN1_idx` (`TERRAIN_ID` ASC),
  CONSTRAINT `fk_MATCH_ABONNE1`
    FOREIGN KEY (`ABONNE_ID_GAGNANT`)
    REFERENCES `clubTennis`.`ABONNE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MATCH_ABONNE2`
    FOREIGN KEY (`ABONNE_ID_PERDANT`)
    REFERENCES `clubTennis`.`ABONNE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MATCH_TERRAIN1`
    FOREIGN KEY (`TERRAIN_ID`)
    REFERENCES `clubTennis`.`TERRAIN` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`ENTRAINEUR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`ENTRAINEUR` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`ENTRAINEUR` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `PRENOM` VARCHAR(100) NOT NULL,
  `NOM` VARCHAR(100) NOT NULL,
  `DESCRIPTION` VARCHAR(2000) NULL,
  `AVATAR` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`GAGNE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`GAGNE` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`GAGNE` (
  `ABONNE_ID` INT UNSIGNED NOT NULL,
  `MATCH_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ABONNE_ID`, `MATCH_ID`),
  INDEX `fk_ABONNE_has_MATCH_MATCH1_idx` (`MATCH_ID` ASC),
  INDEX `fk_ABONNE_has_MATCH_ABONNE1_idx` (`ABONNE_ID` ASC),
  CONSTRAINT `fk_ABONNE_has_MATCH_ABONNE1`
    FOREIGN KEY (`ABONNE_ID`)
    REFERENCES `clubTennis`.`ABONNE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ABONNE_has_MATCH_MATCH1`
    FOREIGN KEY (`MATCH_ID`)
    REFERENCES `clubTennis`.`MATCH` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`MATCH_has_ABONNE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`MATCH_has_ABONNE` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`MATCH_has_ABONNE` (
  `ABONNE_ID` INT UNSIGNED NOT NULL,
  `MATCH_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ABONNE_ID`, `MATCH_ID`),
  INDEX `fk_ABONNE_has_MATCH1_MATCH1_idx` (`MATCH_ID` ASC),
  INDEX `fk_ABONNE_has_MATCH1_ABONNE1_idx` (`ABONNE_ID` ASC),
  CONSTRAINT `fk_ABONNE_has_MATCH1_ABONNE1`
    FOREIGN KEY (`ABONNE_ID`)
    REFERENCES `clubTennis`.`ABONNE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ABONNE_has_MATCH1_MATCH1`
    FOREIGN KEY (`MATCH_ID`)
    REFERENCES `clubTennis`.`MATCH` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`ENTRAINEMENT_has_TERRAIN`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`ENTRAINEMENT_has_TERRAIN` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`ENTRAINEMENT_has_TERRAIN` (
  `ENTRAINEMENT_ID` INT UNSIGNED NOT NULL,
  `TERRAIN_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ENTRAINEMENT_ID`, `TERRAIN_ID`),
  INDEX `fk_ENTRAINEMENT_has_TERRAIN_TERRAIN1_idx` (`TERRAIN_ID` ASC),
  INDEX `fk_ENTRAINEMENT_has_TERRAIN_ENTRAINEMENT1_idx` (`ENTRAINEMENT_ID` ASC),
  CONSTRAINT `fk_ENTRAINEMENT_has_TERRAIN_ENTRAINEMENT1`
    FOREIGN KEY (`ENTRAINEMENT_ID`)
    REFERENCES `clubTennis`.`ENTRAINEMENT` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENTRAINEMENT_has_TERRAIN_TERRAIN1`
    FOREIGN KEY (`TERRAIN_ID`)
    REFERENCES `clubTennis`.`TERRAIN` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`ENTRAINEMENT_has_ENTRAINEUR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`ENTRAINEMENT_has_ENTRAINEUR` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`ENTRAINEMENT_has_ENTRAINEUR` (
  `ENTRAINEMENT_ID` INT UNSIGNED NOT NULL,
  `ENTRAINEUR_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ENTRAINEMENT_ID`, `ENTRAINEUR_ID`),
  INDEX `fk_ENTRAINEMENT_has_ENTRAINEUR_ENTRAINEUR1_idx` (`ENTRAINEUR_ID` ASC),
  INDEX `fk_ENTRAINEMENT_has_ENTRAINEUR_ENTRAINEMENT1_idx` (`ENTRAINEMENT_ID` ASC),
  CONSTRAINT `fk_ENTRAINEMENT_has_ENTRAINEUR_ENTRAINEMENT1`
    FOREIGN KEY (`ENTRAINEMENT_ID`)
    REFERENCES `clubTennis`.`ENTRAINEMENT` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENTRAINEMENT_has_ENTRAINEUR_ENTRAINEUR1`
    FOREIGN KEY (`ENTRAINEUR_ID`)
    REFERENCES `clubTennis`.`ENTRAINEUR` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`AVATAR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`AVATAR` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`AVATAR` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CONTENT` BLOB NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clubTennis`.`IMAGE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clubTennis`.`IMAGE` ;

CREATE TABLE IF NOT EXISTS `clubTennis`.`IMAGE` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CONTENT` BLOB NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
