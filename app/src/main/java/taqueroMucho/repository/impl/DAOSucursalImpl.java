package taqueroMucho.repository.impl;

import taqueroMucho.config.DBConfig;
import taqueroMucho.model.Sucursal;
import taqueroMucho.repository.DAOSucursal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
@PropertySource("classpath:application.queries.properties")
public class DAOSucursalImpl implements DAOSucursal {
    //Se inyecta configuracion de la base de datos
    @Autowired
    private DBConfig dbConfig;
    //Objeto que ayuda a cargar configuracion
    @Autowired
    private Environment env;
    //Objeto para crear la conexión
    private Connection connection;
    //Objeto para executar queries
    private Statement stmt;
    //Objeto para prepara un query para ejecución
    PreparedStatement ps;

    public List<Sucursal> getAllSucursales() {
        //Leo query a ejecutar
        String query = env.getProperty("allSucursales");
        //Preparo respuesta
        List<Sucursal> sucursalList = new ArrayList<>();
        try {
            //Genero conexion
            connection = dbConfig.dataSource().getConnection();
            //Preparo base de datos para una instruccion
            stmt = connection.createStatement();
            //Ejecuto Query
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Sucursal sucursal = new Sucursal(
                        rs.getInt("numero_sucursal"),
                        rs.getString("calle"),
                        rs.getInt("numero"),
                        rs.getString( "ciudad"),
                        rs.getString("estado")
                );
                sucursalList.add(sucursal);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return sucursalList;
    }

    public Sucursal insertSucursal(Sucursal sucursal) {
        String query = env.getProperty("insertSucursal");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1,sucursal.getCalle());
            ps.setInt(2,sucursal.getNumero());
            ps.setString(3,sucursal.getCiudad());
            ps.setString(4,sucursal.getEstado());
            ps.executeUpdate();
            connection.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return sucursal;
    }

    public Sucursal getSucursal(Integer numeroSucursal) {
        //Leo query a ejecutar
        String query = env.getProperty("searchSucursalByPK");
        //Preparo respuesta
        Sucursal sucursal = new Sucursal();
        try {
            //Genero conexion
            connection = dbConfig.dataSource().getConnection();
            //Preparo base de datos para una instruccion
            ps =  connection.prepareStatement(query);
            ps.setInt(1, numeroSucursal);
            //Ejecuto Query
            ResultSet rs = ps.executeQuery();
            //Itero resultado
            while (rs.next()) {
                sucursal = new Sucursal(
                        rs.getInt("numero_sucursal"),
                        rs.getString("calle"),
                        rs.getInt("numero"),
                        rs.getString("ciudad"),
                        rs.getString("estado")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return sucursal;
    }

    public Sucursal updateSucursal(Integer numeroSucursal, Sucursal sucursal) {
        String query = env.getProperty("updateSucursal");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1,sucursal.getCalle());
            ps.setInt(2,sucursal.getNumero());
            ps.setString(3,sucursal.getCiudad());
            ps.setString(4,sucursal.getEstado());
            ps.setInt(5, numeroSucursal);
            ps.executeUpdate();
            connection.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return sucursal;
    }

    public Sucursal deleteSucursal(Integer numeroSucursal) {
        Sucursal sucursal = this.getSucursal(numeroSucursal);
        String query = env.getProperty("deleteSucursal");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, numeroSucursal);
            ps.executeUpdate();
            connection.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return sucursal;
    }
}
