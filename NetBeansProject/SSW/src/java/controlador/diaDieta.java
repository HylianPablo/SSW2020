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
import modelo.Plato;

/**
 *
 * @author pablo
 */
@WebServlet(name = "diaDieta", urlPatterns = {"/FrontEnd/diaDieta", "/FrontEnd/generaDieta/diaDieta"})
public class diaDieta extends HttpServlet {

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
        String diaSemana = request.getParameter("diaSemana");
        HttpSession session = request.getSession();
        
        ArrayList <String> platosElegidos=null;
        if(diaSemana.equals("0")){
            platosElegidos = new ArrayList<>();
        }else{
            try{
            platosElegidos = (ArrayList)session.getAttribute("platosElegidos");
            String desayuno = request.getParameter("desayuno");
            String comida1 = request.getParameter("comida1");
            String comida2 = request.getParameter("comida2");
            String cena = request.getParameter("cena");
            platosElegidos.add(desayuno);
            platosElegidos.add(comida1);
            platosElegidos.add(comida2);
            platosElegidos.add(cena);
            }catch(Exception e){
                e.printStackTrace();
            }       
        }
        
        if(diaSemana.equals("7")){
            url = "/FrontEnd/dietaGenerada.jsp";
        }else{
            url = "/FrontEnd/diaDieta.jsp";
        }
        String codigoPlato ="00000000";
        int codigoInt = 0;
        Plato plato = DBConnection.selectPlato(codigoPlato);
        ArrayList<Plato> platos = new ArrayList<>();
        for(int i = 0; i < 4; i++){
            for(int j = 0; j < 3; j++){
                codigoInt++;
                codigoPlato = String.format("%08d",codigoInt);
                plato =  DBConnection.selectPlato(codigoPlato);
                platos.add(plato);
            }
        }
        
        session.setAttribute("platosElegidos",platosElegidos);
        session.setAttribute("diaSemana", diaSemana);
        session.setAttribute("platos",platos);
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