<%-- 
    Document   : foro
    Created on : Apr 9, 2020, 12:48:12 PM
    Author     : pablo y el javgatto
--%>

<%@page import="data.DBConnection"%>
<%@page import="data.Entrada"%>
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
                <a class="coolFont btn w-100 actualPage" href="./foroUsuario.jsp" role="button">FORO</a>
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

        <a class="btn btn-warning inlineBlock rightAligned" href="./index.html" role="button">Cerrar sesión</a>
        <br/>
        <hr/>
        <button class="botonEstandar btn btn-success botonesEntrada my-3" onclick="window.location.href = '/SSW/FrontEnd/nuevaEntrada.html';">Agregar nueva entrada</button>
        <%
            ArrayList<Entrada> entradas = DBConnection.getAllEntradas();
            for (int i = 0; i < entradas.size(); i++) {
        %>

        <div class="card my-3">
            <div class="mx-3 mt-3 entradaForoTitulo">
                <%= entradas.get(i).getTitulo()%>
                <form action="entradaUsuario.jsp" class="d-inline-block">
                    <input name="cod" type="hidden" value="<%= entradas.get(i).getCodigoEntrada()%>"/>
                    <button class="botonEstandar btn btn-success botonesEntrada" type="submit">Ir al hilo</button>
                </form>
                <%
                        String cuerpo = entradas.get(i).getCuerpo();
                        if (cuerpo == null) {
                            cuerpo = "";
                        }
                        String[] palabras = cuerpo.split("([ ]|\n)");
                        String palabrasPre = "", palabrasPost = "";
                        int NMAX = 10;
                        for (int j = 0; (j < NMAX) && (j < palabras.length); j++) {
                            palabrasPre = palabrasPre + palabras[j] + " ";
                        }
                        for (int j = NMAX; j < palabras.length; j++) {
                            palabrasPost = palabrasPost + palabras[j] + " ";
                        }
                        if(palabras.length>NMAX){
                %>
                <button class="botonEstandar btn btn-success botonesEntrada" onclick="mostrarMas(<%=i%>)" id="leerMas<%=i%>">Leer más</button>
                <%}%>
                <hr/>
            </div>
            <div class="mx-3" id="entrada<%=i%>">
                <p>
                    <%= palabrasPre%>
                    <span class="dots" id="dots<%=i%>"><%if(palabras.length>NMAX){%>...<%}%></span>
                    <span class="more" id="more<%=i%>">
                        <%= palabrasPost%>
                    </span>
                </p>
            </div>
        </div>
        <br/>
        <%}%>

        <script>
            function mostrarMas(i) {
                var dots = document.getElementById("dots" + i);
                var moreText = document.getElementById("more" + i);
                var btnText = document.getElementById("leerMas" + i);

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
