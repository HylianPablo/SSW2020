public class Plato{
	private String codigoPlato nombre, descripcion;
	private boolean desayuno, vegano, vegetariano, frutosSecos, gluten;
	private int kcal, glucidosSimples, polisacaridos, aminoacidos, proteinas, hidratosDeCarbono;

	public Plato(String codigoPlato, String nombre, String descripcion,
			boolean desayuno, boolean vegano, boolean vegetariano, boolean frutosSecos, boolean gluten, int kcal, int glucidosSimples, int polisacaridos, int aminoacidos, int proteinas, int hidratosDeCarbono){
		this.codigoPlato=codigoPlato;
		this.nombre=nombre;
		this.descripcion=descripcion;
		this.desayuno=desayuno;
		this.vegano=vegano;
		this.vegetariano=vegetariano;
		this.frutosSecos=frutosSecos;
		this.gluten=gluten;
		this.kcal=kcal;
		this.glucidosSimples=glucidosSimples;
		this.polisacaridos=polisacaridos;
		this.aminoacidos=aminoacidos;
		this.proteinas=proteinas;
		this.hidratosDeCarbono=hidratosDeCarbono;
	}

	public String getCodigoPlato(){
		return codigoPlato;
	}

	public String getNombre(){
		return nombre;
	}

	public String getDescripcion(){
		return descripcion;
	}

	public boolean getDesayuno(){
		return desayuno;
	}

	public boolean getVegano(){
		return vegano;
	}

	public boolean getVegetariano(){
		return vegetariano;
	}

	public boolean getFrutosSecos(){
		return frutosSecos;
	}

	public boolean getGluten(){
		return gluten;
	}

	public int getKcal(){
		return kcal;
	}

	public int getGlucidosSimples(){
		return glucidosSimples;
	}

	public int getPolisacaridos(){
		return polisacaridos;
	}

	public int getAminoacidos(){
		return aminoacidos;
	}

	public int getProteinas(){
		return proteinas;
	}

	public int getHidratosDeCarbono(){
		return hidratosDeCarbono;
	}
}