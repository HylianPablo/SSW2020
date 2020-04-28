package modelo;

import java.io.Serializable;

public class Usuario implements Serializable{
	private String nombreUsuario, nombre, contrasena, correo, favorito;
        
        public Usuario(){
            
        }

	public String getNombreUsuario(){
		return nombreUsuario;
	}
        
        public void setNombreUsuario(String nombre){
		nombreUsuario = nombre;
	}

	public String getNombre(){
		return nombre;
	}
        
        public void setNombre(String nombre){
		this.nombre = nombre;
	}

	public String getContrasena(){
		return contrasena;
	}
        
        public void setContrasena(String contraseña){
		this.contrasena = contraseña;
	}

	public String getCorreo(){
		return correo;
	}
        
        public void setCorreo(String correo){
		this.correo = correo;
	}

	public String getFavorito(){
		return favorito;
	}
        
        public void setFavorito(String favorito){
		this.favorito = favorito;
	}
}
