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
import modelo.Plato;
import modelo.Usuario;

/**
 *
 * @author alejandro
 */
@WebServlet(name = "PaginaUsuario", urlPatterns = {"/FrontEnd/paginaUsuario"})
public class PaginaUsuario extends HttpServlet {

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

        String url;
        RequestDispatcher dispatcher;

        response.setContentType("text/html;charset=UTF-8 pageEncoding=UTF-8");
        HttpSession session = request.getSession();
        String correoUsuario = null;
        String usuario = null;
        Usuario user = null;
        String mensajeErrorIniciarSesion=null;
        if (session.getAttribute("sessionMail") == null) {
            correoUsuario = request.getParameter("usuarioInput");
            String contraseña = request.getParameter("passwordInput");
            System.out.println(correoUsuario + "," + contraseña);
            Boolean registered = DBConnection.checkRegistrado(correoUsuario, contraseña);
            if (!registered) {
                mensajeErrorIniciarSesion = "Usuario o contraseña erróneos. Introduzca los datos de nuevo.";
                session.setAttribute("mensajeErrorIniciarSesion",mensajeErrorIniciarSesion);
                url = "/FrontEnd/iniciarSesion.jsp";
                dispatcher = getServletContext().getRequestDispatcher(url);
                dispatcher.forward(request, response);
            } else {
                usuario = DBConnection.selectNombreUsuarioDesdeCorreo(correoUsuario);
                user = DBConnection.selectUsuario(usuario);
                session.setAttribute("sessionUserObj", user); 
                session.setAttribute("sessionMail", correoUsuario);
                session.setAttribute("sessionPassword", contraseña);
                session.setAttribute("sessionUser", usuario);
                System.out.println(usuario);
            }
            
        }
        usuario = (String) session.getAttribute("sessionUser");
        url = "/FrontEnd/paginaUsuario.jsp";
        System.out.println(usuario);
        Dieta dieta = DBConnection.selectDietaFavorita(usuario);
        String cri = request.getParameter("criterio");
        int criterio = 0;
        int escogida = 0;
        if (cri != null) {
            criterio = Integer.parseInt(cri);
        }
        ArrayList<Dieta> dietasGuardadas = DBConnection.selectDietasGuardadas(usuario);
        if (dieta != null) {
            dietasGuardadas.add(0, dieta);
            for (int r = 1; r < dietasGuardadas.size(); r++) {
                if (dietasGuardadas.get(r).getCodigoDieta().equals(dietasGuardadas.get(0).getCodigoDieta())) {
                    dietasGuardadas.remove(r);
                }
            }
        }

        for (int i = 0; i < dietasGuardadas.size(); i++) {
            if (Integer.parseInt(dietasGuardadas.get(i).getCodigoDieta()) == criterio) {
                escogida = i;
            }
        }
        
        System.out.println("hola" + escogida);

        ArrayList<Plato> platos = DBConnection.getPlatosDieta(dietasGuardadas.get(escogida).getCodigoDieta());

        session.setAttribute("platos", platos);
        session.setAttribute("sessionUser", usuario);
        session.setAttribute("escogida", Integer.toString(escogida));
        session.setAttribute("dietasGuardadas", dietasGuardadas);
      
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
