package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

public class DBConnection {

    private double maxLimit = 30.0;
    private double minLimit = 30.0;

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
                plato.setAminoacidos(rs.getInt("aminoacidos"));
                plato.setProteinas(rs.getInt("proteinas"));
                plato.setHidratosDeCarbono(rs.getInt("hidratosDeCarbono"));
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
        PreparedStatement ps;
        ResultSet rs;
        ArrayList<Plato> nombresPlatos = new ArrayList<>();
        String query = "SELECT * FROM Plato p WHERE p.codigoPlato=?";
        try {
            for (int i = 0; i < codigosPlatos.size(); i++) {
                ps = connection.prepareStatement(query);
                ps.setString(1, codigosPlatos.get(i));
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
                    plato.setAminoacidos(rs.getInt("aminoacidos"));
                    plato.setProteinas(rs.getInt("proteinas"));
                    plato.setHidratosDeCarbono(rs.getInt("hidratosDeCarbono"));
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

    public static ArrayList<Plato> selectPlatosDias(ArrayList<String> platosElegidos, ArrayList<Boolean> alergias, 
            int glucidosSimples, int polisacaridos, int aminoacidos, int proteinas, int hidratosDeCarbono) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps;
        ResultSet rs;
        double glucidosSimplesActuales;
        double polisacaridosActuales;
        double animoacidosActuales;
        double proteinasActuales;
        double hidratosDeCarbonoActuales;
        ArrayList<Plato> platosFinal = new ArrayList<>();
        String query = "SELECT * FROM Plato p WHERE p.codigoPlato=?";
        //ArrayList<Plato> retorno = new ArrayList<>();
        try {
            ps = connection.prepareStatement(query);
            // ps.setString(1,codigoPlato);
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
                plato.setAminoacidos(rs.getInt("aminoacidos"));
                plato.setProteinas(rs.getInt("proteinas"));
                plato.setHidratosDeCarbono(rs.getInt("hidratosDeCarbono"));
                //retorno.add(entrada);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
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
