package data;

import java.io.Serializable;

public class Ingrediente implements Serializable{
	private String nombre, codigoIngrediente;
	private boolean vegano, vegetariano, frutosSecos, gluten;
        
        public Ingrediente(){
            
        }      

	public String getNombre(){
		return nombre;
	}
        
        public void setNombre(String nombre){
                this.nombre = nombre;
        }

	public String getCodigoIngrediente(){
		return codigoIngrediente;
	}
        
        public void setCodigoIngrediente(String codigo){
		codigoIngrediente = codigo;
	}

	public boolean vegano(){
		return vegano;
	}
        
        public void setVegano(boolean vegano){
		this.vegano = vegano;
	}

	public boolean vegetariano(){
		return vegetariano;
	}
        
        public void setVegetariano(boolean vegetariano){
		this.vegetariano = vegetariano;
	}

	public boolean frutosSecos(){
		return frutosSecos;
	}
        
        public void setFrutosSecos(boolean frutosSecos){
		this.frutosSecos = frutosSecos;
	}
        
	public boolean gluten(){
		return gluten;
	}
        
        public void setGluten(boolean gluten){
		this.gluten = gluten;
	}
}
