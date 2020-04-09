package data;
public class Dieta{
	private String codigoDieta, titulo, descripcion;

	public Dieta(String codigoDieta, String titulo, String descripcion){
		this.codigoDieta = codigoDieta;
		this.titulo = titulo;
		this.descripcion = descripcion;
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