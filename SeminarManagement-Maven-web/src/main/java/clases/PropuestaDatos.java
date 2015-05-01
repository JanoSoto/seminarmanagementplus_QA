/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package clases;

import entities.Alumno;
import entities.Profesor;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Eduardo
 */
public class PropuestaDatos implements Serializable {
    private static final long serialVersionUID = 1L;
    private String nombrePropuesta,nombreCorto, fecha, rutAlumno, idSemestre,idPropuesta, tieneTema, tieneComRev, tipo, profGuia, profCoGuia,nombreAlumno;
    private Profesor guia,coGuia;
    private Alumno alumno;
    
    public PropuestaDatos () {
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public String getNombreCorto() {
        return nombreCorto;
    }

    public void setNombreCorto(String nombreCorto) {
        this.nombreCorto = nombreCorto;
    }

    public String getIdPropuesta() {
        return idPropuesta;
    }

    public void setIdPropuesta(String idPropuesta) {
        this.idPropuesta = idPropuesta;
    }

    public Profesor getGuia() {
        return guia;
    }

    public void setGuia(Profesor guia) {
        this.guia = guia;
    }

    public Profesor getCoGuia() {
        return coGuia;
    }

    public void setCoGuia(Profesor coGuia) {
        this.coGuia = coGuia;
    }

    public String getTieneTema() {
        return tieneTema;
    }

    public void setTieneTema(String tieneTema) {
        this.tieneTema = tieneTema;
    }

    public String getTieneComRev() {
        return tieneComRev;
    }

    public void setTieneComRev(String tieneComRev) {
        this.tieneComRev = tieneComRev;
    }

    public String getNombreAlumno() {
        return nombreAlumno;
    }

    public void setNombreAlumno(String nombreAlumno) {
        this.nombreAlumno = nombreAlumno;
    }
    
    public String getProfGuia() {
        return profGuia;
    }

    public String getProfCoGuia() {
        return profCoGuia;
    }

    public void setProfCoGuia(String profCoGuia) {
        this.profCoGuia = profCoGuia;
    }

    public void setProfGuia(String profGuia) {
        this.profGuia = profGuia;
    }
    
    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
 
    public String getNombrePropuesta() {
        return nombrePropuesta;
    }

    public void setNombrePropuesta(String nombrePropuesta) {
        this.nombrePropuesta = nombrePropuesta;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
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

}
