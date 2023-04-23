<!doctype html>
<html lang="es">

<head>
  <title>Title</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

<!--Icono de Bootstrap-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.4/font/bootstrap-icons.css">
    

</head>

<body>
  
<div class="container mt-3">
    <div class="card">
      <div class="card-header bg-primary text-light">
        <div class="row">
          <div class="col-md-6">
            <strong>LISTA DE COLABORADORES</strong>
          </div>
          <div class="col-md-6 text-end">
            <button class="btn btn-success btn-sm" id="abrir-modal" data-bs-toggle="modal" data-bs-target="#modal-colaboradores"><i class="bi bi-plus-circle"></i> Agregar Curso</button>
          </div>
        </div>
      </div>
      <div class="card-body">
        <table class="table table-sm table-striped" id="tabla-colaboradores">
          <thead>
            <tr>
              <th>#</th>
              <th>Apellidos</th>
              <th>Nombres</th>
              <th>Cargo</th>
              <th>Sede</th>
              <th>Telefono</th>
              <th>Contrato</th>
              <th>Direccion</th>
              <th>Operaciones</th>
            </tr>
          </thead>
          <tbody>

          </tbody>
        </table>
      </div>
      <div class="card-footer text-end">
        <button class="btn btn-primary btn-sm" id="guardar">Actualizar Datos</button>
      </div>
    </div>
  </div>  <!--Fin del container-->

  <!--Zona Modales-->
  <!-- Modal trigger button -->
  
  <!-- Modal Body -->
  <!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
  <div class="modal fade" id="modal-colaboradores" tabindex="-1" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header bg-secondary text-light">
          <h5 class="modal-title" id="modalTitleId">Registro de Colaboradores</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form action="" autocomplete="off" id="formulario-colaboradores" enctype="multipart/form-data">
            <div class="row">
              <div class="mb-3 col-md-6">
                <label for="apellidos" class="form-label">Apellidos:</label>
                <input type="text" class="form-control form-control-sm" id="apellidos">
              </div>
              <div class="mb-3 col-md-6">
                <label for="nombres" class="form-label">Nombres:</label>
                <input type="text" class="form-control form-control-sm" id="nombres">
              </div>
            </div>
            <div class="row">
              <div class="mb-3 col-md-6">
                <label for="cargo" class="form-label">Cargo:</label>
                <select name="cargo" id="cargo" class="form-select form-select-sm">
                  <option value="">Seleccione</option>
                </select>
              </div>
              <div class="mb-3 col-md-6">
                <label for="sede" class="form-label">Sede:</label>
                <select name="sede" id="sede" class="form-select form-select-sm">
                  <option value="">Seleccione</option>
                </select>
              </div>
            </div>
            <div class="row">
              <div class="mb-3 col-md-6">
                <label for="telefono" class="form-label">Telefono:</label>
                <input type="text" class="form-control form-control-sm" id="telefono">
              </div>
              <div class="mb-3 col-md-6">
                <label for="contrato" class="form-label">Contrato:</label>
                <input type="text" class="form-control form-control-sm" id="Contrato">
              </div>
            </div>
            <div class="row">
              <div class="mb-3 col-md-6">
                <label for="direccion" class="form-label">Dirección:</label>
                <input type="text" class="form-control form-control-sm" id="direccion">
              </div>
            </div>

            <div class="mb-3">
              <label for="cv">CV:</label>
              <input type="file" id="cv" accept=".pdf" class="form-control form-control-sm">
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancelar</button>
          <button type="button" class="btn btn-primary btn-sm" id="guardar-colaboradores">Guardar</button>
        </div>
      </div>
    </div>
  </div>
  
  
  <!--Fin zona Modales-->


  <!-- Bootstrap JavaScript Libraries -->
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
    integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous">
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
    integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous">
  </script>

  <!-- jQuery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

  <!-- SweetAlert2 -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  <!-- Lightbox JS -->
  <script src="../dist/lightbox2/src/js/lightbox.js"></script>

  <script>
    $(document).ready(function (){
      function obtenerSedes(){
        $.ajax({
          url: '../controllers/sede.controller.php',
          type: 'POST',
          data: {operacion: 'listar'},
          dataType: 'text',
          success: function(result){
            $("#sede").html(result);
          }
        });
      }


      function obtenerCargo(){
        $.ajax({
          url: '../controllers/cargo.php',
          type: 'POST',
          data: {operacion: 'listar'},
          dataType: 'text',
          success: function(result){
            $("#cargo").html(result);
          }
        });
      }

      function mostrarColaboradores(){
        $.ajax({
          url:    '../controllers/colaboradores.controller.php',
          type:   'POST',
          data:   {operacion:   'listar'},
          dataType: 'text',
          success:function(result){
            $("#tabla-colaboradores tbody").html(result);
          }
        });
      }

      function registrarColaboradores(){
        //Enviaremos los datos dentro de un OBJETO
        var formData = new FormData();

        formData.append("operacion", "registrar");
        formData.append("apellidos", $("#apellidos").val());
        formData.append("nombres", $("#nombres").val());
        formData.append("idcargo", $("#cargo").val());
        formData.append("idsede", $("#sede").val());
        formData.append("telefono", $("#telefono").val());
        formData.append("tipocontrato", $("#tipocontrato").val());
        formData.append("direccion", $("#direccion").val());
        formData.append("cv", $("#cv")[0].files[0]);

        $.ajax({
          url: '../controllers/colaboradores.controller.php',
          type: 'POST',
          data: formData,
          contentType: false,
          processData: false,
          cache: false,
          success: function(){
            $("#formulario-colaboradores")[0].reset();
            $("#modal-colaboradores").modal("hide");
            alert("Guardado correctamente");
          }
        });
      }

      function preguntarRegistro(){
        Swal.fire({
          icon: 'question',
          title: 'COLABORADORES',
          text: '¿Está seguro de registrar al Colaborador?',
          footer: 'Ingresando Colaborador',
          confirmButtonText: 'Aceptar',
          confirmButtonColor: '#3498DB',
          showCancelButton: true,
          cancelButtonText: 'Cancelar'
        }).then((result) => {
          //Identificando acción del usuario
          if (result.isConfirmed){
            registrarColaboradores();
          }
        });
      }


      $("#guardar-colaboradores").click(preguntarRegistro);

      // Control Inicio
      $("#modal-colaboradores").on("shown.bs.modal", event => {
        $("#apellidos").focus();
        
        obtenerSedes();
        obtenerCargo();
      });


      $("#tabla-colaboradores tbody").on("click", ".eliminar", function(){
        const cvEliminar = $(this).data("idcolaborador");
          $.ajax({
            url: '../controllers/colaboradores.controller.php',
            type: 'POST',
            data: {
              operacion : 'eliminarcv',
              idcolaborador   : cvEliminar
            },
            success: function(result){
              if (result == ""){
                ListarColaboradores();
              }
            }
          });
      });

      $("#tabla-colaboradores tbody").on("click", ".eliminar", function(){
        const idcolaboradorEliminar = $(this).data("idcolaborador");
        Swal.fire({
          title: "¿Está seguro?",
          text: "Esto eliminará el registro del Estudiante",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "Eliminar"
        }).then((result) => {
          if (result.isConfirmed) {
            $.ajax({
              url: '../controllers/colaboradores.controller.php',
              type: 'POST',
              data: {
                operacion : 'eliminar',
                idcolaborador   : idcolaboradorEliminar
              },
              success: function(result){
                if (result == ""){
                  ListarColaboradores();
                }
              }
            });
          };
        }); 
      });


      //Funciones de carga automática
      mostrarColaboradores();

      
    });

    
    
    
      

    
  </script>
</body>

</html>