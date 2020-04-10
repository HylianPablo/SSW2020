/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

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
    
    public Plato getPlato(int i){
        return platos.get(i);
    }
    
    public void addPlato(Plato plato){
        platos.add(plato);
    }
}
