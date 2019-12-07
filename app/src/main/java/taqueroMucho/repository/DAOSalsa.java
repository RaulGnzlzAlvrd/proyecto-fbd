package taqueroMucho.repository;

import taqueroMucho.model.Salsa;

import java.util.List;

public interface DAOSalsa {

    /**
     * Obten todos los registros de las Salsas y sus Precios
     * @return List<Salsa>
     */
    List<Salsa> getAllSalsas();
}
