package taqueroMucho.model;

public class Vendedor {
    private String rfc;
    private String nombre;
    private String telefono;

    public Vendedor() {
    }

    public Vendedor(String rfc, String nombre, String telefono) {
        this.rfc = rfc;
        this.nombre = nombre;
        this.telefono = telefono;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
}
