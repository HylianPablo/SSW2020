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
                    <a class="coolFont btn w-100 actualPage" href="./ranking" role="button">TOP DIETAS</a>
                </div>
                <div class="col"></div>
                <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
            </div>
            <br/>

            <jsp:useBean id="plato" class="modelo.Plato" scope="session">  
            </jsp:useBean>
            <h1 class="h1Size coolFontParagraph inlineBlock">El plato en detalle</h1>
            <a class="btn btn-warning inlineBlock rightAligned" href="./cerrarSesion" role="button">Cerrar sesión</a>
            <hr/>
            <br>
            <div class="container">
                <div class="row">
                    <div class="col-sm">
                        <div class="card bg-transparent mx-3 my-4">
                            <div class="entradaForoTitulo2 rounded-top p-2">
                                <div class="row">
                                    <div class="col font-weight-bold"><%=plato.getNombre()%></div>
                                </div>
                            </div>
                            <div class="entradaForoCuerpo2 rounded-bottom p-2" id="entradaEjemplo">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th scope="row">Lípidos</th>
                                            <td><%=plato.getLipidos()%> g</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Proteínas</th>
                                            <td><%=plato.getProteinas()%> g</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Hidratos de carbono</th>
                                            <td><%=plato.getPolisacaridos()+plato.getGlucidosSimples()%> g</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Kilocalorías</th>
                                            <td><%=plato.getKcal()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <br/>
                    </div>
                    <div class="col-sm" align="center">
                        <br>
                        <% String rutaFoto = "/SSW/FrontEnd/platos/"+plato.getFoto();%>
                        <img src="<%=rutaFoto%>" alt="" class="m-3 img-thumbnail border border-dark" style="width:350px; height:250px;">
                    </div>
                </div>
            </div>
            <div class="entradaForoCuerpo2 rounded p-3" id="entradaEjemplo">
                <%=plato.getDescripcion() + "."%>
            </div>
            <br/>
            <div class="entradaForoCuerpo2 rounded p-3" id="entradaEjemplo">
                Un enlace de interés: <a href="<%=plato.getEnlace()%>"><%=plato.getEnlace() + "."%></a>
            </div>
            <br>
            <br>
            <button id="back" class="botonEstandar btn btn-success btn-lg btn-block botonesEntrada" type="button" onclick="history.back()">Volver</button>
            <br>
            <br>
        </div>
        <br/>
    </body>
</html>