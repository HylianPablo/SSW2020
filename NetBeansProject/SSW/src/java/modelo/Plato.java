package modelo;

import java.io.Serializable;

public class Plato implements Serializable{
	private String codigoPlato, nombre, descripcion;
	private boolean desayuno, vegano, vegetariano, frutosSecos, gluten;
	private int kcal, glucidosSimples, polisacaridos, lipidos, proteinas;
        private static double glucDiarios = 250.0, protDiarios = 75, lipDiarios = 60;

	public Plato(){

	}

	public String getCodigoPlato(){
		return codigoPlato;
	}
        
    	public void setCodigoPlato(String codigoPlato){
		this.codigoPlato=codigoPlato;
	}

	public String getNombre(){
		return nombre;
	}

	public void setNombre(String nombre){
		this.nombre=nombre;
	}

	public String getDescripcion(){
		return descripcion;
	}
        
    	public void setDescripcion(String descripcion){
		this.descripcion=descripcion;
	}

	public boolean getDesayuno(){
		return desayuno;
	}
        
    	public void setDesayuno(boolean desayuno){
		this.desayuno=desayuno;
	}
	
	public boolean getVegano(){
		return vegano;
	}
        
    	public void setVegano(boolean vegano){
		this.vegano=vegano;
	}

	public boolean getVegetariano(){
		return vegetariano;
	}
        
    	public void setVegetariano(boolean vegetariano){
		this.vegetariano=vegetariano;
	}

	public boolean getFrutosSecos(){
		return frutosSecos;
	}
        
    	public void setFrutosSecos(boolean frutosSecos){
		this.frutosSecos=frutosSecos;
	}

	public boolean getGluten(){
		return gluten;
	}
        
    	public void setGluten(boolean gluten){
		this.gluten=gluten;
	}

	public int getKcal(){
		return kcal;
	}
        
    	public void setKcal(int kcal){
		this.kcal=kcal;
	}

	public int getGlucidosSimples(){
		return glucidosSimples;
	}
        
        public int getGlucidosSimplesP100(){
                return (int)(glucidosSimples*100/glucDiarios);
        }
        
        public int getGlucidosP100(){
            return getGlucidosSimplesP100()+getPolisacaridosP100();
        }
        
        public static int glucidosGram(int gluc){
            return (int) ((gluc*glucDiarios)/100);
        }
        
    	public void setGlucidosSimples(int glucidosSimples){
		this.glucidosSimples=glucidosSimples;
	}

	public int getPolisacaridos(){
		return polisacaridos;
	}
        
        public int getPolisacaridosP100(){
            return (int)(polisacaridos*100/glucDiarios);
        }
        
    	public void setPolisacaridos(int polisacaridos){
		this.polisacaridos=polisacaridos;
	}

	public int getLipidos(){
		return lipidos;
	}
        
        public int getLipidosP100(){
            return (int)(lipidos*100/lipDiarios);
        }
        
        public static int lipidosGram(int lip){
            return (int) ((lip*lipDiarios)/100);
        }
        
    	public void setLipidos(int lipidos){
		this.lipidos=lipidos;
	}

	public int getProteinas(){
		return proteinas;
	}
        
        public int getProteinasP100(){
            return (int)(proteinas*100/protDiarios);
        }
        
        public static int proteinasGram(int prot){
            return (int) ((prot*protDiarios)/100);
        }
        
    	public void setProteinas(int proteinas){
		this.proteinas=proteinas;
	}
}
