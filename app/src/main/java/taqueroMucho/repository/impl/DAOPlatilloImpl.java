package taqueroMucho.repository.impl;

import taqueroMucho.config.DBConfig;
import taqueroMucho.model.Platillo;
import taqueroMucho.repository.DAOPlatillo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
@PropertySource("classpath:application.queries.properties")
public class DAOPlatilloImpl implements DAOPlatillo {
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

    public List<Platillo> getAllPlatillos() {
        //Leo query a ejecutar
        String query = env.getProperty("allPlatillos");
        //Preparo respuesta
        List<Platillo> platilloList = new ArrayList<>();
        try {
            //Genero conexion
            connection = dbConfig.dataSource().getConnection();
            //Preparo base de datos para una instruccion
            stmt = connection.createStatement();
            //Ejecuto Query
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Platillo platillo = new Platillo(
                        rs.getString("nombre"),
                        rs.getString("precio")
                );
                platilloList.add(platillo);
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
        return platilloList;
    }
}
