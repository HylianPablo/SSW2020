<%-- 
    Document   : iniciarSesion
    Created on : Apr 14, 2020, 12:44:53 PM
    Author     : alejandro
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <!--<script type="text/javascript" src="check.js"></script>-->

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
                    <a class="coolFont btn w-100 actualPage" href="./index" role="button">INICIO</a>
                </div>
                <div class="col">
                    <a class="coolFont btn w-100" href="./foro" role="button">FORO</a>
                </div>
                <div class="col">
                    <a class="coolFont btn w-100" href="./ranking" role="button">TOP DIETAS</a>
                </div>
                <div class="col"></div>
                <hr style="width: 100%; color: black; height: 1px; background-color:black;" />
            </div>
            <br/>
            <div class="container text-center my-5">
                <h1 class="entradillaInicio coolFontParagraph">¡Bienvenido a HealthyBowl!</h1>
                <p class="coolFont">Estás a un par de clicks de empezar a comer saludablemente de forma sencilla.</p>
                <a class="m-1 btn btn-primary" href="./iniciarSesion" role="button">Inicia sesión</a>
                <a class="m-1 btn btn-warning" href="./registro" role="button">Regístrate</a>
            </div>
            <br/>
            <hr/>
            <h2 class="entradillaInicio text-center coolFontParagraph">Crea tu dieta personalizada</h2><br/>
            <div id="carouselCreaDieta" class="carousel slide mx-5 rounded" data-ride="carousel" data-interval="true">
                <ol class="carousel-indicators">
                    <li data-target="#carouselCreaDieta" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselCreaDieta" data-slide-to="1"></li>
                    <li data-target="#carouselCreaDieta" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                    <form action="./diaDieta" method="POST">
                        <input type="hidden" name="diaSemana" value="0">
                        <input type="hidden" name="usuario" value="0">
                        <div class="carousel-item active bg-transparent p-5">
                            <div class="formulario">
                                <div class="container text-center">
                                    <h4 class="coolFont">Datos personales</h4>
                                </div>
                                <div class="container my-5">
                                    <div class="form-group">
                                        <label class="actualPage" for="ageForm">Edad: (*)</label>
                                        <input class="form-control" type="number" id="ageForm" name="ageForm" oninput="checkAllForms()">
                                    </div>
                                    <div class="form-group">
                                        <label class="actualPage" for="heigthForm">Altura (cm): (*)</label>
                                        <input class="form-control" type="number" id="heightForm" name="heigthForm" oninput="checkAllForms()">
                                    </div>
                                    <div class="form-group">
                                        <label class="actualPage" for="weigthForm">Peso actual: (*)</label>
                                        <input class="form-control" type="number" id="weigthForm" name="weightForm" oninput="checkAllForms()">
                                    </div>
                                    <div class="form-group">
                                        <label class="actualPage" for="idealWeigthForm">Peso ideal:</label>
                                        <input class="form-control" type="number" id="idealWeigthForm" name="idealWeightForm" oninput="checkAllForms()">
                                    </div>
                                </div>
                                <div class="float-right">
                                    <button class="btn btn-success" href="#carouselCreaDieta" role="button" data-slide="next" id="siguiente1" disabled>Siguiente ></button>
                                </div>
                                <p class="actualPage">Los campos marcados con (*) son obligatorios.<p>
                            </div>
                        </div>
                        <div class="carousel-item bg-transparent p-5">
                            <div class="formulario">
                                <div class="container text-center">
                                    <h4 class="coolFont">Incompatibilidades de alimentos</h4>

                                </div>
                                <div class="row">
                                    <div class="col container my-5">
                                        <h5>Alergias</h5>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="cerdo" id="cerdoCheck">
                                            <label class="custom-control-label" for="cerdoCheck"> Cerdo</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="marisco" id="mariscoCheck">
                                            <label class="custom-control-label" for="mariscoCheck"> Marisco</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="pescado" id="pescadoCheck">
                                            <label class="custom-control-label" for="pescadoCheck"> Pescado</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="huevo" id="huevoCheck">
                                            <label class="custom-control-label" for="huevoCheck"> Huevo</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="frutosSecos" id="frutosSecosCheck">
                                            <label class="custom-control-label" for="frutosSecosCheck"> Frutos secos (no cacahuetes)</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="cacahuetes" id="cacahuetesCheck">
                                            <label class="custom-control-label" for="cacahuetesCheck"> Cacahuetes</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="soja" id="sojaCheck">
                                            <label class="custom-control-label" for="sojaCheck"> Soja</label>
                                        </div>
                                    </div>
                                    <div class="col container my-5">
                                        <h5>Alergias a frutas</h5>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="melocoton" id="melocotonCheck">
                                            <label class="custom-control-label" for="melocotonCheck"> Melocotón</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="pera" id="peraCheck">
                                            <label class="custom-control-label" for="peraCheck"> Pera</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="manzana" id="manzanaCheck">
                                            <label class="custom-control-label" for="manzanaCheck"> Manzana</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="melon" id="melonCheck">
                                            <label class="custom-control-label" for="melonCheck"> Melón</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="kiwi" id="kiwiCheck">
                                            <label class="custom-control-label" for="kiwiCheck"> Kiwi</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="piña" id="pinaCheck">
                                            <label class="custom-control-label" for="pinaCheck"> Piña</label>
                                        </div>
                                        <div class="custom-control custom-checkbox checkbox-xl">
                                            <input type="checkbox" class="custom-control-input" name="fresa" id="fresaCheck">
                                            <label class="custom-control-label" for="fresaCheck"> Fresa</label>
                                        </div>
                                    </div>
                                    <div class="col container">
                                        <div class="container my-5">
                                            <h5>Intolerancias</h5>
                                            <div class="custom-control custom-checkbox checkbox-xl">
                                                <input type="checkbox" class="custom-control-input" name="celiaco" id="celicacoCheck">
                                                <label class="custom-control-label" for="celicacoCheck"> Celíaco (Gluten)</label>
                                            </div>
                                            <div class="custom-control custom-checkbox checkbox-xl">
                                                <input type="checkbox" class="custom-control-input" name="lactosa" id="lactosaCheck">
                                                <label class="custom-control-label" for="lactosaCheck"> Lactosa</label>
                                            </div>
                                        </div>
                                        <div class="container my-5">
                                            <h5>Otras incompatibilidades</h5>
                                            <div class="custom-control custom-checkbox checkbox-xl">
                                                <input type="checkbox" class="custom-control-input" name="vegetariano" id="vegetarianoCheck">
                                                <label class="custom-control-label" for="vegetarianoCheck"> Vegetariano</label>
                                            </div>
                                            <div class="custom-control custom-checkbox checkbox-xl">
                                                <input type="checkbox" class="custom-control-input" name="vegano" id="veganoCheck">
                                                <label class="custom-control-label" for="veganoCheck"> Vegano</label>
                                            </div>
                                            <div class="custom-control custom-checkbox checkbox-xl">
                                                <input type="checkbox" class="custom-control-input" name="musulman" id="musulmanCheck">
                                                <label class="custom-control-label" for="musulmanCheck"> Musulmán</label>
                                            </div>
                                            <div class="custom-control custom-checkbox checkbox-xl">
                                                <input type="checkbox" class="custom-control-input" name="hindu" id="hinduCheck">
                                                <label class="custom-control-label" for="hinduCheck"> Hindú</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="float-left d-inline-block">
                                    <a class="btn btn-success" href="#carouselCreaDieta" role="button" data-slide="prev">&lt; Volver</a>
                                </div>
                                <div class="float-right d-inline-block">
                                    <a class="btn btn-success" href="#carouselCreaDieta" role="button" data-slide="next">Siguiente ></a>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item bg-transparent p-5">
                            <div class="formulario">
                                <div class="container text-center">
                                    <h4 class="coolFont">Últimos ajustes</h4>
                                </div>
                                <br/>
                                <div class="container m-3">
                                    <div class="m-3 form-group">
                                        <h5>Ejercicio físico realizado semanalmente:</h5>
                                        <div class="d-flex justify-content-center my-4">
                                            <span class="font-weight-bold indigo-text mr-2 mt-1">Nada</span>
                                            <input class="custom-range" type="range" min="0" max="100" />
                                            <span class="font-weight-bold indigo-text ml-2 mt-1">Mucho</span>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="m-3">
                                        <h5>Advertencia:</h5>
                                        <p>Las dietas generadas en HealthyBowl son personalizadas pero no pueden sustituir el trabajo de un dietista o un médico. En caso de necesitar una atención mucho más personalizada debería
                                            contactar con uno.</p>
                                    </div>
                                    <br/>
                                </div>
                                <div class="mr-auto text-center">
                                    <button type="submit" class="btn submitDiet">Generar Dieta</button>
                                </div>
                                <div class="text-left">
                                    <a class="btn btn-success" href="#carouselCreaDieta" role="button" data-slide="prev">&lt; Volver</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <br/>
            <script>
                $('.carousel').carousel({
                    interval: false
                });
                </script>
                <script>
                 function checkAllForms(){
                    var flag = true;
                    var age = document.getElementById("ageForm");
                    var height = document.getElementById("heightForm");
                    var weigth = document.getElementById("weigthForm");
                    
                    var siguiente = document.getElementById("siguiente1");
            
                    if(age.value.length == 0 || height.value.length == 0 || weigth.value.length==0)
                        flag=false;
                    if (flag)
                        siguiente.disabled=false;
                    else
                        siguiente.disabled=true;
                    }
            </script>

        </div>
        <br/>
    </body>

</html>
