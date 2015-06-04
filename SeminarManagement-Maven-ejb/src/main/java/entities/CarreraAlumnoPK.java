package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author stateless
 */
@Embeddable
public class CarreraAlumnoPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "carrera_id")
    private Integer carreraId;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "rut_alumno")
    private String rutAlumno;
    
    public CarreraAlumnoPK(){
    }
    
    public CarreraAlumnoPK(Integer carreraId, String rutAlumno){
        this.carreraId = carreraId;
        this.rutAlumno = rutAlumno;
    }

    public Integer getCarreraId() {
        return carreraId;
    }

    public void setCarreraId(Integer carreraId) {
        this.carreraId = carreraId;
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    @Override
    public String toString() {
        return super.toString(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof CarreraAlumnoPK)) {
            return false;
        }
        CarreraAlumnoPK other = (CarreraAlumnoPK) obj;
        if (this.carreraId != other.carreraId) {
            return false;
        }
        if ((this.rutAlumno == null && other.rutAlumno != null) || (this.rutAlumno != null && !this.rutAlumno.equals(other.rutAlumno))) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) carreraId;
        hash += (rutAlumno != null ? rutAlumno.hashCode() : 0);
        return hash;
    }
    
    
}
