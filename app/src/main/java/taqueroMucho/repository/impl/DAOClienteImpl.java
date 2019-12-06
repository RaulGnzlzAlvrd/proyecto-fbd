package taqueroMucho.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;
import taqueroMucho.config.DBConfig;
import taqueroMucho.model.Cliente;
import taqueroMucho.repository.DAOCliente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
@PropertySource("classpath:application.queries.properties")
public class DAOClienteImpl implements DAOCliente {
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

    public List<Cliente> getAllClientesBySucursal(Integer numeroSucursal) {
        //Leo query a ejecutar
        String query = env.getProperty("allClientesBySucursal");
        //Preparo respuesta
        List<Cliente> clientesList = new ArrayList<>();
        try {
            //Genero conexion
            connection = dbConfig.dataSource().getConnection();
            //Preparo base de datos para una instruccion
            ps = connection.prepareStatement(query);
            ps.setInt(1, numeroSucursal);
            //Ejecuto Query
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cliente cliente = new Cliente(
                        rs.getString("correoElectronico"),
                        rs.getString("nombre"),
                        rs.getString("apellidoPaterno"),
                        rs.getString("apellidMaterno"),
                        rs.getInt("puntos"),
                        rs.getString("calle"),
                        rs.getInt("numero"),
                        rs.getString("estado"),
                        rs.getString("ciudad"),
                        rs.getString("telefono"),
                        rs.getInt("numeroSucursal")
                );
                clientesList.add(cliente);
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
        return clientesList;
    }

    public Cliente insertCliente(Cliente cliente) {
        String query = env.getProperty("insertCliente");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, cliente.getCorreoElectronico());
            ps.setString(2, cliente.getNombre());
            ps.setString(3, cliente.getApellidoPaterno());
            ps.setString(4, cliente.getApellidMaterno());
            ps.setInt(5, cliente.getPuntos());
            ps.setString(6, cliente.getCalle());
            ps.setInt(7, cliente.getNumero());
            ps.setString(8, cliente.getEstado());
            ps.setString(9, cliente.getCiudad());
            ps.setString(10, cliente.getTelefono());
            ps.setInt(11, cliente.getNumeroSucursal());
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
        return cliente;
    }

    public Cliente getCliente(String correoElectronico) {
        //Leo query a ejecutar
        String query = env.getProperty("searchClienteByPK");
        //Preparo respuesta
        Cliente cliente = new Cliente();
        try {
            //Genero conexion
            connection = dbConfig.dataSource().getConnection();
            //Preparo base de datos para una instruccion
            ps = connection.prepareStatement(query);
            ps.setString(1, correoElectronico);
            //Ejecuto Query
            ResultSet rs = ps.executeQuery();
            //Itero resultado
            while (rs.next()) {
                cliente = new Cliente(
                        rs.getString("correo_electronico"),
                        rs.getString("nombre"),
                        rs.getString("apellido_paterno"),
                        rs.getString("apellido_materno"),
                        rs.getInt("puntos"),
                        rs.getString("calle"),
                        rs.getInt("numero"),
                        rs.getString("ciudad"),
                        rs.getString("estado"),
                        rs.getString("telefono"),
                        rs.getInt("numero_sucursal")
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
        return cliente;
    }

    public Cliente updateCliente(Cliente cliente, String correoElectronico) {
        String query = env.getProperty("updateCliente");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, cliente.getCorreoElectronico());
            ps.setString(2, cliente.getNombre());
            ps.setString(3, cliente.getApellidoPaterno());
            ps.setString(4, cliente.getApellidMaterno());
            ps.setInt(5, cliente.getPuntos());
            ps.setString(6, cliente.getCalle());
            ps.setInt(7, cliente.getNumero());
            ps.setString(8, cliente.getEstado());
            ps.setString(9, cliente.getCiudad());
            ps.setString(10, cliente.getTelefono());
            ps.setInt(11, cliente.getNumeroSucursal());
            ps.setString(12, correoElectronico);
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
        return cliente;
    }

    public Cliente deleteCliente(String correoElectronico) {
        Cliente cliente = this.getCliente(correoElectronico);
        String query = env.getProperty("deleteCliente");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, correoElectronico);
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
        return cliente;
    }
}
