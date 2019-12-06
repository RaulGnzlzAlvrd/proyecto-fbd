package taqueroMucho.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;
import taqueroMucho.config.DBConfig;
import taqueroMucho.model.Empleado;
import taqueroMucho.repository.DAOEmpleado;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
@PropertySource("classpath:application.queries.properties")
public class DAOEmpleadoImpl implements DAOEmpleado {
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

    public List<Empleado> getAllEmpleadosBySucursal(Integer numeroSucursal) {
        //Leo query a ejecutar
        String query = env.getProperty("allEmpleadosBySucursal");
        //Preparo respuesta
        List<Empleado> empleadoList = new ArrayList<>();
        try {
            //Genero conexion
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, numeroSucursal);
            //Ejecuto Query
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Empleado empleado = new Empleado(
                        rs.getString("rfc"),
                        rs.getString("nombre"),
                        rs.getString("apellido_paterno"),
                        rs.getString("apellido_materno"),
                        rs.getString("curp"),
                        rs.getString("tipo_empleado"),
                        rs.getString("tipo_sangre"),
                        rs.getString("fecha_nacimiento"),
                        rs.getString("calle"),
                        rs.getInt("numero"),
                        rs.getString("estado"),
                        rs.getString("ciudad"),
                        rs.getString("cuenta_bancaria"),
                        rs.getLong("numero_seguro"),
                        rs.getString("tipo_transporte"),
                        rs.getString("licencia"),
                        rs.getInt("numero_sucursal"),
                        rs.getInt("salario"),
                        rs.getInt("bonos"),
                        rs.getString("fecha_contratacion")
                );
                empleadoList.add(empleado);
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
        return empleadoList;
    }

    public Empleado insertEmpleado(Empleado empleado) {
        String query = env.getProperty("insertEmpleado");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, empleado.getRfc());
            ps.setString(2, empleado.getNombre());
            ps.setString(3, empleado.getApellidoPaterno());
            ps.setString(4, empleado.getApellidMaterno());
            ps.setString(5, empleado.getCurp());
            ps.setString(6, empleado.getTipoEmpleado());
            ps.setString(7, empleado.getTipoSangre());
            ps.setString(8, empleado.getFechaNacimiento());
            ps.setString(9, empleado.getCalle());
            ps.setInt(10, empleado.getNumero());
            ps.setString(11, empleado.getEstado());
            ps.setString(12, empleado.getCiudad());
            ps.setString(13, empleado.getCuentaBancaria());
            ps.setLong(14, empleado.getNumeroSeguro());
            ps.setString(15, empleado.getTipoTransporte());
            ps.setString(16, empleado.getLicencia());
            ps.setInt(17, empleado.getNumeroSucursal());
            ps.setInt(18, empleado.getSalario());
            ps.setInt(19, empleado.getBonos());
            ps.setString(20, empleado.getFechaContratacion());
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
        return empleado;
    }

    public Empleado getEmpleado(String rfc) {
        //Leo query a ejecutar
        String query = env.getProperty("searchEmpleadoByPK");
        //Preparo respuesta
        Empleado empleado = new Empleado();
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
                empleado = new Empleado(
                        rs.getString("rfc"),
                        rs.getString("nombre"),
                        rs.getString("apellido_paterno"),
                        rs.getString("apellido_materno"),
                        rs.getString("curp"),
                        rs.getString("tipo_empleado"),
                        rs.getString("tipo_sangre"),
                        rs.getString("fecha_nacimiento"),
                        rs.getString("calle"),
                        rs.getInt("numero"),
                        rs.getString("estado"),
                        rs.getString("ciudad"),
                        rs.getString("cuenta_bancaria"),
                        rs.getLong("numero_seguro"),
                        rs.getString("tipo_transporte"),
                        rs.getString("licencia"),
                        rs.getInt("numero_seguro"),
                        rs.getInt("salario"),
                        rs.getInt("bonos"),
                        rs.getString("fecha_contratacion")
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
        return empleado;
    }

    public Empleado updateEmpleado(Empleado empleado, String rfc) {
        String query = env.getProperty("updateEmpleado");
        try {
            connection = dbConfig.dataSource().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, empleado.getRfc());
            ps.setString(2, empleado.getNombre());
            ps.setString(3, empleado.getApellidoPaterno());
            ps.setString(4, empleado.getApellidMaterno());
            ps.setString(5, empleado.getCurp());
            ps.setString(6, empleado.getTipoEmpleado());
            ps.setString(7, empleado.getTipoSangre());
            ps.setString(8, empleado.getFechaNacimiento());
            ps.setString(9, empleado.getCalle());
            ps.setInt(10, empleado.getNumero());
            ps.setString(11, empleado.getEstado());
            ps.setString(12, empleado.getCiudad());
            ps.setString(13, empleado.getCuentaBancaria());
            ps.setLong(14, empleado.getNumeroSeguro());
            ps.setString(15, empleado.getTipoTransporte());
            ps.setString(16, empleado.getLicencia());
            ps.setInt(17, empleado.getNumeroSucursal());
            ps.setInt(18, empleado.getSalario());
            ps.setInt(19, empleado.getBonos());
            ps.setString(20, empleado.getFechaContratacion());
            ps.setString(21, rfc);
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
        return empleado;
    }

    public Empleado deleteEmpleado(String rfc) {
        Empleado empleado = this.getEmpleado(rfc);
        String query = env.getProperty("deleteEmpleado");
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
        return empleado;
    }

    public List<String> getTiposEmpleados() {
        //Leo query a ejecutar
        String query = env.getProperty("getTiposEmpleados");
        //Preparo respuesta
        List<String> tiposEmpleados = new ArrayList<>();
        try {
            //Genero conexion
            connection = dbConfig.dataSource().getConnection();
            //Preparo base de datos para una instruccion
            stmt = connection.createStatement();
            //Ejecuto Query
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                String tipoEmpleado = rs.getString("tipo_empleado");
                tiposEmpleados.add(tipoEmpleado);
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
        return tiposEmpleados;
    }
}
