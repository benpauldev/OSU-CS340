
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


DROP TABLE IF EXISTS `artists`;
CREATE TABLE IF NOT EXISTS `artists` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(255) NOT NULL,
  `lname` VARCHAR(255) DEFAULT NULL,
  `year_of_birth` INT NOT NULL,
  `year_of_death` INT,
  PRIMARY KEY (`id`))
ENGINE = innoDB;



DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) UNIQUE NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = innoDB;


DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) UNIQUE NOT NULL,
  `fk_country_id` INT NOT NULL,
  PRIMARY KEY (`id`, `fk_country_id`),
  INDEX `country_id_idx` (`fk_country_id` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `country_id`
    FOREIGN KEY (`fk_country_id`)
    REFERENCES `country` (`country_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = innoDB;


DROP TABLE IF EXISTS `medium`;
CREATE TABLE IF NOT EXISTS `medium` (
  `id` INT(11) NULL DEFAULT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = innoDB;


DROP TABLE IF EXISTS `artists_medium`;
CREATE TABLE IF NOT EXISTS `artists_medium` (
  `artists_id` INT(11) NOT NULL,
  `medium_id` INT(11) NOT NULL,
  PRIMARY KEY (`artists_id`, `medium_id`),
  INDEX (`medium_id` ASC),
  CONSTRAINT 
    FOREIGN KEY (`artists_id`)
    REFERENCES `artists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (`medium_id`)
    REFERENCES `medium` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = innoDB;


DROP TABLE IF EXISTS  `artists_residence`;
CREATE TABLE IF NOT EXISTS `artists_residence` (
  `artists_id` INT(11) NOT NULL,
  `city_id` INT(11) NOT NULL,
  PRIMARY KEY (`artists_id`, `city_id`),
  INDEX (`city_id` ASC),
  CONSTRAINT 
    FOREIGN KEY (`artists_id`)
    REFERENCES `artists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (`city_id`)
    REFERENCES `city` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = innoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
