/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author miguel
 */
@Embeddable
public class UsuarioTipoPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_tipo")
    private long idTipo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "rut_usuario")
    private String rutUsuario;

    public UsuarioTipoPK() {
    }

    public UsuarioTipoPK(long idTipo, String rutUsuario) {
        this.idTipo = idTipo;
        this.rutUsuario = rutUsuario;
    }

    public long getIdTipo() {
        return idTipo;
    }

    public void setIdTipo(long idTipo) {
        this.idTipo = idTipo;
    }

    public String getRutUsuario() {
        return rutUsuario;
    }

    public void setRutUsuario(String rutUsuario) {
        this.rutUsuario = rutUsuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idTipo;
        hash += (rutUsuario != null ? rutUsuario.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UsuarioTipoPK)) {
            return false;
        }
        UsuarioTipoPK other = (UsuarioTipoPK) object;
        if (this.idTipo != other.idTipo) {
            return false;
        }
        if ((this.rutUsuario == null && other.rutUsuario != null) || (this.rutUsuario != null && !this.rutUsuario.equals(other.rutUsuario))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.UsuarioTipoPK[ idTipo=" + idTipo + ", rutUsuario=" + rutUsuario + " ]";
    }
    
}
