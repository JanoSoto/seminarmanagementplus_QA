/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import entities.Profesor;
import java.io.Serializable;

/**
 *
 * @author Eduardo
 */
public class ProfeDatos2 implements Serializable {
    private static final long serialVersionUID = 1L;
    private Profesor profesor;
    private Integer temasVigentes, propSemActual, revSemActual, corrSemActual;
    private String rutProfConGuion, contrato;
    private String rutFormateado;

    public ProfeDatos2(){
    }

    public String getContrato() {
        return contrato;
    }

    public void setContrato(String contrato) {
        this.contrato = contrato;
    }

    public String getRutProfConGuion() {
        return rutProfConGuion;
    }

    public void setRutProfConGuion(String rutProfConGuion) {
        this.rutProfConGuion = rutProfConGuion;
    }
 
    public Integer getPropSemActual() {
        return propSemActual;
    }

    public void setPropSemActual(Integer propSemActual) {
        this.propSemActual = propSemActual;
    }

    public Integer getRevSemActual() {
        return revSemActual;
    }

    public void setRevSemActual(Integer revSemActual) {
        this.revSemActual = revSemActual;
    }

    public Integer getCorrSemActual() {
        return corrSemActual;
    }

    public void setCorrSemActual(Integer corrSemActual) {
        this.corrSemActual = corrSemActual;
    }

    public Profesor getProfesor() {
        return profesor;
    }

    public void setProfesor(Profesor profesor) {
        this.profesor = profesor;
    }

    public Integer getTemasVigentes() {
        return temasVigentes;
    }

    public void setTemasVigentes(Integer temasVigentes) {
        this.temasVigentes = temasVigentes;
    }

    public void setRutFormateado(String string) {
        this.rutFormateado = string;
    }
    public String getRutFormateado() {
        return this.rutFormateado;
    }
    
    
}
