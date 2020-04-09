package data;
public class Plato{
	private String codigoPlato, nombre, descripcion;
	private boolean desayuno, vegano, vegetariano, frutosSecos, gluten;
	private int kcal, glucidosSimples, polisacaridos, aminoacidos, proteinas, hidratosDeCarbono;

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
        
    	public void setGlucidosSimples(int glucidosSimples){
		this.glucidosSimples=glucidosSimples;
	}

	public int getPolisacaridos(){
		return polisacaridos;
	}
        
    	public void setPolisacaridos(int polisacaridos){
		this.polisacaridos=polisacaridos;
	}

	public int getAminoacidos(){
		return aminoacidos;
	}
        
    	public void setAminoacidos(int aminoacidos){
		this.aminoacidos=aminoacidos;
	}

	public int getProteinas(){
		return proteinas;
	}
        
    	public void setProteinas(int proteinas){
		this.proteinas=proteinas;
	}

	public int getHidratosDeCarbono(){
		return hidratosDeCarbono;
	}
        
    	public void setHidratosDeCarbono(int hidratosDeCarbono){
		this.hidratosDeCarbono= hidratosDeCarbono;
	}
}
