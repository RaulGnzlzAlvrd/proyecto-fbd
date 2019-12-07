package taqueroMucho.resources;

// Dependencias de Spring Boot
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

// Deendencias locales
import taqueroMucho.model.Platillo;
import taqueroMucho.repository.DAOPlatillo;

@Controller
public class PlatillosController {
    @Autowired
    private DAOPlatillo daoPlatillo;

    @GetMapping("/platillos")
    public String index(Model model) {
        model.addAttribute("platillos", daoPlatillo.getAllPlatillos());
        return "platillos/index";
    }
}
