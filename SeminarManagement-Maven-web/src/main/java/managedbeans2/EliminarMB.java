/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//#####Cambiar aqui el paquete########
package managedbeans2;
//####################################

import entities.Alumno;
import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.ProfeCorreccion;
import entities.ProfePropuesta;
import entities.ProfeRevision;
import entities.Profesor;
import entities.Propuesta;
import entities.Tema;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.ComisionCorrectoraFacadeLocal;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.ProfeCorreccionFacadeLocal;
import sessionbeans.ProfePropuestaFacadeLocal;
import sessionbeans.ProfeRevisionFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author Sophie Hans Castillo
 */
@Named(value = "eliminarMB")
@RequestScoped
public class EliminarMB {
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private ProfePropuestaFacadeLocal profePropuestaFacade;
    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    @EJB
    private ProfeRevisionFacadeLocal profeRevisionFacade;
    @EJB
    private ComisionRevisoraFacadeLocal comisionRevisoraFacade;
    @EJB
    private ComisionCorrectoraFacadeLocal comisionCorrectoraFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    @EJB
    private ProfeCorreccionFacadeLocal profeCorreccionFacade;
    
    private Integer idProp, idRev, idTem,idCorr;
    private String rutAlumno="", guiaProp, profRev1, profRev2, profCorr1, profCorr2;
    private List<Alumno> alumnos;
    private List<Propuesta> propuestas;
    private ComisionRevisora comRev;
    private Tema tema;
    private ComisionCorrectora comCorr;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(EliminarMB.class);

    /**
     * Creates a new instance of EliminarHitos
     */
    public EliminarMB() {
    }
    
    public void removeByPropuesta(Integer id) throws IOException{
        FacesContext context = FacesContext.getCurrentInstance();
        ExternalContext externalContext = FacesContext.getCurrentInstance().getExternalContext();
        
        if(id==null){
            context.addMessage(null, new FacesMessage("Error","No se ingresó Id"));
            return;
        }
        Propuesta propTemp = propuestaFacade.findById(id).get(0);
        if(propTemp.getIdRevisora()!=null){
            comRev = propTemp.getIdRevisora();
            if(comRev.getIdTema()!=null){
                tema = comRev.getIdTema();
                
                if(tema.getIdCorrectora()!=null){
                    comCorr = tema.getIdCorrectora();
                    
                    //Se eliminan las relaciones entre la Comisión Correctora y sus Profesores
                    for(int i=0;i<comCorr.getProfeCorreccionList().size();i++){
                        profeCorreccionFacade.remove(comCorr.getProfeCorreccionList().get(i));
                        
                        //Se elimina la Comisión Correctora de la lista del Profesor
                        Profesor profeTemp = comCorr.getProfeCorreccionList().get(i).getProfesor();
                        List<ProfeCorreccion> profeCorrListTemp = profeTemp.getProfeCorreccionList();
                        profeCorrListTemp.remove(comCorr.getProfeCorreccionList().get(i));
                        profeTemp.setProfeCorreccionList(profeCorrListTemp);
                        profesorFacade.edit(profeTemp);
                    }
                    
                    //Se elimina la Nota asignada al Profesor Guía del Tema
                    for(int i=0;i<propTemp.getProfePropuestaList().size();i++){
                        ProfePropuesta profePropTemp = propTemp.getProfePropuestaList().get(i);
                        profePropTemp.setNotaGuiaDefensa(null);
                        profePropTemp.setNotaGuiaInforme(null);
                        profePropuestaFacade.edit(profePropTemp);
                    }
                    
                    //Se elimina la relación del Tema con la Comisión Correctora
                    tema.setIdCorrectora(null);
                    temaFacade.edit(tema);
                    
                    //Se elimina la Comisión Correctora
                    comisionCorrectoraFacade.remove(comCorr);
                    
                    //Mensaje de confirmación
                    context.addMessage(null, new FacesMessage("Comisión Correctora","Del tema: "+tema.getNombreTema()+", eliminada del sistema"));
                    LOGGER.info("La comisión correctora del tema: "+tema.getNombreTema()+" ha sido eliminada del sistema");
                }
                
                //Se elimina la relación de la Comisión Revisora con el Tema
                comRev.setIdTema(null);
                comisionRevisoraFacade.edit(comRev);
                
                //Se elimina el Tema
                temaFacade.remove(tema);
                
                //Mensaje de confirmación
                context.addMessage(null, new FacesMessage("Tema",tema.getNombreTema()+", eliminado del sistema"));
                LOGGER.info("El tema "+tema.getNombreTema()+" ha sido eliminado del sistema");
            }
            
            //Se eliminan las relaciones entre la Comisión Revisora y sus Profesores
            for(int i=0;i<comRev.getProfeRevisionList().size();i++){
                profeRevisionFacade.remove(comRev.getProfeRevisionList().get(i));
                
                //Se elimina la Comisión Revisora de la lista del Profesor
                Profesor profeTemp = comRev.getProfeRevisionList().get(i).getProfesor();
                List<ProfeRevision> profeRevListTemp = profeTemp.getProfeRevisionList();
                profeRevListTemp.remove(comRev.getProfeRevisionList().get(i));
                profeTemp.setProfeRevisionList(profeRevListTemp);
                profesorFacade.edit(profeTemp);
            }
            
            //Se elimina la relación de la Propuesta con la Comisión Revisora
            propTemp.setIdRevisora(null);
            propuestaFacade.edit(propTemp);
            
            //Se elimina la Comisión Revisora
            comisionRevisoraFacade.remove(comRev);
            
            //Mensaje de confirmación
            context.addMessage(null, new FacesMessage("Comisión Revisora","De la Propuesta: "+propTemp.getNombrePropuesta()+", eliminada del sistema"));
            LOGGER.info("La comisión revisora de la Propuesta: "+propTemp.getNombrePropuesta()+" ha sido eliminada del sistema");
        }
        
        //Se eliminan las relaciones entre la Propuesta y sus Profesores
        for(int i=0;i<propTemp.getProfePropuestaList().size();i++){
            profePropuestaFacade.remove(propTemp.getProfePropuestaList().get(i));
            
            //Se elimina la Propuesta de la lista del Profesor
            Profesor profeTemp = propTemp.getProfePropuestaList().get(i).getProfesor();
            List<ProfePropuesta> profePropListTemp = profeTemp.getProfePropuestaList();
            profePropListTemp.remove(propTemp.getProfePropuestaList().get(i));
            profeTemp.setProfePropuestaList(profePropListTemp);
            profesorFacade.edit(profeTemp);
        }
        
        //Se elimina la Propuesta de la base de datos
        propuestaFacade.remove(propTemp);
        
        //Se elimina la Propuesta de la lista del alumno
        Alumno alumnoTemp = propTemp.getRutAlumno();
        List<Propuesta> alumnoPropuestaListTemp = propTemp.getRutAlumno().getPropuestaList();
        alumnoPropuestaListTemp.remove(propTemp);
        alumnoTemp.setPropuestaList(alumnoPropuestaListTemp);
        alumnoFacade.edit(alumnoTemp);
                
        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Propuesta",propTemp.getNombrePropuesta()+", eliminada del sistema"));
        LOGGER.info("La propuesta: "+propTemp.getNombrePropuesta()+ " ha sido eliminada del sistema");
        //externalContext.getFlash().setKeepMessages(true); //Para mantener los mensaje aunque se pase de página
        FacesContext.getCurrentInstance().getExternalContext().redirect("../alumnos/alumno.xhtml?alum="+propTemp.getRutAlumno().getRutAlumno());
        
    }
    
    public void removeByComRev(Integer id){
        FacesContext context = FacesContext.getCurrentInstance();
        
        Propuesta propTemp = propuestaFacade.findById(idProp).get(0);
        if(propTemp.getIdRevisora()!=null){
            comRev = propTemp.getIdRevisora();
            if(comRev.getIdTema()!=null){
                tema = comRev.getIdTema();
                
                if(tema.getIdCorrectora()!=null){
                    comCorr = tema.getIdCorrectora();
                    
                    //Se eliminan las relaciones entre la Comisión Correctora y sus Profesores
                    for(int i=0;i<comCorr.getProfeCorreccionList().size();i++){
                        profeCorreccionFacade.remove(comCorr.getProfeCorreccionList().get(i));
                        
                        //Se elimina la Comisión Correctora de la lista del Profesor
                        Profesor profeTemp = comCorr.getProfeCorreccionList().get(i).getProfesor();
                        List<ProfeCorreccion> profeCorrListTemp = profeTemp.getProfeCorreccionList();
                        profeCorrListTemp.remove(comCorr.getProfeCorreccionList().get(i));
                        profeTemp.setProfeCorreccionList(profeCorrListTemp);
                        profesorFacade.edit(profeTemp);
                    }
                    
                    //Se elimina la Nota asignada al Profesor Guía del Tema
                    for(int i=0;i<propTemp.getProfePropuestaList().size();i++){
                        ProfePropuesta profePropTemp = propTemp.getProfePropuestaList().get(i);
                        profePropTemp.setNotaGuiaDefensa(null);
                        profePropTemp.setNotaGuiaInforme(null);
                        profePropuestaFacade.edit(profePropTemp);
                    }
                    
                    //Se elimina la relación del Tema con la Comisión Correctora
                    tema.setIdCorrectora(null);
                    temaFacade.edit(tema);
                    
                    //Se elimina la Comisión Correctora
                    comisionCorrectoraFacade.remove(comCorr);
                    
                    //Mensaje de confirmación
                    context.addMessage(null, new FacesMessage("Comisión Correctora","Del tema: "+tema.getNombreTema()+", eliminada del sistema"));
                    LOGGER.info("La comisión correctora del tema: "+tema.getNombreTema()+" ha sido eliminada del sistema");
                }
                
                //Se elimina la relación de la Comisión Revisora con el Tema
                comRev.setIdTema(null);
                comisionRevisoraFacade.edit(comRev);
                
                //Se elimina el Tema
                temaFacade.remove(tema);
                
                //Mensaje de confirmación
                context.addMessage(null, new FacesMessage("Tema",tema.getNombreTema()+", eliminado del sistema"));
                LOGGER.info("El tema "+tema.getNombreTema()+" ha sido eliminado del sistema");
            }
            
            //Se eliminan las relaciones entre la Comisión Revisora y sus Profesores
            for(int i=0;i<comRev.getProfeRevisionList().size();i++){
                profeRevisionFacade.remove(comRev.getProfeRevisionList().get(i));
                
                //Se elimina la Comisión Revisora de la lista del Profesor
                Profesor profeTemp = comRev.getProfeRevisionList().get(i).getProfesor();
                List<ProfeRevision> profeRevListTemp = profeTemp.getProfeRevisionList();
                profeRevListTemp.remove(comRev.getProfeRevisionList().get(i));
                profeTemp.setProfeRevisionList(profeRevListTemp);
                profesorFacade.edit(profeTemp);
            }
            
            //Se elimina la relación de la Propuesta con la Comisión Revisora
            propTemp.setIdRevisora(null);
            propuestaFacade.edit(propTemp);
            
            //Se elimina la Comisión Revisora
            comisionRevisoraFacade.remove(comRev);
            
            //Mensaje de confirmación
            context.addMessage(null, new FacesMessage("Comisión Revisora","De la Propuesta: "+propTemp.getNombrePropuesta()+", eliminada del sistema"));
            LOGGER.info("La comisión revisora de la Propuesta "+propTemp.getNombrePropuesta()+" ha sido eliminada del sistema\"");
        }
        //Actualizamos los valores mostrados en la vista
    }
    
    public void removeByTema(Integer id) throws IOException{
        FacesContext context = FacesContext.getCurrentInstance();
        
        if(id==null){
            context.addMessage(null, new FacesMessage("Error","No se ingresó Id"));
            return;
        }
        if(temaFacade.findById(id).get(0).getIdRevisora() != null)
            if(temaFacade.findById(id).get(0).getIdRevisora().getIdPropuesta() != null)
                if(temaFacade.findById(id).get(0).getIdRevisora().getIdPropuesta().getIdPropuesta() != null)
                    idProp = temaFacade.findById(id).get(0).getIdRevisora().getIdPropuesta().getIdPropuesta();
        Propuesta propTemp = propuestaFacade.findById(idProp).get(0);
        if(propTemp.getIdRevisora()!=null){
            comRev = propTemp.getIdRevisora();
            if(comRev.getIdTema()!=null){
                tema = comRev.getIdTema();
                
                if(tema.getIdCorrectora()!=null){
                    comCorr = tema.getIdCorrectora();
                    
                    //Se eliminan las relaciones entre la Comisión Correctora y sus Profesores
                    for(int i=0;i<comCorr.getProfeCorreccionList().size();i++){
                        profeCorreccionFacade.remove(comCorr.getProfeCorreccionList().get(i));
                        
                        //Se elimina la Comisión Correctora de la lista del Profesor
                        Profesor profeTemp = comCorr.getProfeCorreccionList().get(i).getProfesor();
                        List<ProfeCorreccion> profeCorrListTemp = profeTemp.getProfeCorreccionList();
                        profeCorrListTemp.remove(comCorr.getProfeCorreccionList().get(i));
                        profeTemp.setProfeCorreccionList(profeCorrListTemp);
                        profesorFacade.edit(profeTemp);
                    }
                    
                    //Se elimina la Nota asignada al Profesor Guía del Tema
                    for(int i=0;i<propTemp.getProfePropuestaList().size();i++){
                        ProfePropuesta profePropTemp = propTemp.getProfePropuestaList().get(i);
                        profePropTemp.setNotaGuiaDefensa(null);
                        profePropTemp.setNotaGuiaInforme(null);
                        profePropuestaFacade.edit(profePropTemp);
                    }
                    
                    //Se elimina la relación del Tema con la Comisión Correctora
                    tema.setIdCorrectora(null);
                    temaFacade.edit(tema);
                    
                    //Se elimina la Comisión Correctora
                    comisionCorrectoraFacade.remove(comCorr);
                    
                    //Mensaje de confirmación
                    context.addMessage(null, new FacesMessage("Comisión Correctora","Del tema: "+tema.getNombreTema()+", eliminada del sistema"));
                    LOGGER.info("La comisión correctora del tema "+tema.getNombreTema()+" ha sido eliminada del sistema");
                }
                
                //Se elimina la relación de la Comisión Revisora con el Tema
                comRev.setIdTema(null);
                comisionRevisoraFacade.edit(comRev);
                
                //Se elimina el Tema
                temaFacade.remove(tema);
                
                //Mensaje de confirmación
                context.addMessage(null, new FacesMessage("Tema",tema.getNombreTema()+", eliminado del sistema"));
                LOGGER.info("El tema "+tema.getNombreTema()+" ha sido eliminado del sistema");
                
                //externalContext.getFlash().setKeepMessages(true); //Para mantener los mensaje aunque se pase de página
                FacesContext.getCurrentInstance().getExternalContext().redirect("../alumnos/alumno.xhtml?alum="+propTemp.getRutAlumno().getRutAlumno());
            }
        }
        
        //Actualizamos los valores mostrados en la vista
    }
    
    public void removeByComCorr(Integer id){
        FacesContext context = FacesContext.getCurrentInstance();
        
        if(comisionCorrectoraFacade.findById(id).get(0).getIdTema() != null)
            if(comisionCorrectoraFacade.findById(id).get(0).getIdTema().getIdRevisora() != null)
                if(comisionCorrectoraFacade.findById(id).get(0).getIdTema().getIdRevisora().getIdPropuesta() != null)
                    idProp = comisionCorrectoraFacade.findById(id).get(0).getIdTema().getIdRevisora().getIdPropuesta().getIdPropuesta();
        Propuesta propTemp = propuestaFacade.findById(idProp).get(0);
        if(propTemp.getIdRevisora()!=null){
            comRev = propTemp.getIdRevisora();
            if(comRev.getIdTema()!=null){
                tema = comRev.getIdTema();
                
                if(tema.getIdCorrectora()!=null){
                    comCorr = tema.getIdCorrectora();
                    
                    //Se eliminan las relaciones entre la Comisión Correctora y sus Profesores
                    for(int i=0;i<comCorr.getProfeCorreccionList().size();i++){
                        profeCorreccionFacade.remove(comCorr.getProfeCorreccionList().get(i));
                        
                        //Se elimina la Comisión Correctora de la lista del Profesor
                        Profesor profeTemp = comCorr.getProfeCorreccionList().get(i).getProfesor();
                        List<ProfeCorreccion> profeCorrListTemp = profeTemp.getProfeCorreccionList();
                        profeCorrListTemp.remove(comCorr.getProfeCorreccionList().get(i));
                        profeTemp.setProfeCorreccionList(profeCorrListTemp);
                        profesorFacade.edit(profeTemp);
                    }
                    
                    //Se elimina la Nota asignada al Profesor Guía del Tema
                    for(int i=0;i<propTemp.getProfePropuestaList().size();i++){
                        ProfePropuesta profePropTemp = propTemp.getProfePropuestaList().get(i);
                        profePropTemp.setNotaGuiaDefensa(null);
                        profePropTemp.setNotaGuiaInforme(null);
                        profePropuestaFacade.edit(profePropTemp);
                    }
                    
                    //Se elimina la relación del Tema con la Comisión Correctora
                    tema.setIdCorrectora(null);
                    //Seteamos estado del Tema "Vigente con Borrador Final"
                    tema.setEstadoTema(6);
                    temaFacade.edit(tema);
                    
                    //Se elimina la Comisión Correctora
                    comisionCorrectoraFacade.remove(comCorr);
                    
                    //Mensaje de confirmación
                    context.addMessage(null, new FacesMessage("Comisión Correctora","Del tema: "+tema.getNombreTema()+", eliminada del sistema"));
                    LOGGER.info("La comisión correctora del tema: "+tema.getNombreTema()+" ha sido eliminada del sistema");
                }
            }
        }
        //Actualizamos los valores mostrados en la vista
    }

    public String getGuiaProp() {
        return guiaProp;
    }

    public void setGuiaProp(String guiaProp) {
        this.guiaProp = guiaProp;
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public Integer getIdProp() {
        return idProp;
    }

    public void setIdProp(Integer idProp) {
        this.idProp = idProp;
    }

    public Integer getIdRev() {
        return idRev;
    }

    public void setIdRev(Integer idRev) {
        this.idRev = idRev;
    }

    public Integer getIdTem() {
        return idTem;
    }

    public void setIdTem(Integer idTem) {
        this.idTem = idTem;
    }

    public Integer getIdCorr() {
        return idCorr;
    }

    public void setIdCorr(Integer idCorr) {
        this.idCorr = idCorr;
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

    public ComisionRevisora getComRev() {
        return comRev;
    }

    public void setComRev(ComisionRevisora comRev) {
        this.comRev = comRev;
    }

    public Tema getTema() {
        return tema;
    }

    public void setTema(Tema tema) {
        this.tema = tema;
    }

    public ComisionCorrectora getComCorr() {
        return comCorr;
    }

    public void setComCorr(ComisionCorrectora comCorr) {
        this.comCorr = comCorr;
    }

    public String getProfRev1() {
        return profRev1;
    }

    public void setProfRev1(String profRev1) {
        this.profRev1 = profRev1;
    }

    public String getProfRev2() {
        return profRev2;
    }

    public void setProfRev2(String profRev2) {
        this.profRev2 = profRev2;
    }

    public String getProfCorr1() {
        return profCorr1;
    }

    public void setProfCorr1(String profCorr1) {
        this.profCorr1 = profCorr1;
    }

    public String getProfCorr2() {
        return profCorr2;
    }

    public void setProfCorr2(String profCorr2) {
        this.profCorr2 = profCorr2;
    }
    
}
