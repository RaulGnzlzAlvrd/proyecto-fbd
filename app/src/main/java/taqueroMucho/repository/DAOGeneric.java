package taqueroMucho.repository;

import java.util.*;

public interface DAOGeneric {
    /**
     * Ejecuta un query genérico y regresa un HashMap con la representación de los valores en string
     * @param queryName
     * @return
     */
    List<HashMap<String, String>> genericQuery(String queryName);
}
