package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

public class DBConnection {

    //USUARIO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    public static int insertUsuario(Usuario user) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryExample = "INSERT INTO Usuario(nombre,nombreUsuario,contraseña,correo,favorito) VALUES(?,?,?,?,?)";
        try {
            ps = connection.prepareStatement(queryExample);
            ps.setString(1, user.getNombre());
            ps.setString(2, user.getNombreUsuario());
            ps.setString(3, user.getContrasena());
            ps.setString(4, user.getCorreo());
            ps.setString(5, user.getFavorito());
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            e.printStackTrace();
            pool.freeConnection(connection);
            return 0;
        }
    }

    public static Usuario selectUsuario(String nombreUsuario) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Usuario WHERE nombreUsuario = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, nombreUsuario);
            rs = ps.executeQuery();
            Usuario usuario = null;

            if (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                usuario = new Usuario();
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setFavorito(rs.getString("favorito"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setNombreUsuario(rs.getString("nombreUsuario"));
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return usuario;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    //ENTRADA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    public static int insertEntrada(Entrada entrada) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryExample = "INSERT INTO Entrada(codigoEntrada,titulo,cuerpo,nombreUsuario,fecha) VALUES(?,?,?,?,?)";
        try {
            ps = connection.prepareStatement(queryExample);
            ps.setString(1, entrada.getCodigoEntrada());
            ps.setString(2, entrada.getTitulo());
            ps.setString(3, entrada.getCuerpo());
            ps.setString(4, entrada.getNombreUsuario());
            ps.setTimestamp(5, Timestamp.valueOf(entrada.getFecha()));
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return 0;
        }
    }

    public static String getLastCodigoEntrada() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT MAX(E.codigoEntrada) FROM Entrada E";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            String salida;
            salida = null;

            if (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                salida = rs.getString(1);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return salida;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static ArrayList<Entrada> getAllEntradas() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Entrada ORDER BY fecha DESC";
        ArrayList<Entrada> retorno = new ArrayList<>();
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Entrada entrada;

            while (rs.next()) {
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
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static ArrayList<Comentario> getComentarios(String codigoEntrada) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Comentario WHERE codigoPadre = ?";
        ArrayList<Comentario> retorno = new ArrayList<>();
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, codigoEntrada);
            rs = ps.executeQuery();
            Comentario comentario;

            while (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                comentario = new Comentario();
                comentario.setCodigoComentario(rs.getString("codigoComentario"));
                comentario.setCodigoPadre(rs.getString("codigoPadre"));
                comentario.setCuerpo(rs.getString("cuerpo"));
                comentario.setNombreUsuario(rs.getString("nombreUsuario"));
                comentario.setFecha(rs.getTimestamp("fecha").toLocalDateTime());
                retorno.add(comentario);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return retorno;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    //COMENTARIO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    public static int insertComentario(Comentario comentario) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryExample = "INSERT INTO Comentario (codigoComentario, codigoPadre, cuerpo, nombreUsuario, fecha) VALUES(?,?,?,?,?)";
        try {
            ps = connection.prepareStatement(queryExample);
            ps.setString(1, comentario.getCodigoComentario());
            ps.setString(2, comentario.getCodigoPadre());
            ps.setString(3, comentario.getCuerpo());
            ps.setString(4, comentario.getNombreUsuario());
            ps.setTimestamp(5, Timestamp.valueOf(comentario.getFecha()));
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return 0;
        }
    }

    public static String getLastCodigoComentario() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT MAX(C.codigoComentario) FROM Comentario C";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            String salida;
            salida = null;

            if (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                salida = rs.getString(1);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return salida;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    //DIETA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    public static Dieta selectDieta(String codigoDieta) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Dieta WHERE codigoDieta = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, codigoDieta);
            rs = ps.executeQuery();
            Dieta dieta = null;

            while (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                dieta = new Dieta();
                dieta.setCodigoDieta(rs.getString("codigoDieta"));
                dieta.setDescripcion(rs.getString("descripcion"));
                dieta.setTitulo(rs.getString("titulo"));
                dieta.setFecha(rs.getTimestamp("fecha").toLocalDateTime());
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return dieta;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static Dieta selectDietaFavorita(String nombreUsuario) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Dieta D, Usuario U WHERE U.nombreUsuario = ? AND D.codigoDieta = U.favorito";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, nombreUsuario);
            rs = ps.executeQuery();
            Dieta dieta = null;

            while (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                dieta = new Dieta();
                dieta.setCodigoDieta(rs.getString("codigoDieta"));
                dieta.setDescripcion(rs.getString("descripcion"));
                dieta.setTitulo(rs.getString("titulo"));
                dieta.setFecha(rs.getTimestamp("fecha").toLocalDateTime());
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return dieta;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static ArrayList<Dieta> selectDietasGuardadas(String nombreUsuario) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Dieta D, Guardado G WHERE G.nombreUsuario = ? AND D.codigoDieta = G.codigoDieta";
        ArrayList<Dieta> dietas = new ArrayList<>();
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, nombreUsuario);
            rs = ps.executeQuery();
            Dieta dieta = null;

            while (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                dieta = new Dieta();
                dieta.setCodigoDieta(rs.getString("codigoDieta"));
                dieta.setDescripcion(rs.getString("descripcion"));
                dieta.setTitulo(rs.getString("titulo"));
                dieta.setFecha(rs.getTimestamp("fecha").toLocalDateTime());
                dietas.add(dieta);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return dietas;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static ArrayList<Dieta> getDietasFavoritas() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT d.codigoDieta, d.titulo, d.descripcion, d.fecha, dF.favoritos, dG.guardados"
                + " FROM (SELECT D.codigoDieta, (SELECT COUNT(*) FROM Usuario U WHERE U.favorito=D.codigoDieta)"
                + "AS favoritos FROM Dieta D GROUP BY D.codigoDieta) AS dF, Dieta d, (SELECT D.codigoDieta,"
                + " (SELECT COUNT(*) FROM Guardado G WHERE G.codigoDieta=D.codigoDieta) AS guardados"
                + " FROM Dieta D GROUP BY D.codigoDieta ) dG"
                + " WHERE d.codigoDieta = dF.codigoDieta AND d.codigoDieta = dG.codigoDieta"
                + " ORDER BY dF.favoritos DESC";
        ArrayList<Dieta> retorno = new ArrayList<>();
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Dieta dieta;

            while (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                dieta = new Dieta();
                dieta.setCodigoDieta(rs.getString("codigoDieta"));
                dieta.setDescripcion(rs.getString("descripcion"));
                dieta.setTitulo(rs.getString("titulo"));
                dieta.setGuardados(rs.getInt("guardados"));
                dieta.setFavoritos(rs.getInt("favoritos"));
                dieta.setFecha(rs.getTimestamp("fecha").toLocalDateTime());
                retorno.add(dieta);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return retorno;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static ArrayList<Dieta> getDietasGuardadas() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT d.codigoDieta, d.titulo, d.descripcion, d.fecha, dF.favoritos, dG.guardados"
                + " FROM (SELECT D.codigoDieta, (SELECT COUNT(*) FROM Usuario U WHERE U.favorito=D.codigoDieta)"
                + "AS favoritos FROM Dieta D GROUP BY D.codigoDieta) AS dF, Dieta d, (SELECT D.codigoDieta,"
                + " (SELECT COUNT(*) FROM Guardado G WHERE G.codigoDieta=D.codigoDieta) AS guardados"
                + " FROM Dieta D GROUP BY D.codigoDieta ) dG"
                + " WHERE d.codigoDieta = dF.codigoDieta AND d.codigoDieta = dG.codigoDieta"
                + " ORDER BY dG.guardados DESC";
        ArrayList<Dieta> retorno = new ArrayList<>();
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Dieta dieta;

            while (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                dieta = new Dieta();
                dieta.setCodigoDieta(rs.getString("codigoDieta"));
                dieta.setDescripcion(rs.getString("descripcion"));
                dieta.setTitulo(rs.getString("titulo"));
                dieta.setGuardados(rs.getInt("guardados"));
                dieta.setFavoritos(rs.getInt("favoritos"));
                dieta.setFecha(rs.getTimestamp("fecha").toLocalDateTime());
                retorno.add(dieta);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return retorno;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static int guardarDieta(String codigoDieta, String nombreUsuario) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryExample = "INSERT INTO Guardado (nombreUsuario, codigoDieta) VALUES(?,?)";
        try {
            ps = connection.prepareStatement(queryExample);
            ps.setString(1, nombreUsuario);
            ps.setString(2, codigoDieta);
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return 0;
        }
    }

    public static int noGuardarDieta(String codigoDieta, String nombreUsuario) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryExample = "DELETE FROM Guardado WHERE codigoDieta = ? AND nombreUsuario = ?";
        try {
            ps = connection.prepareStatement(queryExample);
            ps.setString(1, codigoDieta);
            ps.setString(2, nombreUsuario);
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return 0;
        }
    }

    //PLATO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    public static ArrayList<Plato> getPlatosDieta(String codigoDieta) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT P.nombre, P.codigoPlato, P.descripcion FROM Plato P, PlatoMenu PM, Dieta D"
                + " WHERE D.codigoDieta = ? AND D.codigoDieta = PM.codigoDieta AND PM.codigoPlato = P.codigoPlato "
                + "ORDER BY FIELD(PM.diaSemana, 'lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo') ASC,"
                + " FIELD(PM.momento, 'desayuno', 'comidaPrimero', 'comidaSegundo', 'cena') ASC";
        ArrayList<Plato> retorno = new ArrayList<>();
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, codigoDieta);
            rs = ps.executeQuery();
            Plato plato;

            while (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                plato = new Plato();
                plato.setNombre(rs.getString("nombre"));
                plato.setCodigoPlato(rs.getString("codigoPlato"));
                plato.setDescripcion(rs.getString("descripcion"));
                retorno.add(plato);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return retorno;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static Plato selectPlato(String codigoPlato) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Plato p WHERE p.codigoPlato=? AND p.desayuno=FALSE";
        //ArrayList<Plato> retorno = new ArrayList<>();
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, codigoPlato);
            rs = ps.executeQuery();
            Plato plato = null;

            if (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                plato = new Plato();
                plato.setCodigoPlato(rs.getString("codigoPlato"));
                plato.setNombre(rs.getString("nombre"));
                plato.setDescripcion(rs.getString("descripcion"));
                plato.setDesayuno(rs.getBoolean("desayuno"));
                plato.setVegano(rs.getBoolean("vegano"));
                plato.setVegetariano(rs.getBoolean("vegetariano"));
                plato.setFrutosSecos(rs.getBoolean("frutosSecos"));
                plato.setGluten(rs.getBoolean("gluten"));
                plato.setKcal(rs.getInt("kcal"));
                plato.setGlucidosSimples(rs.getInt("glucidosSimples"));
                plato.setPolisacaridos(rs.getInt("polisacaridos"));
                plato.setLipidos(rs.getInt("lipidos"));
                plato.setProteinas(rs.getInt("proteinas"));
                //retorno.add(entrada);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return plato;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    //ESTE METODO ESTA MAL / INUTILIZADO
    public static ArrayList<String> selectPlato(ArrayList<String> codigosPlatos) {

        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        ArrayList<String> nombresPlatos = new ArrayList<>();
        String query = "SELECT p.nombre FROM Plato p WHERE p.codigoPlato=?";
        //ArrayList<Plato> retorno = new ArrayList<>();
        try {
            for (int i = 0; i < codigosPlatos.size(); i++) {
                ps = connection.prepareStatement(query);
                ps.setString(1, codigosPlatos.get(i));
                rs = ps.executeQuery();
                String plato = null;

                if (rs.next()) {
                    //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                    plato = rs.getString("nombre");
                    nombresPlatos.add(plato);
                }
                rs.close();
                ps.close();
                pool.freeConnection(connection);
            }
            return nombresPlatos;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static ArrayList<Plato> selectPlatosFromCodigo(ArrayList<String> codigosPlatos) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps=null;
        ResultSet rs=null;
        ArrayList<Plato> nombresPlatos = new ArrayList<>();
        String query = "SELECT * FROM Plato p WHERE p.codigoPlato=?";
        try {
            for (int i = 0; i < codigosPlatos.size(); i++) {
                ps = connection.prepareStatement(query);
                ps.setString(1, codigosPlatos.get(i));
                rs = ps.executeQuery();
                Plato plato;

                if (rs.next()) {
                    //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                    plato = new Plato();
                    
                    plato.setCodigoPlato(rs.getString("codigoPlato"));
                    plato.setNombre(rs.getString("nombre"));
                    plato.setDescripcion(rs.getString("descripcion"));
                    plato.setDesayuno(rs.getBoolean("desayuno"));
                    plato.setVegano(rs.getBoolean("vegano"));
                    plato.setVegetariano(rs.getBoolean("vegetariano"));
                    plato.setFrutosSecos(rs.getBoolean("frutosSecos"));
                    plato.setGluten(rs.getBoolean("gluten"));
                    plato.setKcal(rs.getInt("kcal"));
                    plato.setGlucidosSimples(rs.getInt("glucidosSimples"));
                    plato.setPolisacaridos(rs.getInt("polisacaridos"));
                    plato.setLipidos(rs.getInt("lipidos"));
                    plato.setProteinas(rs.getInt("proteinas"));
                    
                    nombresPlatos.add(plato);
                }
            }
                rs.close();
                ps.close();
                pool.freeConnection(connection);
            
                
            return nombresPlatos;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static ArrayList<Plato> selectPlatosDias(ArrayList<Boolean> alergias, 
            int glucidos, int lipidos, int proteinas, int rango, boolean desayuno) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        ArrayList<Plato> platosFinal = new ArrayList<>();
        //Seleccionar todos y luego tomar 3 aleatorios
        String query = "SELECT * FROM Plato p WHERE p.desayuno = ? "
                + "AND (p.glucidosSimples+p.polisacaridos) <= ? AND (p.glucidosSimples+p.polisacaridos)>= ? "
                + "AND p.lipidos <= ? AND p.lipidos>= ? "
                + "AND p.proteinas <= ? AND p.proteinas >= ? ";
        String queryAlergias="";
        String subAlergiaIndiv=" AND (SELECT COUNT(*) FROM Ingrediente i, PertenenciaPlato pp "
                        + "WHERE p.codigoPlato = pp.codigoPlato AND pp.codigoIngrediente = i.codigoIngrediente "
                        + "AND i.nombre<> ";
        for(int i=0;i<4;i++){
            if(i==0 && alergias.get(i)){
                queryAlergias+=" AND p.vegano = TRUE ";
            }else if(i==1 && alergias.get(i)){
                queryAlergias+=" AND p.vegetariano = TRUE ";
            }else if(i==2 && alergias.get(i)){
                queryAlergias+=" AND p.frutosSecos = TRUE ";
            }else if(i==3 && alergias.get(i)){
                queryAlergias+=" AND p.gluten = TRUE ";
            }
        }
        String subAlerg;
        for(int i=4;i<alergias.size();i++){
            if(i==4 && alergias.get(i)){
                queryAlergias+=" AND (SELECT count(*) FROM  (SELECT pp2.codigoPlato, pp2.codigoIngrediente FROM Ingrediente i, PertenenciaPlato pp2, "
                        + "Plato p2 WHERE p2.codigoPlato = pp2.codigoPlato AND pp2.codigoIngrediente = i.codigoIngrediente) igr, "
                        + "Ingrediente i , Cerdo c WHERE p.codigoPlato = igr.codigoPlato AND i.codigoIngrediente = igr.codigoIngrediente "
                        + "AND igr.codigoIngrediente = c.codigoIngrediente)=0";
            }else if(i==5 && alergias.get(i)){
                queryAlergias+=" AND (SELECT count(*) FROM  (SELECT pp2.codigoPlato, pp2.codigoIngrediente FROM Ingrediente i, PertenenciaPlato pp2, "
                        + "Plato p2 WHERE p2.codigoPlato = pp2.codigoPlato AND pp2.codigoIngrediente = i.codigoIngrediente) igr, "
                        + "Ingrediente i , Marisco m WHERE p.codigoPlato = igr.codigoPlato AND i.codigoIngrediente = igr.codigoIngrediente "
                        + "AND igr.codigoIngrediente = m.codigoIngrediente)=0";
            }else if(i==6 && alergias.get(i)){
                queryAlergias+=" AND (SELECT count(*) FROM  (SELECT pp2.codigoPlato, pp2.codigoIngrediente FROM Ingrediente i, PertenenciaPlato pp2, "
                        + "Plato p2 WHERE p2.codigoPlato = pp2.codigoPlato AND pp2.codigoIngrediente = i.codigoIngrediente) igr, "
                        + "Ingrediente i , Huevo h WHERE p.codigoPlato = igr.codigoPlato AND i.codigoIngrediente = igr.codigoIngrediente "
                        + "AND igr.codigoIngrediente = h.codigoIngrediente)=0";
            }else if(i==7 && alergias.get(i)){
                queryAlergias+=" AND (SELECT count(*) FROM  (SELECT pp2.codigoPlato, pp2.codigoIngrediente FROM Ingrediente i, PertenenciaPlato pp2, "
                        + "Plato p2 WHERE p2.codigoPlato = pp2.codigoPlato AND pp2.codigoIngrediente = i.codigoIngrediente) igr, "
                        + "Ingrediente i , Pescado x WHERE p.codigoPlato = igr.codigoPlato AND i.codigoIngrediente = igr.codigoIngrediente "
                        + "AND igr.codigoIngrediente = x.codigoIngrediente)=0";
            }else if(i==8 && alergias.get(i)){
                subAlerg = subAlergiaIndiv + "cacahuetes";
                queryAlergias+=subAlerg;
            }else if(i==9 && alergias.get(i)){
                subAlerg = subAlergiaIndiv+"soja";
                queryAlergias+=subAlerg;
            }else if(i==10 && alergias.get(i)){
                subAlerg = subAlergiaIndiv+"melocoton";
                queryAlergias+=subAlerg;
            }else if(i==11 && alergias.get(i)){
                subAlerg = subAlergiaIndiv+"pera";
                queryAlergias+=subAlerg;
            }else if(i==12 && alergias.get(i)){
                subAlerg = subAlergiaIndiv+"manzana";
                queryAlergias+=subAlerg;
            }else if(i==13 && alergias.get(i)){
                subAlerg = subAlergiaIndiv+"melon";
                queryAlergias+=subAlerg;
            }else if(i==14 && alergias.get(i)){
                subAlerg = subAlergiaIndiv+"kiwi";
                queryAlergias+=subAlerg;
            }else if(i==15 && alergias.get(i)){
                subAlerg = subAlergiaIndiv+"piña";
                queryAlergias+=subAlerg;
            }else if(i==16 && alergias.get(i)){
                subAlerg = subAlergiaIndiv+"fresa";
                queryAlergias+=subAlerg;
            }else if(i==17 && alergias.get(i)){
                queryAlergias+=" AND (SELECT COUNT(*) FROM Ingrediente i, PertenenciaPlato pp "
                        + "WHERE p.codigoPlato = pp.codigoPlato AND pp.codigoIngrediente = i.codigoIngrediente"
                        + "AND i.codigoIngrediente IN (SELECT l.codigoIngrediente FROM Lactoso l)=0)";
            }else if(i==18 && alergias.get(i)){
                queryAlergias+=" AND (SELECT count(*) FROM  (SELECT pp2.codigoPlato, pp2.codigoIngrediente FROM Ingrediente i, PertenenciaPlato pp2, "
                        + "Plato p2 WHERE p2.codigoPlato = pp2.codigoPlato AND pp2.codigoIngrediente = i.codigoIngrediente) igr, "
                        + "Ingrediente i , Cerdo c WHERE p.codigoPlato = igr.codigoPlato AND i.codigoIngrediente = igr.codigoIngrediente "
                        + "AND igr.codigoIngrediente = c.codigoIngrediente)=0";
            }else if(i==19 && alergias.get(i)){
                queryAlergias+=" AND (SELECT count(*) FROM  (SELECT pp2.codigoPlato, pp2.codigoIngrediente FROM Ingrediente i, PertenenciaPlato pp2, "
                        + "Plato p2 WHERE p2.codigoPlato = pp2.codigoPlato AND pp2.codigoIngrediente = i.codigoIngrediente) igr, "
                        + "Ingrediente i , Hindu h WHERE p.codigoPlato = igr.codigoPlato AND i.codigoIngrediente = igr.codigoIngrediente "
                        + "AND igr.codigoIngrediente = h.codigoIngrediente)=0";
            }
        }
        query+=queryAlergias;
        try {
            ps = connection.prepareStatement(query);
           
            ps.setBoolean(1,desayuno);
            ps.setInt(2,glucidos+rango);
            ps.setInt(3,glucidos-rango);
            ps.setInt(4,lipidos+rango);
            ps.setInt(5,lipidos-rango);
            ps.setInt(6,proteinas+rango);
            ps.setInt(7,proteinas-rango);
            
            rs = ps.executeQuery();
            Plato plato = null;

            while (rs.next()) {
                //Igual es mejor tener las clases vacías y usar setters en vez de constructor
                plato = new Plato();
                plato.setCodigoPlato(rs.getString("codigoPlato"));
                plato.setNombre(rs.getString("nombre"));
                plato.setDescripcion(rs.getString("descripcion"));
                plato.setDesayuno(rs.getBoolean("desayuno"));
                plato.setVegano(rs.getBoolean("vegano"));
                plato.setVegetariano(rs.getBoolean("vegetariano"));
                plato.setFrutosSecos(rs.getBoolean("frutosSecos"));
                plato.setGluten(rs.getBoolean("gluten"));
                plato.setKcal(rs.getInt("kcal"));
                plato.setGlucidosSimples(rs.getInt("glucidosSimples"));
                plato.setPolisacaridos(rs.getInt("polisacaridos"));
                plato.setLipidos(rs.getInt("lipidos"));
                plato.setProteinas(rs.getInt("proteinas"));
                platosFinal.add(plato);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            int numMinimo;
            if(desayuno){
                numMinimo=3;
            }else{
                numMinimo=9;
            }
            if(desayuno && platosFinal.size()< numMinimo){
                if(platosFinal.isEmpty()){
                    Plato platoGen = new Plato();
                    platoGen.setCodigoPlato("99999999");
                    platoGen.setNombre("NONE");
                    platoGen.setDescripcion("NONE");
                    platoGen.setDesayuno(desayuno);
                    platoGen.setVegano(false);
                    platoGen.setVegetariano(false);
                    platoGen.setFrutosSecos(false);
                    platoGen.setGluten(false);
                    platoGen.setKcal(0);
                    platoGen.setGlucidosSimples(0);
                    platoGen.setPolisacaridos(0);
                    platoGen.setProteinas(0);
                    platoGen.setLipidos(0);
                    for(int i=0;i<numMinimo;i++){
                        platosFinal.add(platoGen);
                    }
                }else{
                    int iterator = 0;
                    int initialSize = platosFinal.size();
                    for(int i=platosFinal.size();i<numMinimo;i++){
                        platosFinal.add(platosFinal.get(iterator));
                        iterator = (iterator +1) % initialSize;
                    }
                } 
                
            }
            return platosFinal;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }
    
    public static Entrada selectEntrada(String codigoEntrada) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Entrada WHERE codigoEntrada = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, codigoEntrada);
            rs = ps.executeQuery();
            Entrada entrada = null;

            if (rs.next()) {
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
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return null;
        }
    }

    public static boolean checkGuardado(String nombreUsuario, String codigoDieta) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Guardado WHERE codigoDieta = ? AND nombreUsuario = ?";
        boolean result;
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, codigoDieta);
            ps.setString(2, nombreUsuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                result = true;
            } else {
                result = false;
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return result;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return false;
        }
    }

    public static boolean checkFavorito(String nombreUsuario, String favorito) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT * FROM Usuario WHERE favorito = ? AND nombreUsuario = ?";
        boolean result;
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, favorito);
            ps.setString(2, nombreUsuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                result = true;
            } else {
                result = false;
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return result;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return false;
        }
    }

    public static int setFavorito(String codigoDieta, String nombreUsuario) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryExample = "UPDATE Usuario SET favorito = ? WHERE nombreUsuario = ?";
        try {
            ps = connection.prepareStatement(queryExample);
            ps.setString(1, codigoDieta);
            ps.setString(2, nombreUsuario);
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return 0;
        }
    }

    public static int borrarFavorito(String nombreUsuario) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryExample = "UPDATE Usuario SET favorito = NULL WHERE nombreUsuario = ?";
        try {
            ps = connection.prepareStatement(queryExample);
            ps.setString(1, nombreUsuario);
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            pool.freeConnection(connection);
            e.printStackTrace();
            return 0;
        }
    }
}
