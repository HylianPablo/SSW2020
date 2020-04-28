package modelo;

import java.io.Serializable;

import java.time.LocalDateTime;

public class Comentario implements Serializable{
	private String codigoComentario, codigoPadre, cuerpo, nombreUsuario;
        private LocalDateTime fecha;
        
        public Comentario(){
            
        }

	public String getCodigoComentario(){
		return codigoComentario;
	}
        
        public void setCodigoComentario(String codigo){
		codigoComentario = codigo;
	}

	public String getCodigoPadre(){
		return codigoPadre;
	}
        
        public void setCodigoPadre(String codigo){
		codigoPadre = codigo;
	}

	public String getCuerpo(){
		return cuerpo;
	}
        
        public void setCuerpo(String cuerpo){
		this.cuerpo = cuerpo;
	}

	public String getNombreUsuario(){
		return nombreUsuario;
	}
        
        public void setNombreUsuario(String nombre){
		nombreUsuario = nombre;
	}

	public LocalDateTime getFecha(){
		return fecha;
	}
        
        public void setFecha(LocalDateTime fecha){
		this.fecha = fecha;
	}
}
