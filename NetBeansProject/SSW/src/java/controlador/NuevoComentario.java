/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import modelo.Comentario;
import modelo.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.Month;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        response.setContentType("text/html;charset=UTF-8");
        String codigoComentario = DBConnection.getLastCodigoComentario();
        codigoComentario = String.format("%05d",Integer.parseInt(codigoComentario)+1);
        String cuerpo = request.getParameter("cuerpoComentario");
        String usuario = request.getParameter("usuario");
        String codigoEntrada = request.getParameter("codigoEntrada");
        LocalDateTime date = LocalDateTime.of(2019,Month.APRIL,03, 19, 30, 40);//request.getParameter("fechaNuevaEntrada");
        Comentario comentario = new Comentario();
        comentario.setCodigoComentario(codigoComentario);
        comentario.setCodigoPadre(codigoEntrada);
        comentario.setCuerpo(cuerpo);
        comentario.setFecha(date);
        comentario.setNombreUsuario(usuario);
        DBConnection.insertComentario(comentario);
        String url = "/SSW/FrontEnd/entradaUsuario.jsp?cod="+codigoEntrada; //ahora la url tiene SSW
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
