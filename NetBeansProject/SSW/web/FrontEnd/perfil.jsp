<%-- 
    Document   : foro
    Created on : Apr 9, 2020, 12:48:12 PM
    Author     : pablo y el javgatto
--%>

<%@page import="modelo.Dieta"%>
<%@page import="modelo.Usuario"%>
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
                <div class="intro-lead-in">Dietas a medida</div>
            </div>
        </div>
    </header>


    <div class="container" id="cuerpo">
        <div class="row text-center my-3">
            <div class="col"></div>
            <div class="col">
                <a class="coolFont btn w-100" href="./paginaUsuario" role="button">INICIO</a>
            </div>
            <div class="col">
                <a class="coolFont btn w-100" href="./foroUsuario" role="button">FORO</a>
            </div>
            <div class="col">
                <a class="oneLine coolFont btn w-100" href="./rankingUsuario" role="button">TOP DIETAS</a>
            </div>
            <div class="col">
                <a class="coolFont btn w-100 actualPage" href="./perfil" role="button">MI PERFIL</a>
            </div>
            <div class="col"></div>
            <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
        </div>
        <br/>

        <h1 class="h1Size coolFontParagraph center inlineBlock">Mi perfil</h1>
        <a class="btn btn-warning inlineBlock rightAligned" href="./index" role="button">Cerrar sesión</a>
        <hr/>
        <p>Por favor, actualize su información personal si ésta ha cambiado</p>
        <jsp:useBean id="usuario" class="modelo.Usuario" scope="session">  
        </jsp:useBean>
        <jsp:useBean id="dietas" class="java.util.ArrayList" scope="session">  
        </jsp:useBean>
        <jsp:useBean id="hayDietaF" class="java.lang.String" scope="session">  
        </jsp:useBean>
        <jsp:useBean id="dietaF" class="modelo.Dieta" scope="session">  
        </jsp:useBean>
        <%
            boolean hayFav = Boolean.parseBoolean(hayDietaF);
            ArrayList<Dieta> dietasTemp = dietas;
        %>
        <div class="container rounded" id="cuadroPerfil">
            <div class="imagen" align="center">
                <img src="img/profile.jpg" alt="img" class="m-3 img-thumbnail">
            </div>
            <div class="m-3">
                <form action="./paginaUsuario" role="form">
                    <div class="form-group w-70">
                        <label class="d-inline-block" for="usuario">Usuario: </label>
                        <div class="d-inline-block card"> <%=usuario.getNombreUsuario()%> </div>
                        <input type="text" id="usuario" class="form-control" placeholder="--sin modificar--">
                    </div>
                    <div class="form-group w-70">
                        <label for="password">Contraseña actual (*)</label>
                        <input type="password" id="password" class="form-control" placeholder="--obligatorio--">
                    </div>
                    <div class="form-group w-70">
                        <label for="npassword">Nueva contraseña</label>
                        <input type="password" id="npassword" class="form-control" placeholder="--sin modificar--">
                    </div>
                    <div class="form-group w-70">
                        <label for="correo">Correo:</label>
                        <div class="p-2 card"><%=usuario.getCorreo()%></div>
                    </div>
                    <div class="form-group">
                        <label for="archivo">Adjuntar una imagen para tu perfil:</label>
                        </br>
                        <input type="file" id="imagen">
                    </div>
                    <div class="alert alert-warning">
                        Dieta Favorita <i class="fa fa-star text-warning"> </i> :
                        <%if(hayFav){%>
                        No tienes ninguna dieta marcada como favorita
                        <%}else{%>
                        <a class="alert-link" href="dietaUsuario?cod=<%=dietaF.getCodigoDieta()%>"><%=dietaF.getTitulo()%></a>
                        <%}%>
                    </div>
                    <div class="alert alert-danger">
                        Dietas Guardadas <i class="fa fa-heart text-danger"> </i> :
                        <%if(dietas.size()==0){%>
                        Aún no has guardado ninguna dieta
                        <%}%>
                        <ul class="list-group">
                            <%for(int i = 0; i<dietas.size(); i++){%>
                            <li class="list-group-item">
                                <a class="alert-link" href="dietaUsuario?cod=<%=dietasTemp.get(i).getCodigoDieta()%>"><%=dietasTemp.get(i).getTitulo()%></a>
                            </li>
                            <%}%>
                        </ul>
                    </div>
                    <p>Los campos marcados con (*) son obligatorios para cualquier modificación</p>
                    <div class="contenedor">
                        <button id="guardar" type="submit" class="btn btn-primary btn-lg">Guardar</button>
                    </div>
                </form>
            </div>
        </div>
        <br/>
    </div>
    <br/>
</body>
</html>
