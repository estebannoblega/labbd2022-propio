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



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Carga de Datos Personas - Administrador
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Bryan','Millis','bryanmillis@hotmail.com','administrador','1234','Activo','A');
-- Carga de Datos Personas - Usuarios
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Indiana','Jones','Indijones_3399@gmail.com','Indijones','1234','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Han','Solo','Han_solo123@gmail.com','SoloHan7','11111','Pendiente','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Sarah','Connor','arhconnor@yahoo.com','Sconnor','1234','Pendiente','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Rocky','Balboa','Balboarr@gmail.com','Balboa567','1234','Inactivo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Harry','Potter','harrypotter994@outlook.com','Harrypotter22','Gryffindor1234','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Bruce','Wayne','BruceWayne@gmail.com','SoyBataman','553332','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('hannibal','Lecter','hannibal@outlook.com','Lecter_H','HL2234','Inactivo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Tony','Stark','tonystark@outlook.com','Ironman','553366','Pendiente','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Peter','Parker','pparker@gmail.com','Peter1234','5532366','Pendiente','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Frankie','Dunn','frankie@outlook.com','F_Dunn89','abcdeef','Inactivo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Eddie','Dupris','Dupriseddi@outlook.com','Dupris22','aaasd6','Inactivo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Marcus','Higgins','higgins@gmail.com','Marcus','5aa53366','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Roxane','Chase','roxanechase@outlook.com','Salma','5asd53366','Pendiente','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Desmond','Doss','ddoss@gmail.com','Desmond','1234','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Jay','Gatsby','jaygg@outlook.com','TheGreatGatsby','ddgasd','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Nick','Carraway','jaygg@outlook.com','Nicky1','58316','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Bobby','Fischer','bobbyfish@gmail.com','TM','ajedrez','Activo','U');
INSERT INTO Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) VALUES ('Boris','Spassky','boris@outlook.com.ru','BS','ajdz','Activo','U');

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
