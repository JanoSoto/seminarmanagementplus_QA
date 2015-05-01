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
public class ProfePropuestaPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_propuesta")
    private int idPropuesta;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "rut_profesor")
    private String rutProfesor;

    public ProfePropuestaPK() {
    }

    public ProfePropuestaPK(int idPropuesta, String rutProfesor) {
        this.idPropuesta = idPropuesta;
        this.rutProfesor = rutProfesor;
    }

    public int getIdPropuesta() {
        return idPropuesta;
    }

    public void setIdPropuesta(int idPropuesta) {
        this.idPropuesta = idPropuesta;
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
        hash += (int) idPropuesta;
        hash += (rutProfesor != null ? rutProfesor.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProfePropuestaPK)) {
            return false;
        }
        ProfePropuestaPK other = (ProfePropuestaPK) object;
        if (this.idPropuesta != other.idPropuesta) {
            return false;
        }
        if ((this.rutProfesor == null && other.rutProfesor != null) || (this.rutProfesor != null && !this.rutProfesor.equals(other.rutProfesor))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProfePropuestaPK[ idPropuesta=" + idPropuesta + ", rutProfesor=" + rutProfesor + " ]";
    }
    
}
