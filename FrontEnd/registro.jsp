<%-- 
    Document   : iniciarSesion
    Created on : Apr 14, 2020, 12:44:53 PM
    Author     : alejandro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>HealthyBowl</title>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <link rel="icon" href="img/logo.png">
	
</head>

<body id="page-top">
    <div id=app></div>
    <!--Banner-->
    <header class="masthead">
        <div class="container">
            <div class="intro-class">
                <div class="intro-heading">HealthyBowl</div>
                <div class="intro-lead-in">Dietas a medida</div>
            </div>
        </div>
    </header>


    <div class="container rounded" id="cuerpo">
        <div class="row text-center my-3">
            <div class="col"></div>
            <div class="col">
                <a class="coolFont btn w-100" href="./index" role="button">INICIO</a>
            </div>
            <div class="col">
                <a class="coolFont btn w-100" href="./foro" role="button">FORO</a>
            </div>
            <div class="col">
                <a class="coolFont btn w-100" href="./ranking" role="button">TOP DIETAS</a>
            </div>
            <div class="col"></div>
            <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
        </div>
        <br/>

        <h1 class="h1Size coolFontParagraph center">Registro</h1>
		<br/>   
		<hr/>
                <h2 class="coolFontParagraph selfmadeCenter">¡En proceso de implementación!</h2>
        <div class="container" id="cuadroPerfil">
            <div class="m-3">
                
                <form role="form">
                    <div class="form-group w-70">
                        <label for="usuario">Usuario (*):</label>
                        <input type="text" class="form-control" placeholder="--obligatorio--">
                    </div>
                    <div class="form-group w-70">
                        <label for="password">Contraseña (*):</label>
                        <input type="password" id="password" class="form-control" placeholder="--obligatorio--">
                    </div>
                    <div class="form-group w-70">
                        <label for="npassword">Repita la contraseña (*):</label>
                        <input type="password" id="npassword" class="form-control" placeholder="--obligatorio--">
                    </div>
                    <div class="form-group w-70">
                        <label for="correo">Correo (*):</label>
                        <input type="text" id="correo" class="form-control" placeholder="--obligatorio--">
                    </div>
                    <div class="form-group">
                        <label for="archivo">Adjuntar una imagen para tu perfil:</label>
                        </br>
                        <input type="file" id="imagen">
                    </div>
					<p>Los campos marcados con (*) son obligatorios.</p>
                    <div class="contenedor text-center">
                        <button id="guardar" type="button" class="btn btn-primary btn-lg" onclick="window.location.href='iniciarSesion';">Enviar</button>
                    </div>
                </form>
            </div>
        </div>
		<br/>
    </div>
	<br/>
</body>

</html>
