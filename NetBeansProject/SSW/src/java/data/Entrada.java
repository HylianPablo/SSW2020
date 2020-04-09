package data;
import java.io.Serializable;
import java.time.LocalDateTime;

public class Entrada implements Serializable{
	private String codigoEntrada, titulo, cuerpo, nombreUsuario;
        private LocalDateTime fecha;
        
	public Entrada(){
            
	}

	public String getCodigoEntrada(){
		return codigoEntrada;
	}
        
        public void setCodigoEntrada(String codigo){
		codigoEntrada = codigo;
	}

	public String getTitulo(){
		return titulo;
	}
        
        public void setTitulo(String titulo){
		this.titulo = titulo;
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
