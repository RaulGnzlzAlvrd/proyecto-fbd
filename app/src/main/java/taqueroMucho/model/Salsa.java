package taqueroMucho.model;

public class Salsa {
    private String nombre;
    private String lt;
    private String Kg;
    private String mg;
        
    public Salsa() {
    }

    public Salsa(String nombre, String lt, String Kg, String mg) {
        this.nombre = nombre;
        this.lt = lt;
        this.Kg = Kg;
        this.mg = mg;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getlt() {
        return lt;
    }

    public void setlt(String lt) {
        this.lt = lt;
    }
    
    public String getKg() {
        return Kg;
    }

    public void setKg(String Kg) {
        this.Kg = Kg;
    }
    
    public String getmg() {
        return mg;
    }

    public void setmg(String mg) {
        this.mg = mg;
    }
}
