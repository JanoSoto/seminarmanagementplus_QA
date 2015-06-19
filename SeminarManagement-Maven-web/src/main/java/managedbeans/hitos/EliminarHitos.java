/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//#####Cambiar aqui el paquete########
package managedbeans.hitos;
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
import entities.Usuario;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
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
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author Sophie Hans Castillo
 */
@Named(value = "eliminarHitos")
@RequestScoped
public class EliminarHitos {
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
    @EJB
    private UsuarioFacadeLocal usuarioFacade;
    private Integer idProp, idRev, idTem,idCorr;
    private String rutAlumno="", guiaProp, profRev1, profRev2, profCorr1, profCorr2;
    private List<Alumno> alumnos;
    private List<Propuesta> propuestas;
    private ComisionRevisora comRev;
    private Tema tema;
    private ComisionCorrectora comCorr;

    /**
     * Creates a new instance of EliminarHitos
     */
    public EliminarHitos() {
    }
    
    @PostConstruct
    public void init() {
        
        //Buscamos todos los alumnos que tengan por los menos una propuesta
        alumnos = alumnoFacade.findAll();
        List<Alumno> listaAlumTemp = new ArrayList();
        for(int i=0;i<alumnos.size();i++)
            if(alumnos.get(i).getPropuestaList().size()>0)
                listaAlumTemp.add(alumnos.get(i));
        alumnos = listaAlumTemp;
        
        //Buscamos todas las propuestas
        propuestas = propuestaFacade.findAll();
    }
    
    public void updateByAlumno(){
        if(rutAlumno == null){
            propuestas = new ArrayList();
            return;
        }
        Alumno alumnoTemp = alumnoFacade.findByRut(rutAlumno).get(0);
        //Buscamos todas las Propuestas del alumno seleccionado
        propuestas = alumnoTemp.getPropuestaList();
    }
    
    public void updateByPropuesta(){
        if(idProp == -1){
            return;
        }
        Propuesta propTemp = propuestaFacade.findById(idProp).get(0);
        Usuario us = usuarioFacade.findByRut(propTemp.getProfePropuestaList().get(0).getProfesor().getRutProfesor()).get(0);
        guiaProp = us.getNombreUsuario()+" "+us.getApellidoUsuarioPaterno();
        rutAlumno = propTemp.getRutAlumno().getRutAlumno();
        updateByAlumno();
        if(propTemp.getIdRevisora()!=null){
            comRev = propTemp.getIdRevisora();
            for(int i=0;i<comRev.getProfeRevisionList().size();i++){
                if(comRev.getProfeRevisionList().get(i).getRolRevision()==0){
                    Usuario profR = usuarioFacade.findByRut(comRev.getProfeRevisionList().get(i).getProfesor().getRutProfesor()).get(0);
                    profRev1 = profR.getNombreUsuario()+" "+profR.getApellidoUsuarioPaterno();
                }
                if(comRev.getProfeRevisionList().get(i).getRolRevision()==1){
                    Usuario profR2 = usuarioFacade.findByRut(comRev.getProfeRevisionList().get(i).getProfesor().getRutProfesor()).get(0);
                    profRev2 = profR2.getNombreUsuario()+" "+profR2.getApellidoUsuarioPaterno();
                }
            }
            if(comRev.getIdTema()!=null){
                tema = comRev.getIdTema();
                if(tema.getIdCorrectora()!=null){
                    comCorr = tema.getIdCorrectora();
                    for(int i=0;i<comCorr.getProfeCorreccionList().size();i++){
                        if(comCorr.getProfeCorreccionList().get(i).getRolCorreccion()==0){
                            Usuario profCr = usuarioFacade.findByRut(comCorr.getProfeCorreccionList().get(i).getProfesor().getRutProfesor()).get(0);
                            profCorr1 = profCr.getNombreUsuario()+" "+profCr.getApellidoUsuarioPaterno();
                        }
                        if(comCorr.getProfeCorreccionList().get(i).getRolCorreccion()==1){
                            Usuario profCr2 = usuarioFacade.findByRut(comCorr.getProfeCorreccionList().get(i).getProfesor().getRutProfesor()).get(0);
                            profCorr2 = profCr2.getNombreUsuario()+" "+profCr2.getApellidoUsuarioPaterno();
                        }
                    }
                }
            }
        }
    }
    
    public void removeByPropuesta(){
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
                    }
                    
                    //Se elimina la relación del Tema con la Comisión Correctora
                    tema.setIdCorrectora(null);
                    temaFacade.edit(tema);
                    
                    //Se elimina la Comisión Correctora
                    comisionCorrectoraFacade.remove(comCorr);
                    
                    //Mensaje de confirmación
                    context.addMessage(null, new FacesMessage("Comisión Correctora","Del tema: "+tema.getNombreTema()+", eliminada del sistema"));
                }
                
                //Se elimina la relación de la Comisión Revisora con el Tema
                comRev.setIdTema(null);
                comisionRevisoraFacade.edit(comRev);
                
                //Se elimina el Tema
                temaFacade.remove(tema);
                
                //Mensaje de confirmación
                context.addMessage(null, new FacesMessage("Tema",tema.getNombreTema()+", eliminado del sistema"));
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
        
        //Actualizamos los valores mostrados en la vista
        updateByPropuesta();
    }
    
    public void removeByComRev(){
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
                    }
                    
                    //Se elimina la relación del Tema con la Comisión Correctora
                    tema.setIdCorrectora(null);
                    temaFacade.edit(tema);
                    
                    //Se elimina la Comisión Correctora
                    comisionCorrectoraFacade.remove(comCorr);
                    
                    //Mensaje de confirmación
                    context.addMessage(null, new FacesMessage("Comisión Correctora","Del tema: "+tema.getNombreTema()+", eliminada del sistema"));
                }
                
                //Se elimina la relación de la Comisión Revisora con el Tema
                comRev.setIdTema(null);
                comisionRevisoraFacade.edit(comRev);
                
                //Se elimina el Tema
                temaFacade.remove(tema);
                
                //Mensaje de confirmación
                context.addMessage(null, new FacesMessage("Tema",tema.getNombreTema()+", eliminado del sistema"));
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
        }
        //Actualizamos los valores mostrados en la vista
        updateByPropuesta();
    }
    
    public void removeByTema(){
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
                    }
                    
                    //Se elimina la relación del Tema con la Comisión Correctora
                    tema.setIdCorrectora(null);
                    temaFacade.edit(tema);
                    
                    //Se elimina la Comisión Correctora
                    comisionCorrectoraFacade.remove(comCorr);
                    
                    //Mensaje de confirmación
                    context.addMessage(null, new FacesMessage("Comisión Correctora","Del tema: "+tema.getNombreTema()+", eliminada del sistema"));
                }
                
                //Se elimina la relación de la Comisión Revisora con el Tema
                comRev.setIdTema(null);
                comisionRevisoraFacade.edit(comRev);
                
                //Se elimina el Tema
                temaFacade.remove(tema);
                
                //Mensaje de confirmación
                context.addMessage(null, new FacesMessage("Tema",tema.getNombreTema()+", eliminado del sistema"));
            }
        }
        //Actualizamos los valores mostrados en la vista
        updateByPropuesta();
    }
    
    public void removeByComCorr(){
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
                }
            }
        }
        //Actualizamos los valores mostrados en la vista
        updateByPropuesta();
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
