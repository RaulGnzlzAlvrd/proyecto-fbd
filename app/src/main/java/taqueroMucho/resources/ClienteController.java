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
public class ClienteController {
    @Autowired
    private DAOCliente daoCliente;
    private DAOSucursal daoSucursal;

    @GetMapping("/{numero_sucursal}/clientes")
    public String index(@PathVariable(value = "numero_sucursal") Integer numeroSucursal, Model model) {
        model.addAttribute("empleados", daoCliente.getAllClientesBySucursal(numeroSucursal));
        return "cliente/index";
    }

    @GetMapping("/{numero_sucursal}/cliente/crear")
    public String create(Model model) {
        model.addAttribute("accion", "Crear Cliente");
        model.addAttribute("pathAccion", "/cliente/guardar");
        model.addAttribute("cliente", new Cliente());
        model.addAttribute("sucursales", daoSucursal.getAllSucursales());
        return "empleado/form";
    }

    @PostMapping("/cliente/guardar")
    public String store(@RequestParam String correoElectronico,
                        @RequestParam String nombre,
                        @RequestParam String apellidoPaterno,
                        @RequestParam String apellidMaterno,
                        @RequestParam Integer puntos,
                        @RequestParam String calle,
                        @RequestParam Integer numero,
                        @RequestParam String estado,
                        @RequestParam String ciudad,
                        @RequestParam String telefono,
                        @RequestParam Integer numeroSucursal) {
        Cliente cliente = new Cliente(
                correoElectronico,
                nombre,
                apellidoPaterno,
                apellidMaterno,
                puntos,
                calle,
                numero,
                estado,
                ciudad,
                telefono,
                numeroSucursal);
        daoCliente.insertCliente(cliente);
        return "redirect:/" + cliente.getNumeroSucursal() + "/clientes";
    }

    @GetMapping("/cliente/editar/{id}")
    public String edit(@PathVariable(value = "id") String correoElectronico, Model model) {
        model.addAttribute("accion", "Editar Cliente");
        model.addAttribute("pathAccion", "/cliente/actualizar");
        model.addAttribute("empleado", daoCliente.getCliente(correoElectronico));
        model.addAttribute("sucursales", daoSucursal.getAllSucursales());
        return "cliente/form";
    }

    @PostMapping("/cliente/actualizar")
    public String update(@RequestParam String correoElectronico,
                         @RequestParam String nombre,
                         @RequestParam String apellidoPaterno,
                         @RequestParam String apellidMaterno,
                         @RequestParam Integer puntos,
                         @RequestParam String calle,
                         @RequestParam Integer numero,
                         @RequestParam String estado,
                         @RequestParam String ciudad,
                         @RequestParam String telefono,
                         @RequestParam Integer numeroSucursal,
                         @RequestParam String oldCorreoElectronico) {
        Cliente cliente = new Cliente(
                correoElectronico,
                nombre,
                apellidoPaterno,
                apellidMaterno,
                puntos,
                calle,
                numero,
                estado,
                ciudad,
                telefono,
                numeroSucursal);
        daoCliente.updateCliente(cliente, oldCorreoElectronico);
        return "redirect:/" + cliente.getNumeroSucursal() + "/clientes";
    }

    @GetMapping("/cliente/eliminar/{id}")
    public String delete(@PathVariable(value = "id") String correoElectronico) {
        Cliente cliente = daoCliente.deleteCliente(correoElectronico);
        return "redirect:/" + cliente.getNumeroSucursal() + "/clientes";
    }
}
