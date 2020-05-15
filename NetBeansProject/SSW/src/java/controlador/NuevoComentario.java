/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import modelo.Comentario;
import modelo.DBConnection;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Entrada;

/**
 *
 * @author Javier
 */
@WebServlet(name = "NuevoComentario", urlPatterns = {"/FrontEnd/NuevoComentario"})
public class NuevoComentario extends HttpServlet {

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
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        String codigoComentario = DBConnection.getLastCodigoComentario();
        codigoComentario = String.format("%05d",Integer.parseInt(codigoComentario)+1);
        String cuerpo = request.getParameter("cuerpoComentario");
        String usuario = (String) session.getAttribute("sessionUser");
        String codigoEntrada = request.getParameter("codigoEntrada");
        LocalDateTime date = LocalDateTime.now();
        Comentario comentario = new Comentario();
        comentario.setCodigoComentario(codigoComentario);
        comentario.setCodigoPadre(codigoEntrada);
        comentario.setCuerpo(cuerpo);
        comentario.setFecha(date);
        comentario.setNombreUsuario(usuario);
        DBConnection.insertComentario(comentario);
        String url = "/FrontEnd/entradaUsuario.jsp"; 
        ArrayList<Comentario> comentarios = DBConnection.getComentarios(codigoEntrada);
        Entrada entrada = DBConnection.selectEntrada(codigoEntrada);
        session.setAttribute("codigoEntrada", codigoEntrada);
        session.setAttribute("entrada", entrada);
        session.setAttribute("comentarios", comentarios);
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
