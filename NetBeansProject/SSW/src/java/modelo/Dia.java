/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.util.ArrayList;

/**
 *
 * @author alejandro
 */
public class Dia {
    
    ArrayList<Plato> platos;
    
    public Dia(){
        platos = new ArrayList<>();
    }
    
    public Plato getPlato(int indice){
        return platos.get(indice);
    }
    
    public void addPlato(Plato plato){
        platos.add(plato);
    }
}
