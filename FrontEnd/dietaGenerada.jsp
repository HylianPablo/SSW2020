<%-- 
    Document   : dietaGenerada
    Created on : Apr 14, 2020, 1:04:41 PM
    Author     : pablo
--%>

<%@page import="modelo.Plato"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>HealthyBowl</title>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <script type="text/javascript" src="/SSW/FrontEnd/script.js"></script> 

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
				<a class="coolFont btn w-100" href="./index" role="button">INICIO</a>
			</div>
			<div class="col">
				<a class="coolFont btn w-100" href="./foro" role="button">FORO</a>
			</div>
			<div class="col">
				<a class="oneLine coolFont btn w-100" href="./ranking" role="button">TOP DIETAS</a>
			</div>
			<div class="col"></div>
			<hr style="width: 100%; color: black; height: 1px; background-color:black;" />
		</div>
		<br/>

        <h1 class="coolFontParagraph inlineBlock">Dieta generada.</h1>
        <div class="row">
                <div class="MultiCarousel" data-items="1,3,5,6" data-slide="1" id="MultiCarousel" data-interval="false">
                    <div class="MultiCarousel-inner">
                        <jsp:useBean id="platosDATOS" class="java.util.ArrayList" scope="session">  
                        </jsp:useBean>
                        <%
                            ArrayList<Plato> platosElegidos = platosDATOS;
                            String[] dias = new String[]{"Lunes","Martes","Miercoles","Jueves","Viernes","Sábado","Domingo"};
                        for(int i=0;i<7;i++){
                        %>
                        <div class="item">
                            <div id="Lunes" class="pad15">
                                <h4 class="font-weight-bold"><%=dias[i]%></h4>
                                <div class="my-4">
                                <h5>Desayuno</h5>
                                <p><%=platosElegidos.get((i*4)).getNombre()%></p>
                                </div>
                                <div class="my-4">
                                <h5>Comida</h5>
                                <p><%=platosElegidos.get((i*4)+1).getNombre()%></p>
                                <p><%=platosElegidos.get((i*4)+2).getNombre()%></p>
                                <p>Postre</p>
                                </div>
                                <div class="my-4">
                                <h5>Cena</h5>
                                <p><%=platosElegidos.get((i*4)+3).getNombre()%></p>
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
            <br>
            <div class="mr-auto text-center">
                <button type="submit" class="btn submitDiet" onclick="window.location.href='iniciarSesion.html';">Guardar Dieta</button>
            </div>
        <br/>
        <br/>
    </div>
    <br/>
</body>

</html>
