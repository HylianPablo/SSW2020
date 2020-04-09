<%-- 
    Document   : foro
    Created on : Apr 9, 2020, 12:48:12 PM
    Author     : pablo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthyBowl</title>
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
				<a class="coolFont btn w-100" href="./paginaUsuario.html" role="button">INICIO</a>
			</div>
			<div class="col">
				<a class="coolFont btn w-100 actualPage" href="./foroUsuario.html" role="button">FORO</a>
			</div>
			<div class="col">
				<a class="oneLine coolFont btn w-100" href="./rankingUsuario.html" role="button">TOP DIETAS</a>
			</div>
            <div class="col">
				<a class="coolFont btn w-100" href="./perfil.html" role="button">MI PERFIL</a>
			</div>
			<div class="col"></div>
			<hr style="width: 100%; color: black; height: 1px; background-color:black;" />
		</div>
		<br/>
		
        <h1 class="h1Size coolFontParagraph inlineBlock">Foro principal</h1>
        <jsp:useBean id="entrada" scope="session" class="data.Entrada"/>
        <a class="btn btn-warning inlineBlock rightAligned" href="./index.html" role="button">Cerrar sesión</a>
        <br/>
        <hr/>
        <button class="botonEstandar btn btn-success botonesEntrada my-3" onclick="window.location.href='nuevaEntrada.html';">Agregar nueva entrada</button>

        <div class="card my-3">
            <div class="mx-3 mt-3 entradaForoTitulo">
                La dieta mediterránea es genial.
                <button class="botonEstandar btn btn-success botonesEntrada" onclick="window.location.href='entradaUsuario.html';">Ir al hilo</button>
                <button class="botonEstandar btn btn-success botonesEntrada" onclick="mostrarMas()" id="myBtn">Leer más</button>
                <hr/>
            </div>
            <div class="mx-3" id="entradaEjemplo">
                <p>
                    Desayunar pan con aceite y tomate regula la circulación sanguínea.
                    <span class="dots" id="dots">...</span>
                    <span class="more" id="more">
La Dieta Mediterránea es una valiosa herencia cultural que representa mucho más que una simple pauta nutricional, rica y saludable. Es un estilo de vida equilibrado que recoge recetas, formas de cocinar, celebraciones, costumbres, productos típicos y actividades humanas diversas.

Entre las muchas propiedades beneficiosas para la salud de este patrón alimentario se puede destacar el tipo de grasa que lo caracteriza (aceite de oliva, pescado y frutos secos), las proporciones en los nutrientes principales que guardan sus recetas (cereales y vegetales como base de los platos y carnes o similares como “guarnición”) y la riqueza en micronutrientes que contiene, fruto de la utilización de verduras de temporada, hierbas aromáticas y condimentos.

Así lo reconoció y celebró la UNESCO inscribiendo la Dieta Mediterránea como uno de los elementos de la Lista Representativa del Patrimonio Cultural Inmaterial de la Humanidad.
La alimentación saludable que nos proporciona la Dieta Mediterránea es perfectamente compatible con el placer de degustar sabrosos platos.

					</span>
                </p>
            </div>
        </div>
        <br/>
        
        <div class="card my-3">
            <div class="mx-3 mt-3 entradaForoTitulo">
                <jsp:getProperty name="entrada" property="titulo"/>
                <button class="botonEstandar btn btn-success botonesEntrada" onclick="window.location.href='entradaUsuario.html';">Ir al hilo</button>
                <button class="botonEstandar btn btn-success botonesEntrada" onclick="mostrarMas()" id="myBtn">Leer más</button>
                <hr/>
            </div>
            <div class="mx-3" id="entradaEjemplo">
                <p>
                    Texto pequeño.
                    <span class="dots" id="dots">...</span>
                    <span class="more" id="more">
                        <jsp:getProperty name="entrada" property="cuerpo"/>
                    </span>
                </p>
            </div>
        </div>
        <br/>

        <script>
            function mostrarMas() {
                var dots = document.getElementById("dots");
                var moreText = document.getElementById("more");
                var btnText = document.getElementById("myBtn");

                if (dots.style.display === "none") {
                    dots.style.display = "inline";
                    btnText.innerHTML = "Leer más";
                    moreText.style.display = "none";
                } else {
                    dots.style.display = "none";
                    btnText.innerHTML = "Leer menos";
                    moreText.style.display = "inline";
                }
            }
        </script>
    </div>
    <br/>
</body>
</html>
