<%-- 
    Document   : foro
    Created on : Apr 9, 2020, 12:48:12 PM
    Author     : pablo y el javgatto
--%>

<%@page import="modelo.Plato"%>
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
        <div>
            <div class="container rounded" id="cuerpo">

                <div class="row text-center my-3">
                    <div class="col"></div>
                    <div class="col">
                        <a class="coolFont btn w-100" href="index" role="button">INICIO</a>
                    </div>
                    <div class="col">
                        <a class="coolFont btn w-100" href="foro" role="button">FORO</a>
                    </div>
                    <div class="col">
                        <a class="coolFont btn w-100" href="ranking" role="button">TOP DIETAS</a>
                    </div>
                    <div class="col"></div>
                    <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
                </div>
                <br/>
                <h1 class="h1Size coolFontParagraph">Selección de Platos</h1>
                <hr/>
                <button type="button" id="dia" value="0" style="display:none"></button>
                <jsp:useBean id="platos" class="java.util.ArrayList" scope="session">  
                </jsp:useBean>
                <jsp:useBean id="platosElegidos" class="java.util.ArrayList" scope="session">  
                </jsp:useBean>
                <jsp:useBean id="diaSemana" class="java.lang.String" scope="session">  
                </jsp:useBean>
                <%
                    ArrayList<String> Dias = new ArrayList<>();
                    Dias.add("Lunes");
                    Dias.add("Martes");
                    Dias.add("Miércoles");
                    Dias.add("Jueves");
                    Dias.add("Viernes");
                    Dias.add("Sábado");
                    Dias.add("Domingo");
                    int diaActual = Integer.parseInt(diaSemana);
                    ArrayList<Plato> ps = platos;
                %>
                <h1 class="text-center display-4 coolFontParagraph" ><%=Dias.get(diaActual)%></h1>
                <form action="diaDieta" method="POST">
                    <div>
                        <input type="hidden" name="diaSemana" value=<%=diaActual + 1%>>
                        <form action="diaDieta" method ="POST" >
                            <%
                                String nomComida;
                                int numPlato = 0;
                                int cantComidas = 3;
                                String titulos[] = {"Desayuno", "Comida", "Cena"};
                                int cantPlatos[] = {1, 3, 2};
                                String menus[][] = {{"desayuno"}, {"comida1", "comida2", "postre"}, {"cena", "postre"}};
                                String subtitulos[][] = {{"Plato único"}, {"Primer plato", "Segundo plato", "Postre"}, {"Primer plato", "Postre"}};
                                for (int c = 0; c < cantComidas; c++) {

                            %>
                            <div class="card bg-transparent mx-3 my-5">
                                <div class="entradaForoTitulo2 rounded-top p-2">
                                    <div class="text-center font-weight-bold"><%=titulos[c]%></div>
                                </div>
                                <div class="entradaForoCuerpo2 rounded-bottom p-2">
                                    <table class="table table-borderless">
                                        <tbody>
                                        <%for (int m = 0; m < cantPlatos[c]; m++) {%>
                                            <tr>
                                                <th scope="row">
                                                    <%=subtitulos[c][m]%>
                                                </th>
                                                <%
                                                    int NUM_OPC = 3;
                                                    nomComida = menus[c][m];
                                                    if (!nomComida.equals("postre")) {
                                                        for (int i = 0; i < NUM_OPC; i++) { 
                                                            Plato p = ps.get(numPlato);
                                                            numPlato++;
                                                %>
                                                <td>
                                                    <div class="custom-control custom-radio">
                                                        <input value="<%=p.getNombre()%>" type="radio" id="<%=nomComida + i%>" name="<%=nomComida%>" class="custom-control-input">

                                                        <label class="custom-control-label" for="<%=nomComida + i%>">
                                                            <%=p.getNombre()%>
                                                        </label>
                                                    </div>
                                                </td>
                                                <%  }} else {   %>
                                                <td></td>
                                                <td>
                                                    Pieza de fruta o lácteo
                                                </td>
                                                <td></td>
                                                <%  }   %>
                                            </tr>
                                            <%  }   %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <%  }%>
                    </div>
                    <div class="row text-center my-3">
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col"></div>
                        <div class="col">
                            <button class="botonEstandar btn btn-success botonesEntrada" type="submit">Siguiente</button>
                        </div>
                        <div class="col"></div>
                    </div>
                </form>
            <br/>
            </div>
        </div>
        <br/>
    </body>
</html>