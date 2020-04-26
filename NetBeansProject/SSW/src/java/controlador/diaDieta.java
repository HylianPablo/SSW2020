/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
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
        //String codigoPlato = request.getParameter("codigoPlato");
        HttpSession session = request.getSession();
        
        int glucidos=0, lipidos=0, proteinas=0;
        
        ArrayList <String> platosElegidos=null; //Array de codigos de platos elegidos hasta esta iteracion
        ArrayList <Boolean> alergias=null;  //Alergias elegidas al principio, no se modifican
        ArrayList <Plato> platos=null; //Platos que se podrán elegir el siguiente día comidas generales
        ArrayList <Plato> platosDesayuno=null; //Platos que se podrán elegir el siguiente día desayuno
        if(diaSemana.equals("0")){
            platosElegidos = new ArrayList<>();
            alergias = new ArrayList<>();
            try{
                boolean vegano = (request.getParameter("vegano") != null);
                alergias.add(vegano);
                boolean vegetariano = (request.getParameter("vegetariano") != null);
                alergias.add(vegetariano);
                boolean frutosSecos = (request.getParameter("frutosSecos") != null);
                alergias.add(frutosSecos);
                boolean celiaco = (request.getParameter("celiaco") != null);
                alergias.add(celiaco);
                boolean cerdo = (request.getParameter("cerdo") != null);
                alergias.add(cerdo);
                boolean marisco = (request.getParameter("marisco") != null);
                alergias.add(marisco);
                boolean huevo = (request.getParameter("huevo") != null);
                alergias.add(huevo);
                boolean pescado = (request.getParameter("pescado") != null);
                alergias.add(pescado);
                boolean  cacahuetes = (request.getParameter("cacahuetes") != null);
                alergias.add(cacahuetes);
                boolean soja = (request.getParameter("soja") != null);
                alergias.add(soja);
                boolean melocoton = (request.getParameter("melocoton") != null);
                alergias.add(melocoton);
                boolean pera = (request.getParameter("pera") != null);
                alergias.add(pera);
                boolean manzana = (request.getParameter("manzana") != null);
                alergias.add(manzana);
                boolean melon = (request.getParameter("melon") != null);
                alergias.add(melon);
                boolean kiwi = (request.getParameter("kiwi") != null);
                alergias.add(kiwi);
                boolean piña = (request.getParameter("piña") != null);
                alergias.add(piña);
                boolean fresa = (request.getParameter("fresa") != null);
                alergias.add(fresa);
                boolean lactosa = (request.getParameter("lactosa") != null);
                alergias.add(lactosa);
                boolean musulman = (request.getParameter("musulman") != null);
                alergias.add(musulman);
                boolean hindu = (request.getParameter("hindu") != null);
                alergias.add(hindu);
            }catch(Exception e){
                e.printStackTrace();
            }
        }else{
            try{
            alergias = (ArrayList) session.getAttribute("alergias");
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
        
        if(!diaSemana.equals("0")){
            //SE TRANSFORMA ARRAY DE CODIGOS(STRING) A ARRAY DE PLATOS
            //Tiene utilidad para sacar los valores de las macromoleculas
            ArrayList<Plato> platosDATOS = DBConnection.selectPlatosFromCodigo(platosElegidos);
            for(int i=0;i<platosDATOS.size();i++){
                glucidos+=platosDATOS.get(i).getGlucidosP100();
                lipidos+=platosDATOS.get(i).getLipidosP100();
                proteinas+=platosDATOS.get(i).getProteinasP100();
            }
            //AQUI SE CALCULAN LAS VARIABLES DE MACROMOLECULAS, ARRAY PLATOSELEGIDOS ES DE STRINGS
            //System.out.println("hola");
            platos = DBConnection.selectPlatosDias(alergias,0,0,0,0,0);
            platosDesayuno = DBConnection.selectPlatosDiasDesayuno(alergias,0,0,0,0,0);
            Collections.shuffle(platos);
            Collections.shuffle(platosDesayuno);
            
        }else{
            platos = DBConnection.selectPlatosDias(alergias,0,0,0,0,0);
            platosDesayuno = DBConnection.selectPlatosDiasDesayuno(alergias,0,0,0,0,0);
            Collections.shuffle(platos);
            Collections.shuffle(platosDesayuno);
            
        }
        //glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono);
        //Da mal generar dieta hasta que se haga esta consulta
        
        session.setAttribute("platosElegidos",platosElegidos);
        session.setAttribute("diaSemana", diaSemana);
        session.setAttribute("platos",platos);
        session.setAttribute("platosDesayuno",platosDesayuno);
        session.setAttribute("alergias",alergias);

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
