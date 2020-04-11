<%-- 
    Document   : foro
    Created on : Apr 9, 2020, 12:48:12 PM
    Author     : pablo y el javgatto
--%>

<%@page import="data.DiaSemana"%>
<%@page import="data.Plato"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="data.Dieta"%>
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
    <script type="text/javascript" src="script.js"></script> 

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
                <div class="intro-lead-in text-uppercase">Dietas a medida</div>
            </div>
        </div>
    </header>

    <div class="container rounded" id="cuerpo">

        <div class="row text-center my-3">
            <div class="col"></div>
            <div class="col">
                <a class="coolFont btn w-100" href="./index.html" role="button">INICIO</a>
            </div>
            <div class="col">
                <a class="coolFont btn w-100" href="./foro.jsp" role="button">FORO</a>
            </div>
            <div class="col">
                <a class="oneLine coolFont btn w-100" href="./ranking.jsp" role="button">TOP DIETAS</a>
            </div>
            <div class="col"></div>
            <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
        </div>
        <br/>
        <%
            String codigoDieta = request.getParameter("cod");
            if(codigoDieta == null){
                String redirectURL = "rankingUsuario.jsp";
                response.sendRedirect(redirectURL);
            }else{
                ArrayList<Plato> platos = DBConnection.getPlatosDieta(codigoDieta);
                if(platos==null){
                    String redirectURL = "rankingUsuario.jsp";
                    response.sendRedirect(redirectURL);
                }else{
                    Dieta dieta = DBConnection.selectDieta(codigoDieta);
                    String[] diaSemana = {"Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"};
                    int nPlato = 0;
        %>
        <h1 class="coolFontParagraph inlineBlock"><%=dieta.getTitulo()%>. </h1>
        <button disabled class="uncheckedButton btn btn-success inlineBlock"><i class="fa fa-star text-warning"></i> Favorito</button>
        <button disabled class="uncheckedButton btn btn-success inlineBlock"><i class="fa fa-heart text-danger"></i> Guardado</button>
        <a class="m-2 btn btn-warning inlineBlock rightAligned" href="./registro.html" role="button">Regístrate</a>
        <a class="m-2 btn btn-primary inlineBlock rightAligned" href="./iniciarSesion.html" role="button">Inicia sesión</a>

        <div class="row">
            <div class="MultiCarousel" data-items="1,3,5,6" data-slide="1" id="MultiCarousel" data-interval="false">
                <div class="MultiCarousel-inner">
                    <%for(int i = 0; i<diaSemana.length; i++){%>
                    <div class="item">
                        <div id="Lunes" class="pad15">
                            <h4 class="font-weight-bold"><%=diaSemana[i]%></h4>
                            <div class="my-4">
                                <h5>Desayuno</h5>
                                <p><%=platos.get(nPlato).getNombre()%></p>
                            </div>
                            <div class="my-4">
                                <h5>Comida</h5>
                                <p><%=platos.get(nPlato+1).getNombre()%></p>
                                <p><%=platos.get(nPlato/*+2*/).getNombre()%></p>
                                <p>Postre</p>
                            </div>
                            <div class="my-4">
                                <h5>Cena</h5>
                                <p><%=platos.get(nPlato/*+3*/).getNombre()%></p>
                                <p>Postre</p>
                            </div>
                        </div>
                    </div>
                    <%
                        //nPlato=nPlato+4;
                        }
                    %>
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

    <script>
        var countHeart=0;
            function changeHeart() {  
                var but = document.getElementById("like");
                if (countHeart == 1) {
                    but.style.color = '#28A745';
                    but.style.backgroundColor = '#FFFFFF';
                    countHeart=0;
                } else {
                        but.style.color = '#FFFFFF';
                        but.style.backgroundColor = '#28A745';
                        countHeart=1;
                }
            }
    </script>

    <script>
    var countStar=0;
        function changeStar() {
            var but = document.getElementById("fav");
            if (countStar == 1) {
                but.style.color = '#28A745';
                but.style.backgroundColor = '#FFFFFF';
                countStar=0;
            } else {
                    but.style.color = '#FFFFFF';
                    but.style.backgroundColor = '#28A745';
                    countStar=1;
            }
        }
    </script>
    <%}}%>
</body>
</html>