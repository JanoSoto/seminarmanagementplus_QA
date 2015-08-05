/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
@Table(name = "profe_propuesta")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProfePropuesta.findAll", query = "SELECT p FROM ProfePropuesta p"),
    @NamedQuery(name = "ProfePropuesta.findByIdPropuesta", query = "SELECT p FROM ProfePropuesta p WHERE p.profePropuestaPK.idPropuesta = :idPropuesta"),
    @NamedQuery(name = "ProfePropuesta.findByRutProfesor", query = "SELECT p FROM ProfePropuesta p WHERE p.profePropuestaPK.rutProfesor = :rutProfesor"),
    @NamedQuery(name = "ProfePropuesta.findByRolGuia", query = "SELECT p FROM ProfePropuesta p WHERE p.rolGuia = :rolGuia"),
    @NamedQuery(name = "ProfePropuesta.findByNotaGuiaInforme", query = "SELECT p FROM ProfePropuesta p WHERE p.notaGuiaInforme = :notaGuiaInforme"),
    @NamedQuery(name = "ProfePropuesta.findByNotaGuiaDefensa", query = "SELECT p FROM ProfePropuesta p WHERE p.notaGuiaDefensa = :notaGuiaDefensa"),
    @NamedQuery(name = "ProfePropuesta.findByFechaRevision", query = "SELECT p FROM ProfePropuesta p WHERE p.fechaRevision = :fechaRevision")
})
public class ProfePropuesta implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ProfePropuestaPK profePropuestaPK;
    @Column(name = "rol_guia")
    private Integer rolGuia;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "nota_guia_informe")
    private Float notaGuiaInforme;
    @Column(name = "nota_guia_defensa")
    private Float notaGuiaDefensa;
    @Size(max = 15)
    @Column(name = "fecha_revision")
    private String fechaRevision;
    @JoinColumn(name = "id_propuesta", referencedColumnName = "id_propuesta", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Propuesta propuesta;
    @JoinColumn(name = "rut_profesor", referencedColumnName = "rut_usuario", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Profesor profesor;

    public ProfePropuesta() {
    }

    public ProfePropuesta(ProfePropuestaPK profePropuestaPK) {
        this.profePropuestaPK = profePropuestaPK;
    }

    public ProfePropuesta(int idPropuesta, String rutProfesor) {
        this.profePropuestaPK = new ProfePropuestaPK(idPropuesta, rutProfesor);
    }

    public ProfePropuestaPK getProfePropuestaPK() {
        return profePropuestaPK;
    }

    public void setProfePropuestaPK(ProfePropuestaPK profePropuestaPK) {
        this.profePropuestaPK = profePropuestaPK;
    }

    public Integer getRolGuia() {
        return rolGuia;
    }

    public void setRolGuia(Integer rolGuia) {
        this.rolGuia = rolGuia;
    }

    public Float getNotaGuiaInforme() {
        return notaGuiaInforme;
    }

    public void setNotaGuiaInforme(Float notaGuiaInforme) {
        this.notaGuiaInforme = notaGuiaInforme;
    }

    public Float getNotaGuiaDefensa() {
        return notaGuiaDefensa;
    }

    public void setNotaGuiaDefensa(Float notaGuiaDefensa) {
        this.notaGuiaDefensa = notaGuiaDefensa;
    }

    public String getFechaRevision() {
        return fechaRevision;
    }

    public void setFechaRevision(String fechaRevision) {
        this.fechaRevision = fechaRevision;
    }

    public Propuesta getPropuesta() {
        return propuesta;
    }

    public void setPropuesta(Propuesta propuesta) {
        this.propuesta = propuesta;
    }

    public Profesor getProfesor() {
        return profesor;
    }

    public void setProfesor(Profesor profesor) {
        this.profesor = profesor;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (profePropuestaPK != null ? profePropuestaPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProfePropuesta)) {
            return false;
        }
        ProfePropuesta other = (ProfePropuesta) object;
        if ((this.profePropuestaPK == null && other.profePropuestaPK != null) || (this.profePropuestaPK != null && !this.profePropuestaPK.equals(other.profePropuestaPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProfePropuesta[ profePropuestaPK=" + profePropuestaPK + " ]";
    }
    
}
