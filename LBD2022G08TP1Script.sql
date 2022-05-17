-- Año: 2022
-- Grupo Nro: 08
-- Integrantes: Faciano Enzo Nicolás, Nóblega Caro Esteban Leonel
-- Tema: Veterinaria
-- Nombre del Esquema: LBD2022G08VETNET
-- Plataforma: Windows 10 Pro - Version: 21H1 
-- Motor y Versión: MySQL Server 8.0.22 (Community Edition)
-- GitHub Repositorio: LBD2022G08
-- GitHub Usuarios: enzofac, estebannoblega

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

select @@version;
-- -----------------------------------------------------
-- Schema LBD2022G08VETNET
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LBD2022G08VETNET` ;

-- -----------------------------------------------------
-- Schema LBD2022G08VETNET
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LBD2022G08VETNET` DEFAULT CHARACTER SET utf8 ;
USE `LBD2022G08VETNET` ;

-- -----------------------------------------------------
-- Table `Usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Usuarios` ;

CREATE TABLE IF NOT EXISTS `Usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `apellido` VARCHAR(30) NOT NULL,
  `email` VARCHAR(30) NOT NULL, 
  CONSTRAINT CX_EmailUsuarios CHECK (`email`LIKE '%_@__%.__%'),
  `fechaNacimiento` DATE NOT NULL CHECK (2022-(fechaNacimiento)>= 18),
  /*Comprobar que la persona sea mayor de 18 años--> se lo puede resolver utilizando un trigger pues check no admite funciones NO DETERMINISTAS en este caso now()*/
  `usuario` VARCHAR(30) NOT NULL,
  `contrasenia` VARCHAR(30) NOT NULL,
  `estado` ENUM('Pendiente', 'Activo', 'Inactivo') NOT NULL  /*P: Pendiente - I: Inactivo - A: Activo*/,
  `tipo` ENUM('U', 'A') NOT NULL  /*A: Administrador - U: Usuario*/,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `UX_Usuario` ON `Usuarios` (`usuario` ASC);
CREATE INDEX `IX_Usuario` ON `Usuarios` (`usuario` ASC);
CREATE INDEX `IX_Apellido&Nombre` ON `Usuarios` (`apellido` ASC, `nombre` ASC);
CREATE INDEX `IX_Email` ON `Usuarios` (`email` ASC);


-- -----------------------------------------------------
-- Table `Ventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ventas` ;

CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`Ventas` (
  `idVenta` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `fechaVenta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVenta`, `idUsuario`),
  INDEX `fk_Ventas_Usuarios1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Ventas_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `lbd2022g08vetnet`.`Usuarios` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 21;



-- -----------------------------------------------------
-- Table `Proveedores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Proveedores` ;

CREATE TABLE IF NOT EXISTS `Proveedores` (
  `CUIT` INT NOT NULL,
  `razonSocial` VARCHAR(100) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  CONSTRAINT CX_EmailProveedores CHECK (`email`LIKE '%_@__%.__%'),
  `domicilio` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(30) NOT NULL,
  `estado` ENUM('A', 'I') NOT NULL DEFAULT 'A' /*A: Activo - I: Inactivo*/,
  PRIMARY KEY (`CUIT`),
  UNIQUE INDEX `UX_CUIT&RazonSocial` (`CUIT` ASC, `RazonSocial` ASC))
ENGINE = InnoDB;

-- DROP TABLE IF EXISTS `Compras`;
-- DROP TABLE IF EXISTS `LineasCompra`;

-- -----------------------------------------------------
-- Table `Compras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Compras` ;

CREATE TABLE IF NOT EXISTS `lbd2022g08vetnet`.`Compras` (
  `idCompra` INT NOT NULL,
  `proveedoresCUIT` INT NOT NULL,
  `fechaCompra` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCompra`, `proveedoresCUIT`),
  INDEX `fk_Compras_Proveedores1_idx` (`proveedoresCUIT` ASC),
  CONSTRAINT `fk_Compras_Proveedores1`
    FOREIGN KEY (`proveedoresCUIT`)
    REFERENCES `lbd2022g08vetnet`.`Proveedores` (`CUIT`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `Categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Categorias` ;

CREATE TABLE IF NOT EXISTS `Categorias` (
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `UX_nombre` ON `Categorias` (`nombre` ASC);


-- -----------------------------------------------------
-- Table `Articulos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Articulos` ;

CREATE TABLE IF NOT EXISTS `Articulos` (
  `idArticulo` INT NOT NULL AUTO_INCREMENT,
  `nombreCategoria` VARCHAR(30) NOT NULL,
  `nombre` VARCHAR(150) NOT NULL,
  `descripcion` TINYTEXT NULL,
  `marca` VARCHAR(30) NOT NULL,
  `ganancia` FLOAT NOT NULL CHECK (`ganancia`>0),
  `recurso1` VARCHAR(100) NULL,
  `recurso2` VARCHAR(100) NULL,
  PRIMARY KEY (`idArticulo`, `nombreCategoria`),
  CONSTRAINT `fk_Articulos_Categorias1`
    FOREIGN KEY (`nombreCategoria`)
    REFERENCES `Categorias` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `IX_Nombre` ON `Articulos` (`nombre` ASC);

CREATE INDEX `IX_Marca` ON `Articulos` (`marca` ASC);

CREATE INDEX `fk_Articulos_Categorias1_idx` ON `Articulos` (`nombreCategoria` ASC);


-- -----------------------------------------------------
-- Table `InfoContacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InfoContacto` ;

CREATE TABLE IF NOT EXISTS `InfoContacto` (
  `idInfoContacto` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(50) NOT NULL, /*Cambio el tipo, total no se hacen operaciones con el dato*/
  PRIMARY KEY (`idInfoContacto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LineasCompra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LineasCompra` ;

CREATE TABLE IF NOT EXISTS `LineasCompra` (
  `idCompra` INT NOT NULL,
  `proveedoresCUIT` INT NOT NULL,
  `idArticulo` INT NOT NULL,
  `nombreCategoria` VARCHAR(30) NOT NULL,
  `cantidad` INT NOT NULL CHECK (`cantidad`>0),
  `precioUnitario` FLOAT NOT NULL CHECK (`precioUnitario`>0),
  PRIMARY KEY (`idCompra`, `proveedoresCUIT`, `idArticulo`, `nombreCategoria`),
  CONSTRAINT `fk_Compras_has_Articulos_Compras1`
    FOREIGN KEY (`idCompra` , `proveedoresCUIT`)
    REFERENCES `Compras` (`idCompra` , `proveedoresCUIT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compras_has_Articulos_Articulos1`
    FOREIGN KEY (`idArticulo` , `nombreCategoria`)
    REFERENCES `Articulos` (`idArticulo` , `nombreCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Compras_has_Articulos_Articulos1_idx` ON `LineasCompra` (`idArticulo` ASC, `nombreCategoria` ASC);

CREATE INDEX `fk_Compras_has_Articulos_Compras1_idx` ON `LineasCompra` (`idCompra` ASC, `proveedoresCUIT` ASC);

-- drop table lineascompra;
-- drop table compras;

-- -----------------------------------------------------
-- Table `LineasVenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LineasVenta` ;

CREATE TABLE IF NOT EXISTS `LineasVenta` (
  `idVenta` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `idArticulo` INT NOT NULL,
  `nombreCategoria` VARCHAR(30) NOT NULL,
  `cantidad` INT NOT NULL CHECK (`cantidad`>0),
  `precioUnitario` INT NOT NULL CHECK (`precioUnitario`>0), 
  PRIMARY KEY (`idVenta`, `idUsuario`, `idArticulo`, `nombreCategoria`),
  CONSTRAINT `fk_Ventas_has_Articulos_Ventas1`
    FOREIGN KEY (`idVenta` , `idUsuario`)
    REFERENCES `Ventas` (`idVenta` , `idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ventas_has_Articulos_Articulos1`
    FOREIGN KEY (`idArticulo` , `nombreCategoria`)
    REFERENCES `Articulos` (`idArticulo` , `nombreCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ventas_has_Articulos_Articulos1_idx` ON `LineasVenta` (`idArticulo` ASC, `nombreCategoria` ASC); -- creado por la clave articulo

CREATE INDEX `fk_Ventas_has_Articulos_Ventas1_idx` ON `LineasVenta` (`idVenta` ASC, `idUsuario` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Carga de Datos Personas - Administrador
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Bryan','Millis','bryanmillis@hotmail.com','1979-06-12','administrador','1234','Activo','A');
select * from Usuarios;
-- Carga de Datos Personas - Usuarios
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Han','Solo','Han_solo123@gmail.com','1973-06-11','SoloHan7','twFpwAvOX_FgsHf','Pendiente','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Sarah','Connor','arhconnor@yahoo.com','1960-03-03','Sconnor','ZcCk5qa6QSCnnCo','Pendiente','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Rocky','Balboa','Balboarr@gmail.com','1991-11-14','Balboa567','YPDA_7scaMp97mf','Inactivo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Harry','Potter','harrypotter994@outlook.com','1981-08-18','E0vuwk5qL4a_YFl','Gryffindor1234','Activo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Bruce','Wayne','BruceWayne@gmail.com','2001-01-03','SoyBataman','ucxUUYYCx3SH968','Activo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('hannibal','Lecter','hannibal@outlook.com','1977-01-22','Lecter_H','wapLK1bLhT0zUTu','Inactivo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Tony','Stark','tonystark@outlook.com','1982-02-16','Ironman','L1ZYGHKtPQasTKy','Pendiente','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Peter','Parker','pparker@gmail.com','1993-10-04','Peter1234','kpNMjb7Drx8fQuD','Pendiente','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Frankie','Dunn','frankie@outlook.com','1978-03-01','F_Dunn89','Do1Ekq0nJ223k5n','Inactivo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Eddie','Dupris','Dupriseddi@outlook.com','1973-06-11','Dupris22','06zDdSp5wTPZ9e8','Inactivo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Marcus','Higgins','higgins@gmail.com','1997-04-04','Marcus','oWRKH4PgU6qG_Ck','Activo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Roxane','Chase','roxanechase@outlook.com','1979-06-01','Salma','dkhr_PFLEnIMNtC','Pendiente','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Desmond','Doss','ddoss@gmail.com','2002-01-08','Desmond','3sFHkrYEW2ALJNW','Activo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Jay','Gatsby','jaygg@outlook.com','1994-04-27','TheGreatGatsby','CLssLtCFfZu8vx1','Activo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Nick','Carraway','jaygg@outlook.com','1974-04-19','Nicky1','YuQ9Ba4rmN7DaLk','Activo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Bobby','Fischer','bobbyfish@gmail.com','1999-05-27','TM','hbEC2YV0PIVOl5m','Activo','U');
INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Boris','Spassky','boris@outlook.com.ru','1990-01-19','BS','A0jbNppiavYNSvq','Activo','U');
select * from Usuarios;

select * from Usuarios where estado = 'Activo';

-- Carga de datos para infocontacto
INSERT INTO InfoContacto (direccion, email, telefono) VALUES ('Lavalle 150','ventas@veterinariavetnet.com','3815497552');
select * from InfoContacto;

-- Carga de datos para ventas
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (2,48692039,'2021-07-19 16:42:06');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (2,48692040,'2021-05-27 18:00:35');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (6,48692041,'2021-05-27 18:30:35');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (7,48692042,'2021-02-16 00:18:47');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (2,48692043,'2021-05-27 18:00:35');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (14,48692044,'2020-05-05 13:49:46');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (16,48692045,'2022-02-14 03:40:46');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (16,48692046,'2021-08-04 23:48:16');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (17,48692047,'2022-08-08 18:46:21');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (17,48692048,'2022-11-12 03:41:23');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (16,48692049,'2022-12-02 23:42:31');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (10,48692050,'2022-10-03 18:21:30');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (14,48692051,'2022-01-20 15:50:02');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (18,48692052,'2022-11-19 01:08:07');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (18,48692053,'2021-06-30 15:24:25');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (17,48692054,'2022-12-13 15:30:37');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (17,48692055,'2022-05-27 21:15:36');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (6,48692056,'2020-01-11 11:41:18');
INSERT INTO Ventas (idUsuario, idVenta, fechaVenta) VALUES (6,48692057,'2020-10-04 07:43:26');
-- Comprobación de la Restriccion tipo DEFAULT
INSERT INTO Ventas (idUsuario, idVenta) VALUES (6,48692058);


-- Carga de datos para Proveedores
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (203289881, 'Eamia', 'plaing0@icio.us', '3 Namekagon Avenue', '7015124390');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (788047743, 'Babbleset', 'hwarry1@skype.com', '416 Brickson Park Junction', '9473644629');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (799468601, 'Blogspan', 'efoley2@telegraph.co.uk', '91742 Maple Hill', '6846590762');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (568336191, 'Leexo', 'cmacalpin3@qq.com', '280 Carpenter Parkway', '5371409364');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (336541077, 'Feedfish', 'cmacavddy4@weather.com', '0462 Namekagon Road', '3899382428');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (623700318, 'Demivee', 'ttrynor5@chronoengine.com', '8 Westerfield Park', '4822696133');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (308346939, 'Fanoodle', 'sverdey6@ca.gov', '34 Blackbird Place', '5278752951');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (902272735, 'Skiba', 'gpygott7@meetup.com', '43 Dawn Park', '4848794945');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (729155061, 'Pixope', 'bhavik8@yahoo.com', '3 Sunbrook Center', '4711054852');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (282484849, 'Bubbletube', 'zeyes9@engadget.com', '569 1st Hill', '2347769781');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (796469630, 'Edgeclub', 'pbriertona@tripod.com', '6916 Northwestern Parkway', '1713299383');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (330792808, 'Lazzy', 'bjumonetb@pcworld.com', '015 Forest Park', '3241915039');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (223415092, 'Photobean', 'tstarlingc@exblog.jp', '3 Scott Hill', '2718896356');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (645969859, 'Zooxo', 'rteesd@unesco.org', '361 Crest Line Junction', '5384719653');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (691940539, 'Ainyx', 'hmilligane@nba.com', '07478 Iowa Court', '2129632646');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (451198207, 'Dabfeed', 'mmcnellyf@cyberchimps.com', '82 Carberry Lane', '6027256205');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (985320584, 'Avaveo', 'pmilburng@comcast.net', '8 Del Mar Circle', '8539619709');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (560781226, 'Gabspot', 'mtoobyh@webmd.com', '43 Steensland Place', '6515802981');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (884639013, 'Twinte', 'degelli@printfriendly.com', '883 Fordem Plaza', '5733729916');
INSERT INTO Proveedores (CUIT, razonSocial, email, domicilio, telefono) VALUES (607607261, 'Voonix', 'cdeangeloj@umich.edu', '8 Brickson Park Terrace', '9112157157');

select * from Proveedores;

-- Agregado de las Compras
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

select * from Compras;

-- Agregado de las categorías
INSERT INTO Categorias (nombre) VALUES ('Medicamento General');
INSERT INTO Categorias (nombre) VALUES ('Alimento para Perros');
INSERT INTO Categorias (nombre) VALUES ('Alimento para Gatos');
INSERT INTO Categorias (nombre) VALUES ('Juguetes');
INSERT INTO Categorias (nombre) VALUES ('Higiene');

select * from Categorias;

-- Agregado de Articulos
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Medicamento General','Antibiótico','Antibiótico para mascotas, peso recomendado 4kg, 1 comprimido cada 8 horas','Tafirol',1.25,'link');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Alimento para Gatos','PURINA CATCHOW ADULTOS CARNE','Alimento sabor carne para gatos mayores de 1 año','CATCHOW',1.2,'https://www.purina-latam.com/mx/catchow/productos/adultos-carne');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Alimento para Gatos','PURINA CATCHOW ADULTOS PEZCADO','Alimento sabor pezcado para gatos mayores de 1 año','CATCHOW',1.2,'link');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Alimento para Gatos','PURINA CATCHOW GATITOS PEZCADO, CARNE Y LECHE','Alimento sabor pezcado, carne y leche para gatos menores de 6 meses','CATCHOW',1.2,'link');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Alimento para Perros','BISCROCK','Galletas deliciosamente crujientes de tres diferentes sabores. ideal para disfrutar al máximo de la hora de recompensar y premiar. Las galletas Biscrock contienen omega 3, calcio y vitaminas','PEDIGREE',1.2,'link');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Alimento para Perros','Razas pequeñas <10Kg','Alimento para perros de razas pequeñas, menores a 10Kg','PEDIGREE',1.2,'link');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Juguetes','Juguete Pesa Mordillo Para Perro De Cuerda Soga 24 cm - Mordedor','Juguete Pesa Mordillo Para Perro De Cuerda Soga 24 cm - Mordedor','DENTAFUN',1.3,'link');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Medicamento General','12P15 Vitaminico','Hace disminuir los signos clásicos de inflamación (calor-dolor-inflamación). Alivia los síntomas de lesiones tales como artritis y procesos alérgicos','NORT',1.5,'link');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Medicamento General','Acarox Concentrado','Antiparasitario externo. Antisárnico. Garrapaticida. Elimina pulgas, piojos, moscas.','Agropharma',1.5,'https://veterinariaonline.com.ar/wp-content/uploads/2019/08/Acarox-Concentrado-Agropharma-01.jpg');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Medicamento General','Bravecto','Bravecto ya está actuando en forma efectiva desde las 2 horas desde su aplicación. Con Bravecto su mascota obtendrá la más duradera protección que existe en el mercado.','Bravecto',1.5,'link');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Higiene','FORMULA MAC DONALD Gel','Fórmula Mac Donald Gel Champú actúa sobre el mayor espectro de microorganismos por la combinación sinérgica de Miconazol y Clorhexidina','MAC DONALD Gel',1.5,'link');
INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Higiene','DERMOSEDAN','Dermosedan Champú  Avena y Aloe, ha sido formulado para proveer un rápido y prolongado alivio del prurito. Incorpora avena coloidal, agente tópico clínicamente probado seguro y efectivo en aliviar el prurito en pacientes con afecciones alérgicas.','DERMOSEDAN',1.5,'link');

-- Agregado de LineasVenta
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692039,2,2,'Alimento para Gatos',1,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692039,2,5,'Alimento para Perros',2,319.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692040,2,10,'Medicamento General',2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692040,2,11,'Higiene',2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,1,'Medicamento General',1,500);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,2,'Alimento para Gatos',1,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,3,'Alimento para Gatos',1,450.50);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,4,'Alimento para Gatos',2,775.66);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,5,'Alimento para Perros',2,319.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,6,'Alimento para Perros',1,450.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,7,'Juguetes',1,1150.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,8,'Medicamento General',1,2050.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,10,'Medicamento General',2,1350.29);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,11,'Higiene',1,650.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692047,17,12,'Higiene',1,650.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692041,6,4,'Alimento para Gatos',2,775.66);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692042,7,12,'Higiene',2,700.69);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692043,2,6,'Alimento para Perros',1,450.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692044,14,6,'Alimento para Perros',1,450.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692045,16,6,'Alimento para Perros',1,450.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692046,16,7,'Juguetes',1,1150.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692048,17,4,'Alimento para Gatos',1,475.66);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692049,16,4,'Alimento para Gatos',3,1275.42);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692050,10,4,'Alimento para Gatos',1,475.66);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692051,14,6,'Alimento para Perros',2,1001.00);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692052,18,6,'Alimento para Perros',1,450.00);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692053,18,6,'Alimento para Perros',2,1001.00);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692054,17,12,'Higiene',1,650.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692055,17,12,'Higiene',1,710.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692056,6,12,'Higiene',1,650.99);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (48692057,6,11,'Higiene',1,650.99);



select * from compras;
-- Agregado de LineasCompra
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (150193,203289881,2,'Alimento para Gatos',50,300);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (150193,203289881,3,'Alimento para Gatos',50,400);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (150193,203289881,4,'Alimento para Gatos',50,400);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (999598,788047743,12,'Higiene',45,600);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (999598,788047743,11,'Higiene',30,300);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (230759,799468601,7,'Juguetes',20,800);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (169413,568336191,9,'Medicamento General',20,800);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (169413,568336191,10,'Medicamento General',20,900);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (604663,203289881,7,'Juguetes',10,850);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (396284,729155061,4,'Alimento para Gatos',40,320);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (727299,560781226,4,'Alimento para Gatos',40,320);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (727299,560781226,7,'Juguetes',4,100);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (813802,560781226,12,'Higiene',10,420);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (116708,884639013,4,'Alimento para Gatos',40,320);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (116708,884639013,3,'Alimento para Gatos',70,1320);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (567780,607607261,5,'Alimento para Perros',40,220);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (640723,451198207,9,'Medicamento General',40,320);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (605337,223415092,5,'Alimento para Perros',43,220);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (605337,223415092,4,'Alimento para Gatos',40,320);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (639041,330792808,4,'Alimento para Gatos',40,320);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (245355,985320584,1,'Medicamento General',50,620);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (244282,330792808,6,'Alimento para Perros',50,320);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (135069,985320584,10,'Medicamento General',20,720);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (948153,451198207,11,'Higiene',10,440);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (829696,560781226,5,'Alimento para Perros',50,311);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (667429,330792808,6,'Alimento para Perros',70,300.99);
INSERT INTO LineasCompra (idCompra, proveedoresCUIT, idArticulo, nombreCategoria, cantidad, precioUnitario) VALUES (385308,607607261,9,'Medicamento General',10,540.76);

-- PRUEBA DE RESTRICCIONES TIPO CHECK --------------------------------------------

-- INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Gretha','Diaz','grethadiaz@outlook.com.ru','2007-09-19','GreatGreta','A0jbNppiavYNSvq','Activo','U');
-- No debería cargar el último debido a la restricción CHECK sobre fecha

-- INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Gretha','Diaz','grethadiazoutlook.com.ru','2000-09-19','GreatGreta','A0jbNppiavYNSvq','Activo','U');
-- No debería cargar el último debido a la restricción CHECK sobre email

-- INSERT INTO Usuarios (nombre,apellido,email,fechaNacimiento,usuario,contrasenia,estado,tipo) VALUES ('Gretha','Diaz','grethadiaz@outlookcom','2000-09-19','GreatGreta','A0jbNppiavYNSvq','Activo','U');
-- No debería cargar el último debido a la restricción CHECK sobre email

-- INSERT INTO Articulos (nombreCategoria, nombre, descripcion, marca, ganancia, recurso1) VALUES ('Higiene','DERMOSEDAN','Dermosedan Champú  Avena y Aloe, ha sido formulado para proveer un rápido y prolongado alivio del prurito. Incorpora avena coloidal, agente tópico clínicamente probado seguro y efectivo en aliviar el prurito en pacientes con afecciones alérgicas.','DERMOSEDAN',0,'link');
-- No debería cargar debido a que se está poniendo ganancia cero

-- *******************CORRECCIONES****************************************************************
-- LOS ATRIBUTOS EMAIL DE LAS TABLAS USUARIOS Y PROVEEDORES NO COINCIDEN CON LOS DEL MODELO LOGICO
ALTER TABLE Usuarios MODIFY COLUMN Email VARCHAR(50);
ALTER TABLE Proveedores MODIFY COLUMN Email VARCHAR(50);
-- En la tabla usuarios cambiar la restriccion check para comprobar que LA PERSONA ES MAYOR DE 18 AÑOS
-- No se puede usar la funcion now() para obtener la fecha ya que check no permite funciones no deterministicas. https://es.stackoverflow.com/questions/443512/an-expression-of-a-check-constraint-producto-chk-3-contains-disallowed-functio
-- AGREGAR DEFAULT A LOS ENUM
ALTER TABLE Usuarios ALTER COLUMN Estado SET DEFAULT 'Pendiente';
ALTER TABLE Usuarios ALTER COLUMN Tipo SET DEFAULT 'U';
ALTER TABLE Proveedores ALTER COLUMN Estado SET DEFAULT 'A';