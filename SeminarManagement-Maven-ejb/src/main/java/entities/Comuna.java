/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author xarly
 */
@Entity
@Table(name = "comuna")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Comuna.findAll", query = "SELECT c FROM Comuna c"),
    @NamedQuery(name = "Comuna.findByComunaId", query = "SELECT c FROM Comuna c WHERE c.comunaId = :comunaId"),
    @NamedQuery(name = "Comuna.findByRegion", query = "SELECT c FROM Comuna c WHERE c.comunaProvinciaId.provinciaRegionId = :regionId"),
    @NamedQuery(name = "Comuna.findByComunaNombre", query = "SELECT c FROM Comuna c WHERE c.comunaNombre = :comunaNombre")})
public class Comuna implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "comuna_id")
    private Integer comunaId;
    @Size(max = 20)
    @Column(name = "comuna_nombre")
    private String comunaNombre;
    @JoinColumn(name = "comuna_provincia_id", referencedColumnName = "provincia_id")
    @ManyToOne
    private Provincia comunaProvinciaId;
    @OneToMany(mappedBy = "comuna")
    private List<Usuario> usuarioList;
    

    public Comuna() {
    }

    public Comuna(Integer comunaId) {
        this.comunaId = comunaId;
    }

    public Integer getComunaId() {
        return comunaId;
    }

    public void setComunaId(Integer comunaId) {
        this.comunaId = comunaId;
    }

    public String getComunaNombre() {
        return comunaNombre;
    }

    public void setComunaNombre(String comunaNombre) {
        this.comunaNombre = comunaNombre;
    }

    public Provincia getComunaProvinciaId() {
        return comunaProvinciaId;
    }

    public void setComunaProvinciaId(Provincia comunaProvinciaId) {
        this.comunaProvinciaId = comunaProvinciaId;
    }

    public List<Usuario> getAlumnoList() {
        return usuarioList;
    }

    public void setAlumnoList(List<Usuario> alumnoList) {
        this.usuarioList = alumnoList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (comunaId != null ? comunaId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Comuna)) {
            return false;
        }
        Comuna other = (Comuna) object;
        if ((this.comunaId == null && other.comunaId != null) || (this.comunaId != null && !this.comunaId.equals(other.comunaId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Comuna[ comunaId=" + comunaId + " ]";
    }
    
}
