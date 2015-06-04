/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Collection;
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
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author miguel
 */
@Entity
@Table(name = "planestudio")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Planestudio.findAll", query = "SELECT p FROM Planestudio p"),
    @NamedQuery(name = "Planestudio.findById", query = "SELECT p FROM Planestudio p WHERE p.id = :id"),
    @NamedQuery(name = "Planestudio.findByCodigo", query = "SELECT p FROM Planestudio p WHERE p.codigo = :codigo"),
    @NamedQuery(name = "Planestudio.findByJornada", query = "SELECT p FROM Planestudio p WHERE p.jornada = :jornada")})
public class Planestudio implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id")
    private Long id;
    @Column(name = "codigo")
    private Integer codigo;
    @Column(name = "jornada")
    private Integer jornada;
    @JoinColumn(name = "carrera_id", referencedColumnName = "id")
    @ManyToOne
    private Carrera carreraId;
    @OneToMany(mappedBy = "planestudioId")
    private Collection<Versionplan> versionplanCollection;

    public Planestudio() {
    }

    public Planestudio(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public Integer getJornada() {
        return jornada;
    }

    public void setJornada(Integer jornada) {
        this.jornada = jornada;
    }

    public Carrera getCarreraId() {
        return carreraId;
    }

    public void setCarreraId(Carrera carreraId) {
        this.carreraId = carreraId;
    }

    @XmlTransient
    public Collection<Versionplan> getVersionplanCollection() {
        return versionplanCollection;
    }

    public void setVersionplanCollection(Collection<Versionplan> versionplanCollection) {
        this.versionplanCollection = versionplanCollection;
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
        if (!(object instanceof Planestudio)) {
            return false;
        }
        Planestudio other = (Planestudio) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Planestudio[ id=" + id + " ]";
    }
    
}
