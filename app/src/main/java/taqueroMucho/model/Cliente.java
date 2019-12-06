package taqueroMucho.model;

public class Cliente {
    private String correoElectronico;
    private String nombre;
    private String apellidoPaterno;
    private String apellidMaterno;
    private Integer puntos;
    private String calle;
    private Integer numero;
    private String estado;
    private String ciudad;
    private String telefono;
    private Integer numeroSucursal;

    public Cliente() {
    }

    public Cliente(
            String correoElectronico,
            String nombre,
            String apellidoPaterno,
            String apellidMaterno,
            Integer puntos,
            String calle,
            Integer numero,
            String estado,
            String ciudad,
            String telefono,
            Integer numeroSucursal) {
        this.correoElectronico = correoElectronico;
        this.nombre = nombre;
        this.apellidoPaterno = apellidoPaterno;
        this.apellidMaterno = apellidMaterno;
        this.puntos = puntos;
        this.calle = calle;
        this.numero = numero;
        this.estado = estado;
        this.ciudad = ciudad;
        this.telefono = telefono;
        this.numeroSucursal = numeroSucursal;
    }

    public String getCorreoElectronico() {
        return correoElectronico;
    }

    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidoPaterno() {
        return apellidoPaterno;
    }

    public void setApellidoPaterno(String apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }

    public String getApellidMaterno() {
        return apellidMaterno;
    }

    public void setApellidMaterno(String apellidMaterno) {
        this.apellidMaterno = apellidMaterno;
    }

    public Integer getPuntos() {
        return puntos;
    }

    public void setPuntos(Integer puntos) {
        this.puntos = puntos;
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

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Integer getNumeroSucursal() {
        return numeroSucursal;
    }

    public void setNumeroSucursal(Integer numeroSucursal) {
        this.numeroSucursal = numeroSucursal;
    }
}
