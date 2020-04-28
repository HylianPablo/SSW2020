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

    
    
    
    private ArrayList<Plato> tresPlatos(ArrayList<Boolean> alergias, int glucidos, 
            int lipidos, int proteinas, int rangoIni, int rangoAumento, boolean desayuno){
        ArrayList<Plato> respuesta, temp;
        int rango = rangoIni;
        glucidos = Plato.glucidosGram(glucidos);
        lipidos = Plato.lipidosGram(lipidos);
        proteinas = Plato.proteinasGram(proteinas);
        do{ 
            respuesta = DBConnection.selectPlatosDias(alergias, glucidos, lipidos, proteinas, rango, desayuno);
            rango += rangoAumento;
            if(rango > 220)
                break;
        }while(respuesta.size()<3);
        if(respuesta.size()==0){
            Plato platoEmergencia = DBConnection.selectPlato("33");
            respuesta.add(platoEmergencia);
        }
        if(respuesta.size()<3){
            for(int i = respuesta.size(); i < 3; i++)
                respuesta.add(respuesta.get(0));
        }else if(respuesta.size()>3){
            Collections.shuffle(respuesta);
            temp = respuesta;
            respuesta = new ArrayList<>();
            for(int i = 0; i < 3; i++)
                respuesta.add(temp.get(i));
        }
        return respuesta;
    }
    
    private void addAlergias(ArrayList<Boolean> alergias, HttpServletRequest request){
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
    }
    
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
        String usuario = request.getParameter("usuario");
        HttpSession session = request.getSession();
        int glucidos=0, lipidos=0, proteinas=0;
        
        ArrayList <String> platosElegidos=null; //Array de codigos de platos elegidos hasta esta iteracion
        ArrayList <Boolean> alergias=null;  //Alergias elegidas al principio, no se modifican
        ArrayList <Plato> platos=null; //Platos que se podrán elegir el siguiente día comidas generales
        ArrayList <Plato> platosDATOS=null; //Arraylist de platos (objetos) elegidos hasta el momento
        ArrayList <Plato> platosComida1, platosComida2, platosCena, platosDesayuno=null; //Platos que se podrán elegir el siguiente día desayuno
        if(diaSemana.equals("0")){
            platosElegidos = new ArrayList<>();
            alergias = new ArrayList<>();
            addAlergias(alergias, request);
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
        System.out.println(usuario);
        if(diaSemana.equals("7")){
            if(usuario.equals("0")){
                url = "/FrontEnd/dietaGenerada.jsp";
            }else{
                url = "/FrontEnd/dietaGeneradaUsuario.jsp";
            }
        }else{
            if(usuario.equals("0")){
                url = "/FrontEnd/diaDieta.jsp";
            }else{
                url = "/FrontEnd/diaDietaUsuario.jsp";
            }
            int rango = 10, rangoAum = 20;
            if(!diaSemana.equals("0")){
                platosDATOS = DBConnection.selectPlatosFromCodigo(platosElegidos);
                for(int i=0;i<platosDATOS.size();i++){
                    glucidos+=platosDATOS.get(i).getGlucidosP100();
                    lipidos+=platosDATOS.get(i).getLipidosP100();
                    proteinas+=platosDATOS.get(i).getProteinasP100();
                }
                glucidos = 100 + Integer.parseInt(diaSemana)*100 - glucidos;
                lipidos = 100 + Integer.parseInt(diaSemana)*100 - lipidos;
                proteinas = 100 + Integer.parseInt(diaSemana)*100 - proteinas;
            }else{
                glucidos = 100;
                lipidos = 100;
                proteinas = 100;
            }
            platosComida1 = tresPlatos(alergias,(int)(0.4*(glucidos)),(int)(0.3*(lipidos)),(int)(0.1*(proteinas)), rango, rangoAum, false);
            platosComida2 = tresPlatos(alergias,(int)(0.25*(glucidos)),(int)(0.3*(lipidos)),(int)(0.8*(proteinas)),rango, rangoAum, false);
            platosCena = tresPlatos(alergias,(int)(0.25*(glucidos)),(int)(0.3*(lipidos)),(int)(0.1*(proteinas)), rango, rangoAum, false);
            platosDesayuno = tresPlatos(alergias,(int)(0.1*(glucidos)),(int)(0.1*(lipidos)),(int)(0.0*(proteinas)), rango, rangoAum, true);

            platos = new ArrayList<>();
            for(int i=0; i<Math.min(platosComida1.size(), 3);i++)
                platos.add(platosComida1.get(i));
            for(int i=0; i<Math.min(platosComida2.size(), 3);i++)
                platos.add(platosComida2.get(i));
            for(int i=0; i<Math.min(platosCena.size(), 3);i++)
                platos.add(platosCena.get(i));
            
            
            session.setAttribute("platos",platos);
            session.setAttribute("usuario",usuario);
            session.setAttribute("platosDesayuno",platosDesayuno);
            session.setAttribute("diaSemana", diaSemana);
            session.setAttribute("alergias",alergias);
        }
        if(diaSemana.equals("7")){
            platosDATOS = DBConnection.selectPlatosFromCodigo(platosElegidos);
            session.setAttribute("platosDATOS",platosDATOS);
        }
        
        session.setAttribute("platosElegidos",platosElegidos);

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
