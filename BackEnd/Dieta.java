public class Dieta{

	private String codigoDieta, titulo, descripcion;

	public Dieta(String codigoDieta, String titulo, String descipcion){
		this.codigoDieta = codigoDieta;
		this.titulo = titulo;
		this.descipcion = descipcion;
	}

	public String getCodigoDieta(){
		return codigoDieta;
	}

	public String getTitulo(){
		return titulo;
	}

	public String getDescripcion(){
		return descripcion;
	}
}