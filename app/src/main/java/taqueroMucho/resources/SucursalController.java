package taqueroMucho.resources;

// Dependencias de Spring Boot
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

// Deendencias locales
import taqueroMucho.model.Sucursal;
import taqueroMucho.repository.DAOSucursal;

@Controller
public class SucursalController {
    @Autowired
    private DAOSucursal daoSucursal;

    @GetMapping("/sucursales")
    public String index(Model model) {
        model.addAttribute("sucursales", daoSucursal.getAllSucursales());
        return "sucursal/index";
    }

    @GetMapping("/sucursal/crear")
    public String create(Model model) {
        model.addAttribute("accion", "Nueva Sucursal");
        model.addAttribute("pathAccion", "/sucursal/guardar");
        model.addAttribute("sucursal", new Sucursal());
        return "sucursal/form";
    }

    @GetMapping("/sucursal/{numero_sucursal}")
    public String show(@PathVariable(value = "numero_sucursal") Integer numeroSucursal, Model model) {
        model.addAttribute("sucursal", daoSucursal.getSucursal(numeroSucursal));
        return "sucursal/show";
    }

    @PostMapping("/sucursal/guardar")
    public String store(@RequestParam String calle,
                        @RequestParam Integer numero,
                        @RequestParam String ciudad,
                        @RequestParam String estado) {
        Sucursal sucursal = new Sucursal(
                calle,
                numero,
                ciudad,
                estado);
        daoSucursal.insertSucursal(sucursal);
        return "redirect:/sucursales";
    }

    @GetMapping("/sucursal/editar/{id}")
    public String edit(@PathVariable(value = "id") Integer numeroSucursal, Model model) {
        model.addAttribute("accion", "Editar Sucursal");
        model.addAttribute("pathAccion", "/sucursal/actualizar");
        model.addAttribute("sucursal", daoSucursal.getSucursal(numeroSucursal));
        return "sucursal/form";
    }

    @PostMapping("/sucursal/actualizar")
    public String update(@RequestParam Integer numeroSucursal,
                         @RequestParam String calle,
                         @RequestParam Integer numero,
                         @RequestParam String ciudad,
                         @RequestParam String estado) {
        Sucursal sucursal = new Sucursal(
                calle,
                numero,
                ciudad,
                estado);
        daoSucursal.updateSucursal(numeroSucursal, sucursal);
        return "redirect:/sucursales";
    }

    @GetMapping("/sucursal/eliminar/{id}")
    public String delete(@PathVariable(value = "id") Integer numeroSucursal) {
        daoSucursal.deleteSucursal(numeroSucursal);
        return "redirect:/sucursales";
    }
}
