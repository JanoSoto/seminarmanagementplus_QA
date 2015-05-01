/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package clases;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Eduardo
 */
public class ComisionRevDatos implements Serializable {
    private static final long serialVersionUID = 1L;
    private String nombrePropuesta, fecha, rutAlumno, idSemestre,idRevisora, idTema, tipo, profGuia, profCoGuia,nombreAlumno, comRev;
    private List<String> profRev;
    
    public ComisionRevDatos () {
        profRev = new ArrayList();
    }

    public String getComRev() {
        return comRev;
    }

    public void setComRev(String comRev) {
        this.comRev = comRev;
    }

    public String getNombreAlumno() {
        return nombreAlumno;
    }

    public void setNombreAlumno(String nombreAlumno) {
        this.nombreAlumno = nombreAlumno;
    }

    public List<String> getProfRev() {
        return profRev;
    }

    public void setProfRev(List<String> profRev) {
        this.profRev = profRev;
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
    
    public ComisionRevDatos(String nombrePropuesta, String idRevisora) {
        this.nombrePropuesta = nombrePropuesta;
        this.idRevisora = idRevisora;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public String getIdRevisora() {
        return idRevisora;
    }

    public void setIdRevisora(String idRevisora) {
        this.idRevisora = idRevisora;
    }

    public String getIdTema() {
        return idTema;
    }

    public void setIdTema(String idTema) {
        this.idTema = idTema;
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
    
    public String getProfRev1() {
        return profRev.get(0);
    }
    
    public String getProfRev2() {
        return profRev.get(1);
    }
    
    public void addProfRev(String nombreProfesor) {
        profRev.add(nombreProfesor);
    }
}
