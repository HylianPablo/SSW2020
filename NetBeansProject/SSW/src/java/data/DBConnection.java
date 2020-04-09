package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

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
            ps.setTimestamp(5,Timestamp.valueOf(entrada.getFecha()));
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        }catch (SQLException e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public static ArrayList<Entrada> getAllEntradas(){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Entrada";
        ArrayList<Entrada> retorno = new ArrayList<>();
        try{
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Entrada entrada;
            
            while(rs.next()){
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                entrada = new Entrada();
                entrada.setCodigoEntrada(rs.getString("codigoEntrada"));
                entrada.setTitulo(rs.getString("titulo"));
                entrada.setCuerpo(rs.getString("cuerpo"));
                entrada.setNombreUsuario(rs.getString("nombreUsuario"));
                entrada.setFecha(rs.getTimestamp("fecha").toLocalDateTime());
                retorno.add(entrada);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return retorno;
        } catch(SQLException e){
            e.printStackTrace();
            return null;
        }
    }
    
    public static Entrada selectEntrada(String codigoEntrada){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Entrada WHERE codigoEntrada = ?";
        try{
            ps = connection.prepareStatement(query);
            ps.setString(1,codigoEntrada);
            rs = ps.executeQuery();
            Entrada entrada = null;
            
            if(rs.next()){
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                entrada = new Entrada();
                entrada.setCodigoEntrada(rs.getString("codigoEntrada"));
                entrada.setTitulo(rs.getString("titulo"));
                entrada.setCuerpo(rs.getString("cuerpo"));
                entrada.setNombreUsuario(rs.getString("nombreUsuario"));
                entrada.setFecha(rs.getTimestamp("fecha").toLocalDateTime());
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
