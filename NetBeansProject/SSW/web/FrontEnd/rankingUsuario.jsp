<%-- 
    Document   : foro
    Created on : Apr 9, 2020, 12:48:12 PM
    Author     : pablo y el javgatto
--%>

<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="modelo.Dieta"%>
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
                    <a class="oneLine coolFont btn w-100 actualPage" href="./ranking" role="button">TOP DIETAS</a>
                </div>
                <div class="col">
                    <a class="coolFont btn w-100" href="./perfil" role="button">MI PERFIL</a>
                </div>
                <div class="col"></div>
                <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
            </div>
            <br/>
            <h1 class="h1Size coolFontParagraph inlineBlock">Top dietas</h1>
            <a class="btn btn-warning inlineBlock rightAligned" href="./index" role="button">Cerrar sesión</a>
            <hr/>

            <jsp:useBean id="favoritas" class="java.lang.String" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="siempre" class="java.lang.String" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="fechaLimite" class="java.lang.String" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="selectTiempo" class="java.lang.String" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="tiempo" class="java.lang.String" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="dietas" class="java.util.ArrayList" scope="session">  
            </jsp:useBean>
            <%
                boolean favoritasTemp = Boolean.parseBoolean(favoritas);
                boolean siempreTemp = Boolean.parseBoolean(siempre);
                int selectTiempoTemp = Integer.parseInt(selectTiempo);
                ArrayList<Dieta> dietasTemp = dietas;
                LocalDateTime fechaLimiteTemp = LocalDateTime.parse(fechaLimite);
            %>
            <form action="./rankingUsuario">
                <div class="row mb-5">
                    <div class="col">
                        <div class="row">
                            <div class="col">
                                <h5 class="inlineBlock">Ordenar por:</h5>
                                <select class="inlineBlock botonEstandar btn btn-secondary" name="criterio" onchange="this.form.submit();">
                                    <option <%if (!favoritasTemp) {%>selected<%}%>>Guardadas</option>
                                    <option <%if (favoritasTemp) {%>selected<%}%>>Favoritas</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col"></div>

                    <div class="col">
                        <div class="inlineBlock row">
                            <div class="col">
                                <h5 class="oneLine inlineBlock">Fecha de creación: </h5>
                                <select class="inlineBlock botonEstandar btn btn-secondary" name="tiempo" onchange="this.form.submit();">
                                    <option <%if (siempreTemp) {%>selected<%}%>>Siempre</option>
                                    <option <%if (selectTiempoTemp == 1) {%>selected<%}%>>Última Semana</option>
                                    <option <%if (selectTiempoTemp == 2) {%>selected<%}%>>Último Mes</option>
                                    <option <%if (selectTiempoTemp == 3) {%>selected<%}%>>Último Año</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <div class="ScrollStyle p-2"> 
                <%
                    for (int i = 0; i < dietas.size(); i++) {
                        LocalDateTime fechaDieta = dietasTemp.get(i).getFecha();
                        if (siempreTemp || fechaDieta.compareTo(fechaLimiteTemp) >= 0) {
                %>
                <a class="text-decoration-none blackHref" href="./dietaUsuario?cod=<%=dietasTemp.get(i).getCodigoDieta()%>">
                    <div class="card bg-transparent mx-3 my-4">
                        <div class="entradaForoTitulo2 rounded-top p-2">
                            <div class="row">
                                <div class="col font-weight-bold"><%= dietasTemp.get(i).getTitulo()%></div>
                                <div class="col row">
                                    <div class="col"><i class="fa fa-star text-warning"></i> Favorito: <%= dietasTemp.get(i).getFavoritos()%></div>
                                    <div class="col"><i class="fa fa-heart text-danger"></i> Guardado: <%= dietasTemp.get(i).getGuardados()%></div>
                                </div>
                            </div>
                        </div>
                        <div class="entradaForoCuerpo2 rounded-bottom p-2" id="entradaEjemplo">
                            <p><%= dietasTemp.get(i).getDescripcion()%></p>
                        </div>
                    </div>
                </a>
                <%}
                }%>
            </div>
            <br/>
        </div>
        <br/>
    </body>
</html>