import java.time.LocalDateTime;

public class Entrada{
	private String codigoEntrada, titulo, cuerpo, nombreUsuario;
	private LocalDateTime fecha;

	public Usuario(String codigoEntrada, String titulo, String cuerpo,
			String nombreUsuario, LocalDateTime fecha){
		this.codigoEntrada=codigoEntrada;
		this.titulo=titulo;
		this.cuerpo=cuerpo;
		this.nombreUsuario=nombreUsuario;
		this.fecha=fecha;
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

	public LocalDateTime getFecha(){
		return fecha;
	}
}
