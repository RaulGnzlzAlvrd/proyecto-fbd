package taqueroMucho.resources;

// Dependencias de Spring Boot
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

// Deendencias locales
import taqueroMucho.model.Salsa;
import taqueroMucho.repository.DAOSalsa;

@Controller
public class SalsasController {
    @Autowired
    private DAOSalsa daoSalsa;

    @GetMapping("/salsas")
    public String index(Model model) {
        model.addAttribute("salsas", daoSalsa.getAllSalsas());
        return "salsas/index";
    }
}
