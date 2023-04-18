<?php

require_once '../models/Colaboradores.php';

if (isset($_POST['operacion'])){

  $estudiante = new Colaboradores();

  if ($_POST['operacion'] == 'registrar'){

    //PASO 1: Recolectar todos los valores enviados
    //por la vista y almacenarlos en un array asociativo
    $datosGuardar = [
      "apellidos"     => $_POST['apellidos'],
      "nombres"       => $_POST['nombres'],
      "idcargo"       => $_POST['idcargo'],
      "nrodocumento"  => $_POST['nrodocumento'],
      "idsede"        => $_POST['idsede'],
      "telefono"      => $_POST['telefono'],
      "tipocontrato"  => $_POST['tipocontrato'],
      "direccion"     => $_POST['direccion'],
      "cv"            => ''
    ];

    //Vamos a verificar si la vista nos envió una FOTOGRAFIA
    if (isset($_FILES['cv'])){

      $rutaDestino = '../views/Doc/pdf/'; //Carpeta
      $fechaActual = date('c'); //C = Complete, AÑO/MES/DIA/HORA/MINUTO/SEGUNDO
      $nombreArchivo = sha1($fechaActual) . ".pdf";
      $rutaDestino .= $nombreArchivo;

      //Guardamos la fotografía en el servidor
      if (move_uploaded_file($_FILES['cv']['tmp_name'], $rutaDestino)){
        $datosGuardar['cv'] = $nombreArchivo;
      }

    }

    //PASO 2: Enviar el array al método registrar
    $estudiante->registrarColaboradores($datosGuardar);

  }

  if ($_POST['operacion'] == 'listar'){
    $data = $estudiante->ListarColaboradores();

    if ($data){
      $numeroFila = 1;
      $datosEstudiante = '';
      $botonNulo = " <a href='#' class='btn btn-sm btn-warning' title='No tiene fotografía'><i class='bi bi-eye-slash-fill'></i></a>";
      
      foreach($data as $registro){
        $datosEstudiante = $registro['apellidos'] . ' ' . $registro['nombres'];

        //La primera parte a RENDERIZAR, es lo standard (siempre se muestra)
        echo "
          <tr>
            <td>{$numeroFila}</td>
            <td>{$registro['apellidos']}</td>
            <td>{$registro['nombres']}</td>
            <td>{$registro['cargo']}</td>
            <td>{$registro['sede']}</td>
            <td>{$registro['telefono']}</td>
            <td>{$registro['tipocontrato']}</td>
            <td>{$registro['direccion']}</td>
            <td>
              <a href='#' class='btn btn-sm btn-danger'><i class='bi bi-trash3'></i></a>
              <a href='#' class='btn btn-sm btn-info'><i class='bi bi-pencil-fill'></i></a>";
        
        //La segunda parte a RENDERIZAR, es el botón VER FOTOGRAFÍA
        if ($registro['cv'] == ''){
          echo $botonNulo;
        }else{
          echo " <a href='../views/Doc/pdf/{$registro['cv']}' data-lightbox='{$registro['idcolaborador']}' data-title='{$datosEstudiante}' class='btn btn-sm btn-warning'><i class='bi bi-eye-fill'></i></a>";
        }

        //La tercera parte a RENDERIZAR, cierre de la fila
        echo "
            </td>
          </tr>
        ";


        $numeroFila++;
      }
    }
  } //Fin operacion=listar

}