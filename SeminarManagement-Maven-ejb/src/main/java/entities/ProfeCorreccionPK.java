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
public class ProfeCorreccionPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_correctora")
    private int idCorrectora;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "rut_profesor")
    private String rutProfesor;

    public ProfeCorreccionPK() {
    }

    public ProfeCorreccionPK(int idCorrectora, String rutProfesor) {
        this.idCorrectora = idCorrectora;
        this.rutProfesor = rutProfesor;
    }

    public int getIdCorrectora() {
        return idCorrectora;
    }

    public void setIdCorrectora(int idCorrectora) {
        this.idCorrectora = idCorrectora;
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
        hash += (int) idCorrectora;
        hash += (rutProfesor != null ? rutProfesor.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProfeCorreccionPK)) {
            return false;
        }
        ProfeCorreccionPK other = (ProfeCorreccionPK) object;
        if (this.idCorrectora != other.idCorrectora) {
            return false;
        }
        if ((this.rutProfesor == null && other.rutProfesor != null) || (this.rutProfesor != null && !this.rutProfesor.equals(other.rutProfesor))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProfeCorreccionPK[ idCorrectora=" + idCorrectora + ", rutProfesor=" + rutProfesor + " ]";
    }
    
}
