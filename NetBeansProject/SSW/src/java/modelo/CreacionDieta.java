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

public class CreacionDieta {
    
    ArrayList<Dia> dias;
    
    public CreacionDieta(){
        dias = new ArrayList<>();
    }
    
    public Dia getDia(int i){
        return dias.get(i);
    }
    
    public void clear(){
        dias.clear();
    }
}
