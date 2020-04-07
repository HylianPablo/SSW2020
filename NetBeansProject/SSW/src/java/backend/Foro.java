package backend;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author pablo
 */
@WebServlet(urlPatterns = {"/Foro"})
public class Foro extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String titulo = request.getParameter("tituloNuevaEntrada");
            String cuerpo = request.getParameter("cuerpoNuevaEntrada");
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>\n" +
"<html lang=\"es\">\n" +
"<head>\n" +
"	<meta charset=\"utf-8\">\n" +
"	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">\n" +
"	<meta name=\"description\" content=\"\">\n" +
"	<meta name=\"author\" content=\"\">\n" +
"\n" +
"	<title>HealthyBowl</title>\n" +
"\n" +
"	<script src=\"https://code.jquery.com/jquery-3.3.1.slim.min.js\" integrity=\"sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo\" crossorigin=\"anonymous\"></script>\n" +
"	<script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js\" integrity=\"sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49\" crossorigin=\"anonymous\"></script>\n" +
"	<script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js\" integrity=\"sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T\" crossorigin=\"anonymous\"></script>\n" +
"\n" +
"	<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css\" integrity=\"sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh\" crossorigin=\"anonymous\">\n" +
"  	<link rel=\"stylesheet\" type=\"text/css\" href=\"<%=request.getContextPath()%> ../../FrontEnd/styles.css\""+"\n" +
"    <link rel=\"icon\" href=\"img/logo.png\">\n" +
"</head>\n" +
"<body id=\"page-top\">\n" +
"	<div id=app></div>\n" +
"  	<!--Banner-->\n" +
"	<header class=\"masthead\">\n" +
"  		<div class=\"container\">\n" +
"  			<div class=\"intro-class\">\n" +
"  				<div class=\"intro-heading\">HealthyBowl</div>\n" +
"  				<div class=\"intro-lead-in\">Dietas a medida</div>\n" +
"  			</div>\n" +
"  		</div>\n" +
"  	</header>\n" +
"\n" +
"\n" +
"	<div class=\"container rounded\" id=\"cuerpo\">\n" +
"		<div class=\"row text-center my-3\">\n" +
"			<div class=\"col\"></div>\n" +
"			<div class=\"col\">\n" +
"				<a class=\"coolFont btn w-100\" href=\"./paginaUsuario.html\" role=\"button\">INICIO</a>\n" +
"			</div>\n" +
"			<div class=\"col\">\n" +
"				<a class=\"coolFont btn w-100 actualPage\" href=\"./foroUsuario.html\" role=\"button\">FORO</a>\n" +
"			</div>\n" +
"			<div class=\"col\">\n" +
"				<a class=\"oneLine coolFont btn w-100\" href=\"./rankingUsuario.html\" role=\"button\">TOP DIETAS</a>\n" +
"			</div>\n" +
"            <div class=\"col\">\n" +
"				<a class=\"coolFont btn w-100\" href=\"./perfil.html\" role=\"button\">MI PERFIL</a>\n" +
"			</div>\n" +
"			<div class=\"col\"></div>\n" +
"			<hr style=\"width: 100%; color: black; height: 1px; background-color:black;\" />\n" +
"		</div>\n" +
"		<br/>\n" +
"		\n" +
"        <h1 class=\"h1Size coolFontParagraph inlineBlock\">Foro principal</h1>\n" +
"        <a class=\"btn btn-warning inlineBlock rightAligned\" href=\"./index.html\" role=\"button\">Cerrar sesión</a>\n" +
"        <br/>\n" +
"        <hr/>\n" +
"        <button class=\"botonEstandar btn btn-success botonesEntrada my-3\" onclick=\"window.location.href='nuevaEntrada.html';\">Agregar nueva entrada</button>\n" +
"\n" +
"        <div class=\"card my-3\">\n" +
"            <div class=\"mx-3 mt-3 entradaForoTitulo\">\n" +
"                La dieta mediterránea es genial.\n" +
"                <button class=\"botonEstandar btn btn-success botonesEntrada\" onclick=\"window.location.href='entradaUsuario.html';\">Ir al hilo</button>\n" +
"                <button class=\"botonEstandar btn btn-success botonesEntrada\" onclick=\"mostrarMas(\'myBtn\',\'dots\',\'more\')\" id=\"myBtn\">Leer más</button>\n" +
"                <hr/>\n" +
"            </div>\n" +
"            <div class=\"mx-3\" id=\"entradaEjemplo\">\n" +
"                <p>\n" +
"                    Desayunar pan con aceite y tomate regula la circulación sanguínea.\n" +
"                    <span class=\"dots\" id=\"dots\">...</span>\n" +
"                    <span class=\"more\" id=\"more\">\n" +
"La Dieta Mediterránea es una valiosa herencia cultural que representa mucho más que una simple pauta nutricional, rica y saludable. Es un estilo de vida equilibrado que recoge recetas, formas de cocinar, celebraciones, costumbres, productos típicos y actividades humanas diversas.\n" +
"\n" +
"Entre las muchas propiedades beneficiosas para la salud de este patrón alimentario se puede destacar el tipo de grasa que lo caracteriza (aceite de oliva, pescado y frutos secos), las proporciones en los nutrientes principales que guardan sus recetas (cereales y vegetales como base de los platos y carnes o similares como “guarnición”) y la riqueza en micronutrientes que contiene, fruto de la utilización de verduras de temporada, hierbas aromáticas y condimentos.\n" +
"\n" +
"Así lo reconoció y celebró la UNESCO inscribiendo la Dieta Mediterránea como uno de los elementos de la Lista Representativa del Patrimonio Cultural Inmaterial de la Humanidad.\n" +
"La alimentación saludable que nos proporciona la Dieta Mediterránea es perfectamente compatible con el placer de degustar sabrosos platos.\n" +
"\n" +
"					</span>\n" +
"                </p>\n" +
"            </div>\n" +
"        </div>\n" +
"        <br/>\n" +
"                    <div class=\"card my-3\">\n" +
"            <div class=\"mx-3 mt-3 entradaForoTitulo\">\n" +
                titulo+"\n" +
"                <button class=\"botonEstandar btn btn-success botonesEntrada\" onclick=\"window.location.href='entradaUsuario.html';\">Ir al hilo</button>\n" +
"                <button class=\"botonEstandar btn btn-success botonesEntrada\" onclick=\"mostrarMas(\'myBtn2\',\'dots2\',\'more2\')\" id=\"myBtn2\">Leer más</button>\n" +
"                <hr/>\n" +
"            </div>\n" +
"            <div class=\"mx-3\" id=\"entradaEjemplo\">\n" +
"                <p>\n" +
"                    Desayunar pan con aceite y tomate regula la circulación sanguínea.\n" +
"                    <span class=\"dots\" id=\"dots2\">...</span>\n" +
"                    <span class=\"more\" id=\"more2\">\n" + cuerpo+
"\n" +
"					</span>\n" +
"                </p>\n" +
"            </div>\n" +
"        </div>\n" +
"        <br/>\n" +
"\n" +
"        <script>\n" +
"            function mostrarMas(idVar,dotsVar,moreVar) {\n" +
"                var dots = document.getElementById(dotsVar);\n" +
"                var moreText = document.getElementById(moreVar);\n" +
"                var btnText = document.getElementById(idVar);\n" +
"\n" +
"                if (dots.style.display === \"none\") {\n" +
"                    dots.style.display = \"inline\";\n" +
"                    btnText.innerHTML = \"Leer más\";\n" +
"                    moreText.style.display = \"none\";\n" +
"                } else {\n" +
"                    dots.style.display = \"none\";\n" +
"                    btnText.innerHTML = \"Leer menos\";\n" +
"                    moreText.style.display = \"inline\";\n" +
"                }\n" +
"            }\n" +
"        </script>\n" +
"    </div>\n" +
"    <br/>\n" +
"</body>\n" +
"</html>\n" +
"");
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
