/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package clases;

import entities.Profesor;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Eduardo
 */
public class ComisionCorrecDatos implements Serializable {
    private static final long serialVersionUID = 1L;
    private String nombreTema, idTema, rutAlumno, idSemestre, idCorrectora, profGuia, profCoGuia, fecha, nombreAlumno;
    private List<String> profCorrec;
    private Float notaCorrec1Def,notaCorrec2Def,notaGuiaDef,notaCorrec1Inf,notaCorrec2Inf,notaGuiaInf;
    
    public ComisionCorrecDatos() {
        profCorrec = new ArrayList();
    }

    public String getNombreAlumno() {
        return nombreAlumno;
    }

    public void setNombreAlumno(String nombreAlumno) {
        this.nombreAlumno = nombreAlumno;
    }

    public String getProfCoGuia() {
        return profCoGuia;
    }


    public void setProfCoGuia(String profCoGuia) {
        this.profCoGuia = profCoGuia;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public ComisionCorrecDatos(String nombreTema, String idTema) {
        this.nombreTema = nombreTema;
        this.idTema = idTema;
    }
    
    public String getNombreTema() {
        return nombreTema;
    }

    public void setNombreTema(String nombreTema) {
        this.nombreTema = nombreTema;
    }

    public String getIdTema() {
        return idTema;
    }

    public void setIdTema(String idTema) {
        this.idTema = idTema;
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public String getIdSemestre() {
        return idSemestre;
    }

    public void setIdSemestre(String idSemestre) {
        this.idSemestre = idSemestre;
    }

    public String getIdCorrectora() {
        return idCorrectora;
    }

    public void setIdCorrectora(String idCorrectora) {
        this.idCorrectora = idCorrectora;
    }

    public String getProfGuia() {
        return profGuia;
    }

    public void setProfGuia(String profGuia) {
        this.profGuia = profGuia;
    }   
    
    public String getProfCorrec1() {
        return profCorrec.get(0);
    }
    
    public String getProfCorrec2() {
        return profCorrec.get(1);
    }
    
    public void addProfCorrec(String nombreProfesor) {
        profCorrec.add(nombreProfesor);
    }

    public Float getNotaCorrec1Def() {
        return notaCorrec1Def;
    }

    public void setNotaCorrec1Def(Float notaCorrec1Def) {
        this.notaCorrec1Def = notaCorrec1Def;
    }

    public Float getNotaCorrec2Def() {
        return notaCorrec2Def;
    }

    public void setNotaCorrec2Def(Float notaCorrec2Def) {
        this.notaCorrec2Def = notaCorrec2Def;
    }

    public Float getNotaGuiaDef() {
        return notaGuiaDef;
    }

    public void setNotaGuiaDef(Float notaGuiaDef) {
        this.notaGuiaDef = notaGuiaDef;
    }

    public Float getNotaCorrec1Inf() {
        return notaCorrec1Inf;
    }

    public void setNotaCorrec1Inf(Float notaCorrec1Inf) {
        this.notaCorrec1Inf = notaCorrec1Inf;
    }

    public Float getNotaCorrec2Inf() {
        return notaCorrec2Inf;
    }

    public void setNotaCorrec2Inf(Float notaCorrec2Inf) {
        this.notaCorrec2Inf = notaCorrec2Inf;
    }

    public Float getNotaGuiaInf() {
        return notaGuiaInf;
    }

    public void setNotaGuiaInf(Float notaGuiaInf) {
        this.notaGuiaInf = notaGuiaInf;
    }
    
}
