/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
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
 * @author alejandro
 */
@WebServlet(name = "IniciarSesion", urlPatterns = {"/FrontEnd/iniciarSesion"})
public class IniciarSesion extends HttpServlet {

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
        String url;
        RequestDispatcher dispatcher;
        HttpSession session = request.getSession();
        String username = request.getParameter("username"); //mejor con session? no aparece en la barra
        if(username!=null){
            String name = request.getParameter("realname");
            String password1 = request.getParameter("password");
            String password2 = request.getParameter("repeatedPassword");
            if(!password1.equals(password2)){
                url = "/FrontEnd/registro.jsp";
                dispatcher = getServletContext().getRequestDispatcher(url);
                dispatcher.forward(request, response);
            }
            String mail = request.getParameter("userMail");
            Usuario user = new Usuario();
            user.setNombre(name);
            user.setNombreUsuario(username);
            user.setContrasena(password1);
            user.setCorreo(mail);
            user.setFavorito("1"); //Por ahora así, pues un usuario recién creado no tiene favorita
            DBConnection.insertUsuario(user);
        }
        url = "/FrontEnd/iniciarSesion.jsp";
        dispatcher = getServletContext().getRequestDispatcher(url);
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
