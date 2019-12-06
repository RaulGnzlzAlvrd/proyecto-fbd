package taqueroMucho.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;
import taqueroMucho.config.DBConfig;
import taqueroMucho.model.*;
import taqueroMucho.repository.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
@PropertySource("classpath:application.queries.properties")
public class DAOVendedorImpl implements DAOVendedor {
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

    public List<Vendedor> getAllVendedores() {
        //Leo query a ejecutar
        String query = env.getProperty("allVendedores");
        //Preparo respuesta
        List<Vendedor> vendedoresList = new ArrayList<>();
        try {
            //Genero conexion
            connection = dbConfig.dataSource().getConnection();
            //Preparo base de datos para una instruccion
            stmt = connection.createStatement();
            //Ejecuto Query
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Vendedor vendedor = new Vendedor(
                        rs.getString("rfc"),
                        rs.getString("nombre"),
                        rs.getString("telefono")
                );
                vendedoresList.add(vendedor);
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
        return vendedoresList;
    }

    public Vendedor insertVendedor(Vendedor vendedor) {
        String query = env.getProperty("insertVendedor");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, vendedor.getRfc());
            ps.setString(2, vendedor.getNombre());
            ps.setString(3, vendedor.getTelefono());
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
        return vendedor;
    }

    public Vendedor getVendedor(String rfc) {
        //Leo query a ejecutar
        String query = env.getProperty("searchVendedorByPK");
        //Preparo respuesta
        Vendedor vendedor = new Vendedor();
        try {
            //Genero conexion
            connection = dbConfig.dataSource().getConnection();
            //Preparo base de datos para una instruccion
            ps = connection.prepareStatement(query);
            ps.setString(1, rfc);
            //Ejecuto Query
            ResultSet rs = ps.executeQuery();
            //Itero resultado
            while (rs.next()) {
                vendedor = new Vendedor(
                        rs.getString("rfc"),
                        rs.getString("nombre"),
                        rs.getString("telefono")
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
        return vendedor;
    }

    public Vendedor updateVendedor(Vendedor vendedor, String rfc) {
        String query = env.getProperty("updateVendedor");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, vendedor.getRfc());
            ps.setString(2, vendedor.getNombre());
            ps.setString(3, vendedor.getTelefono());
            ps.setString(4, rfc);
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
        return vendedor;
    }

    public Vendedor deleteVendedor(String rfc) {
        Vendedor vendedor = this.getVendedor(rfc);
        String query = env.getProperty("deleteVendedor");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, rfc);
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
        return vendedor;
    }
}
