package taqueroMucho.repository;

import taqueroMucho.model.Platillo;

import java.util.List;

public interface DAOPlatillo {

    /**
     * Obten todos los registros de los Platillos y sus Precios
     * @return List<Platillo>
     */
    List<Platillo> getAllPlatillos();
}
