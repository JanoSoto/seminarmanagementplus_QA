/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.alumnos;

import clases.PropuestaDatos;
import clases.TemaDatos;
import entities.Alumno;
import entities.ProfePropuesta;
import entities.Tema;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.AlumnoFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "verAlumnoMB")
@RequestScoped
public class VerAlumnoMB {
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    
    private String rutAlumno;
    private Alumno alumno;
    private List<PropuestaDatos> propDatos;
    private List<TemaDatos> temaDatos;
    
    /**
     * Creates a new instance of VerAlumnoMB
     */
    public VerAlumnoMB() {
    }
    
    public void buscarAlumno(){
        if(rutAlumno!=null){
            List<Alumno> alumnoTemp =  alumnoFacade.findByRut(rutAlumno);
            if(alumnoTemp.isEmpty()){
                FacesContext context = FacesContext.getCurrentInstance();
                context.addMessage(null, new FacesMessage("Error","La página solicitada no existe"));
                return;
            }
            alumno = alumnoFacade.findByRut(rutAlumno).get(0);
            
            propDatos = new ArrayList();
            PropuestaDatos propDTemp;
            for(int i=0;i<alumno.getPropuestaList().size();i++){
                propDTemp = new PropuestaDatos();
                propDTemp.setIdPropuesta(Integer.toString(alumno.getPropuestaList().get(i).getIdPropuesta()));
                propDTemp.setNombrePropuesta(alumno.getPropuestaList().get(i).getNombrePropuesta());
                if(alumno.getPropuestaList().get(i).getNombrePropuesta().length()>64)
                    propDTemp.setNombreCorto(alumno.getPropuestaList().get(i).getNombrePropuesta().substring(0,65)+"...");
                else
                    propDTemp.setNombreCorto(alumno.getPropuestaList().get(i).getNombrePropuesta());
                List<ProfePropuesta> listaProfes = alumno.getPropuestaList().get(i).getProfePropuestaList();
                for(int j=0;j<listaProfes.size();j++)
                    if(listaProfes.get(j).getRolGuia()==0)
                        propDTemp.setGuia(listaProfes.get(j).getProfesor());

                propDatos.add(propDTemp);
            }

            temaDatos = new ArrayList();
            TemaDatos temaDTemp;
            List<Tema> temasTemp = new ArrayList();
            for(int i=0;i<alumno.getPropuestaList().size();i++)
                if(alumno.getPropuestaList().get(i).getIdRevisora()!=null)
                    if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema()!=null){
                        temaDTemp = new TemaDatos();
                        temaDTemp.setIdTema(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getIdTema());
                        temaDTemp.setNombreTema(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getNombreTema());
                        if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getNombreTema().length()>64)
                            temaDTemp.setNombreCorto(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getNombreTema().substring(0,65)+"...");
                        else
                            temaDTemp.setNombreCorto(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getNombreTema());
                        if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema()!=null){
                            if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema()==0)
                                temaDTemp.setEstadoTema("VIGENTE");
                            if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema()==1)
                                temaDTemp.setEstadoTema("TITULADO");
                            if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema()==2)
                                temaDTemp.setEstadoTema("PRORROGADO");
                            if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema()==3)
                                temaDTemp.setEstadoTema("CADUCO");
                            if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema()==4)
                                temaDTemp.setEstadoTema("EN PROCESO EXAMEN");
                            if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema()==5)
                                temaDTemp.setEstadoTema("MAGISTER");
                            if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema()==6)
                                temaDTemp.setEstadoTema("VIGENTE");
                        }
                        List<ProfePropuesta> listaProfes = alumno.getPropuestaList().get(i).getProfePropuestaList();
                        for(int j=0;j<listaProfes.size();j++)
                            if(listaProfes.get(j).getRolGuia()==0)
                                temaDTemp.setGuia(listaProfes.get(j).getProfesor());
                        temaDatos.add(temaDTemp);
                    }
        }
        else{
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage("Error","No se ingresó Alumno"));
        }
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public List<PropuestaDatos> getPropDatos() {
        return propDatos;
    }

    public void setPropDatos(List<PropuestaDatos> propDatos) {
        this.propDatos = propDatos;
    }

    public List<TemaDatos> getTemaDatos() {
        return temaDatos;
    }

    public void setTemaDatos(List<TemaDatos> temaDatos) {
        this.temaDatos = temaDatos;
    }
    
}
