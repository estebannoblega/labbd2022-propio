-- Año: 2022
-- Grupo Nro: 08
-- Integrantes: Faciano Enzo Nicolás, Nóblega Caro Esteban Leonel
-- Tema: Veterinaria
-- Nombre del Esquema: LBD2022G08
-- Plataforma: Windows 10
-- GitHub Repositorio: LBD2022G08
-- GitHub Usuarios: mezuckerberg, estebannoblega

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `LBD2022G08` DEFAULT CHARACTER SET UTF8MB4 ;

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`Personas` (
  `IdPersona` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  `Contrasenia` VARCHAR(100) NOT NULL,
  `Estado` ENUM('Pendiente', 'Activo', 'Inactivo') NOT NULL  /*P: Pendiente - I: Inactivo - A: Activo*/,
  `Tipo` ENUM('U', 'A') NOT NULL  /*A: Administrador - U: Usuario*/,
  PRIMARY KEY (`IdPersona`),
  UNIQUE INDEX `Usuario_UNIQUE` (`Usuario` ASC))
ENGINE = InnoDB;
-- DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`Clientes` (
  `IdPersona` INT(11) NOT NULL,
  `FechaNacimiento` DATE NOT NULL CHECK (FechaNacimiento< '2005-01-01' ) /*Comprobar que la persona sea mayor de 18 años*/,
  PRIMARY KEY (`IdPersona`),
  CONSTRAINT `fk_Usuarios_Personas`
    FOREIGN KEY (`IdPersona`)
    REFERENCES `LBD2022G08`.`Personas` (`IdPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`InfoContacto` (
  `idInfoContacto` INT(11) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idInfoContacto`))
ENGINE = InnoDB;
-- DEFAULT CHARACTER SET = utf8;
-- Correccion del tipo de dato para Telefono
ALTER TABLE `LBD2022G08`.`InfoContacto` MODIFY Telefono INT NOT NULL;

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`Ventas` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `IdPersona` INT NOT NULL,
  `NumeroVenta` INT NOT NULL,
  `FechaVenta` DATETIME NOT NULL,
  PRIMARY KEY (`idVenta`, `IdPersona`),
  UNIQUE INDEX `Venta_UNIQUE` (`NumeroVenta` ASC),
  INDEX `fk_Ventas_Usuarios1_idx` (`IdPersona` ASC),
  CONSTRAINT `fk_Ventas_Usuarios1`
    FOREIGN KEY (`IdPersona`)
    REFERENCES `LBD2022G08`.`Clientes` (`IdPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`Proveedores` (
  `idProveedor` INT(11) NOT NULL,
  `CUIT` INT(11) NOT NULL,
  `Domicilio` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  `RazonSocial` VARCHAR(30) NOT NULL,
  `Telefono` INT(11) NOT NULL,
  `Estado` ENUM('A', 'I') NOT NULL  /*A: Activo - I: Inactivo*/,
  PRIMARY KEY (`idProveedor`),
  UNIQUE INDEX `CUIT&RazonSocial_UNIQUE` (`CUIT` ASC, `RazonSocial` ASC))
ENGINE = InnoDB;
-- DEFAULT CHARACTER SET = utf8;
-- Cambio del tipo de dato para los atributos: telefono y RazonSocial
ALTER TABLE Proveedores MODIFY COLUMN Telefono VARCHAR(45);
ALTER TABLE Proveedores MODIFY COLUMN RazonSocial VARCHAR (50);
CREATE TABLE IF NOT EXISTS `LBD2022G08`.`Compras` (
  `idCompra` INT NOT NULL,
  `idProveedor` INT NOT NULL,
  `numeroCompra` INT NOT NULL,
  `fechaCompra` DATETIME NOT NULL,
  PRIMARY KEY (`idCompra`, `idProveedor`),
  INDEX `fk_Compras_Proveedores1_idx` (`idProveedor` ASC),
  CONSTRAINT `fk_Compras_Proveedores1`
    FOREIGN KEY (`idProveedor`)
    REFERENCES `LBD2022G08`.`Proveedores` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`Categorias` (
  `IdCategoria` INT(11) NOT NULL,
  `Nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`IdCategoria`),
  UNIQUE INDEX `nombre_UNIQUE` (`Nombre` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`Articulos` (
  `IdArticulo` INT NOT NULL,
  `IdCategoria` INT NOT NULL,
  `Nombre` VARCHAR(30) NOT NULL,
  `Descripcion` TINYTEXT NULL DEFAULT NULL,
  `Marca` VARCHAR(30) NULL DEFAULT NULL,
  `Ganancia` FLOAT(11) NOT NULL,
  `Recurso1` VARCHAR(100) NULL DEFAULT NULL,
  `Recurso2` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`IdArticulo`, `IdCategoria`),
  INDEX `fk_Articulos_Categorias1_idx` (`IdCategoria` ASC),
  CONSTRAINT `fk_Articulos_Categorias1`
    FOREIGN KEY (`IdCategoria`)
    REFERENCES `LBD2022G08`.`Categorias` (`IdCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `LBD2022G08`.`LineasCompra` (
  `idCompra` INT NOT NULL,
  `idArticulo` INT NOT NULL,
  `IdCategoria` INT NOT NULL,
  `IdProveedor` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `PrecioUnitario` FLOAT(11) NOT NULL,
  PRIMARY KEY (`idCompra`, `idArticulo`, `IdCategoria`, `IdProveedor`),
  INDEX `fk_Compras_has_Articulos_Articulos1_idx` (`idArticulo` ASC),
  INDEX `fk_Compras_has_Articulos_Compras_idx` (`idCompra` ASC),
  INDEX `fk_IdCategoria_idx` (`IdCategoria` ASC),
  INDEX `fk_IdProveedor_idx` (`IdProveedor` ASC),
  CONSTRAINT `fk_Compras_has_Articulos_Compras`
    FOREIGN KEY (`idCompra`)
    REFERENCES `LBD2022G08`.`Compras` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compras_has_Articulos_Articulos1`
    FOREIGN KEY (`idArticulo`)
    REFERENCES `LBD2022G08`.`Articulos` (`IdArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IdCategoria`
    FOREIGN KEY (`IdCategoria`)
    REFERENCES `LBD2022G08`.`Articulos` (`IdCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IdProveedor`
    FOREIGN KEY (`IdProveedor`)
    REFERENCES `LBD2022G08`.`Compras` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`LineasVenta` (
  `IdArticulo` INT(11) NOT NULL,
  `IdVenta` INT(11) NOT NULL,
  `IdCategoria` INT(11) NOT NULL,
  `IdPersona` INT(11) NOT NULL,
  `Cantidad` INT(11) NOT NULL,
  `PrecioUnitario` FLOAT(11) NOT NULL,
  PRIMARY KEY (`IdArticulo`, `IdVenta`, `IdCategoria`, `IdPersona`),
  INDEX `fk_Articulos_has_Ventas_Ventas1_idx` (`IdVenta` ASC),
  INDEX `fk_Articulos_has_Ventas_Articulos1_idx` (`IdArticulo` ASC),
  INDEX `fk_IdPersona_idx` (`IdPersona` ASC),
  INDEX `fk_IdCategoria_idx` (`IdCategoria` ASC),
  CONSTRAINT `fk_Articulos_has_Ventas_Articulos1`
    FOREIGN KEY (`IdArticulo`)
    REFERENCES `LBD2022G08`.`Articulos` (`IdArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulos_has_Ventas_Ventas1`
    FOREIGN KEY (`IdVenta`)
    REFERENCES `LBD2022G08`.`Ventas` (`idVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IdPersona`
    FOREIGN KEY (`IdPersona`)
    REFERENCES `LBD2022G08`.`Ventas` (`IdPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IdCategoria2`
    FOREIGN KEY (`IdCategoria`)
    REFERENCES `LBD2022G08`.`Articulos` (`IdCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;





SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- Carga de Datos Personas - Administrador
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Bryan','Millis','bryanmillis@hotmail.com','administrador','1234','Activo','A');
-- Carga de Datos Personas - Usuarios
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Indiana','Jones','Indijones_3399@gmail.com','Indijones','twFpwAvOX_FgsHf','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Han','Solo','Han_solo123@gmail.com','SoloHan7','twFpwAvOX_FgsHf','Pendiente','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Sarah','Connor','arhconnor@yahoo.com','Sconnor','ZcCk5qa6QSCnnCo','Pendiente','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Rocky','Balboa','Balboarr@gmail.com','Balboa567','YPDA_7scaMp97mf','Inactivo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Harry','Potter','harrypotter994@outlook.com','E0vuwk5qL4a_YFl','Gryffindor1234','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Bruce','Wayne','BruceWayne@gmail.com','SoyBataman','ucxUUYYCx3SH968','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('hannibal','Lecter','hannibal@outlook.com','Lecter_H','wapLK1bLhT0zUTu','Inactivo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Tony','Stark','tonystark@outlook.com','Ironman','L1ZYGHKtPQasTKy','Pendiente','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Peter','Parker','pparker@gmail.com','Peter1234','kpNMjb7Drx8fQuD','Pendiente','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Frankie','Dunn','frankie@outlook.com','F_Dunn89','Do1Ekq0nJ223k5n','Inactivo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Eddie','Dupris','Dupriseddi@outlook.com','Dupris22','06zDdSp5wTPZ9e8','Inactivo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Marcus','Higgins','higgins@gmail.com','Marcus','oWRKH4PgU6qG_Ck','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Roxane','Chase','roxanechase@outlook.com','Salma','dkhr_PFLEnIMNtC','Pendiente','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Desmond','Doss','ddoss@gmail.com','Desmond','3sFHkrYEW2ALJNW','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Jay','Gatsby','jaygg@outlook.com','TheGreatGatsby','CLssLtCFfZu8vx1','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Nick','Carraway','jaygg@outlook.com','Nicky1','YuQ9Ba4rmN7DaLk','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Bobby','Fischer','bobbyfish@gmail.com','TM','hbEC2YV0PIVOl5m','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Boris','Spassky','boris@outlook.com.ru','BS','A0jbNppiavYNSvq','Activo','U');

select * from personas where Estado = 'Activo';

-- Carga de datos de usuarios
INSERT INTO Clientes VALUES (2,'1973-06-11');
INSERT INTO Clientes VALUES (3,'1960-03-03');
INSERT INTO Clientes VALUES (4,'1991-11-14');
INSERT INTO Clientes VALUES (5,'2001-01-03');
INSERT INTO Clientes VALUES (6,'1977-01-22');
INSERT INTO Clientes VALUES (7,'1982-02-16');
INSERT INTO Clientes VALUES (8,'1993-10-04');
INSERT INTO Clientes VALUES (9,'1978-03-01');
INSERT INTO Clientes VALUES (10,'1973-06-11');
INSERT INTO Clientes VALUES (11,'1979-06-01');
INSERT INTO Clientes VALUES (12,'2002-01-08');
INSERT INTO Clientes VALUES (13,'1994-04-27');
INSERT INTO Clientes VALUES (14,'1974-04-19');
INSERT INTO Clientes VALUES (15,'1999-05-27');
INSERT INTO Clientes VALUES (16,'1990-01-19');
INSERT INTO Clientes VALUES (17,'1981-08-18');
INSERT INTO Clientes VALUES (18,'1997-04-04');
INSERT INTO Clientes VALUES (19,'1973-06-11');
INSERT INTO Clientes VALUES (20,'1993-06-21');

SELECT * FROM Clientes;

-- Carga de datos para infocontacto
INSERT INTO InfoContacto (Direccion, Telefono, Email) VALUES ('Lavalle 150',3815497552,'ventas@veterinariavetnet.com');

-- Carga de datos para ventas
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (2,48692039,'2021-07-19 16:42:06');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (2,48692040,'2021-05-27 18:00:35');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (6,48692041,'2021-05-27 18:30:35');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (7,48692042,'2021-02-16 00:18:47');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (2,48692043,'2021-05-27 18:00:35');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (14,48692044,'2020-05-05 13:49:46');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (16,48692045,'2022-02-14 03:40:46');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (16,48692046,'2021-08-04 23:48:16');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (17,48692047,'2022-08-08 18:46:21');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (17,48692048,'2022-11-12 03:41:23');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (16,48692049,'2022-12-02 23:42:31');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (20,48692050,'2022-10-03 18:21:30');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (14,48692051,'2022-01-20 15:50:02');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (19,48692052,'2022-11-19 01:08:07');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (19,48692053,'2021-06-30 15:24:25');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (17,48692054,'2022-12-13 15:30:37');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (17,48692055,'2022-05-27 21:15:36');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (6,48692056,'2020-01-11 11:41:18');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (6,48692057,'2020-10-04 07:43:26');
INSERT INTO Ventas (IdPersona, NumeroVenta, FechaVenta) VALUES (6,48692058,'2021-09-10 07:07:49');

-- Carga de datos para Proveedores
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (1, 464900536, '246 Dexter Plaza', 'cblanden0@rediff.com', 'Realty Income Corporation', '3810514466', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (2, '411693901', '10802 Mosinee Avenue', 'egumbrell1@wix.com', 'Astronics Corporation', '3815132053', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (3, '873924115', '9502 Pleasure Trail', 'mdalmeida2@noaa.gov', 'Heat Biologics, Inc.', '3813922770', 'I');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (4, '839698426', '631 Lawn Court', 'bkelleher3@mtv.com', 'Darden Restaurants, Inc.', '3819731127', 'I');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (5, '263423822', '74070 Di Loreto Hill', 'efullwood4@amazon.co.uk', 'The Navigators Group, Inc.', '3816449596', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (6, '637779142', '3 Buell Point', 'hmournian5@alibaba.com', 'Eagle Point Credit Company', '3810870969', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (7, '852763742', '660 Sunfield Alley', 'acoddrington6@1und1.de', 'Entercom Communications Corporation', '3818298680', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (8, '387949985', '9248 Cottonwood Alley', 'chaggarth7@canalblog.com', 'M/I Homes, Inc.', '3819105897', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (9, '306200101', '14647 Warner Junction', 'emulrooney8@sourceforge.net', 'Capitala Finance Corp.', '3810845854', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (10, '071625157', '2466 Nancy Terrace', 'ksaltsberger9@i2i.jp', 'Roka Bioscience, Inc.', '3818654113', 'I');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (11, '966230857', '7261 Goodland Alley', 'lwimmsa@google.com.au', 'First Trust Mega Cap AlphaDEX Fund', '3813683575', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (12, '956855844', '81 Elmside Court', 'ciacapuccib@cisco.com', 'Teekay Offshore Partners L.P.', '3813027849', 'I');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (13, '411381599', '68 Alpine Crossing', 'gpentinc@booking.com', 'Connecture, Inc.', '3818331292', 'I');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Eçmail, RazonSocial, Telefono, Estado) VALUES (14, '460276410', '80 Mallard Crossing', 'vvannozziid@cdbaby.com', 'Israel Chemicals Shs', '3810416544', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (15, '304068059', '04433 Stephen Road', 'wswalowee@tmall.com', 'WisdomTree China ex-State-Owned Enterprises Fund', '3811706533', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (16, '121916712', '18 Oakridge Alley', 'rkohrsf@chronoengine.com', 'EP Energy Corporation', '3810916900', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (17, '545012376', '59 Continental Terrace', 'lnajarag@unc.edu', 'Macatawa Bank Corporation', '3810724082', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (18, '488884996', '21 Gerald Road', 'ahamorh@free.fr', 'Zions Bancorporation', '3812719272', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (19, '322128979', '2 Cardinal Drive', 'grougei@unc.edu', 'Nuveen NASDAQ 100 Dynamic Overwrite Fund', '3811976564', 'A');
INSERT INTO Proveedores (IdProveedor, CUIT, Domicilio, Email, RazonSocial, Telefono, Estado) VALUES (20, '325256229', '34284 Menomonie Avenue', 'slantophj@mit.edu', 'Snap Inc.', '3819360816', 'A');

-- Agregado de las Compras
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (1,2, '150193', '2021-12-22 10:12:54');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (2,2, '999598', '2022-01-12 01:23:21');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (3,5,'230759', '2021-01-31 12:15:33');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (4,5, '169413', '2020-09-19 05:11:16');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (5,9, '604663', '2020-05-05 03:30:44');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (6,8, '396284', '2020-03-04 05:44:31');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (7,8, '727299', '2020-10-08 11:05:18');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (8,9, '813802', '2021-04-04 10:45:30');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (9,6, '116708', '2020-03-24 05:39:16');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (10,5, '567780', '2021-04-30 21:29:46');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (11,7, '640723', '2021-12-20 10:40:43');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (12,8, '605337', '2020-09-09 05:56:27');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (13,1, '639041', '2022-02-09 11:15:28');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (14,1, '245355', '2020-08-02 17:02:50');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (15,1, '244282', '2022-03-14 10:54:46');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (16,2, '135069', '2021-04-08 17:43:24');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (17,19, '948153', '2020-04-29 02:57:39');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (18,20, '829696', '2021-09-29 05:39:51');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (19,20, '667429', '2020-07-16 09:05:12');
INSERT INTO Compras (IdCompra,IdProveedor, NumeroCompra, FechaCompra) VALUES (20,18, '385308', '2021-10-11 02:02:21');

-- Agregado de las categorías
INSERT INTO Categorias VALUES (1,'Medicamento General');
INSERT INTO Categorias VALUES (2,'Alimento para Perro');
INSERT INTO Categorias VALUES (3,'Alimento para Gato');
INSERT INTO Categorias VALUES (4,'Juguete');

-- Agregado de Articulos


