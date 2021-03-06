/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package managedbeans;

import clases.ComisionCorrecDatos;
import clases.ComisionRevDatos;
import clases.TemaDatos;
import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.Historial;
import entities.Tema;
import java.io.IOException;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author Eduardo
 */
@Named(value = "temaViewMB")
@SessionScoped
public class TemaViewMB implements Serializable {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private TemaFacadeLocal temaFacade;

    /**
     * Creates a new instance of TemaViewMB
     */
    
    private int idTema;
    private TemaDatos temaSelected;
    private ComisionRevDatos comRevisoraTema;
    private ComisionCorrecDatos comCorrectoraTema;
    private boolean mostrarProfRevs;
    private List<Historial> historialTema;
    
    public TemaViewMB() {
    }
    
    @PostConstruct
    public void init() {

    }

    public boolean isMostrarProfRevs() {
        return mostrarProfRevs;
    }

    public void setMostrarProfRevs(boolean mostrarProfRevs) {
        this.mostrarProfRevs = mostrarProfRevs;
    }

    public ComisionRevDatos getComRevisoraTema() {
        return comRevisoraTema;
    }

    public void setComRevisoraTema(ComisionRevDatos comRevisoraTema) {
        this.comRevisoraTema = comRevisoraTema;
    }

    public ComisionCorrecDatos getComCorrectoraTema() {
        return comCorrectoraTema;
    }

    public void setComCorrectoraTema(ComisionCorrecDatos comCorrectoraTema) {
        this.comCorrectoraTema = comCorrectoraTema;
    }

    public TemaDatos getTemaSelected() {
        return temaSelected;
    }

    public void setTemaSelected(TemaDatos temaSelected) {
        this.temaSelected = temaSelected;
    }

    public List<Historial> getHistorialTema() {
        return historialTema;
    }

    public void setHistorialTema(List<Historial> historialTema) {
        this.historialTema = historialTema;
    }
    
    public void viewSelectTema() throws IOException {
        try{
            //Obtenemos el valor del tema por el id, y seteamos sus datos
            idTema = Integer.valueOf(FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap().get("id"));
            List<Tema> temas = temaFacade.findById(idTema);
            if(!temas.isEmpty()) {
                temaSelected = new TemaDatos();
                Tema tema = temas.get(0);
                if(tema.getEstadoTema() == 0)
                    temaSelected.setEstadoTema("Vigente");
                if(tema.getEstadoTema() == 1)
                    temaSelected.setEstadoTema("Titulado");
                if(tema.getEstadoTema() == 2)
                    temaSelected.setEstadoTema("Prolongado");
                if(tema.getEstadoTema() == 3)
                    temaSelected.setEstadoTema("Caduco");
                if(tema.getEstadoTema() == 4)
                    temaSelected.setEstadoTema("En Proceso de Examen");
                if(tema.getEstadoTema() == 5)
                    temaSelected.setEstadoTema("Magíster");
                if(tema.getEstadoTema() == 6)
                    temaSelected.setEstadoTema("Vigente con borrador final");
                temaSelected.setFechaTema(tema.getFechaTema());
                temaSelected.setIdTema(idTema);
                if (tema.getIdRevisora().getTipoRevision() == 0)
                    temaSelected.setIngresoTema("Propuesta por Trabajo de titulación (Prof por hora)");
                if (tema.getIdRevisora().getTipoRevision() == 1)
                    temaSelected.setIngresoTema("Ramo de Seminario");
                if (tema.getIdRevisora().getTipoRevision() == 2)
                    temaSelected.setIngresoTema("Acuerdo de Consejo");
                temaSelected.setNombreAlumno(tema.getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno()+" "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno());
                for(int i=0; i<tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().size(); i++){
                    if(tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia() == 0)
                        temaSelected.setNombreProfesor(tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getNombreProfesor()+" "+tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getApellidoProfesor());
                    if(tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia() == 1)
                        temaSelected.setNombreProfCoGuia(tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getNombreProfesor()+" "+tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getApellidoProfesor());
                }
                temaSelected.setNombreTema(tema.getNombreTema());
                temaSelected.setSemestreTema(tema.getIdSemestre().getIdSemestre());
                init();
            }
            else {
                FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
            }
        } catch (NumberFormatException e) {
             FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
        
    }
    
    public void comisionRevisoraTema() throws IOException{
        try{
            comRevisoraTema = new ComisionRevDatos();
            ComisionRevisora comRevTema = temaFacade.findById(temaSelected.getIdTema()).get(0).getIdRevisora();
            comRevisoraTema.setFecha(comRevTema.getFechaRevision());
            comRevisoraTema.setIdRevisora(String.valueOf(comRevTema.getIdRevisora()));
            comRevisoraTema.setIdSemestre(comRevTema.getIdSemestre().getIdSemestre());
            comRevisoraTema.setNombreAlumno(comRevTema.getIdPropuesta().getRutAlumno().getNombreAlumno());
            comRevisoraTema.setRutAlumno(comRevTema.getIdPropuesta().getRutAlumno().getRutAlumno());
            for(int i=0; i<comRevTema.getProfeRevisionList().size();i++)
                comRevisoraTema.addProfRev(comRevTema.getProfeRevisionList().get(i).getProfesor().getNombreProfesor());
            if(comRevTema.getIdPropuesta().getNombrePropuesta().length()>38)
                comRevisoraTema.setNombrePropuesta(comRevTema.getIdPropuesta().getNombrePropuesta().substring(0,39)+"...");
            else
                comRevisoraTema.setNombrePropuesta(comRevTema.getIdPropuesta().getNombrePropuesta());
            for(int i=0;i<comRevTema.getIdPropuesta().getProfePropuestaList().size();i++){
                if(comRevTema.getIdPropuesta().getProfePropuestaList().get(i).getRolGuia()== 0)
                    comRevisoraTema.setProfGuia(comRevTema.getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getNombreProfesor()+" "+comRevTema.getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getApellidoProfesor());
                if(comRevTema.getIdPropuesta().getProfePropuestaList().get(i).getRolGuia() == 1)
                    comRevisoraTema.setProfCoGuia(comRevTema.getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getNombreProfesor()+" "+comRevTema.getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getApellidoProfesor());
            }
            
            //Seteamos tipo de revision
            //mostrarProfRevs, es parae evitar problemas si la comisión es por acuerdo de consejo
            //Ya que no habrían profesores y daría nullPointerException
            if(comRevTema.getTipoRevision() == 0){
                comRevisoraTema.setTipo("Propuesta por Trabajo de titulación (Prof por hora)");
                mostrarProfRevs = true;
            }
            if(comRevTema.getTipoRevision() == 1){
                comRevisoraTema.setTipo("Ramo de Seminario");
                mostrarProfRevs = true;
            }
            if(comRevTema.getTipoRevision() == 2){
                comRevisoraTema.setTipo("Acuerdo de Consejo");
                mostrarProfRevs = false;
            }
        } catch (Exception e){
            Logger.getLogger(TemaViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
    
    public void comisionCorrectoraTema() throws IOException{
        try{
            //Mostramos mensaje si no tiene comisión correctora
            if(temaFacade.findById(temaSelected.getIdTema()).get(0).getIdCorrectora()==null){
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Este tema aún no posee Comisión Correctora",""));
                return;
            }
            //Seteamos la comisión correctora
            comCorrectoraTema = new ComisionCorrecDatos();
            ComisionCorrectora comCorrecTema = temaFacade.findById(temaSelected.getIdTema()).get(0).getIdCorrectora();
            comCorrectoraTema.setFecha(comCorrecTema.getFechaCorreccion());
            comCorrectoraTema.setIdCorrectora(String.valueOf(comCorrecTema.getIdCorrectora()));
            comCorrectoraTema.setIdSemestre(comCorrecTema.getIdSemestre().getIdSemestre());
            comCorrectoraTema.addProfCorrec(comCorrecTema.getProfeCorreccionList().get(0).getProfesor().getNombreProfesor()+" "+comCorrecTema.getProfeCorreccionList().get(0).getProfesor().getApellidoProfesor());
            comCorrectoraTema.addProfCorrec(comCorrecTema.getProfeCorreccionList().get(1).getProfesor().getNombreProfesor()+" "+comCorrecTema.getProfeCorreccionList().get(1).getProfesor().getApellidoProfesor());
            comCorrectoraTema.setNombreAlumno(comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno()+" "+comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno());
            comCorrectoraTema.setNombreAlumno(comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno());
            comCorrectoraTema.setIdTema(String.valueOf(comCorrecTema.getIdTema().getIdTema()));
            if(comCorrecTema.getIdTema().getNombreTema().length()>41)
                comCorrectoraTema.setNombreTema(comCorrecTema.getIdTema().getNombreTema().substring(0,42)+"...");
            else
                comCorrectoraTema.setNombreTema(comCorrecTema.getIdTema().getNombreTema());
            //Seteamos prof correctores y notas, si es que están puestas
            comCorrectoraTema.addProfCorrec(comCorrecTema.getProfeCorreccionList().get(0).getProfesor().getNombreProfesor()+" "+comCorrecTema.getProfeCorreccionList().get(0).getProfesor().getApellidoProfesor());
            comCorrectoraTema.addProfCorrec(comCorrecTema.getProfeCorreccionList().get(1).getProfesor().getNombreProfesor()+" "+comCorrecTema.getProfeCorreccionList().get(1).getProfesor().getApellidoProfesor());
            if(comCorrecTema.getProfeCorreccionList().get(0).getNotaCorreccionDefensa() != null){
                comCorrectoraTema.setNotaCorrec1Def(comCorrecTema.getProfeCorreccionList().get(0).getNotaCorreccionDefensa());
                comCorrectoraTema.setNotaCorrec1Inf(comCorrecTema.getProfeCorreccionList().get(0).getNotaCorreccionInforme());
                comCorrectoraTema.setNotaCorrec2Def(comCorrecTema.getProfeCorreccionList().get(1).getNotaCorreccionDefensa());
                comCorrectoraTema.setNotaCorrec2Inf(comCorrecTema.getProfeCorreccionList().get(1).getNotaCorreccionInforme());
            }
            
            //Seteamos prof guía, co-guía y notaGuía si está puesta
            for(int i=0; i<comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().size(); i++){
                if(comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia() == 0){
                   comCorrectoraTema.setProfGuia(comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getNombreProfesor()+" "+comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getApellidoProfesor());
                   if(comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getNotaGuiaInforme() != null){
                      comCorrectoraTema.setNotaGuiaDef(comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getNotaGuiaDefensa());
                      comCorrectoraTema.setNotaGuiaInf(comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getNotaGuiaInforme());
                   }
                }
                if(comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia() == 1)
                    comCorrectoraTema.setProfCoGuia(comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getNombreProfesor()+" "+comCorrecTema.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor().getApellidoProfesor());
            }
        } catch (Exception e){
            Logger.getLogger(TemaViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
        
    }
    
    public void historialTema() throws IOException{
        try{
            List<Historial> historiales = historialFacade.findAll();
            historialTema = new ArrayList();
            for(int i=0; i<historiales.size(); i++){
                //Si el historial es de cambio de estado o de crear tema, se agrega a la lista
                if(((historiales.get(i).getTipoHistorial() == 1) || (historiales.get(i).getTipoHistorial() == 4) ))
                    if(historiales.get(i).getIdEntidad().equals(String.valueOf(temaSelected.getIdTema())))
                        historialTema.add(historiales.get(i));
            }
        } catch (Exception e){
            Logger.getLogger(TemaViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
}
