package taqueroMucho.resources;

// Dependencias de Spring Boot
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

// Deendencias locales
import taqueroMucho.model.*;
import taqueroMucho.repository.*;

@Controller
public class VendedorController {
    @Autowired
    private DAOVendedor daoVendedor;

    @GetMapping("/vendedores")
    public String index(Model model) {
        model.addAttribute("vendedores", daoVendedor.getAllVendedores());
        return "vendedor/index";
    }

    @GetMapping("/vendedor/crear")
    public String create(Model model) {
        model.addAttribute("accion", "Crear Vendedor");
        model.addAttribute("pathAccion", "/vendedor/guardar");
        model.addAttribute("vendedor", new Vendedor());
        return "vendedor/form";
    }

    @PostMapping("/vendedor/guardar")
    public String store(@RequestParam String rfc,
                        @RequestParam String nombre,
                        @RequestParam String telefono) {
        Vendedor vendedor = new Vendedor(
                rfc,
                nombre,
                telefono
        );
        daoVendedor.insertVendedor(vendedor);
        return "redirect:/vendedores";
    }

    @GetMapping("/vendedor/editar/{id}")
    public String edit(@PathVariable(value = "id") String rfc, Model model) {
        model.addAttribute("accion", "Editar Vendedor");
        model.addAttribute("pathAccion", "/vendedor/actualizar");
        model.addAttribute("vendedor", daoVendedor.getVendedor(rfc));
        return "vendedor/form";
    }

    @PostMapping("/vendedor/actualizar")
    public String update(@RequestParam String rfc,
                         @RequestParam String nombre,
                         @RequestParam String telefono,
                         @RequestParam String oldRfc) {
        Vendedor vendedor = new Vendedor(
                rfc,
                nombre,
                telefono);
        daoVendedor.updateVendedor(vendedor, oldRfc);
        return "redirect:/vendedores";
    }

    @GetMapping("/vendedor/eliminar/{id}")
    public String delete(@PathVariable(value = "id") String rfc) {
        daoVendedor.deleteVendedor(rfc);
        return "redirect:/vendedores";
    }
}
