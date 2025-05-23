-- MySQL Script generated by MySQL Workbench
-- Sat Apr 26 19:33:25 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema eshop
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `eshop` ;

-- -----------------------------------------------------
-- Schema eshop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eshop` DEFAULT CHARACTER SET utf8 ;
USE `eshop` ;

-- -----------------------------------------------------
-- Table `eshop`.`Zakaznik`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eshop`.`Zakaznik` ;

CREATE TABLE IF NOT EXISTS `eshop`.`Zakaznik` (
  `idZakaznik` INT NOT NULL AUTO_INCREMENT,
  `jmeno` VARCHAR(45) NOT NULL,
  `prijmeni` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `adresa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idZakaznik`),
  UNIQUE INDEX `idZakaznik_UNIQUE` (`idZakaznik` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshop`.`Produkt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eshop`.`Produkt` ;

CREATE TABLE IF NOT EXISTS `eshop`.`Produkt` (
  `idProdukt` INT NOT NULL AUTO_INCREMENT,
  `nazev` VARCHAR(100) NOT NULL,
  `popis` TEXT NOT NULL,
  `skladem` INT NOT NULL DEFAULT 0,
  `cena` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idProdukt`),
  UNIQUE INDEX `idProdukt_UNIQUE` (`idProdukt` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshop`.`objednavka`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eshop`.`objednavka` ;

CREATE TABLE IF NOT EXISTS `eshop`.`objednavka` (
  `idobjednavka` INT NOT NULL AUTO_INCREMENT,
  `datum_objednavky` DATE NOT NULL DEFAULT (CURRENT_DATE),
  `Zakaznik_idZakaznik` INT NOT NULL,
  `stav` ENUM('Přijata', 'Zpracovává se', 'Odeslána', 'Dokončena', 'Stornována') NULL DEFAULT 'Přijata',
  PRIMARY KEY (`idobjednavka`, `Zakaznik_idZakaznik`),
  UNIQUE INDEX `idobjednavka_UNIQUE` (`idobjednavka` ASC) ,
  INDEX `fk_objednavka_Zakaznik_idx` (`Zakaznik_idZakaznik` ASC) ,
  CONSTRAINT `fk_objednavka_Zakaznik`
    FOREIGN KEY (`Zakaznik_idZakaznik`)
    REFERENCES `eshop`.`Zakaznik` (`idZakaznik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshop`.`objednavka_produkt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eshop`.`objednavka_produkt` ;

CREATE TABLE IF NOT EXISTS `eshop`.`objednavka_produkt` (
  `objednavka_idobjednavka` INT NOT NULL,
  `objednavka_Zakaznik_idZakaznik` INT NOT NULL,
  `Produkt_idProdukt` INT NOT NULL,
  `mnozstvi` INT NULL DEFAULT 1,
  PRIMARY KEY (`objednavka_idobjednavka`, `objednavka_Zakaznik_idZakaznik`, `Produkt_idProdukt`),
  INDEX `fk_objednavka_produkt_Produkt1_idx` (`Produkt_idProdukt` ASC) ,
  CONSTRAINT `fk_objednavka_produkt_objednavka1`
    FOREIGN KEY (`objednavka_idobjednavka` , `objednavka_Zakaznik_idZakaznik`)
    REFERENCES `eshop`.`objednavka` (`idobjednavka` , `Zakaznik_idZakaznik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_objednavka_produkt_Produkt1`
    FOREIGN KEY (`Produkt_idProdukt`)
    REFERENCES `eshop`.`Produkt` (`idProdukt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Ukázková data: zákazníci
INSERT INTO zakaznik (jmeno, prijmeni, email, telefon, adresa)
VALUES ('Jana', 'Malá', 'jana.mala@email.cz', '777123456', 'Ulice 12, Město'),
       ('Petr', 'Velký', 'petr.velky@email.cz', '606987654', 'Náměstí 1, Obec');

-- Ukázková data: produkty
INSERT INTO produkt (nazev, popis, cena, skladem)
VALUES ('USB klíč 16GB', 'Malý flash disk s kapacitou 16 GB', 149.00, 100),
       ('Bezdrátová myš', 'Ergonomická optická myš s bluetooth', 299.00, 50),
       ('Sluchátka', 'Kvalitní sluchátka přes uši s mikrofonem', 599.00, 25);

-- Ukázková objednávka: Jana objednala 2 produkty
INSERT INTO objednavka (Zakaznik_idZakaznik, datum_objednavky, stav)
VALUES (1, '2025-04-24', 'Zpracovává se');

-- Propojíme produkty s objednávkou (objednavka_idobjednavka = 1)
INSERT INTO objednavka_produkt (objednavka_idobjednavka, objednavka_Zakaznik_idZakaznik, Produkt_idProdukt, mnozstvi)
VALUES (1, 1, 1, 2),  -- 2x USB klíč
       (1, 1, 2, 1); -- 1x myš

-- Ukázková objednávka: Petr objednal 1 produkt
INSERT INTO objednavka (Zakaznik_idZakaznik,datum_objednavky, stav)
VALUES (2,'2025-04-24', 'Přijata');

-- Naplníme produkty do objednávky (objednavka_idobjednavka = 2)
INSERT INTO objednavka_produkt (objednavka_idobjednavka, objednavka_Zakaznik_idZakaznik, Produkt_idProdukt, mnozstvi)
VALUES (2, 2, 3, 1); -- 1x sluchátka


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
