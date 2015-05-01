/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import entities.Alumno;
import entities.Profesor;
import java.io.Serializable;

/**
 *
 * @author Eduardo
 */
public class TemaDatos implements Serializable {
    private static final long serialVersionUID = 1L;
    private String estadoTema,nombreTema,nombreCorto,nombreAlumno,nombreProfesor,semestreTema, ingresoTema,fechaTema,nombreProfCoGuia,rutAlumno,apellidoAlumno;
    private int idTema, motivoCaducado;
    private Profesor guia,coGuia;
    private Alumno alumno;
    //motivo caducado es 1 por informe de avance o 2 por borrador final

    public TemaDatos(String estadoTema, String semestreTema, String nombreTema, String nombreAlumno, String nombreProfesor, String ingresoTema) {
        this.estadoTema = estadoTema;
        this.semestreTema = semestreTema;
        this.nombreTema = nombreTema;
        this.nombreAlumno = nombreAlumno;
        this.nombreProfesor = nombreProfesor;
        this.ingresoTema = ingresoTema;
    }
    
    public TemaDatos(String estadoTema, String semestreTema, String nombreTema, String nombreAlumno, String nombreProfesor, String ingresoTema, String fechaTema) {
        this.estadoTema = estadoTema;
        this.semestreTema = semestreTema;
        this.nombreTema = nombreTema;
        this.nombreAlumno = nombreAlumno;
        this.nombreProfesor = nombreProfesor;
        this.ingresoTema = ingresoTema;
        this.fechaTema = fechaTema;
    }
    
    public TemaDatos(){
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

    public String getNombreCorto() {
        return nombreCorto;
    }

    public void setNombreCorto(String nombreCorto) {
        this.nombreCorto = nombreCorto;
    }

    public void setCoGuia(Profesor coGuia) {
        this.coGuia = coGuia;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public int getMotivoCaducado() {
        return motivoCaducado;
    }

    public void setMotivoCaducado(int motivoCaducado) {
        this.motivoCaducado = motivoCaducado;
    }

    public String getApellidoAlumno() {
        return apellidoAlumno;
    }

    public void setApellidoAlumno(String apellidoAlumno) {
        this.apellidoAlumno = apellidoAlumno;
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }
    
    public String getNombreProfCoGuia() {
        return nombreProfCoGuia;
    }

    public void setNombreProfCoGuia(String nombreProfCoGuia) {
        this.nombreProfCoGuia = nombreProfCoGuia;
    }
    
    public String getFechaTema() {
        return fechaTema;
    }

    public int getIdTema() {
        return idTema;
    }

    public void setIdTema(int idTema) {
        this.idTema = idTema;
    }

    public void setFechaTema(String fechaTema) {
        this.fechaTema = fechaTema;
    }
    
    public String getIngresoTema() {
        return ingresoTema;
    }

    public void setIngresoTema(String ingresoTema) {
        this.ingresoTema = ingresoTema;
    }

    public String getSemestreTema() {
        return semestreTema;
    }

    public void setSemestreTema(String semestreTema) {
        this.semestreTema = semestreTema;
    }

    public String getEstadoTema() {
        return estadoTema;
    }

    public void setEstadoTema(String estadoTema) {
        this.estadoTema = estadoTema;
    }

    public String getNombreTema() {
        return nombreTema;
    }

    public void setNombreTema(String nombreTema) {
        this.nombreTema = nombreTema;
    }

    public String getNombreAlumno() {
        return nombreAlumno;
    }

    public void setNombreAlumno(String nombreAlumno) {
        this.nombreAlumno = nombreAlumno;
    }

    public String getNombreProfesor() {
        return nombreProfesor;
    }

    public void setNombreProfesor(String nombreProfesor) {
        this.nombreProfesor = nombreProfesor;
    }
}
