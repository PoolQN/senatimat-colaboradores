<?php

require_once 'Conexion.php';

class Colaboradores extends Conexion{
  private $accesoBD;

  public function __CONSTRUCT(){
    $this->accesoBD = parent::getConexion();
  }

  public function registrarColaboradores($datos = []){
    try{
      $consulta = $this->accesoBD->prepare("CALL spu_colaboradores_registrar(?,?,?,?,?,?,?,?)");    
      $consulta->execute(
        array(
          $datos['apellidos'],
          $datos['nombres'],
          $datos['idcargo'],
          $datos['idsede'],
          $datos['telefono'],
          $datos['tipocontrato'],
          $datos['cv'],
          $datos['direccion']
        )
        );
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function ListarColaboradores(){
    try{
      $consulta = $this->accesoBD->prepare("CALL spu_colaboradores_listar()");
      $consulta->execute();

      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function eliminarColaboradores($idcolaborador = 0){
    try{
      $consulta = $this->accesoBD->prepare("CALL spu_colaboradores_eliminar(?)");
      $consulta->execute(array($idcolaborador));
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }
  
  public function eliminarCv($idcolaborador=0){
    try {
      $consulta = $this->accesoBD->prepare("CALL spu_cv_eliminar(?)");
      $consulta->execute(array($idcolaborador));

      return $consulta->fetch(PDO::FETCH_ASSOC);

    } catch (Exception $e) {
        die($e->getMessage());
    }
  }
}