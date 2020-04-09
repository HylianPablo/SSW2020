package control;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import data.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import data.Entrada;
import java.time.LocalDateTime;
import java.time.Month;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 *
 * @author pablo
 */
@WebServlet(name = "Foro", urlPatterns = {"/Foro"})
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

        String codigo = "codigoEjemplo";
        String titulo = request.getParameter("tituloNuevaEntrada");
        String cuerpo = request.getParameter("cuerpoNuevaEntrada");
        String usuario = "pepe";//request.getParameter("usuarioNuevaEntrada");
        LocalDateTime date = LocalDateTime.of(2019,Month.APRIL,03, 19, 30, 40);//request.getParameter("fechaNuevaEntrada");
        Entrada entrada = new Entrada();
        entrada.setCodigoEntrada(codigo);
        entrada.setTitulo(titulo);
        entrada.setCuerpo(cuerpo);
        entrada.setNombreUsuario(usuario);
        entrada.setFecha(date);

        String url = "/FrontEnd/foro.jsp";
        //DBConnection.insertEntrada(entrada);
        HttpSession session = request.getSession();
        session.setAttribute("entrada", entrada);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
        dispatcher.forward(request, response);
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
