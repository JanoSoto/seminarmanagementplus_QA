/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2;

import clases.PropuestaDatos;
import clases.TemaDatos;
import entities.Alumno;
import entities.ProfePropuesta;
import entities.Profesor;
import entities.Propuesta;
import entities.Tema;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "buscarMB")
@RequestScoped
public class BuscarMB {
    @EJB
    private TemaFacadeLocal temaFacade;
    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    
    private String query;
    private List<Profesor> profesores;
    private List<Alumno> alumnos;
    private List<Propuesta> propuestas;
    private List<PropuestaDatos> propDatos;
    private List<Tema> temas;
    private List<TemaDatos> temaDatos;

    /**
     * Creates a new instance of Buscar
     */
    public BuscarMB() {
    }
    
    public void buscarProfesor(){
        BuscarMB bMB = new BuscarMB();
        List<String> queries = bMB.splitString(query);
        
        profesores = profesorFacade.findProfesor(queries.get(0));
        
        for(int i=1;i<queries.size();i++){
            List<Profesor> profTemp,profTemp2 = new ArrayList();
            
            profTemp = profesorFacade.findProfesor(queries.get(i));
            
            for(int j=0;j<profTemp.size();j++)
                if(profesores.contains(profTemp.get(j)))
                    profTemp2.add(profTemp.get(j));
            profesores = profTemp2;
        }
    }
    
    public void buscarAlumno(){
        BuscarMB bMB = new BuscarMB();
        List<String> queries = bMB.splitString(query);
        
        alumnos = alumnoFacade.findAlumno(queries.get(0));
        
        for(int i=1;i<queries.size();i++){
            List<Alumno> alumTemp,alumTemp2 = new ArrayList();
            
            alumTemp = alumnoFacade.findAlumno(queries.get(i));
            
            for(int j=0;j<alumTemp.size();j++)
                if(alumnos.contains(alumTemp.get(j)))
                    alumTemp2.add(alumTemp.get(j));
            alumnos = alumTemp2;
        }
    }
    
    public void buscarPropuesta(){
        propuestas = propuestaFacade.findPropuesta(query);
        
        propDatos = new ArrayList();
        PropuestaDatos propDTemp;
        for(int i=0;i<propuestas.size();i++){
            propDTemp = new PropuestaDatos();
            propDTemp.setIdPropuesta(Integer.toString(propuestas.get(i).getIdPropuesta()));
            propDTemp.setAlumno(propuestas.get(i).getRutAlumno());
            propDTemp.setNombrePropuesta(propuestas.get(i).getNombrePropuesta());
            if(propuestas.get(i).getNombrePropuesta().length()>64)
                propDTemp.setNombreCorto(propuestas.get(i).getNombrePropuesta().substring(0,65)+"...");
            else
                propDTemp.setNombreCorto(propuestas.get(i).getNombrePropuesta());
            List<ProfePropuesta> listaProfes = propuestas.get(i).getProfePropuestaList();
            for(int j=0;j<listaProfes.size();j++)
                if(listaProfes.get(j).getRolGuia()==0)
                    propDTemp.setGuia(listaProfes.get(j).getProfesor());
                else
                    propDTemp.setCoGuia(listaProfes.get(j).getProfesor());

            propDatos.add(propDTemp);
        }
    }
    
    public void buscarTema(){
        temas = temaFacade.findTema(query);
        
        temaDatos = new ArrayList();
        TemaDatos temaDTemp;
        for(int i=0;i<temas.size();i++){
            temaDTemp = new TemaDatos();
            temaDTemp.setAlumno(temas.get(i).getIdRevisora().getIdPropuesta().getRutAlumno());
            List<ProfePropuesta> listaProfes = temas.get(i).getIdRevisora().getIdPropuesta().getProfePropuestaList();
            for(int j=0;j<listaProfes.size();j++)
                if(listaProfes.get(j).getRolGuia()==0)
                    temaDTemp.setGuia(listaProfes.get(j).getProfesor());
            temaDTemp.setIdTema(temas.get(i).getIdTema());
            temaDTemp.setNombreTema(temas.get(i).getNombreTema());
            if(temas.get(i).getNombreTema().length()>64)
                temaDTemp.setNombreCorto(temas.get(i).getNombreTema().substring(0,65)+"...");
            else
                temaDTemp.setNombreCorto(temas.get(i).getNombreTema());
            temaDTemp.setSemestreTema(temas.get(i).getIdSemestre().getIdSemestre());
            temaDatos.add(temaDTemp);
        }
    }
    
    public List<String> splitString(String s){
        List<String> splitTemp = new ArrayList();
        
        while(!s.equals("")){
            if(!s.contains(" ")){
                splitTemp.add(s);
                s = "";
            }
            else{
                splitTemp.add(s.substring(0,s.indexOf(" ")));
                s = s.substring(s.indexOf(" ")+1);
            }
        }
        return splitTemp;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public List<Profesor> getProfesores() {
        return profesores;
    }

    public List<TemaDatos> getTemaDatos() {
        return temaDatos;
    }

    public void setTemaDatos(List<TemaDatos> temaDatos) {
        this.temaDatos = temaDatos;
    }

    public void setProfesores(List<Profesor> profesores) {
        this.profesores = profesores;
    }

    public List<Alumno> getAlumnos() {
        return alumnos;
    }

    public void setAlumnos(List<Alumno> alumnos) {
        this.alumnos = alumnos;
    }

    public List<Propuesta> getPropuestas() {
        return propuestas;
    }

    public void setPropuestas(List<Propuesta> propuestas) {
        this.propuestas = propuestas;
    }

    public List<PropuestaDatos> getPropDatos() {
        return propDatos;
    }

    public void setPropDatos(List<PropuestaDatos> propDatos) {
        this.propDatos = propDatos;
    }
    
    public List<Tema> getTemas() {
        return temas;
    }

    public void setTemas(List<Tema> temas) {
        this.temas = temas;
    }
    
}
