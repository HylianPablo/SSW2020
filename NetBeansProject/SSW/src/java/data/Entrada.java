package data;
import java.io.Serializable;
import java.time.LocalDateTime;

public class Entrada implements Serializable{
	private String codigoEntrada, titulo, cuerpo, nombreUsuario;
	private String fecha;

	public Entrada(){
	}

	public String getCodigoEntrada(){
		return codigoEntrada;
	}

	public String getTitulo(){
		return titulo;
	}

	public String getCuerpo(){
		return cuerpo;
	}

	public String getNombreUsuario(){
		return nombreUsuario;
	}

	public String getFecha(){
		return fecha;
	}
        
        public void setCodigoEntrada(String c){
            codigoEntrada=c;
        }
        
        public void setTitulo(String t){
            titulo=t;
        }
        
        public void setCuerpo(String c){
            cuerpo=c;
        }
        
        public void setNombreUsuario(String nu){
            nombreUsuario=nu;
        }
        
        public void setFecha(String f){
            fecha=f;
        }
}
