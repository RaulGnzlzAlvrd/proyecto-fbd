package taqueroMucho.model;

public class Sucursal {
    private Integer numeroSucursal;
    private String calle;
    private Integer numero;
    private String ciudad;
    private String estado;

    public Sucursal() {
    }

    public Sucursal(Integer numeroSucursal, String calle, Integer numero, String ciudad, String estado) {
        this.numeroSucursal = numeroSucursal;
        this.calle = calle;
        this.numero = numero;
        this.ciudad = ciudad;
        this.estado = estado;
    }

    public Sucursal(String calle, Integer numero, String ciudad, String estado) {
        this.calle = calle;
        this.numero = numero;
        this.ciudad = ciudad;
        this.estado = estado;
    }

    public Integer getNumeroSucursal() {
        return numeroSucursal;
    }

    public void setNumeroSucursal(Integer numeroSucursal) {
        this.numeroSucursal = numeroSucursal;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public Integer getNumero() {
        return numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
