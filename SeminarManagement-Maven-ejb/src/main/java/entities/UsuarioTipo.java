/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author miguel
 */
@Entity
@Table(name = "usuario_tipo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UsuarioTipo.findAll", query = "SELECT u FROM UsuarioTipo u"),
    @NamedQuery(name = "UsuarioTipo.findByIdTipo", query = "SELECT u FROM UsuarioTipo u WHERE u.usuarioTipoPK.idTipo = :idTipo"),
    @NamedQuery(name = "UsuarioTipo.findByRutUsuario", query = "SELECT u FROM UsuarioTipo u WHERE u.usuarioTipoPK.rutUsuario = :rutUsuario")})
public class UsuarioTipo implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected UsuarioTipoPK usuarioTipoPK;

    public UsuarioTipo() {
    }

    public UsuarioTipo(UsuarioTipoPK usuarioTipoPK) {
        this.usuarioTipoPK = usuarioTipoPK;
    }

    public UsuarioTipo(long idTipo, String rutUsuario) {
        this.usuarioTipoPK = new UsuarioTipoPK(idTipo, rutUsuario);
    }

    public UsuarioTipoPK getUsuarioTipoPK() {
        return usuarioTipoPK;
    }

    public void setUsuarioTipoPK(UsuarioTipoPK usuarioTipoPK) {
        this.usuarioTipoPK = usuarioTipoPK;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (usuarioTipoPK != null ? usuarioTipoPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UsuarioTipo)) {
            return false;
        }
        UsuarioTipo other = (UsuarioTipo) object;
        if ((this.usuarioTipoPK == null && other.usuarioTipoPK != null) || (this.usuarioTipoPK != null && !this.usuarioTipoPK.equals(other.usuarioTipoPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.UsuarioTipo[ usuarioTipoPK=" + usuarioTipoPK + " ]";
    }
    
}
