/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.io.Serializable;

/**
 *
 * @author Eduardo
 */
public class ProfeDatos implements Serializable {
    private static final long serialVersionUID = 1L;
    private int guiasP,guiasT,rev,revProp,revSem,corr;
    private String rutProfesor,nombreProfesor,apellidoProfesor,isGuia,contratoProfesor,mailProfesor,telefonoProfesor;
    private int maxGuias;

    public ProfeDatos(){
    }
    
    public ProfeDatos(int guiasP, int guiasT, int rev, int corr, String rutProfesor, String nombreProfesor, String apellidoProfesor) {
        this.guiasP = guiasP;
        this.guiasT = guiasT;
        this.rev = rev;
        this.corr = corr;
        this.rutProfesor = rutProfesor;
        this.nombreProfesor = nombreProfesor;
        this.apellidoProfesor = apellidoProfesor;
    }

    public String getTelefonoProfesor() {
        return telefonoProfesor;
    }

    public int getMaxGuias() {
        return maxGuias;
    }

    public void setMaxGuias(int maxGuias) {
        this.maxGuias = maxGuias;
    }

    public void setTelefonoProfesor(String telefonoProfesor) {
        this.telefonoProfesor = telefonoProfesor;
    }

    public String getIsGuia() {
        return isGuia;
    }

    public void setIsGuia(String isGuia) {
        this.isGuia = isGuia;
    }

    public String getContratoProfesor() {
        return contratoProfesor;
    }

    public void setContratoProfesor(String contratoProfesor) {
        this.contratoProfesor = contratoProfesor;
    }

    public String getMailProfesor() {
        return mailProfesor;
    }

    public void setMailProfesor(String mailProfesor) {
        this.mailProfesor = mailProfesor;
    }

    public int getGuiasP() {
        return guiasP;
    }

    public void setGuiasP(int guiasP) {
        this.guiasP = guiasP;
    }

    public int getGuiasT() {
        return guiasT;
    }

    public void setGuiasT(int guiasT) {
        this.guiasT = guiasT;
    }

    public int getRev() {
        return rev;
    }

    public void setRev(int rev) {
        this.rev = rev;
    }

    public int getRevProp() {
        return revProp;
    }

    public void setRevProp(int revProp) {
        this.revProp = revProp;
    }

    public int getRevSem() {
        return revSem;
    }

    public void setRevSem(int revSem) {
        this.revSem = revSem;
    }
    
    public int getCorr() {
        return corr;
    }

    public void setCorr(int corr) {
        this.corr = corr;
    }

    public String getRutProfesor() {
        return rutProfesor;
    }

    public void setRutProfesor(String rutProfesor) {
        this.rutProfesor = rutProfesor;
    }

    public String getNombreProfesor() {
        return nombreProfesor;
    }

    public void setNombreProfesor(String nombreProfesor) {
        this.nombreProfesor = nombreProfesor;
    }

    public String getApellidoProfesor() {
        return apellidoProfesor;
    }

    public void setApellidoProfesor(String apellidoProfesor) {
        this.apellidoProfesor = apellidoProfesor;
    }
}
