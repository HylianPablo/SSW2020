<%-- 
    Document   : foro
    Created on : Apr 9, 2020, 12:48:12 PM
    Author     : pablo y el javgatto
--%>

<%@page import="modelo.DiaSemana"%>
<%@page import="modelo.Plato"%>
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
        <script type="text/javascript" src="script.js"></script> 

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="/SSW/FrontEnd/styles.css">
        <link rel="icon" href="/SSW/FrontEnd/img/logo.png">
    </head>
    <body id="page-top">
        <div id=app></div>
        <!--Banner-->
        <header class="masthead">
            <div class="container">
                <div class="intro-class">
                    <div class="intro-heading">HealthyBowl</div>
                    <div class="intro-lead-in text-uppercase">Dietas a medida</div>
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
                    <a class="oneLine coolFont btn w-100" href="./ranking" role="button">TOP DIETAS</a>
                </div>
                <div class="col">
                    <a class="coolFont btn w-100" href="./perfil" role="button">MI PERFIL</a>
                </div>
                <div class="col"></div>
                <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
            </div>
            <br/>
            <jsp:useBean id="cod" class="java.lang.String" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="platos" class="java.util.ArrayList" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="dieta" class="modelo.Dieta" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="favorito" class="java.lang.String" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="guardado" class="java.lang.String" scope="session">  
            </jsp:useBean>
            <%
                boolean guardadoTemp = Boolean.parseBoolean(guardado);
                boolean favoritoTemp = Boolean.parseBoolean(favorito);
                ArrayList<String> Dias = new ArrayList<>();
                ArrayList<Plato> platosTemp = platos;
                Dias.add("Lunes");
                Dias.add("Martes");
                Dias.add("Miércoles");
                Dias.add("Jueves");
                Dias.add("Viernes");
                Dias.add("Sábado");
                Dias.add("Domingo");
                int numPlato = 0;
                if (cod == null) {  //ESTO ES UNA ABERRACION, SE CONTROLA EN CONTROLADOR NO AQUI
                    String redirectURL = "./ranking";
                    response.sendRedirect(redirectURL);
                } else {
                    if (platos == null) {
                        String redirectURL = "./ranking";
                        response.sendRedirect(redirectURL);
                    } else {

            %>
            <h1 class="coolFontParagraph inlineBlock"><%=dieta.getTitulo()%>. </h1>
            <button class="<%if (!favoritoTemp) {%>uncheckedButton<%}%> btn btn-success inlineBlock" data-toggle="modal" href="#confirmarFav">
                <i class="fa fa-star text-warning"></i> Favorito
            </button>
            <form method="post" class="d-inline-block" action="./guardarDieta">
                <input type="hidden" name="guardadoTemp" value="<%=!guardadoTemp%>"/>
                <input type="hidden" name="codigoDieta" value="<%=cod%>"/>
                <button type="submit" class="<%if (!guardadoTemp) {%>uncheckedButton<%}%> btn btn-success inlineBlock">
                    <i class="fa fa-heart text-rosa"></i><%if (!guardadoTemp) {%> Guardar<%} else {%> Guardado<%}%>
                </button>
            </form>
            <a class="btn btn-warning inlineBlock rightAligned" href="./cerrarSesion" role="button">Cerrar sesión</a>

            <div class="row">
                <div class="MultiCarousel" data-items="1,3,5,6" data-slide="1" id="MultiCarousel" data-interval="false">
                    <div class="MultiCarousel-inner">
                        <%for (int c = 0; c < Dias.size(); c++) {%>
                        <div class="item">
                            <div id<%=Dias.get(c)%> class="pad15">
                                <h4 class="font-weight-bold"><%=Dias.get(c)%></h4>
                                <div class="my-4">
                                    <h5>Desayuno</h5>
                                    <p><%=platosTemp.get(numPlato).getNombre()%></p>
                                    <%numPlato++;%>
                                </div>
                                <div class="my-4">
                                    <h5>Comida</h5>
                                    <p><%=platosTemp.get(numPlato).getNombre()%></p>
                                    <%numPlato++;%>
                                    <p><%=platosTemp.get(numPlato).getNombre()%></p>
                                    <%numPlato++;%>
                                    <p>Postre</p>
                                </div>
                                <div class="my-4">
                                    <h5>Cena</h5>
                                    <p><%=platosTemp.get(numPlato).getNombre()%></p>
                                    <%numPlato++;%>
                                    <p>Postre</p>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    <button class="btn btn-success leftLst"><</button>
                    <button class="btn btn-success rightLst">></button>
                </div>
            </div>
            <br/>
            <hr>
            <br>
            <h2 class="coolFontParagraph">Descripción de la dieta</h2>

            <div class="card my-3" id="entradaEjemplo">
                <div class="m-2">
                    <p>
                        <%=dieta.getDescripcion()%>
                    </p>
                </div>
            </div>
            <br/>
        </div>
        <br/>

        <!-- Modal -->
        <div class="modal fade" id="confirmarFav" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">
                            <%if (favoritoTemp) {%>¿Eliminar favorito?<%} else {%>
                            ¿Confirmar favorito?<%}%>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <%if (!favoritoTemp) {%>
                        <p>Sólo puedes tener una dieta como favorita</p>
                        <p>Si marcas esta dieta como favorita cualquier otra dieta que tengas marcada se desmarcará.</p>
                        <%} else {%>
                        <p>¿Seguro que quieres desmarcar esta dieta como favorita?</p>
                        <%}%>
                    </div>
                    <div class="modal-footer">
                        <form method="post" action="./favoritoDieta">
                            <input type="hidden" name="codigoDieta" value="<%=cod%>"/>
                            <input type="hidden" name="favorito" value="<%=!favoritoTemp%>"/>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Confirmar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%}
            }%>
    </body>
</html>