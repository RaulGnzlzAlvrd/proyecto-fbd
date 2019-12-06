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
public class EmpleadoController {
    @Autowired
    private DAOEmpleado daoEmpleado;
    private DAOSucursal daoSucursal;

    @GetMapping("/{numero_sucursal}/empleados")
    public String index(@PathVariable(value = "numero_sucursal") Integer numeroSucursal, Model model) {
        model.addAttribute("empleados", daoEmpleado.getAllEmpleadosBySucursal(numeroSucursal));
        return "empleado/index";
    }

    @GetMapping("/{numero_sucursal}/empleado/crear")
    public String create(Model model) {
        model.addAttribute("accion", "Crear Empleado");
        model.addAttribute("pathAccion", "/empleado/guardar");
        model.addAttribute("empleado", new Empleado());
        model.addAttribute("sucursales", daoSucursal.getAllSucursales());
        model.addAttribute("tiposEmpleados", daoEmpleado.getTiposEmpleados());
        return "empleado/form";
    }

    @PostMapping("/empleado/guardar")
    public String store(@RequestParam String rfc,
                        @RequestParam String nombre,
                        @RequestParam String apellidoPaterno,
                        @RequestParam String apellidMaterno,
                        @RequestParam String curp,
                        @RequestParam String tipoEmpleado,
                        @RequestParam String tipoSangre,
                        @RequestParam String fechaNacimiento,
                        @RequestParam String calle,
                        @RequestParam Integer numero,
                        @RequestParam String estado,
                        @RequestParam String ciudad,
                        @RequestParam String cuentaBancaria,
                        @RequestParam Long numeroSeguro,
                        @RequestParam String tipoTransporte,
                        @RequestParam String licencia,
                        @RequestParam Integer numeroSucursal,
                        @RequestParam Integer salario,
                        @RequestParam Integer bonos,
                        @RequestParam String fechaContratacion) {
        Empleado empleado = new Empleado(
                rfc,
                nombre,
                apellidoPaterno,
                apellidMaterno,
                curp,
                tipoEmpleado,
                tipoSangre,
                fechaNacimiento,
                calle,
                numero,
                estado,
                ciudad,
                cuentaBancaria,
                numeroSeguro,
                tipoTransporte,
                licencia,
                numeroSucursal,
                salario,
                bonos,
                fechaContratacion);
        daoEmpleado.insertEmpleado(empleado);
        return "redirect:/" + empleado.getNumeroSucursal() + "/empleados";
    }

    @GetMapping("/empleado/editar/{id}")
    public String edit(@PathVariable(value = "id") String rfc, Model model) {
        model.addAttribute("accion", "Editar Empleado");
        model.addAttribute("pathAccion", "/empleado/actualizar");
        model.addAttribute("empleado", daoEmpleado.getEmpleado(rfc));
        model.addAttribute("sucursales", daoSucursal.getAllSucursales());
        model.addAttribute("tiposEmpleados", daoEmpleado.getTiposEmpleados());
        return "empleado/form";
    }

    @PostMapping("/empleado/actualizar")
    public String update(@RequestParam String rfc,
                         @RequestParam String nombre,
                         @RequestParam String apellidoPaterno,
                         @RequestParam String apellidMaterno,
                         @RequestParam String curp,
                         @RequestParam String tipoEmpleado,
                         @RequestParam String tipoSangre,
                         @RequestParam String fechaNacimiento,
                         @RequestParam String calle,
                         @RequestParam Integer numero,
                         @RequestParam String estado,
                         @RequestParam String ciudad,
                         @RequestParam String cuentaBancaria,
                         @RequestParam Long numeroSeguro,
                         @RequestParam String tipoTransporte,
                         @RequestParam String licencia,
                         @RequestParam Integer numeroSucursal,
                         @RequestParam Integer salario,
                         @RequestParam Integer bonos,
                         @RequestParam String fechaContratacion,
                         @RequestParam String oldRfc) {
        Empleado empleado = new Empleado(
                rfc,
                nombre,
                apellidoPaterno,
                apellidMaterno,
                curp,
                tipoEmpleado,
                tipoSangre,
                fechaNacimiento,
                calle,
                numero,
                estado,
                ciudad,
                cuentaBancaria,
                numeroSeguro,
                tipoTransporte,
                licencia,
                numeroSucursal,
                salario,
                bonos,
                fechaContratacion);
        daoEmpleado.updateEmpleado(empleado, oldRfc);
        return "redirect:/" + empleado.getNumeroSucursal() + "/empleados";
    }

    @GetMapping("/empleado/eliminar/{id}")
    public String delete(@PathVariable(value = "id") String rfc) {
        Empleado empleado = daoEmpleado.deleteEmpleado(rfc);
        return "redirect:/" + empleado.getNumeroSucursal() + "/empleados";
    }
}
