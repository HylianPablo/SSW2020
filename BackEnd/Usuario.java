public class Usuario{
	private String nombreUsuario, nombre, contrasena, correo, favorito;

	public Usuario(String nombreUsuario, String nombre, String contrasena,
			String correo, String favorito){
		this.nombreUsuario=nombreUsuario;
		this.nombre=nombre;
		this.contrasena=contrasena;
		this.correo=correo;
		this.favorito=favorito;
	}

	public String getNombreUsuario(){
		return nombreUsuario;
	}

	public String getNombre(){
		return nombre;
	}

	public String getContrasena(){
		return contrasena;
	}

	public String getCorreo(){
		return correo;
	}

	public String getFavorito(){
		return favorito;
	}
}
