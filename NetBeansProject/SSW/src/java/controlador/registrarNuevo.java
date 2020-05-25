/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
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
@WebServlet(name = "registrarNuevo", urlPatterns = {"/FrontEnd/registrarNuevo"})
public class registrarNuevo extends HttpServlet {

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
        HttpSession session = request.getSession();
        String url = "/SSW/FrontEnd/iniciarSesion.jsp";
        
        String username = request.getParameter("username");
        String realname = request.getParameter("realname");
        String password = request.getParameter("password");
        String repeatedPassword = request.getParameter("repeatedPassword");
        String userMail = request.getParameter("userMail");
        
        if(!username.equals("") && !realname.equals("") && !password.equals("") && !repeatedPassword.equals("") && !userMail.equals("") && password.equals(repeatedPassword)){
            Usuario user = new Usuario();
            user.setNombre(realname);
            user.setNombreUsuario(username);
            user.setContrasena(password);
            user.setCorreo(userMail);
            user.setFavorito("1"); //HACER DIETA GENERICA
            if(DBConnection.correoPresente(userMail)){
                url = "./registro";
                session.setAttribute("errorRegistro", "El correo introducido ya esta siendo utilizado");
            }else if(username.contains("@")){
                url = "./registro";
                session.setAttribute("errorRegistro","El nombre de usuario no puede contener '@'");
            }else if(DBConnection.nombreUsuarioPresente(username)){
                url = "./registro";
                session.setAttribute("errorRegistro", "El nombre de usuario introducido ya esta siendo utilizado");
            }else{
                session.setAttribute("errorRegistro", "");
                DBConnection.insertUsuario(user);
                ArrayList<modelo.Plato> platosRegistro = (ArrayList) session.getAttribute("platosRegistro");
                if(platosRegistro!=null){
                    String titulo = (String) session.getAttribute("tituloDieta");
                    if(titulo.equals("")){
                        titulo = "Dieta de "+username;
                    }
                    Timestamp ld = new Timestamp(System.currentTimeMillis());
                    String descripcion = "Dieta creada por el usuario "+username;
                    DBConnection.insertDieta(titulo,descripcion,ld);
                    String codigoDieta = DBConnection.getLastCodigoDieta();
                    DBConnection.insertPlatosMenu(platosRegistro,codigoDieta);
                    DBConnection.insertGuardado(username,codigoDieta);
                    DBConnection.setFavorito(codigoDieta, username);
                    String escodiga = codigoDieta;
                    session.setAttribute("platos",platosRegistro);
                    session.setAttribute("escogida","0");
                }
            }
        }else{
            url = "./registro";
            session.setAttribute("errorRegistro", "Las contraseñas no coinciden");
        }
        // Como he recibido con post tengo que hacer redirect !!!
        
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
