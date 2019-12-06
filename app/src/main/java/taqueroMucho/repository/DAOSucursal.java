package taqueroMucho.repository;

import taqueroMucho.model.Sucursal;

import java.util.List;

public interface DAOSucursal {

    /**
     * Obten todos los registros de la tabla Sucursal
     * @return List<Sucursal>
     */
    List<Sucursal> getAllSucursales();

    /**
     * Inserta una nueva Sucursal a la base de datos
     * @param sucursal
     * @return Sucursal
     */
    Sucursal insertSucursal(Sucursal sucursal);

    /**
     * Obtiene la informacion de una Sucursal
     * @param numeroSucursal
     * @return Sucursal
     */
    Sucursal getSucursal(Integer numeroSucursal);

    /**
     * Actualiza una Sucursal a la base de datos
     * @param numeroSucursal
     * @param sucursal
     * @return Sucursal
     */
    Sucursal updateSucursal(Integer numeroSucursal, Sucursal sucursal);

    /**
     * Elimina una Sucursal a la base de datos
     * @param numeroSucursal
     * @return Sucursal
     */
    Sucursal deleteSucursal(Integer numeroSucursal);
}
