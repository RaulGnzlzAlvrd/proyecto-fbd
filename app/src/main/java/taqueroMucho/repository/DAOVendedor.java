package taqueroMucho.repository;

import taqueroMucho.model.*;

import java.util.List;

public interface DAOVendedor {

    /**
     * Obten todos los registros de Vendedores
     * @return List<Vendedor>
     */
    List<Vendedor> getAllVendedores();

    /**
     * Inserta un nuevo Vendedor a la base de datos
     * @param vendedor
     * @return Vendedor
     */
    Vendedor insertVendedor(Vendedor vendedor);

    /**
     * Obtiene la informacion de un Vendedor
     * @param rfc
     * @return Vendedor
     */
    Vendedor getVendedor(String rfc);

    /**
     * Actualiza un Vendedor en la base de datos
     * @param vendedor
     * @param rfc
     * @return Vendedor
     */
    Vendedor updateVendedor(Vendedor vendedor, String rfc);

    /**
     * Elimina un Vendedor de la base de datos
     * @param rfc
     * @return Vendedor
     */
    Vendedor deleteVendedor(String rfc);
}
