-- Año: 2022
-- Grupo Nro: 08
-- Integrantes: Faciano Enzo Nicolás, Nóblega Caro Esteban Leonel
-- Tema: Veterinaria
-- Nombre del Esquema: LBD2022G08Veterinaria
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

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`Usuarios` (
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

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`Ventas` (
  `idVentas` INT(11) NOT NULL,
  `IdPersona` INT(11) NOT NULL,
  `NumeroVenta` INT(10) NOT NULL,
  `FechaVenta` DATE NOT NULL,
  PRIMARY KEY (`idVentas`, `IdPersona`),
  UNIQUE INDEX `Venta_UNIQUE` (`NumeroVenta` ASC),
  INDEX `fk_Ventas_Usuarios1_idx` (`IdPersona` ASC),
  CONSTRAINT `fk_Ventas_Usuarios1`
    FOREIGN KEY (`IdPersona`)
    REFERENCES `LBD2022G08`.`Usuarios` (`IdPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `LBD2022G08`.`Proveedores` (
  `idProveedores` INT(11) NOT NULL,
  `CUIT` INT(11) NOT NULL,
  `Domicilio` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  `RazonSocial` VARCHAR(30) NOT NULL,
  `Telefono` INT(11) NOT NULL,
  `Estado` ENUM('A', 'I') NOT NULL  /*A: Activo - I: Inactivo*/,
  PRIMARY KEY (`idProveedores`),
  UNIQUE INDEX `CUIT&RazonSocial_UNIQUE` (`CUIT` ASC, `RazonSocial` ASC))
ENGINE = InnoDB;
-- DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Carga de Datos Personas - Administrador
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Bryan','Millis','bryanmillis@hotmail.com','administrador','1234','Activo','A');
-- Carga de Datos Personas - Usuarios
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Indiana','Jones','Indijones_3399@gmail.com','Indijones','1234','Activo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Han','Solo','Han_solo123@gmail.com','SoloHan7','11111','Pendiente','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Sarah','Connor','arhconnor@yahoo.com','Sconnor','1234','Pendiente','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Rocky','Balboa','Balboarr@gmail.com','Balboa567','1234','Inactivo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Harry','Potter','harrypotter994@outlook.com','Harrypotter22','Gryffindor1234','Activo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Bruce','Wayne','BruceWayne@gmail.com','SoyBataman','553332','Activo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('hannibal','Lecter','hannibal@outlook.com','Lecter_H','HL2234','Inactivo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Tony','Stark','tonystark@outlook.com','Ironman','553366','Pendiente','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Peter','Parker','pparker@gmail.com','Peter1234','5532366','Pendiente','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Frankie','Dunn','frankie@outlook.com','F_Dunn89','abcdeef','Inactivo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Eddie','Dupris','Dupriseddi@outlook.com','Dupris22','aaasd6','Inactivo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Erick','Lamonsoff','Lamonsoff@gmail.com','kevinjames','553366','Pendiente','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Marcus','Higgins','higgins@gmail.com','Marcus','5aa53366','Activo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Roxane','Chase','roxanechase@outlook.com','Salma','5asd53366','Pendiente','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Desmond','Doss','ddoss@gmail.com','Desmond','1234','Activo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Jay','Gatsby','jaygg@outlook.com','TheGreatGatsby','ddgasd','Activo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Nick','Carraway','jaygg@outlook.com','Nicky1','58316','Activo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Bobby','Fischer','bobbyfish@gmail.com','TM','ajedrez','Activo','U');
insert into Personas (Nombre,Apellido,Email,Usuario,Contrasenia,Estado,Tipo) values ('Boris','Spassky','boris@outlook.com.ru','BS','ajdz','Activo','U');

select * from personas;

