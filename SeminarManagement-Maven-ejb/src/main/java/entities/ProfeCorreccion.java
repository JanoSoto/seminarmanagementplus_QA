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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Elagos
 */
@Entity
@Table(name = "profe_correccion")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProfeCorreccion.findAll", query = "SELECT p FROM ProfeCorreccion p"),
    @NamedQuery(name = "ProfeCorreccion.findByIdCorrectora", query = "SELECT p FROM ProfeCorreccion p WHERE p.profeCorreccionPK.idCorrectora = :idCorrectora"),
    @NamedQuery(name = "ProfeCorreccion.findByRutProfesor", query = "SELECT p FROM ProfeCorreccion p WHERE p.profeCorreccionPK.rutProfesor = :rutProfesor"),
    @NamedQuery(name = "ProfeCorreccion.findByRolCorreccion", query = "SELECT p FROM ProfeCorreccion p WHERE p.rolCorreccion = :rolCorreccion"),
    @NamedQuery(name = "ProfeCorreccion.findByNotaCorreccionInforme", query = "SELECT p FROM ProfeCorreccion p WHERE p.notaCorreccionInforme = :notaCorreccionInforme"),
    @NamedQuery(name = "ProfeCorreccion.findByNotaCorreccionDefensa", query = "SELECT p FROM ProfeCorreccion p WHERE p.notaCorreccionDefensa = :notaCorreccionDefensa"),
    })
public class ProfeCorreccion implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ProfeCorreccionPK profeCorreccionPK;
    @Column(name = "rol_correccion")
    private Integer rolCorreccion;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "nota_correccion_informe")
    private Float notaCorreccionInforme;
    @Column(name = "nota_correccion_defensa")
    private Float notaCorreccionDefensa;
    @JoinColumn(name = "rut_profesor", referencedColumnName = "rut_usuario", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Profesor profesor;
    @JoinColumn(name = "id_correctora", referencedColumnName = "id_correctora", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private ComisionCorrectora comisionCorrectora;

    public ProfeCorreccion() {
    }

    public ProfeCorreccion(ProfeCorreccionPK profeCorreccionPK) {
        this.profeCorreccionPK = profeCorreccionPK;
    }

    public ProfeCorreccion(int idCorrectora, String rutProfesor) {
        this.profeCorreccionPK = new ProfeCorreccionPK(idCorrectora, rutProfesor);
    }

    public ProfeCorreccionPK getProfeCorreccionPK() {
        return profeCorreccionPK;
    }

    public void setProfeCorreccionPK(ProfeCorreccionPK profeCorreccionPK) {
        this.profeCorreccionPK = profeCorreccionPK;
    }

    public Integer getRolCorreccion() {
        return rolCorreccion;
    }

    public void setRolCorreccion(Integer rolCorreccion) {
        this.rolCorreccion = rolCorreccion;
    }

    public Float getNotaCorreccionInforme() {
        return notaCorreccionInforme;
    }

    public void setNotaCorreccionInforme(Float notaCorreccionInforme) {
        this.notaCorreccionInforme = notaCorreccionInforme;
    }

    public Float getNotaCorreccionDefensa() {
        return notaCorreccionDefensa;
    }

    public void setNotaCorreccionDefensa(Float notaCorreccionDefensa) {
        this.notaCorreccionDefensa = notaCorreccionDefensa;
    }

    public Profesor getProfesor() {
        return profesor;
    }

    public void setProfesor(Profesor profesor) {
        this.profesor = profesor;
    }

    public ComisionCorrectora getComisionCorrectora() {
        return comisionCorrectora;
    }

    public void setComisionCorrectora(ComisionCorrectora comisionCorrectora) {
        this.comisionCorrectora = comisionCorrectora;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (profeCorreccionPK != null ? profeCorreccionPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProfeCorreccion)) {
            return false;
        }
        ProfeCorreccion other = (ProfeCorreccion) object;
        if ((this.profeCorreccionPK == null && other.profeCorreccionPK != null) || (this.profeCorreccionPK != null && !this.profeCorreccionPK.equals(other.profeCorreccionPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProfeCorreccion[ profeCorreccionPK=" + profeCorreccionPK + " ]";
    }
    
}
