package taqueroMucho.resources;

// Dependencias de Spring Boot
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

// Deendencias locales
import taqueroMucho.repository.*;

@Controller
public class DocumentosController {
    @Autowired
    private DAOGeneric daoGeneric;

    /**
     * 1. Sucursal que más ha vendido
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta1")
    public String consulta1(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta1"));
        return "cliente/index";
    }

    /**
     * 2. Ganancia por dia en sucursales
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta2")
    public String consulta2(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta2"));
        return "cliente/index";
    }

    /**
     * 3. Tiempo que lleva cada empleado en las sucursales que ha estado.
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta3")
    public String consulta3(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta3"));
        return "cliente/index";
    }

    /**
     * 4. Ventas totales de cada platillo
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta4")
    public String consulta4(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta4"));
        return "cliente/index";
    }

    /**
     * 5. El proveedor al que más se le compra
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta5")
    public String consulta5(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta5"));
        return "cliente/index";
    }

    /**
     * 6. Precio actual de cada platillo por sucursal.
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta6")
    public String consulta6(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta6"));
        return "cliente/index";
    }

    /**
     * 7. Platillos más vendidos con tarjeta de credito y débito
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta7")
    public String consulta7(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta7"));
        return "cliente/index";
    }

    /**
     * 8. Numero de platillo entregados por tipo de transporte en cada sucursal
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta8")
    public String consulta8(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta8"));
        return "cliente/index";
    }

    /**
     * 9. Numero de clientes del estado con mas usuarios
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta9")
    public String consulta9(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta9"));
        return "cliente/index";
    }

    /**
     * 10. Veces que cada metodo de pago ha sido usado en cada sucursal
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta10")
    public String consulta10(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta10"));
        return "cliente/index";
    }

    /**
     * 11. Los platillos que lleven más de 4 ingredientes y cuesten mas de 60 pesos
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta11")
    public String consulta11(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta11"));
        return "cliente/index";
    }

    /**
     * 12. El total de todos los pagos hechos a empleados. Se asume que el salario es mensual.
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta12")
    public String consulta12(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta12"));
        return "cliente/index";
    }

    /**
     * 13. La cantidad de dinero que más ha gastado un cliente en los últimos 6 meses en cada sucursal.
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta13")
    public String consulta13(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta13"));
        return "cliente/index";
    }

    /**
     * 14. La salsa más vendida junto con tacos.
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta14")
    public String consulta14(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta14"));
        return "cliente/index";
    }

    /**
     * 15. El tipo de ingrediente más utilizado en tacos
     *
     * @param model
     * @return
     */
    @GetMapping("/documento/consulta15")
    public String consulta15(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("consulta15"));
        return "cliente/index";
    }
}
