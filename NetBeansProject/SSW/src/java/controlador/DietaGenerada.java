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
import modelo.Plato;

/**
 *
 * @author pablo
 */
@WebServlet(name = "dietaGenerada", urlPatterns = {"/FrontEnd/dietaGenerada"})
public class DietaGenerada extends HttpServlet {

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
        ArrayList<Plato> platosElegidos = (ArrayList)session.getAttribute("platosDATOS");
        //ArrayList<Plato> platosElegidos = 
        String url;
        String escogida = null;
        String codigoDieta ="";
        String usuario = (String) session.getAttribute("sessionUser");
        String titulo = request.getParameter("nombreDieta");

        if(usuario!=null){
            url = "./index";
            if(titulo.equals("")){
                titulo = "Dieta de "+usuario;
            }
            Timestamp ld = new Timestamp(System.currentTimeMillis());
            String descripcion = "Dieta creada por el usuario "+usuario;
            DBConnection.insertDieta(titulo,descripcion,ld);
            codigoDieta = DBConnection.getLastCodigoDieta();
            DBConnection.insertPlatosMenu(platosElegidos,codigoDieta);
            DBConnection.insertGuardado(usuario,codigoDieta);
            
            escogida = codigoDieta;
        }else{
            session.setAttribute("platosRegistro",platosElegidos);
            session.setAttribute("tituloDieta",titulo);
            url = "./registro";
        }
        
        session.setAttribute("platos",platosElegidos);
        session.setAttribute("escogida","0");
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
