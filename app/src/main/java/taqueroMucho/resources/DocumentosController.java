package taqueroMucho.resources;

// Dependencias de Spring Boot

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

// Dependencias de Java
import java.util.*;

// Deendencias locales
import taqueroMucho.repository.*;


@Controller
public class DocumentosController {
    @Autowired
    private DAOGeneric daoGeneric;

    @GetMapping("/disclaimer")
    public String disclaimer(Model model) {
        return "disclaimer";
    }

    @GetMapping("/documentos")
    public String index(Model model) {
        model.addAttribute("size", 15);
        return "documentos/index";
    }

    /**
     * 1. Sucursal que más ha vendido
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta1")
    public String consulta1(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta1");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "Sucursal que más ha vendido.");
        return "documentos/genericDocument";
    }

    /**
     * 2. Ganancia por dia en sucursales
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta2")
    public String consulta2(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta2");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "Ganancia por dia en sucursales.");
        return "documentos/genericDocument";
    }

    /**
     * 3. Tiempo que lleva cada empleado en las sucursales que ha estado.
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta3")
    public String consulta3(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta3");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "Tiempo que lleva cada empleado en las sucursales que ha estado.");
        return "documentos/genericDocument";
    }

    /**
     * 4. Ventas totales de cada platillo
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta4")
    public String consulta4(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta4");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "Ventas totales de cada platillo.");
        return "documentos/genericDocument";
    }

    /**
     * 5. El proveedor al que más se le compra
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta5")
    public String consulta5(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta5");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "El proveedor al que más se le compra.");
        return "documentos/genericDocument";
    }

    /**
     * 6. Precio actual de cada platillo por sucursal.
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta6")
    public String consulta6(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta6");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "Precio actual de cada platillo por sucursal.");
        return "documentos/genericDocument";
    }

    /**
     * 7. Platillos más vendidos con tarjeta de credito y débito
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta7")
    public String consulta7(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta7");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "Platillos más vendidos usando efectivo.");
        return "documentos/genericDocument";
    }

    /**
     * 8. Numero de platillo entregados por tipo de transporte en cada sucursal
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta8")
    public String consulta8(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta8");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "Numero de platillo entregados por tipo de transporte en cada sucursal.");
        return "documentos/genericDocument";
    }

    /**
     * 9. Numero de clientes del estado con mas usuarios
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta9")
    public String consulta9(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta9");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "Numero de clientes del estado con mas usuarios.");
        return "documentos/genericDocument";
    }

    /**
     * 10. Veces que cada metodo de pago ha sido usado en cada sucursal
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta10")
    public String consulta10(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta10");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "Veces que cada metodo de pago ha sido usado en cada sucursal.");
        return "documentos/genericDocument";
    }

    /**
     * 11. Los platillos que lleven más de 4 ingredientes y cuesten mas de 60 pesos
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta11")
    public String consulta11(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta11");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "Los platillos que lleven más de 4 ingredientes y cuesten mas de 60 pesos.");
        return "documentos/genericDocument";
    }

    /**
     * 12. El total de todos los pagos hechos a empleados. Se asume que el salario es mensual.
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta12")
    public String consulta12(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta12");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "El total de todos los pagos hechos a empleados. Se asume que el salario es mensual.");
        return "documentos/genericDocument";
    }

    /**
     * 13. La cantidad de dinero que más ha gastado un cliente en los últimos 6 meses en cada sucursal.
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta13")
    public String consulta13(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta13");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "La cantidad de dinero que más ha gastado un cliente en los últimos 6 meses en cada sucursal.");
        return "documentos/genericDocument";
    }

    /**
     * 14. La salsa más vendida junto con tacos.
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta14")
    public String consulta14(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta14");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "La salsa más vendida junto con tacos.");
        return "documentos/genericDocument";
    }

    /**
     * 15. El tipo de ingrediente más utilizado en tacos
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta15")
    public String consulta15(Model model) {
        List<HashMap<String, String>> filas = daoGeneric.genericQuery("consulta15");
        model.addAttribute("filas", filas);
        model.addAttribute("encabezados", filas.get(0).keySet().toArray());
        model.addAttribute("descripcion", "El tipo de ingrediente más utilizado en tacos.");
        return "documentos/genericDocument";
    }
}
