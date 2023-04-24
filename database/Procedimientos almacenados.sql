USE senatimat;

DELIMITER $$
CREATE PROCEDURE spu_estudiantes_listar()
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
END $$

CALL spu_estudiantes_listar();

DELIMITER $$
CREATE PROCEDURE spu_estudiantes_registrar
(
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
END $$

/*
CALL spu_estudiantes_registrar('Francia Minaya', 'Jhon', 'D', '12345678', '1984-09-20', 5, 1, '');
CALL spu_estudiantes_registrar('Munayco', 'José', 'D', '77779999', '1999-09-20', 3, 2, NULL);
CALL spu_estudiantes_registrar('Prada', 'Teresa', 'C', '01234567', '2002-09-25', 3, 2, '');
SELECT * FROM estudiantes;
*/

-- Proceso Eliminar 
DELIMITER $$
CREATE PROCEDURE spu_estudiantes_eliminar(IN idestudiante_ INT)
BEGIN
	DELETE FROM estudiantes
	WHERE idestudiante = idestudiante_;
END $$

CALL spu_estudiantes_eliminar(4)

DELIMITER$$
CREATE PROCEDURE spu_fotografia_eliminar(IN idestudiante_ INT)
BEGIN
	SELECT fotografia FROM estudiantes WHERE idestudiante = idestudiante_;
END$$

CALL spu_fotografia_eliminar(5)
CALL spu_estudiantes_listar
	

DELIMITER $$
CREATE PROCEDURE spu_cargos_listar()
BEGIN
	SELECT * FROM cargos ORDER BY 2;
END $$

DELIMITER $$
CREATE PROCEDURE spu_sedes_listar()
BEGIN
	SELECT * FROM sedes ORDER BY 2;
END $$


DELIMITER $$
CREATE PROCEDURE spu_escuelas_listar()
BEGIN 
	SELECT * FROM escuelas ORDER BY 2;
END $$

DELIMITER $$
CREATE PROCEDURE spu_carreras_listar(IN _idescuela INT)
BEGIN
	SELECT idcarrera, carrera 
		FROM carreras
		WHERE idescuela = _idescuela;
END $$

CALL spu_carreras_listar(3);


-- Tabla listar Colaboradores --
DELIMITER $$
CREATE PROCEDURE spu_colaboradores_listar()
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
END $$

CALL spu_colaboradores_listar;

-- Proceso Registrar --
DELIMITER $$
CREATE PROCEDURE spu_colaboradores_registrar
(
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
END $$

CALL spu_colaboradores_registrar('Munayco', 'José',1 ,1 ,'977779999' , 'C', "", "Calle Lima");
SELECT * FROM colaboradores;


DELIMITER $$
CREATE PROCEDURE spu_colaboradores_eliminar(IN idcolaborador_ INT)
BEGIN
	DELETE FROM colaboradores
	WHERE idcolaborador = idcolaborador_;
END $$

CALL spu_colaboradores_eliminar(4)

DELIMITER$$
CREATE PROCEDURE spu_cv_eliminar(IN idcolaborador_ INT)
BEGIN
	SELECT cv FROM colaboradores WHERE idcolaborador = idcolaborador_;
END$$

CALL spu_cv_eliminar(7)
CALL spu_colaboradores_listar



-- LOGIN --
DELIMITER $$
CREATE PROCEDURE spu_usuarios_login(IN _nombreusuario VARCHAR(30))
BEGIN	
	SELECT idusuario, nombreusuario, claveacceso,
						apellidos, nombres, nivelacceso
	FROM usuarios
	WHERE nombreusuario = _nombreusuario AND estado = '1';
END $$
	
CALL spu_usuarios_login('POOL');

-- Registrar usuario
DELIMITER $$
CREATE PROCEDURE spu_usuarios_registrar
(
	IN _nombreusuario		VARCHAR(30),
	IN _claveacceso			VARCHAR(90),
	IN _apellidos			VARCHAR(30),
	IN _nombres			VARCHAR(30)
)
BEGIN
	INSERT INTO usuarios (nombreusuario, claveacceso, apellidos, nombres) VALUES
				(_nombreusuario, _claveacceso, _apellidos, _nombres);
END $$

CALL spu_usuarios_registrar('PEDRO', '789456', 'Perez Gomez','Raul');
CALL spu_usuarios_registrar('LUIS', '147852', 'Campos Bautista','Luis');


-- Mostrar Usuarios
DELIMITER $$
CREATE PROCEDURE spu_usuarios_mostrar()
BEGIN
	SELECT 	*
		FROM usuarios
		WHERE estado = '1'
		ORDER BY idusuario DESC;
END $$

CALL spu_usuarios_mostrar()

-- Eliminar Usuarios
DELIMITER $$
CREATE PROCEDURE spu_usuarios_eliminar(IN _idusuario INT)
BEGIN
	UPDATE usuarios
		SET estado = '0' 
		WHERE idusuario = _idusuario;
END $$

CALL spu_usuarios_eliminar(3);
SELECT * FROM usuarios;

