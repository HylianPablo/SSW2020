public class Ingrediente{

	private String nombre, codigoIngrediente;
	private boolean vegano, vegetariano, frutosSecos, gluten;

	public Ingrendiente(String codigoIngrediente, String nombre, boolean vegano, boolean vegetariano, boolean frutosSecos, boolean gluten){
		this.nombre = nombre;
		this.vegano = vegano;
		this.codigoIngrediente = codigoIngrediente;
		this.vegetariano = vegetariano;
		this.frutosSecos = frutosSecos;
		this.gluten = gluten;
	}

	public String getNombre(){
		return nombre;
	}

	public String getCodigoIngrediente(){
		return codigoIngrediente;
	}

	public boolean vegano(){
		return vegano;
	}

	public boolean vegetariano(){
		return vegetariano;
	}

	public boolean frutosSecos(){
		return frutosSecos;
	}

	public boolean gluten(){
		return gluten;
	}
}