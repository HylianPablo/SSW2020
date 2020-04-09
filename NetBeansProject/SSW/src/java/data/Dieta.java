package data;

import java.io.Serializable;

public class Dieta implements Serializable{
	private String codigoDieta, titulo, descripcion;
        
        public Dieta(){
            
        }

	public String getCodigoDieta(){
		return codigoDieta;
	}
        
        public void setCodigoDieta(String codigo){
                codigoDieta = codigo;
	}

	public String getTitulo(){
		return titulo;
	}
        
        public void setTitulo(String titulo){
		this.titulo = titulo;
	}

	public String getDescripcion(){
		return descripcion;
	}
        
        public void setDescripcion(String descripcion){
		this.descripcion = descripcion;
	}
}