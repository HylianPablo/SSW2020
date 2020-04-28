/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.Month;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Comentario;
import modelo.DBConnection;
import modelo.Dieta;

/**
 *
 * @author alejandro
 */
@WebServlet(name = "Ranking", urlPatterns = {"/FrontEnd/ranking"})
public class Ranking extends HttpServlet {

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
        Boolean favoritasTemp;
        String criterio = request.getParameter("criterio");
        if (criterio != null && criterio.equals("Favoritas")) {
            favoritasTemp = true;
        } else {
            favoritasTemp = false;
        }
        Boolean siempreTemp = false;
        Integer selectTiempoTemp = 5;
        LocalDateTime hoy = LocalDateTime.of(2020, Month.APRIL, 03, 19, 30, 40);
        LocalDateTime fechaLimiteTemp;
        String tiempo = request.getParameter("tiempo");
        if (tiempo == null || tiempo.equals("Siempre")) {
            siempreTemp = true;
            selectTiempoTemp = 0;
            fechaLimiteTemp = hoy;
        } else if (tiempo.equals("Última Semana")) {
            selectTiempoTemp = 1;
            fechaLimiteTemp = hoy.minusDays(7);
        } else if (tiempo.equals("Último Mes")) {
            selectTiempoTemp = 2;
            fechaLimiteTemp = hoy.minusMonths(1);
        } else {
            selectTiempoTemp = 3;
            fechaLimiteTemp = hoy.minusYears(1);
        }

        ArrayList<Dieta> dietas;
        if (favoritasTemp) {
            dietas = DBConnection.getDietasFavoritas();
        } else {
            dietas = DBConnection.getDietasGuardadas();
        }

        //ArrayList<Comentario> comentarios = DBConnection.getComentarios(cod);
        String url = "/FrontEnd/ranking.jsp";
        HttpSession session = request.getSession();
        String siempre = String.valueOf(siempreTemp);
        String fechaLimite = fechaLimiteTemp.toString();
        String selectTiempo = String.valueOf(selectTiempoTemp);
        String favoritas = String.valueOf(favoritasTemp);
        session.setAttribute("siempre", siempre);
        session.setAttribute("dietas", dietas);
        session.setAttribute("favoritas", favoritas);
        session.setAttribute("tiempo", tiempo);
        session.setAttribute("fechaLimite", fechaLimite);
        session.setAttribute("selectTiempo", selectTiempo);

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
