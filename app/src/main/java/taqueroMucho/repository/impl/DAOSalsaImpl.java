package taqueroMucho.repository.impl;

import taqueroMucho.config.DBConfig;
import taqueroMucho.model.Salsa;
import taqueroMucho.repository.DAOSalsa;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
@PropertySource("classpath:application.queries.properties")
public class DAOSalsaImpl implements DAOSalsa {
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

    public List<Salsa> getAllSalsas() {
        //Leo query a ejecutar
        String query = env.getProperty("allSalsas");
        //Preparo respuesta
        List<Salsa> salsaList = new ArrayList<>();
        try {
            //Genero conexion
            connection = dbConfig.dataSource().getConnection();
            //Preparo base de datos para una instruccion
            stmt = connection.createStatement();
            //Ejecuto Query
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Salsa salsa = new Salsa(
                        rs.getString("nombre"),
                        rs.getString("bolsa_1lt"),
                        rs.getString("bote_1Kg"),
                        rs.getString("bolsita_30mg")
                );
                salsaList.add(salsa);
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
        return salsaList;
    }
}
