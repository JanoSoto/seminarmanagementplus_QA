/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
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
 * @author Elagos
 */
@Entity
@Table(name = "tipo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tipo.findAll", query = "SELECT t FROM Tipo t"),
    @NamedQuery(name = "Tipo.findByNombreTipo", query = "SELECT t FROM Tipo t WHERE t.nombreTipo = :nombreTipo")})
public class Tipo implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "nombre_tipo")
    private String nombreTipo;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "nombreTipo")
    private List<UsuarioTipo> usuarioTipoList;

    public Tipo() {
    }

    public Tipo(String nombreTipo) {
        this.nombreTipo = nombreTipo;
    }

    public String getNombreTipo() {
        return nombreTipo;
    }

    public void setNombreTipo(String nombreTipo) {
        this.nombreTipo = nombreTipo;
    }

    @XmlTransient
    public List<UsuarioTipo> getUsuarioTipoList() {
        return usuarioTipoList;
    }

    public void setUsuarioTipoList(List<UsuarioTipo> usuarioTipoList) {
        this.usuarioTipoList = usuarioTipoList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (nombreTipo != null ? nombreTipo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tipo)) {
            return false;
        }
        Tipo other = (Tipo) object;
        if ((this.nombreTipo == null && other.nombreTipo != null) || (this.nombreTipo != null && !this.nombreTipo.equals(other.nombreTipo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Tipo[ nombreTipo=" + nombreTipo + " ]";
    }
    
}
