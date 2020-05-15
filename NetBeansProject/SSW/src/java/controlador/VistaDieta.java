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

/**
 *
 * @author alejandro
 */
@WebServlet(name = "DietaUsuario", urlPatterns = {"/FrontEnd/dieta"})
public class VistaDieta extends HttpServlet {

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
        String cod = request.getParameter("cod");
        String url = "/FrontEnd/dieta.jsp";
        Dieta dieta;
        String usuario = (String) session.getAttribute("sessionUser");
        String favorito = request.getParameter("favorito");
        String guardado = request.getParameter("guardado");
        System.out.println("hola " + favorito);
        ArrayList<Plato> platos = null;
        if(cod != null){
            platos = DBConnection.getPlatosDieta(cod);
            if(platos != null && !platos.isEmpty()){
                
                dieta = DBConnection.selectDieta(cod);
                if(usuario != null){
                    boolean guardadoTemp = DBConnection.checkGuardado(usuario, cod);
                    boolean favoritoTemp = DBConnection.checkFavorito(usuario, cod);
                    
                    if(favorito == null){
                        favorito = String.valueOf(favoritoTemp);
                    }
                    if(guardado == null){
                        guardado = String.valueOf(guardadoTemp);
                    }
                    if(String.valueOf(guardadoTemp).equals(guardado)){
                        guardado = String.valueOf(guardadoTemp);
                    }
                    if(String.valueOf(favoritoTemp).equals(favorito)){
                        favorito = String.valueOf(favoritoTemp);
                    }
                    session.setAttribute("guardado", guardado);
                    session.setAttribute("favorito", favorito);
                    url = "/FrontEnd/dietaUsuario.jsp";
                }
                session.setAttribute("platos", platos);
                session.setAttribute("codDieta", cod);
                session.setAttribute("dieta", dieta);
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
                dispatcher.forward(request, response);
            }
        }
        if(platos == null || platos.isEmpty()){
            response.sendRedirect("/SSW/FrontEnd/ranking");
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
