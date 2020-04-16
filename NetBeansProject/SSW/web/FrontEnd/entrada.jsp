<%-- 
    Document   : foro
    Created on : Apr 9, 2020, 12:48:12 PM
    Author     : pablo y el javgatto
--%>

<%@page import="modelo.Comentario"%>
<%@page import="modelo.DBConnection"%>
<%@page import="modelo.Entrada"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
    <link rel="stylesheet" type="text/css" href="/SSW/FrontEnd/styles.css"><link>
    <link rel="icon" href="/SSW/FrontEnd/img/logo.png">
</head>
<body id="page-top">
    <div id=app></div>
    <header class="masthead">
        <div class="container">
            <div class="intro-class">
                <div class="intro-heading">HealthyBowl</div>
                <div class="intro-lead-in text-uppercase">Dietas a medida</div>
            </div>
        </div>
    </header>
    <jsp:useBean id="comentarios" class="java.util.ArrayList" scope="session">  
    </jsp:useBean>
    <jsp:useBean id="entrada" class="modelo.Entrada" scope="session">  
    </jsp:useBean>
    <%
        String codigoEntrada = request.getParameter("cod");
        ArrayList<Comentario> comentariosTemp = comentarios;
        //entrada = (Entrada)session.getAttribute("entrada");
    %>

    <div class="container rounded" id="cuerpo">

        <div class="row text-center my-3">
            <div class="col"></div>
            <div class="col">
                <a class="coolFont btn w-100" href="./index.html" role="button">INICIO</a>
            </div>
            <div class="col">
                <a class="coolFont btn w-100 actualPage" href="./foro.jsp" role="button">FORO</a>
            </div>
            <div class="col">
                <a class="coolFont btn w-100" href="./ranking.jsp" role="button">TOP DIETAS</a>
            </div>
            <div class="col"></div>
            <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
        </div>
        <br/>

        <h1 class="coolFontParagraph inlineBlock"><%= entrada.getTitulo()%></h1>
        <a class="m-2 btn btn-warning inlineBlock rightAligned" href="./registro.html" role="button">Regístrate</a>
	<a class="m-2 btn btn-primary inlineBlock rightAligned" href="./iniciarSesion.html" role="button">Inicia sesión</a>

        <div class="card my-3" id="entradaEjemplo">
            <div class="m-2">
                <p class="font-weight-bold"><%= entrada.getNombreUsuario()%></p>
                <p>
                    <%= entrada.getCuerpo()%>
                </p>
            </div>
        </div>
        <br/>
        <p>¡Para escribir una respuesta tienes que iniciar sesión!</p>
        <button class="my-3 btn btn-success" disabled type="button" id="addEntrada" data-toggle="collapse" data-target="#collapseForm" aria-expanded="false" aria-controls="collapseForm">
            + Añadir respuesta
	</button>
        <a class="btn-info btn inline-block" href="./foro.jsp" role="button">Volver</a>
        <div class="collapse" id="collapseForm">
            <form class="m-3">
                <input type="text" id="respuesta" class="form-control" placeholder="Respuesta">
                <button id="botonRespuesta" type="submit" class="botonEstandar btn btn-success">Agregar entrada</button>
            </form>
        </div>
        <%
            for(int i = 0; i < comentarios.size(); i++){
        %>
        <div class="card m-3">
            <div class="m-2">
                <p class="font-weight-bold"><%= comentariosTemp.get(i).getNombreUsuario()%></p>
                <p><%= comentariosTemp.get(i).getCuerpo()%></p>
            </div>
        </div>
        <%}%>
        <br/>
    </div>
    <br/>
</body>
</html>
