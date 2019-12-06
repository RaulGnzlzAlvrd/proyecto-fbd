package taqueroMucho.repository;

import taqueroMucho.model.Cliente;

import java.util.List;

public interface DAOCliente {

    /**
     * Obten todos los registros de Clientes por Sucursal
     * @return List<Cliente>
     */
    List<Cliente> getAllClientesBySucursal(Integer numeroSucursal);

    /**
     * Inserta un nuevo Cliente a la base de datos
     * @param cliente
     * @return Cliente
     */
    Cliente insertCliente(Cliente cliente);

    /**
     * Obtiene la informacion de un Cliente
     * @param correoElectronico
     * @return Cliente
     */
    Cliente getCliente(String correoElectronico);

    /**
     * Actualiza un Cliente en la base de datos
     * @param cliente
     * @param correoElectronico
     * @return Cliente
     */
    Cliente updateCliente(Cliente cliente, String correoElectronico);

    /**
     * Elimina un Cliente de la base de datos
     * @param correoElectronico
     * @return Cliente
     */
    Cliente deleteCliente(String correoElectronico);
}
