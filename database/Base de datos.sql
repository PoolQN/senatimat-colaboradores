CREATE DATABASE senatimat;
USE senatimat;

CREATE TABLE escuelas
(
	idescuela 		INT AUTO_INCREMENT PRIMARY KEY,
	escuela 			VARCHAR(50) 	NOT NULL,
	CONSTRAINT uk_escuela_esc UNIQUE (escuela)
)ENGINE = INNODB;

INSERT INTO escuelas (escuela) VALUES
	('ETI'), -- 1
	('Administración'), -- 2
	('Metal mecánica'); -- 3

SELECT * FROM escuelas ORDER BY 1;

-- Agregando una nueva escuela
INSERT INTO escuelas (escuela) VALUES
	('Gastronomía');

-- ***** SEGUNDA TABLA ***** --

CREATE TABLE carreras
(
	idcarrera 		INT AUTO_INCREMENT PRIMARY KEY,
	idescuela 		INT 			NOT NULL,
	carrera 			VARCHAR(100)NOT NULL,
	CONSTRAINT fk_idescuela_car FOREIGN KEY (idescuela) REFERENCES escuelas (idescuela),
	CONSTRAINT uk_carrera_car UNIQUE (carrera)
)ENGINE = INNODB;

INSERT INTO carreras (idescuela, carrera) VALUES
	(1, 'Diseño Gráfico Digital'),
	(1, 'Ingeniería de Software con IA'),
	(1, 'Cyberseguridad'),
	(2, 'Administración de empresas'),
	(2, 'Administración Industrial'),
	(2, 'Prevencionista de Riesgo'),
	(3, 'Soldador Universal'),
	(3, 'Mecánico de mantenimiento'),
	(3, 'Soldador estructuras metálicas');

SELECT * FROM carreras ORDER BY 1;

-- ****** TERCERA TABLA ******* --
CREATE TABLE sedes
(
	idsede 		INT AUTO_INCREMENT PRIMARY KEY,
	sede 			VARCHAR(40)		NOT NULL,
	CONSTRAINT uk_sede_sde UNIQUE (sede)
)ENGINE = INNODB;

INSERT INTO sedes (sede) VALUES
	('Chincha'),
	('Pisco'),
	('Ica'),
	('Ayacucho');

SELECT * FROM sedes ORDER BY 1;

-- ******* CUARTA TABLA ********* --
CREATE TABLE estudiantes
(
	idestudiante 		INT AUTO_INCREMENT PRIMARY KEY,
	apellidos			VARCHAR(40)		NOT NULL,
	nombres 				VARCHAR(40)		NOT NULL,
	tipodocumento 		CHAR(1)			NOT NULL DEFAULT 'D',
	nrodocumento		CHAR(8)			NOT NULL,
	fechanacimiento	DATE 				NOT NULL,
	idcarrera 			INT 				NOT NULL,
	idsede 				INT 				NOT NULL,
	fotografia 			VARCHAR(100)	NULL,
	fecharegistro		DATETIME 		NOT NULL DEFAULT NOW(),
	fechaupdate 		DATETIME 		NULL,
	estado 				CHAR(1)			NOT NULL DEFAULT '1',
	CONSTRAINT uk_nrodocumento_est UNIQUE (tipodocumento, nrodocumento),
	CONSTRAINT fk_idcarrera_est FOREIGN KEY (idcarrera) REFERENCES carreras (idcarrera),
	CONSTRAINT fk_idsede_est FOREIGN KEY (idsede) REFERENCES sedes (idsede)
)ENGINE = INNODB;

INSERT INTO estudiantes 
	(apellidos, nombres, nrodocumento, fechanacimiento, idcarrera, idsede) VALUES
	('Martinez', 'Carlos', '44445555', '2000-01-01', 1, 1),
	('Ochoa', 'Fiorella', '77778888', '2000-10-10', 4, 2),
	('Perez', 'Roxana', '88881111', '2001-03-03', 7, 3),
	('Quintana', 'Tania', '33334444', '2001-05-05', 9, 4);

SELECT * FROM estudiantes;

-- QUINTA TABLA --

CREATE TABLE cargos 
(
	idcargo 		INT AUTO_INCREMENT PRIMARY KEY,
	cargo			VARCHAR(40)		NOT NULL
	
)ENGINE = INNODB;


DROP TABLE colaboradores
CREATE TABLE colaboradores
(
	idcolaborador		INT AUTO_INCREMENT PRIMARY KEY,
	apellidos				VARCHAR(40)		NOT NULL,
	nombres					VARCHAR(40)		NOT NULL,
	idcargo					INT 				NOT NULL,
	idsede					INT 				NOT NULL,
	telefono					CHAR(9)			NOT NULL,
	tipocontrato			CHAR(1)			NOT NULL,
	cv							VARCHAR(100) 	NULL,
	direccion				VARCHAR(40)  	NOT NULL,
	fecharegistro			DATETIME			NOT NULL DEFAULT NOW(),
	fechaupdate				DATETIME			NULL,
	estado					CHAR(1)			NOT NULL DEFAULT '1',
	CONSTRAINT fk_idcargo_car FOREIGN KEY (idcargo) REFERENCES cargos (idcargo),
	CONSTRAINT fk_idsede_car FOREIGN KEY (idsede) REFERENCES sedes (idsede)
)ENGINE = INNODB;

INSERT INTO colaboradores
(apellidos, nombres, idcargo, idsede, telefono, tipocontrato, direccion) VALUES
('Quispe', 'Roger', 1, 1, '958623742', 'C', 'Calle Pilpa');

SELECT * FROM colaboradores;
SELECT * FROM sedes;
SELECT * FROM cargos;

INSERT INTO cargos (cargo) VALUES
('Instructor'),
('Jefe Centro'),
('Asist. Administrativo'),
('Asist. Academico'),
('Coordinador ETIA'),
('Coordinador CIS');

CREATE TABLE usuarios
(
	idusuario			INT AUTO_INCREMENT PRIMARY KEY,
	nombreusuario		VARCHAR(30)			NOT NULL,
	claveacceso			VARCHAR(90)			NOT NULL,
	apellidos			VARCHAR(30)			NOT NULL,
	nombres				VARCHAR(30)			NOT NULL,
	nivelacceso			CHAR(1)				NOT NULL DEFAULT 'A',
	estado				CHAR(1)				NOT NULL DEFAULT '1',
	fecharegistro		DATETIME				NOT NULL DEFAULT NOW(),
	fechaupdate 		DATETIME 			NULL,
	CONSTRAINT uk_nombreusuario_usa UNIQUE (nombreusuario)
)ENGINE = INNODB;

INSERT INTO usuarios (nombreusuario, claveacceso, apellidos, nombres) VALUES
	('POOL', '123456', 'Quesada Nolasco', 'Pool'),
	('JOSE', '123456', 'Marcos Perez', 'Jose');
	
SELECT * FROM nombreusuario;

-- Actualizando por la clave incriptada
-- Defecto: SENATI
UPDATE usuarios SET
claveacceso = '$2y$10$HRK9czgpbr9vyIPJMl2R0Ob7pMontFy5NdSn0Jdhy1kksMYNsy4LG'
WHERE idusuario = 1;

UPDATE usuarios SET
claveacceso = '$2y$10$qWHt2TJCxtXdEyAQPP/Jde0GmwuN3PgIwogvUTPt5FSD.ygWGIzRK'
WHERE idusuario = 2;

SELECT * FROM usuarios;

