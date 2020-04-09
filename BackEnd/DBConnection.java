package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnection {
    //EJEMPLO 
    public static int insertUsuario(Usuario user){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryExample = "INSERT INTO Usuario(nombre,nombreUsuario,contraseña,correo,favorito) VALUES(?,?,?,?,?)";
        try{
            ps = connection.prepareStatement(queryExample);
            ps.setString(1,user.getNombre());
            ps.setString(2,user.getNombreUsuario());
            ps.setString(3,user.getContrasena());
            ps.setString(4,user.getCorreo());
            ps.setString(5,user.getFavorito());
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        }catch (SQLException e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public static int insertEntrada(Entrada entrada){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryExample = "INSERT INTO Entrada(codigoEntrada,titulo,cuerpo,nombreUsuario,fecha) VALUES(?,?,?,?,?)";
        try{
            ps = connection.prepareStatement(queryExample);
            ps.setString(1,entrada.getCodigoEntrada());
            ps.setString(2,entrada.getTitulo());
            ps.setString(3,entrada.getCuerpo());
            ps.setString(4,entrada.getNombreUsuario());
            ps.setString(5,entrada.getFecha());
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        }catch (SQLException e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public static Entrada selectEntrada(String codigoEntrada){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps  = null;
        ResultSet rs = null;
        String query = "SELECT * FROM Entrada WHERE codigoEntrada = ?";
        try{
            ps = connection.prepareStatement(query);
            ps.setString(1,codigoEntrada);
            rs = ps.executeQuery();
            Entrada entrada = null;
            
            if(rs.next()){
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                entrada = new Entrada(
                        rs.getString("codigoEntrada"),
                        rs.getString("titulo"),
                        rs.getString("cuerpo"),
                        rs.getString("nombreUsuario"),
                        rs.getString("fecha")
                );
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return entrada;
        } catch(SQLException e){
            e.printStackTrace();
            return null;
        }
    }
}
