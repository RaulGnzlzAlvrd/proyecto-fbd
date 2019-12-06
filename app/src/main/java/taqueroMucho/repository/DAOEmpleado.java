package taqueroMucho.repository;

import taqueroMucho.model.Empleado;
import taqueroMucho.model.Sucursal;

import java.util.List;

public interface DAOEmpleado {

    /**
     * Obten todos los registros de Empleados por Sucursal
     * @return List<Empleado>
     */
    List<Empleado> getAllEmpleadosBySucursal(Integer numeroSucursal);

    /**
     * Inserta un nuevo Empleado a la base de datos
     * @param empleado
     * @return Empleado
     */
    Empleado insertEmpleado(Empleado empleado);

    /**
     * Obtiene la informacion de un Empleado
     * @param rfc
     * @return Empleado
     */
    Empleado getEmpleado(String rfc);

    /**
     * Actualiza un Empleado en la base de datos
     * @param empleado
     * @param rfc
     * @return Empleado
     */
    Empleado updateEmpleado(Empleado empleado, String rfc);

    /**
     * Elimina un Empleado de la base de datos
     * @param rfc
     * @return Empleado
     */
    Empleado deleteEmpleado(String rfc);

    /**
     * Lista con los tipos de Empleado existentes
     * return List<String>
     */
    List<String> getTiposEmpleados();
}
