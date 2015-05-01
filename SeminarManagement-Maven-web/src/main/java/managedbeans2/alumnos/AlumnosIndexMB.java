/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.alumnos;

import entities.Alumno;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.faces.model.SelectItem;
import sessionbeans.AlumnoFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "alumnosIndexMB")
@RequestScoped
public class AlumnosIndexMB {
    
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    
    private List<Alumno> alumnos, alumnosFiltrados;
    
    //Para filtro de jornadas como campo select en vez de input
    private List<String> jornadas;
    private SelectItem[] jornadaAlum;

    /**
     * Creates a new instance of AlumnosIndexMB
     */
    public AlumnosIndexMB() {
    }
    
    @PostConstruct
    public void init() {
        alumnos = alumnoFacade.findAll();
        
        //Filtro
        jornadaAlum = new SelectItem[3];
        jornadaAlum[0] = new SelectItem("");
        jornadaAlum[1] = new SelectItem("0");
        jornadaAlum[2] = new SelectItem("1");
        
    }

    public List<Alumno> getAlumnosFiltrados() {
        return alumnosFiltrados;
    }

    public void setAlumnosFiltrados(List<Alumno> alumnosFiltrados) {
        this.alumnosFiltrados = alumnosFiltrados;
    }
  
    public List<Alumno> getAlumnos() {
        return alumnos;
    }

    public void setAlumnos(List<Alumno> alumnos) {
        this.alumnos = alumnos;
    }

    public SelectItem[] getJornadaAlum() {
        return jornadaAlum;
    }

    public void setJornadaAlum(SelectItem[] jornadaAlum) {
        this.jornadaAlum = jornadaAlum;
    }

    public List<String> getJornadas() {
        return jornadas;
    }

    public void setJornadas(List<String> jornadas) {
        this.jornadas = jornadas;
    }
    
    //Para el filtro de las jornadas
    public SelectItem[] getJornadaOptions() {
       SelectItem[] r = new SelectItem[jornadas.size() + 1];
       r[0] = new SelectItem("", "Seleccione");
       for (int t = 0; t < jornadas.size(); t++)
         r[t + 1] = new SelectItem(jornadas.get(t), jornadas.get(t));
       return r;
    }
    
}
