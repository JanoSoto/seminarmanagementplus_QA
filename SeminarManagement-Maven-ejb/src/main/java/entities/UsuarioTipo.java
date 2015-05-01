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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Elagos
 */
@Entity
@Table(name = "usuario_tipo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UsuarioTipo.findAll", query = "SELECT u FROM UsuarioTipo u"),
    @NamedQuery(name = "UsuarioTipo.findByIdUsuarioTipo", query = "SELECT u FROM UsuarioTipo u WHERE u.idUsuarioTipo = :idUsuarioTipo")})
public class UsuarioTipo implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_usuario_tipo")
    private Integer idUsuarioTipo;
    @JoinColumn(name = "username", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private Usuario username;
    @JoinColumn(name = "nombre_tipo", referencedColumnName = "nombre_tipo")
    @ManyToOne(optional = false)
    private Tipo nombreTipo;

    public UsuarioTipo() {
    }

    public UsuarioTipo(Integer idUsuarioTipo) {
        this.idUsuarioTipo = idUsuarioTipo;
    }

    public Integer getIdUsuarioTipo() {
        return idUsuarioTipo;
    }

    public void setIdUsuarioTipo(Integer idUsuarioTipo) {
        this.idUsuarioTipo = idUsuarioTipo;
    }

    public Usuario getUsername() {
        return username;
    }

    public void setUsername(Usuario username) {
        this.username = username;
    }

    public Tipo getNombreTipo() {
        return nombreTipo;
    }

    public void setNombreTipo(Tipo nombreTipo) {
        this.nombreTipo = nombreTipo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idUsuarioTipo != null ? idUsuarioTipo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UsuarioTipo)) {
            return false;
        }
        UsuarioTipo other = (UsuarioTipo) object;
        if ((this.idUsuarioTipo == null && other.idUsuarioTipo != null) || (this.idUsuarioTipo != null && !this.idUsuarioTipo.equals(other.idUsuarioTipo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.UsuarioTipo[ idUsuarioTipo=" + idUsuarioTipo + " ]";
    }
    
}
