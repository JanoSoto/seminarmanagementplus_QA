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
 * @author Elagos
 */
@Embeddable
public class ProfeRevisionPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_revisora")
    private int idRevisora;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "rut_profesor")
    private String rutProfesor;

    public ProfeRevisionPK() {
    }

    public ProfeRevisionPK(int idRevisora, String rutProfesor) {
        this.idRevisora = idRevisora;
        this.rutProfesor = rutProfesor;
    }

    public int getIdRevisora() {
        return idRevisora;
    }

    public void setIdRevisora(int idRevisora) {
        this.idRevisora = idRevisora;
    }

    public String getRutProfesor() {
        return rutProfesor;
    }

    public void setRutProfesor(String rutProfesor) {
        this.rutProfesor = rutProfesor;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idRevisora;
        hash += (rutProfesor != null ? rutProfesor.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProfeRevisionPK)) {
            return false;
        }
        ProfeRevisionPK other = (ProfeRevisionPK) object;
        if (this.idRevisora != other.idRevisora) {
            return false;
        }
        if ((this.rutProfesor == null && other.rutProfesor != null) || (this.rutProfesor != null && !this.rutProfesor.equals(other.rutProfesor))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProfeRevisionPK[ idRevisora=" + idRevisora + ", rutProfesor=" + rutProfesor + " ]";
    }
    
}
