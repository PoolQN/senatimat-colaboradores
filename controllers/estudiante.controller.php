<?php

require_once '../models/Estudiante.php';

if (isset($_POST['operacion'])){

  $estudiante = new Estudiante();

  if ($_POST['operacion'] == 'registrar'){

    // PASO 1: Recolectar todos los valores enviados
    // por la vista y almacenarlos en un array asociativo
    $datosGuardar = [
      "apellidos"         => $_POST['apellidos'],
      "nombres"           => $_POST['nombres'],
      "tipodocumento"     => $_POST['tipodocumento'],
      "nrodocumento"      => $_POST['nrodocumento'],
      "fechanacimiento"   => $_POST['fechanacimiento'],
      "idcarrera"         => $_POST['idcarrera'],
      "idsede"            => $_POST['idsede'],
      "fotografia"        => ''
    ];

    // Vamos a verificar si la vista nos envio una FOTOGRAFIA
    if (isset($_FILES['fotografia'])){

      $rutaDestino = '../views/img/fotografias/';
      $fechaActual = date('c'); //C = Complete, AÑO MES DIA HORA MINUTO SEGUNDO
      $nombreArchivo = sha1($fechaActual).".jpg";
      $rutaDestino .= $nombreArchivo;

      // Guardamos la fotografia en el servidor
      if (move_uploaded_file($_FILES['fotografia']['tmp_name'], $rutaDestino)){
        $datosGuardar['fotografia'] = $nombreArchivo;
      }

    }

    // PASO 2: Enviar el array al metodo registrar
    $estudiante->registrarEstudiante($datosGuardar);

  }

  if ($_POST['operacion'] == 'listar'){
    $data = $estudiante->listarEstudiantes();

    if ($data){
      $numeroFila = 1;
      $datosEstudiante = '';
      $botonFoto = "  <a href='#' class='btn btn-sm btn-secondary' title='No tiene fotografia'><i class='bi bi-eye-slash-fill'></i></a>";

      foreach($data as $registro){
        $datosEstudiante = $registro['apellidos'] . ' ' . $registro['nombres'];

        // La primera parte a RENDERIZAR, es lo standar (siempre se muestra)
        echo"
          <tr>
            <td>{$numeroFila}</td>
            <td>{$registro['apellidos']}</td>
            <td>{$registro['nombres']}</td>
            <td>{$registro['tipodocumento']}</td>
            <td>{$registro['nrodocumento']}</td>
            <td>{$registro['fechanacimiento']}</td>
            <td>{$registro['carrera']}</td>
            <td>
              <a href='#' data-idestudiante='{$registro['idestudiante']}' class='btn btn-danger btn-sm eliminar'><i class='bi bi-trash3'></i></a>
              <a href='#' data-idestudiante='{$registro['idestudiante']}' class='btn btn-warning btn-sm editar'><i class='bi bi-pencil-square'></i></a>";

        // La segunda parte a RENDERIZAR, es el boton VER FOTOGRAFIA
        if ($registro['fotografia'] == ''){
          echo $botonFoto;
        }else{
          echo "  <a href='../views/img/fotografias/{$registro['fotografia']}' data-lightbox='{$registro['idestudiante']}' data-title='{$datosEstudiante}' class='btn btn-primary btn-sm'><i class='bi bi-eye-fill'></i></a>";
        }

        // La tercera parte a RENDERIZAR, cierre 
        echo "
            </td>
          </td>
        ";

        $numeroFila++;
      }
    }
  } // FIN OPERACION = LISTAR

  if ($_POST['operacion'] == 'eliminar'){
    $estudiante->eliminarEstudiante($_POST['idestudiante']);
  }


  if ($_POST['operacion'] == 'eliminarFotografia'){
    $registro = $estudiante->eliminarFotografia($_POST['idestudiante']);
      
    if($registro == null ){
      echo"No hay imagen a Eliminar";
    }else{
      unlink("../views/img/fotografias/{$registro['fotografia']}");
    }
    
  }


}