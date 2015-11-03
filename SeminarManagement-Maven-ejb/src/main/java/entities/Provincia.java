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
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author xarly
 */
@Entity
@Table(name = "provincia")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Provincia.findAll", query = "SELECT p FROM Provincia p"),
    @NamedQuery(name = "Provincia.findByRegion", query = "SELECT p FROM Provincia p WHERE p.provinciaRegionId = :regionId"),
    @NamedQuery(name = "Provincia.findByProvinciaId", query = "SELECT p FROM Provincia p WHERE p.provinciaId = :provinciaId"),
    @NamedQuery(name = "Provincia.findByProvinciaNombre", query = "SELECT p FROM Provincia p WHERE p.provinciaNombre = :provinciaNombre")})
public class Provincia implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "provincia_id")
    private Integer provinciaId;
    @Size(max = 23)
    @Column(name = "provincia_nombre")
    private String provinciaNombre;
    @OneToMany(mappedBy = "comunaProvinciaId")
    private List<Comuna> comunaList;
    @JoinColumn(name = "provincia_region_id", referencedColumnName = "region_id")
    @ManyToOne
    private Region provinciaRegionId;

    public Provincia() {
    }

    public Provincia(Integer provinciaId) {
        this.provinciaId = provinciaId;
    }

    public Integer getProvinciaId() {
        return provinciaId;
    }

    public void setProvinciaId(Integer provinciaId) {
        this.provinciaId = provinciaId;
    }

    public String getProvinciaNombre() {
        return provinciaNombre;
    }

    public void setProvinciaNombre(String provinciaNombre) {
        this.provinciaNombre = provinciaNombre;
    }

    @XmlTransient
    public List<Comuna> getComunaList() {
        return comunaList;
    }

    public void setComunaList(List<Comuna> comunaList) {
        this.comunaList = comunaList;
    }

    public Region getProvinciaRegionId() {
        return provinciaRegionId;
    }

    public void setProvinciaRegionId(Region provinciaRegionId) {
        this.provinciaRegionId = provinciaRegionId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (provinciaId != null ? provinciaId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Provincia)) {
            return false;
        }
        Provincia other = (Provincia) object;
        if ((this.provinciaId == null && other.provinciaId != null) || (this.provinciaId != null && !this.provinciaId.equals(other.provinciaId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Provincia[ provinciaId=" + provinciaId + " ]";
    }
    
}
