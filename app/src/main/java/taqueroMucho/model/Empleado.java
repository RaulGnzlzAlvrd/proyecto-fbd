package taqueroMucho.model;

public class Empleado {
    private String rfc;
    private String nombre;
    private String apellidoPaterno;
    private String apellidMaterno;
    private String curp;
    private String tipoEmpleado;
    private String tipoSangre;
    private String fechaNacimiento;
    private String calle;
    private Integer numero;
    private String estado;
    private String ciudad;
    private String cuentaBancaria;
    private Long numeroSeguro;
    private String tipoTransporte;
    private String licencia;
    private Integer numeroSucursal;
    private Integer salario;
    private Integer bonos;
    private String fechaContratacion;

    public Empleado() {
    }

    public Empleado(String rfc,
                    String nombre,
                    String apellidoPaterno,
                    String apellidMaterno,
                    String curp,
                    String tipoEmpleado,
                    String tipoSangre,
                    String fechaNacimiento,
                    String calle,
                    Integer numero,
                    String estado,
                    String ciudad,
                    String cuentaBancaria,
                    Long numeroSeguro,
                    String tipoTransporte,
                    String licencia,
                    Integer numeroSucursal,
                    Integer salario,
                    Integer bonos,
                    String fechaContratacion) {
        this.rfc = rfc;
        this.nombre = nombre;
        this.apellidoPaterno = apellidoPaterno;
        this.apellidMaterno = apellidMaterno;
        this.curp = curp;
        this.tipoEmpleado = tipoEmpleado;
        this.tipoSangre = tipoSangre;
        this.fechaNacimiento = fechaNacimiento;
        this.calle = calle;
        this.numero = numero;
        this.estado = estado;
        this.ciudad = ciudad;
        this.cuentaBancaria = cuentaBancaria;
        this.numeroSeguro = numeroSeguro;
        this.tipoTransporte = tipoTransporte;
        this.licencia = licencia;
        this.numeroSucursal = numeroSucursal;
        this.salario = salario;
        this.bonos = bonos;
        this.fechaContratacion = fechaContratacion;
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

    public String getCurp() {
        return curp;
    }

    public void setCurp(String curp) {
        this.curp = curp;
    }

    public String getTipoEmpleado() {
        return tipoEmpleado;
    }

    public void setTipoEmpleado(String tipoEmpleado) {
        this.tipoEmpleado = tipoEmpleado;
    }

    public String getTipoSangre() {
        return tipoSangre;
    }

    public void setTipoSangre(String tipoSangre) {
        this.tipoSangre = tipoSangre;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
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

    public String getCuentaBancaria() {
        return cuentaBancaria;
    }

    public void setCuentaBancaria(String cuentaBancaria) {
        this.cuentaBancaria = cuentaBancaria;
    }

    public Long getNumeroSeguro() {
        return numeroSeguro;
    }

    public void setNumeroSeguro(Long numeroSeguro) {
        this.numeroSeguro = numeroSeguro;
    }

    public String getTipoTransporte() {
        return tipoTransporte;
    }

    public void setTipoTransporte(String tipoTransporte) {
        this.tipoTransporte = tipoTransporte;
    }

    public String getLicencia() {
        return licencia;
    }

    public void setLicencia(String licencia) {
        this.licencia = licencia;
    }

    public Integer getNumeroSucursal() {
        return numeroSucursal;
    }

    public void setNumeroSucursal(Integer numeroSucursal) {
        this.numeroSucursal = numeroSucursal;
    }

    public Integer getSalario() {
        return salario;
    }

    public void setSalario(Integer salario) {
        this.salario = salario;
    }

    public Integer getBonos() {
        return bonos;
    }

    public void setBonos(Integer bonos) {
        this.bonos = bonos;
    }

    public String getFechaContratacion() {
        return fechaContratacion;
    }

    public void setFechaContratacion(String fechaContratacion) {
        this.fechaContratacion = fechaContratacion;
    }
}
