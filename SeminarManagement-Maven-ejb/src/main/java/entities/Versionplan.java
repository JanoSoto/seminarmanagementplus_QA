/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author miguel
 */
@Entity
@Table(name = "versionplan")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Versionplan.findAll", query = "SELECT v FROM Versionplan v"),
    @NamedQuery(name = "Versionplan.findById", query = "SELECT v FROM Versionplan v WHERE v.id = :id"),
    @NamedQuery(name = "Versionplan.findByVersion", query = "SELECT v FROM Versionplan v WHERE v.version = :version"),
    @NamedQuery(name = "Versionplan.findByAnio", query = "SELECT v FROM Versionplan v WHERE v.anio = :anio")})
public class Versionplan implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id")
    private Long id;
    @Column(name = "version")
    private Integer version;
    @Column(name = "anio")
    private Integer anio;
    @JoinColumn(name = "planestudio_id", referencedColumnName = "id")
    @ManyToOne
    private Planestudio planestudioId;

    public Versionplan() {
    }

    public Versionplan(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Integer getAnio() {
        return anio;
    }

    public void setAnio(Integer anio) {
        this.anio = anio;
    }

    public Planestudio getPlanestudioId() {
        return planestudioId;
    }

    public void setPlanestudioId(Planestudio planestudioId) {
        this.planestudioId = planestudioId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Versionplan)) {
            return false;
        }
        Versionplan other = (Versionplan) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Versionplan[ id=" + id + " ]";
    }
    
}
