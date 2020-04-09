package data;
import java.time.LocalDateTime;

public class Comentario{
	private String codigoComentario, codigoPadre, cuerpo, nombreUsuario;
	private LocalDateTime fecha;

	public Comentario(String codigoComentario, String codigoPadre,
		String cuerpo, String nombreUsuario, LocalDateTime fecha){
		this.codigoComentario=codigoComentario;
		this.codigoPadre=codigoPadre;
		this.cuerpo=cuerpo;
		this.nombreUsuario=nombreUsuario;
		this.fecha=fecha;
	}

	public String getCodigoComentario(){
		return codigoComentario;
	}

	public String getCodigoPadre(){
		return codigoPadre;
	}

	public String getCuerpo(){
		return cuerpo;
	}

	public String getNombreUsuario(){
		return nombreUsuario;
	}

	public LocalDateTime getFecha(){
		return fecha;
	}
}
