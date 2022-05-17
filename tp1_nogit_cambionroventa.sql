-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema LBD2022G08VETNET
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lbd2022g08vetnet
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lbd2022g08vetnet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lbd2022g08vetnet` DEFAULT CHARACTER SET utf8 ;
USE `lbd2022g08vetnet` ;

-- -----------------------------------------------------
-- Table `lbd2022g08vetnet`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`categorias` (
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`nombre`),
  UNIQUE INDEX `UX_nombre` (`nombre` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lbd2022g08vetnet`.`articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`articulos` (
  `idArticulo` INT NOT NULL AUTO_INCREMENT,
  `nombreCategoria` VARCHAR(30) NOT NULL,
  `nombre` VARCHAR(150) NOT NULL,
  `descripcion` TINYTEXT NULL DEFAULT NULL,
  `marca` VARCHAR(30) NOT NULL,
  `ganancia` FLOAT NOT NULL,
  `recurso1` VARCHAR(100) NULL DEFAULT NULL,
  `recurso2` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idArticulo`, `nombreCategoria`),
  INDEX `IX_Nombre` (`nombre` ASC),
  INDEX `IX_Marca` (`marca` ASC),
  INDEX `fk_Articulos_Categorias1_idx` (`nombreCategoria` ASC),
  CONSTRAINT `fk_Articulos_Categorias1`
    FOREIGN KEY (`nombreCategoria`)
    REFERENCES `lbd2022g08vetnet`.`categorias` (`nombre`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lbd2022g08vetnet`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`proveedores` (
  `CUIT` INT NOT NULL,
  `razonSocial` VARCHAR(100) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `domicilio` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(30) NOT NULL,
  `estado` ENUM('A', 'I') NOT NULL,
  PRIMARY KEY (`CUIT`),
  UNIQUE INDEX `UX_CUIT&RazonSocial` (`CUIT` ASC, `razonSocial` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lbd2022g08vetnet`.`compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`compras` (
  `idCompra` INT NOT NULL,
  `proveedoresCUIT` INT NOT NULL,
  `fechaCompra` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCompra`, `proveedoresCUIT`),
  INDEX `fk_Compras_Proveedores1_idx` (`proveedoresCUIT` ASC),
  CONSTRAINT `fk_Compras_Proveedores1`
    FOREIGN KEY (`proveedoresCUIT`)
    REFERENCES `lbd2022g08vetnet`.`proveedores` (`CUIT`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lbd2022g08vetnet`.`infocontacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`infocontacto` (
  `idInfoContacto` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idInfoContacto`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lbd2022g08vetnet`.`lineascompra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`lineascompra` (
  `idCompra` INT NOT NULL,
  `proveedoresCUIT` INT NOT NULL,
  `idArticulo` INT NOT NULL,
  `nombreCategoria` VARCHAR(30) NOT NULL,
  `cantidad` INT NOT NULL,
  `precioUnitario` FLOAT NOT NULL,
  PRIMARY KEY (`idCompra`, `proveedoresCUIT`, `idArticulo`, `nombreCategoria`),
  INDEX `fk_Compras_has_Articulos_Articulos1_idx` (`idArticulo` ASC, `nombreCategoria` ASC),
  INDEX `fk_Compras_has_Articulos_Compras1_idx` (`idCompra` ASC, `proveedoresCUIT` ASC),
  CONSTRAINT `fk_Compras_has_Articulos_Articulos1`
    FOREIGN KEY (`idArticulo` , `nombreCategoria`)
    REFERENCES `lbd2022g08vetnet`.`articulos` (`idArticulo` , `nombreCategoria`),
  CONSTRAINT `fk_Compras_has_Articulos_Compras1`
    FOREIGN KEY (`idCompra` , `proveedoresCUIT`)
    REFERENCES `lbd2022g08vetnet`.`compras` (`idCompra` , `proveedoresCUIT`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lbd2022g08vetnet`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `apellido` VARCHAR(30) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `usuario` VARCHAR(30) NOT NULL,
  `contrasenia` VARCHAR(30) NOT NULL,
  `estado` ENUM('Pendiente', 'Activo', 'Inactivo') NOT NULL,
  `tipo` ENUM('U', 'A') NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `UX_Usuario` (`usuario` ASC),
  INDEX `IX_Usuario` (`usuario` ASC),
  INDEX `IX_Apellido&Nombre` (`apellido` ASC, `nombre` ASC),
  INDEX `IX_Email` (`email` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lbd2022g08vetnet`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`ventas` (
  `idVenta` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `fechaVenta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVenta`, `idUsuario`),
  INDEX `fk_Ventas_Usuarios1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Ventas_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `lbd2022g08vetnet`.`usuarios` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lbd2022g08vetnet`.`lineasventa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`lineasventa` (
  `idVenta` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `idArticulo` INT NOT NULL,
  `nombreCategoria` VARCHAR(30) NOT NULL,
  `cantidad` INT NOT NULL,
  `precioUnitario` INT NOT NULL,
  PRIMARY KEY (`idVenta`, `idUsuario`, `idArticulo`, `nombreCategoria`),
  INDEX `fk_Ventas_has_Articulos_Articulos1_idx` (`idArticulo` ASC, `nombreCategoria` ASC),
  INDEX `fk_Ventas_has_Articulos_Ventas1_idx` (`idVenta` ASC, `idUsuario` ASC),
  CONSTRAINT `fk_Ventas_has_Articulos_Articulos1`
    FOREIGN KEY (`idArticulo` , `nombreCategoria`)
    REFERENCES `lbd2022g08vetnet`.`articulos` (`idArticulo` , `nombreCategoria`),
  CONSTRAINT `fk_Ventas_has_Articulos_Ventas1`
    FOREIGN KEY (`idVenta` , `idUsuario`)
    REFERENCES `lbd2022g08vetnet`.`ventas` (`idVenta` , `idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (203289881, '150193', '2021-12-22 10:12:54');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (788047743, '999598', '2022-01-12 01:23:21');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (799468601,'230759', '2021-01-31 12:15:33');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (568336191, '169413', '2020-09-19 05:11:16');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (203289881, '604663', '2020-05-05 03:30:44');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (729155061, '396284', '2020-03-04 05:44:31');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (560781226, '727299', '2020-10-08 11:05:18');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (560781226, '813802', '2021-04-04 10:45:30');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (884639013, '116708', '2020-03-24 05:39:16');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (607607261, '567780', '2021-04-30 21:29:46');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (451198207, '640723', '2021-12-20 10:40:43');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (223415092, '605337', '2020-09-09 05:56:27');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (330792808, '639041', '2022-02-09 11:15:28');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (985320584, '245355', '2020-08-02 17:02:50');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (330792808, '244282', '2022-03-14 10:54:46');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (985320584, '135069', '2021-04-08 17:43:24');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (451198207, '948153', '2020-04-29 02:57:39');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (560781226, '829696', '2021-09-29 05:39:51');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (330792808, '667429', '2020-07-16 09:05:12');
INSERT INTO Compras (proveedoresCUIT, idCompra, FechaCompra) VALUES (607607261, '385308', '2021-10-11 02:02:21');