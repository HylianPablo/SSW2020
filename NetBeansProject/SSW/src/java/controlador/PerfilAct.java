/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.DBConnection;
import modelo.Dieta;
import modelo.Usuario;

/**
 *
 * @author pablo
 */
@WebServlet(name = "PerfilAct", urlPatterns = {"/FrontEnd/perfilAct"})
public class PerfilAct extends HttpServlet {

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
        String url = "/FrontEnd/perfil.jsp";
        HttpSession session = request.getSession();
        String mensajeErrorPerfil;
        Usuario userObj = (Usuario) session.getAttribute("sessionUserObj");
        
        String nombre = request.getParameter("realname");
        if(nombre.equals("")){
            nombre = userObj.getNombre();
        }
        String user = request.getParameter("username");
        if(user.equals("")){
            user = userObj.getNombreUsuario();
        }
        String oldPassword = request.getParameter("actualPassword");
        String newPassword = request.getParameter("newPassword");
        if(newPassword.equals("")){
            newPassword = oldPassword;
        }
        String mail = (String) session.getAttribute("sessionMail");
        if(mail.equals("")){
            mail = userObj.getCorreo();
        }
        boolean passOK = DBConnection.checkRegistrado(mail,oldPassword);
        if(!passOK){
            mensajeErrorPerfil = "Contraseña antigua errónea. Vuelva a introducir los datos correctamente.";
        }else{
            mensajeErrorPerfil = "";
            DBConnection.updateUser(mail,nombre,user,newPassword);
        }
        
        Usuario u = new Usuario();
        u.setNombreUsuario(user);
        u.setNombre(nombre);
        u.setContrasena(newPassword);
        u.setCorreo(mail);
        u.setFavorito("1");
        
        ArrayList<Dieta> dietas = DBConnection.selectDietasGuardadas(u.getNombreUsuario());
        Dieta dietaF = DBConnection.selectDietaFavorita(u.getNombreUsuario());
        session.removeAttribute("sessionUser");
        session.setAttribute("sessionUser", user);
        session.removeAttribute("sessionUserObj");
        session.setAttribute("sessionUserObj",u);
        session.setAttribute("dietas", dietas);
        String hayDietaF = String.valueOf(dietaF==null);
        session.setAttribute("hayDietaF", hayDietaF);
        session.setAttribute("dietaF", dietaF);
        session.setAttribute("mensajeErrorPerfil",mensajeErrorPerfil);
        

        //Lo quito y pongo sendRedirect, asi si das F5 no peta
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
