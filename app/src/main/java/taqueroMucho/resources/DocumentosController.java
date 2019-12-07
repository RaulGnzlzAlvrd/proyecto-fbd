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

    @GetMapping("/documento/sucursal-que-mas-ha-vendido")
    public String sucursalQueMasHaVendido(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("sucursalQueMasHaVendido"));
        return "cliente/index";
    }

    @GetMapping("/documento/ganancia-por-dia-sucursales")
    public String gananciaPorDiaSucursales(Model model) {
        model.addAttribute("datos", daoGeneric.genericQuery("gananciaPorDiaSucursales"));
        return "cliente/index";
    }
}
