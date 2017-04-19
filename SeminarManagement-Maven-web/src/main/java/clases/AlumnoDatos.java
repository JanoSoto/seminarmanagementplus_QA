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
public class AlumnoDatos implements Serializable {
    private static final long serialVersionUID = 1L;
    private String rutAlumno,nombreAlumno,apellidoAlumno,nombreTema,profesorGuia,matriculaAlumno,mailAlumno,telefonoAlumno,jornadaAlumno,carreraAlumno,profCoGuia;

    public AlumnoDatos(){
    }
    
    public AlumnoDatos(String rutAlumno, String nombreAlumno, String apellidoAlumno, String nombreTema, String profesorGuia, String matriculaAlumno) {
        this.rutAlumno = rutAlumno;
        this.nombreAlumno = nombreAlumno;
        this.apellidoAlumno = apellidoAlumno;
        this.nombreTema = nombreTema;
        this.profesorGuia = profesorGuia;
        this.matriculaAlumno = matriculaAlumno;
    }
    
    public AlumnoDatos (String rutAlumno, String nombreAlumno, String apellidoAlumno, String nombreTema, String profesorGuia, String matriculaAlumno, String mailAlumno, String telefonoAlumno, String jornadaAlumno, String carreraAlumno) {
        this.rutAlumno = rutAlumno;
            this.nombreAlumno = nombreAlumno;
            this.nombreTema = nombreTema;
            this.profesorGuia = profesorGuia;
            this.matriculaAlumno = matriculaAlumno;
            this.mailAlumno = mailAlumno;
            this.telefonoAlumno = telefonoAlumno;
            this.jornadaAlumno = jornadaAlumno;
            this.carreraAlumno = carreraAlumno;
    }

    public String getProfCoGuia() {
        return profCoGuia;
    }

    public void setProfCoGuia(String profCoGuia) {
        this.profCoGuia = profCoGuia;
    }
    
    public String getMatriculaAlumno() {
        return matriculaAlumno;
    }

    public void setMatriculaAlumno(String matriculaAlumno) {
        this.matriculaAlumno = matriculaAlumno;
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public String getNombreAlumno() {
        return nombreAlumno;
    }

    public void setNombreAlumno(String nombreAlumno) {
        this.nombreAlumno = nombreAlumno;
    }

    public String getApellidoAlumno() {
        return apellidoAlumno;
    }

    public void setApellidoAlumno(String apellidoAlumno) {
        this.apellidoAlumno = apellidoAlumno;
    }

    public String getNombreTema() {
        return nombreTema;
    }

    public void setNombreTema(String nombreTema) {
        this.nombreTema = nombreTema;
    }

    public String getProfesorGuia() {
        return profesorGuia;
    }

    public void setProfesorGuia(String profesorGuia) {
        this.profesorGuia = profesorGuia;
    }

    public String getMailAlumno() {
        return mailAlumno;
    }

    public void setMailAlumno(String mailAlumno) {
        this.mailAlumno = mailAlumno;
    }

    public String getTelefonoAlumno() {
        return telefonoAlumno;
    }

    public void setTelefonoAlumno(String telefonoAlumno) {
        this.telefonoAlumno = telefonoAlumno;
    }

    public String getJornadaAlumno() {
        return jornadaAlumno;
    }

    public void setJornadaAlumno(String jornadaAlumno) {
        this.jornadaAlumno = jornadaAlumno;
    }
    
    public String getCarreraAlumno() {
        return carreraAlumno;
    }

    public void setCarreraAlumno(String carreraAlumno) {
        this.carreraAlumno = carreraAlumno;
    }

}
