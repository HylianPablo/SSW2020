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
        //String codigoPlato = request.getParameter("codigoPlato");
        HttpSession session = request.getSession();
        
        int glucidosSimples=0;
        int polisacaridos=0;
        int aminoacidos=0;
        int proteinas=0;
        int hidratosDeCarbono=0;
        
        ArrayList <String> platosElegidos=null; //Array de codigos de platos elegidos hasta esta iteracion
        ArrayList <Boolean> alergias=null;  //Alergias elegidas al principio, no se modifican
        ArrayList <Plato> platos=null; //Platos que se podrán elegir el siguiente día
        if(diaSemana.equals("0")){
            platosElegidos = new ArrayList<>();
            alergias = new ArrayList<>();
            try{
                boolean vegano = Boolean.parseBoolean(request.getParameter("vegano"));
                alergias.add(vegano);
                boolean vegetariano = Boolean.parseBoolean(request.getParameter("vegetariano"));
                alergias.add(vegetariano);
                boolean frutosSecos = Boolean.parseBoolean(request.getParameter("frutosSecos"));
                alergias.add(frutosSecos);
                boolean celiaco = Boolean.parseBoolean(request.getParameter("celiaco"));
                alergias.add(celiaco);
                boolean cerdo = Boolean.parseBoolean(request.getParameter("cerdo"));
                alergias.add(cerdo);
                boolean marisco = Boolean.parseBoolean(request.getParameter("marisco"));
                alergias.add(marisco);
                boolean huevo = Boolean.parseBoolean(request.getParameter("huevo"));
                alergias.add(huevo);
                boolean pescado = Boolean.parseBoolean(request.getParameter("pescado"));
                alergias.add(pescado);
                boolean cacahuetes = Boolean.parseBoolean(request.getParameter("cacahuetes"));
                alergias.add(cacahuetes);
                boolean soja = Boolean.parseBoolean(request.getParameter("soja"));
                alergias.add(soja);
                boolean melocoton = Boolean.parseBoolean(request.getParameter("melocoton"));
                alergias.add(melocoton);
                boolean pera = Boolean.parseBoolean(request.getParameter("pera"));
                alergias.add(pera);
                boolean manzana = Boolean.parseBoolean(request.getParameter("manzana"));
                alergias.add(manzana);
                boolean melon = Boolean.parseBoolean(request.getParameter("melon"));
                alergias.add(melon);
                boolean kiwi = Boolean.parseBoolean(request.getParameter("kiwi"));
                alergias.add(kiwi);
                boolean piña = Boolean.parseBoolean(request.getParameter("piña"));
                alergias.add(piña);
                boolean fresa = Boolean.parseBoolean(request.getParameter("fresa"));
                alergias.add(fresa);
                boolean lactosa = Boolean.parseBoolean(request.getParameter("lactosa"));
                alergias.add(lactosa);
                boolean musulman = Boolean.parseBoolean(request.getParameter("musulman"));
                alergias.add(musulman);
                boolean hindu = Boolean.parseBoolean(request.getParameter("hindu"));
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
            ArrayList<Plato> platosDATOS = DBConnection.selectPlatosFromCodigo(platosElegidos);
            for(int i=0;i<platosDATOS.size();i++){
                glucidosSimples+=platosDATOS.get(i).getGlucidosSimples();
                polisacaridos+=platosDATOS.get(i).getPolisacaridos();
                aminoacidos+=platosDATOS.get(i).getAminoacidos();
                proteinas+=platosDATOS.get(i).getProteinas();
                hidratosDeCarbono+=platosDATOS.get(i).getHidratosDeCarbono();
            }
            //AQUI SE CALCULAN LAS VARIABLES DE MACROMOLECULAS, ARRAY PLATOSELEGIDOS ES DE STRINGS
            platos = DBConnection.selectPlatosDias(alergias,
                    glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono);
            //Da mal generar dieta hasta que se haga esta consulta
            System.out.println("TAMAÑO DE PLATOS ELEGIDOS: "+platos.size());
        }
        session.setAttribute("platosElegidos",platosElegidos);
        session.setAttribute("diaSemana", diaSemana);
        session.setAttribute("platos",platos);
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
