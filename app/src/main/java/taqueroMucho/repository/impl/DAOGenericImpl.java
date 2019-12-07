package taqueroMucho.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;
import taqueroMucho.config.DBConfig;
import taqueroMucho.repository.DAOGeneric;

import java.sql.*;
import java.util.*;

@Repository
@PropertySource("classpath:application.queries.properties")
public class DAOGenericImpl implements DAOGeneric {
    @Autowired
    private DBConfig dbConfig;
    @Autowired
    private Environment env;
    private Connection connection;
    private Statement stmt;
    PreparedStatement ps;

    public List<HashMap<String, String>> genericQuery(String queryName) {
        String query = env.getProperty(queryName);
        List<HashMap<String, String>> entriesList = new ArrayList<>();
        try {
            connection = dbConfig.dataSource().getConnection();
            stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                HashMap<String, String> entry = new HashMap<>();
                ResultSetMetaData rsMetaData = rs.getMetaData();
                for (int i = 1; i <= rsMetaData.getColumnCount(); i++) {
                    String column = rsMetaData.getColumnName(i);
                    entry.put(column, rs.getString(column));
                }
                entriesList.add(entry);
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
        System.out.println(entriesList.toString());
        return entriesList;
    }
}
