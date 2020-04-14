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

        <div class="container rounded" id="cuerpo">

            <div class="row text-center my-3">
                <div class="col"></div>
                <div class="col">
                    <a class="coolFont btn w-100" href="../index.html" role="button">INICIO</a>
                </div>
                <div class="col">
                    <a class="coolFont btn w-100" href="../foro.html" role="button">FORO</a>
                </div>
                <div class="col">
                    <a class="coolFont btn w-100" href="../ranking.html" role="button">TOP DIETAS</a>
                </div>
                <div class="col"></div>
                <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
            </div>
            <br/>

            <h1 class="h1Size coolFontParagraph">Selección de Platos</h1>
            <hr/>
            <button type="button" id="dia" value="0" style="display:none"></button>
            <jsp:useBean id="plato" class="modelo.Plato" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="platosElegidos" class="java.util.ArrayList" scope="session">  
            </jsp:useBean>
            <jsp:useBean id="diaSemana" class="java.lang.String" scope="session">  
            </jsp:useBean>
            <%
                String visible;
                ArrayList<String> Dias = new ArrayList<>();
                try{
                ArrayList<String> platosE = platosElegidos;
                request.setAttribute("platosElegidos", platosElegidos);
                RequestDispatcher rd = request.getRequestDispatcher("diaDieta");
                rd.forward(request,response);
                }catch(Exception e){
                    e.printStackTrace();
                }
                
                Dias.add("Lunes");
                Dias.add("Martes");
                Dias.add("Miercoles");
                Dias.add("Jueves");
                Dias.add("Viernes");
                Dias.add("Sabado");
                Dias.add("Domingo");
                Plato p = plato;
                for (int i = 0; i < 7; i++) {
                    if (i == Integer.parseInt(diaSemana)) {
                        visible = "";
                    } else {
                        visible = "hidden";
                    }

            %>
            <h1 class="text-center display-4 coolFontParagraph" <%=visible%>><%=Dias.get(i)%></h1>
            <div <%=visible%>>
                <input type="hidden" value=<%=Integer.parseInt(diaSemana) + 1%>>
                <form action="diaDieta" method ="POST" >
                    <div class="card bg-transparent mx-3 my-5">
                        <div class="entradaForoTitulo2 rounded-top p-2">
                            <div class="text-center font-weight-bold">Desayuno</div>
                        </div>
                        <div class="entradaForoCuerpo2 rounded-bottom p-2">
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th scope="row">
                                            Plato único
                                        </th>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%>type="radio" id="desayuno1" name="desayuno" class="custom-control-input">
                                                <label class="custom-control-label" for="desayuno1">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="desayuno2" name="desayuno" class="custom-control-input">
                                                <label class="custom-control-label" for="desayuno2">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="desayuno3" name="desayuno" class="custom-control-input">
                                                <label class="custom-control-label" for="desayuno3">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card bg-transparent mx-3 my-5">
                        <div class="entradaForoTitulo2 rounded-top p-2">
                            <div class="text-center font-weight-bold"<%=visible%>>Comida</div>
                        </div>
                        <div class="entradaForoCuerpo2 rounded-bottom p-2">
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th scope="row">
                                            Primer Plato
                                        </th>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="comida11" name="comida1" class="custom-control-input">
                                                <label class="custom-control-label" for="comida11">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="comida12" name="comida1" class="custom-control-input">
                                                <label class="custom-control-label" for="comida12">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="comida13" name="comida1" class="custom-control-input">
                                                <label class="custom-control-label" for="comida13">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">
                                            Segundo Plato
                                        </th>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="comida21" name="comida2" class="custom-control-input">
                                                <label class="custom-control-label" for="comida21">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="comida22" name="comida2" class="custom-control-input">
                                                <label class="custom-control-label" for="comida22">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="comida23" name="comida2" class="custom-control-input">
                                                <label class="custom-control-label" for="comida23">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">
                                            Postre
                                        </th>
                                        <td></td>
                                        <td>
                                            Pieza de fruta o lácteo
                                        </td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card bg-transparent mx-3 my-5">
                        <div class="entradaForoTitulo2 rounded-top p-2">
                            <div class="text-center font-weight-bold">Cena</div>
                        </div>
                        <div class="entradaForoCuerpo2 rounded-bottom p-2">
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th scope="row">
                                            Primer Plato
                                        </th>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="cena1" name="cena" class="custom-control-input">
                                                <label class="custom-control-label" for="cena1">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="cena2" name="cena" class="custom-control-input">
                                                <label class="custom-control-label" for="cena2">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="custom-control custom-radio">
                                                <input value=<%=p.getNombre()%> type="radio" id="cena3" name="cena" class="custom-control-input">
                                                <label class="custom-control-label" for="cena3">
                                                    <%=p.getNombre()%>
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">
                                            Postre
                                        </th>
                                        <td></td>
                                        <td>
                                            Pieza de fruta o lácteo
                                        </td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
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
                            <%int diaSem = Integer.parseInt(diaSemana) + 1;%>
                            <button name="diaSemana" class="botonEstandar btn btn-success botonesEntrada" type="submit" value=<%=Integer.toString(diaSem)%>>Siguiente</button>
                        </div>
                        <div class="col"></div>
                    </div>
                </form>
            </div>
            <br/>
            <%}%>
        </div>
        <br/>
    </body>
</html>
