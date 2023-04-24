/*
SQLyog Community v13.2.0 (64 bit)
MySQL - 10.4.28-MariaDB : Database - senatimat
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`senatimat` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;

USE `senatimat`;

/*Table structure for table `cargos` */

DROP TABLE IF EXISTS `cargos`;

CREATE TABLE `cargos` (
  `idcargo` int(11) NOT NULL AUTO_INCREMENT,
  `cargo` varchar(40) NOT NULL,
  PRIMARY KEY (`idcargo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `cargos` */

insert  into `cargos`(`idcargo`,`cargo`) values 
(1,'Instructor'),
(2,'Jefe Centro'),
(3,'Asist. Administrativo'),
(4,'Asist. Academico'),
(5,'Coordinador ETIA'),
(6,'Coordinador CIS');

/*Table structure for table `carreras` */

DROP TABLE IF EXISTS `carreras`;

CREATE TABLE `carreras` (
  `idcarrera` int(11) NOT NULL AUTO_INCREMENT,
  `idescuela` int(11) NOT NULL,
  `carrera` varchar(100) NOT NULL,
  PRIMARY KEY (`idcarrera`),
  UNIQUE KEY `uk_carrera_car` (`carrera`),
  KEY `fk_idescuela_car` (`idescuela`),
  CONSTRAINT `fk_idescuela_car` FOREIGN KEY (`idescuela`) REFERENCES `escuelas` (`idescuela`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `carreras` */

insert  into `carreras`(`idcarrera`,`idescuela`,`carrera`) values 
(1,1,'Diseño Gráfico Digital'),
(2,1,'Ingeniería de Software con IA'),
(3,1,'Cyberseguridad'),
(4,2,'Administración de empresas'),
(5,2,'Administración Industrial'),
(6,2,'Prevencionista de Riesgo'),
(7,3,'Soldador Universal'),
(8,3,'Mecánico de mantenimiento'),
(9,3,'Soldador estructuras metálicas');

/*Table structure for table `colaboradores` */

DROP TABLE IF EXISTS `colaboradores`;

CREATE TABLE `colaboradores` (
  `idcolaborador` int(11) NOT NULL AUTO_INCREMENT,
  `apellidos` varchar(40) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `idcargo` int(11) NOT NULL,
  `idsede` int(11) NOT NULL,
  `telefono` char(9) NOT NULL,
  `tipocontrato` char(1) NOT NULL,
  `cv` varchar(100) DEFAULT NULL,
  `direccion` varchar(40) NOT NULL,
  `fecharegistro` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaupdate` datetime DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idcolaborador`),
  KEY `fk_idcargo_car` (`idcargo`),
  KEY `fk_idsede_car` (`idsede`),
  CONSTRAINT `fk_idcargo_car` FOREIGN KEY (`idcargo`) REFERENCES `cargos` (`idcargo`),
  CONSTRAINT `fk_idsede_car` FOREIGN KEY (`idsede`) REFERENCES `sedes` (`idsede`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `colaboradores` */

insert  into `colaboradores`(`idcolaborador`,`apellidos`,`nombres`,`idcargo`,`idsede`,`telefono`,`tipocontrato`,`cv`,`direccion`,`fecharegistro`,`fechaupdate`,`estado`) values 
(3,'Pool','Quesada Nolasco',3,3,'902206063','u','20c167ec271dd86f3fcceedd2498f40e9b0b64ca.pdf','Av 28 De Julio','2023-04-23 08:24:56',NULL,'1');

/*Table structure for table `escuelas` */

DROP TABLE IF EXISTS `escuelas`;

CREATE TABLE `escuelas` (
  `idescuela` int(11) NOT NULL AUTO_INCREMENT,
  `escuela` varchar(50) NOT NULL,
  PRIMARY KEY (`idescuela`),
  UNIQUE KEY `uk_escuela_esc` (`escuela`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `escuelas` */

insert  into `escuelas`(`idescuela`,`escuela`) values 
(2,'Administración'),
(1,'ETI'),
(4,'Gastronomía'),
(3,'Metal mecánica');

/*Table structure for table `estudiantes` */

DROP TABLE IF EXISTS `estudiantes`;

CREATE TABLE `estudiantes` (
  `idestudiante` int(11) NOT NULL AUTO_INCREMENT,
  `apellidos` varchar(40) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `tipodocumento` char(1) NOT NULL DEFAULT 'D',
  `nrodocumento` char(8) NOT NULL,
  `fechanacimiento` date NOT NULL,
  `idcarrera` int(11) NOT NULL,
  `idsede` int(11) NOT NULL,
  `fotografia` varchar(100) DEFAULT NULL,
  `fecharegistro` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaupdate` datetime DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idestudiante`),
  UNIQUE KEY `uk_nrodocumento_est` (`tipodocumento`,`nrodocumento`),
  KEY `fk_idcarrera_est` (`idcarrera`),
  KEY `fk_idsede_est` (`idsede`),
  CONSTRAINT `fk_idcarrera_est` FOREIGN KEY (`idcarrera`) REFERENCES `carreras` (`idcarrera`),
  CONSTRAINT `fk_idsede_est` FOREIGN KEY (`idsede`) REFERENCES `sedes` (`idsede`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `estudiantes` */

insert  into `estudiantes`(`idestudiante`,`apellidos`,`nombres`,`tipodocumento`,`nrodocumento`,`fechanacimiento`,`idcarrera`,`idsede`,`fotografia`,`fecharegistro`,`fechaupdate`,`estado`) values 
(1,'Martinez','Carlos','D','44445555','2000-01-01',1,1,NULL,'2023-04-23 08:15:16',NULL,'1'),
(2,'Ochoa','Fiorella','D','77778888','2000-10-10',4,2,NULL,'2023-04-23 08:15:16',NULL,'1'),
(3,'Perez','Roxana','D','88881111','2001-03-03',7,3,NULL,'2023-04-23 08:15:16',NULL,'1'),
(7,'Quispe','Rosa','D','87943567','2023-04-25',5,1,'46694e3ac52aa403a2cc638809515359771c0bc8.jpg','2023-04-23 10:58:08',NULL,'1');

/*Table structure for table `sedes` */

DROP TABLE IF EXISTS `sedes`;

CREATE TABLE `sedes` (
  `idsede` int(11) NOT NULL AUTO_INCREMENT,
  `sede` varchar(40) NOT NULL,
  PRIMARY KEY (`idsede`),
  UNIQUE KEY `uk_sede_sde` (`sede`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `sedes` */

insert  into `sedes`(`idsede`,`sede`) values 
(4,'Ayacucho'),
(1,'Chincha'),
(3,'Ica'),
(2,'Pisco');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombreusuario` varchar(30) NOT NULL,
  `claveacceso` varchar(90) NOT NULL,
  `apellidos` varchar(30) NOT NULL,
  `nombres` varchar(30) NOT NULL,
  `nivelacceso` char(1) NOT NULL DEFAULT 'A',
  `estado` char(1) NOT NULL DEFAULT '1',
  `fecharegistro` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaupdate` datetime DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_nombreusuario_usa` (`nombreusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idusuario`,`nombreusuario`,`claveacceso`,`apellidos`,`nombres`,`nivelacceso`,`estado`,`fecharegistro`,`fechaupdate`) values 
(1,'POOL','$2y$10$HRK9czgpbr9vyIPJMl2R0Ob7pMontFy5NdSn0Jdhy1kksMYNsy4LG','Quesada Nolasco','Pool','A','1','2023-04-24 02:42:43',NULL),
(2,'JOSE','$2y$10$qWHt2TJCxtXdEyAQPP/Jde0GmwuN3PgIwogvUTPt5FSD.ygWGIzRK','Marcos Perez','Jose','A','1','2023-04-24 02:42:43',NULL),
(3,'PEDRO','789456','Perez Gomez','Raul','A','0','2023-04-24 02:45:39',NULL),
(4,'LUIS','147852','Campos Bautista','Luis','A','1','2023-04-24 02:45:39',NULL),
(6,'POOL99','123456','Quesada','Pool','A','1','2023-04-24 08:59:24',NULL);

/* Procedure structure for procedure `spu_cargos_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cargos_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargos_listar`()
BEGIN
	SELECT * FROM cargos ORDER BY 2;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_carreras_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_carreras_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_carreras_listar`(IN _idescuela INT)
BEGIN
	SELECT idcarrera, carrera 
		FROM carreras
		WHERE idescuela = _idescuela;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_colaboradores_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_colaboradores_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_colaboradores_eliminar`(IN idcolaborador_ INT)
BEGIN
	DELETE FROM colaboradores
	WHERE idcolaborador = idcolaborador_;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_colaboradores_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_colaboradores_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_colaboradores_listar`()
BEGIN
	SELECT	COL.idcolaborador,
				COL.apellidos,
				COL.nombres,
				CAR.cargo,
				SED.sede,
				COL.telefono,
				COL.tipocontrato,
				COL.cv,
				COL.direccion
		FROM colaboradores COL
		INNER JOIN cargos CAR ON CAR.idcargo = COL.idcargo
		INNER JOIN sedes SED ON SED.idsede = COL.idsede
		WHERE COL.estado = '1';
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_colaboradores_registrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_colaboradores_registrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_colaboradores_registrar`(
	IN _apellidos 			VARCHAR(40),
	IN _nombres 			VARCHAR(40),
	IN _idcargo 			INT,
	IN _idsede				INT,
	IN _telefono			CHAR(9),
	IN _tipocontrato 		CHAR(1),
	IN _cv					VARCHAR(100),
	IN _direccion 			VARCHAR(40)
)
BEGIN
	-- Validar el contenido de _fotografia
	IF _cv = '' THEN 
		SET _cv = NULL;
	END IF;

	INSERT INTO colaboradores 
	(apellidos, nombres, idcargo, idsede, telefono, tipocontrato, cv, direccion) VALUES
	(_apellidos, _nombres, _idcargo, _idsede, _telefono, _tipocontrato, _cv, _direccion);
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_cv_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_cv_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cv_eliminar`(IN idcolaborador_ INT)
BEGIN
	SELECT cv FROM colaboradores WHERE idcolaborador = idcolaborador_;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_escuelas_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_escuelas_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_escuelas_listar`()
BEGIN 
	SELECT * FROM escuelas ORDER BY 2;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_estudiantes_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_estudiantes_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_estudiantes_eliminar`(in idestudiante_ int)
BEGIN
	DELETE FROM estudiantes
	WHERE idestudiante = idestudiante_;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_estudiantes_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_estudiantes_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_estudiantes_listar`()
BEGIN
	SELECT	EST.idestudiante,
				EST.apellidos,
				EST.nombres,
				EST.tipodocumento,
				EST.nrodocumento,
				EST.fechanacimiento,
				ESC.escuela,
 				CAR.carrera,
				SED.sede,
				EST.fotografia
		FROM estudiantes EST
		INNER JOIN carreras CAR ON CAR.idcarrera = EST.idcarrera
		INNER JOIN sedes SED ON SED.idsede = EST.idsede
		INNER JOIN escuelas ESC ON ESC.idescuela = CAR.idescuela
		WHERE EST.estado = '1';
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_estudiantes_registrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_estudiantes_registrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_estudiantes_registrar`(
	IN _apellidos 			VARCHAR(40),
	IN _nombres 			VARCHAR(40),
	IN _tipodocumento		CHAR(1),
	IN _nrodocumento		CHAR(8),
	IN _fechanacimiento	DATE,
	IN _idcarrera 			INT,
	IN _idsede 				INT,
	IN _fotografia 		VARCHAR(100)
)
BEGIN
	-- Validar el contenido de _fotografia
	IF _fotografia = '' THEN 
		SET _fotografia = NULL;
	END IF;

	INSERT INTO estudiantes 
	(apellidos, nombres, tipodocumento, nrodocumento, fechanacimiento, idcarrera, idsede, fotografia) VALUES
	(_apellidos, _nombres, _tipodocumento, _nrodocumento, _fechanacimiento, _idcarrera, _idsede, _fotografia);
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_fotografia_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_fotografia_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fotografia_eliminar`(IN idestudiante_ INT)
BEGIN
	SELECT fotografia FROM estudiantes WHERE idestudiante = idestudiante_;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_sedes_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_sedes_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_sedes_listar`()
BEGIN
	SELECT * FROM sedes ORDER BY 2;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_usuarios_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_usuarios_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_eliminar`(IN _idusuario INT)
BEGIN
	UPDATE usuarios
		SET estado = '0' 
		WHERE idusuario = _idusuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_usuarios_login` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_usuarios_login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_login`(IN _nombreusuario VARCHAR(30))
BEGIN	
	SELECT idusuario, nombreusuario, claveacceso,
						apellidos, nombres, nivelacceso
	FROM usuarios
	WHERE nombreusuario = _nombreusuario AND estado = '1';
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_usuarios_mostrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_usuarios_mostrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_mostrar`()
BEGIN
	SELECT 	*
		FROM usuarios
		WHERE estado = '1'
		ORDER BY idusuario DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_usuarios_registrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_usuarios_registrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_registrar`(
	IN _nombreusuario		VARCHAR(30),
	IN _claveacceso			VARCHAR(90),
	IN _apellidos			VARCHAR(30),
	IN _nombres			VARCHAR(30)
)
BEGIN
	INSERT INTO usuarios (nombreusuario, claveacceso, apellidos, nombres) VALUES
				(_nombreusuario, _claveacceso, _apellidos, _nombres);
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
