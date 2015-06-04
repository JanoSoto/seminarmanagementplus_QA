package entities;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author stateless
 */
@Entity
@Table( name = "carrera_alumno" )
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CarreraAlumno.findAll", query = "SELECT c FROM CarreraAlumno c"),
    @NamedQuery(name = "CarreraAlumno.findByRutAlumno", query = "SELECT c From CarreraAlumno c WHERE c.carreraAlumnoPK.rutAlumno = :rutAlumno"),
    @NamedQuery(name = "CarreraAlumno.findByCarreraId", query = "SELECT c From CarreraAlumno c WHERE c.carreraAlumnoPK.carreraId = :carreraId"),
    @NamedQuery(name = "CarreraAlumno.findByJornada", query = "SELECT c From CarreraAlumno c WHERE c.jornada = :jornada")
})
public class CarreraAlumno implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @EmbeddedId
    protected CarreraAlumnoPK carreraAlumnoPK;
    
    @Column( name = "jornada" )
    private Integer jornada;
    
    @JoinColumn(name = "rut_alumno", referencedColumnName = "rut_alumno", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Alumno alumno;
    
    @JoinColumn(name = "carrera_id", referencedColumnName = "id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Carrera carrera;

    public CarreraAlumno() {
    }
    
    public CarreraAlumno(CarreraAlumnoPK alumnoCarreraPK) {
        this.carreraAlumnoPK = alumnoCarreraPK;
    }

    public CarreraAlumno(Integer idCarrera, String rutAlumno) {
        this.carreraAlumnoPK = new CarreraAlumnoPK(idCarrera, rutAlumno);
    }
    
    public CarreraAlumnoPK getCarreraAlumnoPK() {
        return carreraAlumnoPK;
    }

    public void setCarreraAlumnoPK(CarreraAlumnoPK alumnoCarreraPK) {
        this.carreraAlumnoPK = alumnoCarreraPK;
    }

    public Integer getJornada() {
        return jornada;
    }

    public void setJornada(Integer jornada) {
        this.jornada = jornada;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public Carrera getCarrera() {
        return carrera;
    }

    public void setCarrera(Carrera carrera) {
        this.carrera = carrera;
    }
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (carreraAlumnoPK != null ? carreraAlumnoPK.hashCode() : 0);
        return hash;
    }
    
    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProfeCorreccion)) {
            return false;
        }
        CarreraAlumno other = (CarreraAlumno) object;
        if ((this.carreraAlumnoPK == null && other.carreraAlumnoPK != null) || (this.carreraAlumnoPK != null && !this.carreraAlumnoPK.equals(other.carreraAlumnoPK))) {
            return false;
        }
        return true;
    }
    
    @Override
    public String toString() {
        return "entities.CarreraAlumno[ carreraAlumnoPK=" + carreraAlumnoPK + " ]";
    }
}
