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
@Table(name = "profe_revision")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProfeRevision.findAll", query = "SELECT p FROM ProfeRevision p"),
    @NamedQuery(name = "ProfeRevision.findByIdRevisora", query = "SELECT p FROM ProfeRevision p WHERE p.profeRevisionPK.idRevisora = :idRevisora"),
    @NamedQuery(name = "ProfeRevision.findByRutProfesor", query = "SELECT p FROM ProfeRevision p WHERE p.profeRevisionPK.rutProfesor = :rutProfesor"),
    @NamedQuery(name = "ProfeRevision.findByRolRevision", query = "SELECT p FROM ProfeRevision p WHERE p.rolRevision = :rolRevision"),
    @NamedQuery(name = "ProfeRevision.findByFechaRevision", query = "SELECT p FROM ProfeRevision p WHERE p.fechaRevision = :fechaRevision")})
public class ProfeRevision implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ProfeRevisionPK profeRevisionPK;
    @Column(name = "rol_revision")
    private Integer rolRevision;
    @Size(max = 15)
    @Column(name = "fecha_revision")
    private String fechaRevision;
    @JoinColumn(name = "rut_profesor", referencedColumnName = "rut_usuario", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Profesor profesor;
    @JoinColumn(name = "id_revisora", referencedColumnName = "id_revisora", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private ComisionRevisora comisionRevisora;

    public ProfeRevision() {
    }

    public ProfeRevision(ProfeRevisionPK profeRevisionPK) {
        this.profeRevisionPK = profeRevisionPK;
    }

    public ProfeRevision(int idRevisora, String rutProfesor) {
        this.profeRevisionPK = new ProfeRevisionPK(idRevisora, rutProfesor);
    }

    public ProfeRevisionPK getProfeRevisionPK() {
        return profeRevisionPK;
    }

    public void setProfeRevisionPK(ProfeRevisionPK profeRevisionPK) {
        this.profeRevisionPK = profeRevisionPK;
    }

    public Integer getRolRevision() {
        return rolRevision;
    }

    public void setRolRevision(Integer rolRevision) {
        this.rolRevision = rolRevision;
    }
    
    public String getFechaRevision() {
        return fechaRevision;
    }

    public void setFechaRevision(String fechaRevision) {
        this.fechaRevision = fechaRevision;
    }

    public Profesor getProfesor() {
        return profesor;
    }

    public void setProfesor(Profesor profesor) {
        this.profesor = profesor;
    }

    public ComisionRevisora getComisionRevisora() {
        return comisionRevisora;
    }

    public void setComisionRevisora(ComisionRevisora comisionRevisora) {
        this.comisionRevisora = comisionRevisora;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (profeRevisionPK != null ? profeRevisionPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProfeRevision)) {
            return false;
        }
        ProfeRevision other = (ProfeRevision) object;
        if ((this.profeRevisionPK == null && other.profeRevisionPK != null) || (this.profeRevisionPK != null && !this.profeRevisionPK.equals(other.profeRevisionPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProfeRevision[ profeRevisionPK=" + profeRevisionPK + " ]";
    }
    
}
