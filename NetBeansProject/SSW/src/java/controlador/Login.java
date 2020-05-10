/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.DBConnection;
import modelo.Usuario;

/**
 *
 * @author Javier
 */
@WebServlet(name = "Login", urlPatterns = {"/FrontEnd/login"})
public class Login extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8 pageEncoding=UTF-8");
        HttpSession session = request.getSession();
        
        String url;

        String correoUsuario = request.getParameter("usuarioInput");
        String contraseña = request.getParameter("passwordInput");
        Boolean registered = DBConnection.checkRegistrado(correoUsuario, contraseña);
        if (!registered) {
            String mensajeErrorIniciarSesion = "Usuario o contraseña erróneos. Introduzca los datos de nuevo.";
            session.setAttribute("mensajeErrorIniciarSesion",mensajeErrorIniciarSesion);
            url = "./iniciarSesion";
        } else {
            url = "./index";
            String usuario = DBConnection.selectNombreUsuarioDesdeCorreo(correoUsuario);
            Usuario user = DBConnection.selectUsuario(usuario);
            session.setAttribute("sessionUserObj", user);
            session.setAttribute("sessionMail", correoUsuario);
            session.setAttribute("sessionPassword", contraseña);
            session.setAttribute("sessionUser", usuario);
            System.out.println(usuario);
        }
        
        response.sendRedirect(url);
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
