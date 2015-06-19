/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package managedbeans;

import clases.ComisionCorrecDatos;
import clases.ComisionRevDatos;
import clases.ProfeDatos;
import clases.PropuestaDatos;
import clases.TemaDatos;
import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.Historial;
import entities.Profesor;
import entities.Tema;
import entities.Usuario;
import java.io.IOException;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import sessionbeans.HistorialFacade;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.TemaFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author Eduardo
 */
@Named(value="profesorViewMB")
@SessionScoped
public class ProfesorViewMB implements Serializable {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;

    /**
     * Creates a new instance of profesorViewMB
     */
    
    private ProfeDatos profeSelected, profeEdit;
    private String rutProfesor;
    private List<ComisionRevDatos> comRevisoras, propuestasQueRevisa;
    private List<ComisionCorrecDatos> comCorrectoras;
    private List<TemaDatos> temas;
    private List<Historial> historialProf;
    private List<PropuestaDatos> propuestas;
    private int guiaOld,contratoOld,maxGuiasOld,maxGuiasEdit;
    private boolean mostrarMaxGuias,mostrarProfRevs,mostrarProfRevsRevisor;
    private Date date;
    
    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value="#{authMB}")
    private AuthMB user;
    
    @PostConstruct
    public void init(){
        //Para inicializar el managed property, si no no se puede acceder a esos datos
    }
    
    public ProfesorViewMB() {
    }
    
    public AuthMB getUser() {
        return user;
    }

    public void setUser(AuthMB user) {
        this.user = user;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getMaxGuiasEdit() {
        return maxGuiasEdit;
    }

    public void setMaxGuiasEdit(int maxGuiasEdit) {
        this.maxGuiasEdit = maxGuiasEdit;
    }

    public boolean isMostrarProfRevsRevisor() {
        return mostrarProfRevsRevisor;
    }

    public void setMostrarProfRevsRevisor(boolean mostrarProfRevsRevisor) {
        this.mostrarProfRevsRevisor = mostrarProfRevsRevisor;
    }

    public boolean isMostrarMaxGuias() {
        return mostrarMaxGuias;
    }

    public void setMostrarMaxGuias(boolean mostrarMaxGuias) {
        this.mostrarMaxGuias = mostrarMaxGuias;
    }

    public List<Historial> getHistorialProf() {
        return historialProf;
    }

    public void setHistorialProf(List<Historial> historialProf) {
        this.historialProf = historialProf;
    }

    public ProfeDatos getProfeEdit() {
        return profeEdit;
    }

    public void setProfeEdit(ProfeDatos profeEdit) {
        this.profeEdit = profeEdit;
    }

    public String getRutProfesor() {
        return rutProfesor;
    }

    public void setRutProfesor(String rutProfesor) {
        this.rutProfesor = rutProfesor;
    }

    public ProfeDatos getProfeSelected() {
        return profeSelected;
    }

    public void setProfeSelected(ProfeDatos profeSelected) {
        this.profeSelected = profeSelected;
    }


    public List<ComisionCorrecDatos> getComCorrectoras() {
        return comCorrectoras;
    }

    public void setComCorrectoras(List<ComisionCorrecDatos> comCorrectoras) {
        this.comCorrectoras = comCorrectoras;
    }

    public List<TemaDatos> getTemas() {
        return temas;
    }

    public void setTemas(List<TemaDatos> temas) {
        this.temas = temas;
    }

    public List<ComisionRevDatos> getPropuestasQueRevisa() {
        return propuestasQueRevisa;
    }

    public void setPropuestasQueRevisa(List<ComisionRevDatos> propuestasQueRevisa) {
        this.propuestasQueRevisa = propuestasQueRevisa;
    }
    
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public List<ComisionRevDatos> getComRevisoras() {
        return comRevisoras;
    }

    public void setComRevisoras(List<ComisionRevDatos> comRevisoras) {
        this.comRevisoras = comRevisoras;
    }

    public List<PropuestaDatos> getPropuestas() {
        return propuestas;
    }

    public void setPropuestas(List<PropuestaDatos> propuestas) {
        this.propuestas = propuestas;
    }

    public boolean isMostrarProfRevs() {
        return mostrarProfRevs;
    }

    public void setMostrarProfRevs(boolean mostrarProfRevs) {
        this.mostrarProfRevs = mostrarProfRevs;
    }

    public void handleErrorView() throws IOException{
        try{
            if(profeSelected.getNombreProfesor() == null)
                FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
        catch (IOException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void viewSelectProfesor() throws IOException {
        rutProfesor = FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap().get("prof");
        try{
            if (!profesorFacade.findByRut(rutProfesor).isEmpty()){
                Profesor profe = profesorFacade.findByRut(rutProfesor).get(0);
                Usuario prof = usuarioFacade.findByRut(rutProfesor).get(0);
                profeSelected = new ProfeDatos();
                if(profe.getContrato() == 0)
                    profeSelected.setContratoProfesor("Por Hora");
                else
                    profeSelected.setContratoProfesor("JC");
                if(!prof.getMailUsuario().isEmpty())
                    profeSelected.setMailProfesor(prof.getMailUsuario());
                else
                    profeSelected.setMailProfesor("No tiene mail registrado");
                if(!prof.getTelefonoUsuario().isEmpty())
                    profeSelected.setTelefonoProfesor(prof.getTelefonoUsuario());
                else
                    profeSelected.setTelefonoProfesor("No tiene teléfono registrado");
                if(profe.getTipoProfesor() == 0)
                    profeSelected.setIsGuia("Si");
                else
                    profeSelected.setIsGuia("No");
                profeSelected.setApellidoProfesor(prof.getApellidoUsuarioPaterno());
                profeSelected.setNombreProfesor(prof.getNombreUsuario());
                profeSelected.setRutProfesor(rutProfesor);
                
                //Si el profesor es por hora y puede ser profesor guía
                mostrarMaxGuias = false;
                if((profeSelected.getIsGuia().equals("Si")) && (profeSelected.getContratoProfesor().equals("Por Hora"))){
                    mostrarMaxGuias = true;
                    profeSelected.setMaxGuias(profe.getMaximoGuias());
                    maxGuiasOld = profeSelected.getMaxGuias();
                    maxGuiasEdit = maxGuiasOld;
                }
                init();
            }
            else
                FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        } catch (NumberFormatException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void loadEditPage() throws IOException {
        try {
            profeEdit = new ProfeDatos();
            if (profeSelected.getContratoProfesor().equals("Por Hora")){
                profeEdit.setContratoProfesor("0");
                contratoOld = 0;
            }
            if(profeSelected.getContratoProfesor().equals("JC")){
                profeEdit.setContratoProfesor("1");
                contratoOld = 1;
            }
            if(profeSelected.getIsGuia().equals("Si")){
                profeEdit.setIsGuia("0");
                guiaOld = 0;
            }
            if(profeSelected.getIsGuia().equals("No")){
                profeEdit.setIsGuia("1");
                guiaOld = 1;
            }
            if(profeSelected.getMailProfesor().equals("No tiene mail registrado"))
                profeEdit.setMailProfesor("");
            else
                profeEdit.setMailProfesor(profeSelected.getMailProfesor());
            if (profeSelected.getTelefonoProfesor().equals("No tiene teléfono registrado"))
                profeEdit.setTelefonoProfesor("");
            else
                profeEdit.setTelefonoProfesor(profeSelected.getTelefonoProfesor());
            profeEdit.setApellidoProfesor(profeSelected.getApellidoProfesor());
            profeEdit.setNombreProfesor(profeSelected.getNombreProfesor());
            profeEdit.setRutProfesor(profeSelected.getRutProfesor());
            FacesContext.getCurrentInstance().getExternalContext().redirect("datosprofesor.xhtml");
        } catch (IOException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }

 //Devuelve true si en una cadena que llega todos son numeros, false en caso contrario
    public boolean esEntero(String cad) {
        for(int i = 0; i<cad.length(); i++)
            if( !Character.isDigit(cad.charAt(i)) )
                return false;
        return true;
    }
    
    public void editProfesor() throws IOException{
        Profesor profesor = new Profesor();
        Historial historialGuia= new Historial();
        String descripcion = null;
        
        try {
            FacesContext context = FacesContext.getCurrentInstance();
            
            //Si se le cambió el atributo isGuia, se añade al historial
            //y se setean los máx guías correspondientes
            if(!(guiaOld == Integer.valueOf(profeEdit.getIsGuia()))){
                //Validamos que se haya ingresado fecha
                if(date == null){
                    context.addMessage(null, new FacesMessage("Fecha edición", "Al cambiar el permiso para ser guía, es obligatorio que ponga la fecha en que sucedió este hecho, para el historial de permisos"));
                    return;
                }
                if(guiaOld == 0)
                    descripcion = "Permiso guía: Se le quitó el permiso para ser guía";
                else
                    descripcion = "Permiso guía: Se le concedió permiso para ser guía";
                String fechaCambioGuia = dateToString(date);
                historialGuia.setDescripcion(descripcion);
                historialGuia.setFechaHistorial(fechaCambioGuia);
                historialGuia.setIdEntidad(profeEdit.getRutProfesor());
                historialGuia.setTipoHistorial(0);
                historialFacade.create(historialGuia);
            }
            
            //Si se cambió de Por hora a JC
            if(contratoOld==0 && profeEdit.getContratoProfesor().equals("1")){
                profesor.setMaximoGuias(null);
                mostrarMaxGuias = false;
                maxGuiasOld = 0;
            }
            //Si se cambió de JC a Por hora, se setean máximo guías = 7
            if((contratoOld==1 && profeEdit.getContratoProfesor().equals("0"))){
                profesor.setMaximoGuias(7);
                maxGuiasOld = 7;
                maxGuiasEdit = 7;
                mostrarMaxGuias = true;
            }
            
            //Editamos datos profesor
            profesor.setContrato(Integer.valueOf(profeEdit.getContratoProfesor()));
            profesor.setTipoProfesor(Integer.valueOf(profeEdit.getIsGuia()));
            profesor.setRutProfesor(profeEdit.getRutProfesor());
            profesorFacade.edit(profesor);
            date = null;
            
            
            context.addMessage(null, new FacesMessage("Editar Profesor", "Datos de '"+profeEdit.getNombreProfesor()+" "+profeEdit.getApellidoProfesor()+"' editados exitosamente"));
        } catch (NumberFormatException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    
    public void loadEditProfMaxGuias() throws IOException{
        try{
            if(profeSelected == null)
                FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
            if(!mostrarMaxGuias){
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Editar máximo guías no permitido", "El profesor seleccionado es por hora sin permiso de ser guía, o de jornada completa"));
                return;
            } else
                FacesContext.getCurrentInstance().getExternalContext().redirect("guiasprofesor.xhtml");
        } catch (IOException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void editProfMaxGuias() throws IOException{
        try{
            Historial historial = new Historial();
            FacesContext context = FacesContext.getCurrentInstance();
            if (!esEntero(Integer.toString(maxGuiasEdit)) || maxGuiasEdit==0){
                context.addMessage(null, new FacesMessage("Máximo de Guías en Temas", "El valor debe ser un número entero mayor a 0"));
                return;
            }
            
            //Se valida ingreso de fecha
            if(date == null){
                context.addMessage(null, new FacesMessage("Fecha Edición","Debe seleccionar una fecha"));
                return;
            }
            Profesor prof = profesorFacade.findByRut(profeSelected.getRutProfesor()).get(0);

            //En caso de cualquier error, verificamos que el profesor pueda ser guía
            if(prof.getTipoProfesor() == 1){
                context.addMessage(null, new FacesMessage("Error al Editar Profesor", "Ha ocurrido un error. Este profesor no tiene permiso para guiar, por lo que no puede editarse su cantidad máxima de guías"));
                return;
            }
            if(maxGuiasOld == maxGuiasEdit){
                context.addMessage(null, new FacesMessage("Error al Editar Profesor", "No se ha cambiado la cantidad de guías"));
                return;
            }
            prof.setMaximoGuias(maxGuiasEdit);
            profesorFacade.edit(prof);
            
            //Agregamos al historial la edición
            String fechaAddMaxguia = dateToString(date);
            historial.setDescripcion("Permiso guía: se ha editado la cantidad máxima de guías de '"+maxGuiasOld+"' a '"+maxGuiasEdit+"'");
            historial.setFechaHistorial(rutProfesor);
            historial.setFechaHistorial(fechaAddMaxguia);
            historial.setIdEntidad(profeSelected.getRutProfesor());
            historial.setTipoHistorial(0);
            historialFacade.create(historial);

            //Añadimos al historial del usuario que editó al proefsor
            Historial histProfMaxGuiaEditUser = new Historial();
            Date temp = new Date();
            String dateHist = dateToString(temp);
            histProfMaxGuiaEditUser.setDescripcion("Permiso guía: el usuario editó la cantidad máxima de guías del profesor "+profeSelected.getRutProfesor());
            histProfMaxGuiaEditUser.setFechaHistorial(dateHist);
            histProfMaxGuiaEditUser.setTipoHistorial(3);
            histProfMaxGuiaEditUser.setIdEntidad(user.getUsername());
            historialFacade.create(histProfMaxGuiaEditUser);
            
            
            context.addMessage(null, new FacesMessage("Editar Profesor", "Se editó correctamente la cantidad máxima de guías en temas del profesor '"+profeSelected.getNombreProfesor()+" "+profeSelected.getApellidoProfesor()+"' de '"+maxGuiasOld+"' a '"+maxGuiasEdit+"'"));
        } catch (Exception e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }

    public void comisionesRevisorasProf() throws IOException{
        try{
            //Propuestas en las que el profesor es guía y propuestas que ha revisado
            Profesor profesor = profesorFacade.findByRut(profeSelected.getRutProfesor()).get(0);
            comRevisoras = new ArrayList();
            ComisionRevDatos propuesta;
            ComisionRevisora comRev;
            //Validamos si existen o no revisiones del profesor
            for(int i=0; i<profesor.getProfePropuestaList().size(); i++){
                if(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora() != null){
                    propuesta = new ComisionRevDatos();
                    comRev = new ComisionRevisora();
                    //Seteamos comisiones revisoras en las que ha sido guía
                    if(profesor.getProfePropuestaList().get(i).getRolGuia() == 0){
                        comRev = profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora();
                        propuesta.setFecha(comRev.getFechaRevision());
                        if(comRev.getIdPropuesta().getNombrePropuesta().length()>41)
                            propuesta.setNombrePropuesta(comRev.getIdPropuesta().getNombrePropuesta().substring(0,42)+"...");
                        else
                            propuesta.setNombrePropuesta(comRev.getIdPropuesta().getNombrePropuesta());
                        Usuario al2 = usuarioFacade.findByRut(comRev.getIdPropuesta().getRutAlumno().getRutAlumno()).get(0);
                        propuesta.setNombreAlumno(al2.getNombreUsuario()+" "+al2.getApellidoUsuarioPaterno());
                        propuesta.setIdSemestre(comRev.getIdSemestre().getIdSemestre());
                        if (comRev.getTipoRevision() == 0){
                            propuesta.setTipo("Propuesta en Trabajo de titulación (Prof por hora)");
                            mostrarProfRevs = true;
                        }
                        if (comRev.getTipoRevision() == 1){
                            propuesta.setTipo("Ramo de Seminario");
                            mostrarProfRevs = true;
                        }
                        if (comRev.getTipoRevision() == 2){
                            propuesta.setTipo("Acuerdo de Consejo");
                            mostrarProfRevs = false;
                        }
                        for(int j=0; j<comRev.getProfeRevisionList().size(); j++){
                            Usuario proff = usuarioFacade.findByRut(comRev.getProfeRevisionList().get(j).getProfesor().getRutProfesor()).get(0);
                            propuesta.addProfRev(proff.getNombreUsuario()+" "+proff.getApellidoUsuarioPaterno());
                        if(profesor.getProfePropuestaList().get(i).getRolGuia() == 0){
                            Usuario proff2 = usuarioFacade.findByRut(profesor.getProfePropuestaList().get(i).getProfesor().getRutProfesor()).get(0);
                            propuesta.setProfGuia(proff2.getNombreUsuario()+" "+proff2.getApellidoUsuarioPaterno());
                        }
                        if(profesor.getProfePropuestaList().get(i).getRolGuia() == 1){
                            Usuario proff3 = usuarioFacade.findByRut(profesor.getProfePropuestaList().get(i).getProfesor().getRutProfesor()).get(0);
                            propuesta.setProfCoGuia(proff3.getNombreUsuario()+" "+proff3.getApellidoUsuarioPaterno());
                        }
                        if(propuesta.getProfCoGuia() == null)
                            propuesta.setProfCoGuia("No posee");
                        comRevisoras.add(propuesta);
                        }
                    }
                }
            }
        } catch (Exception e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
    
    public void comisionesRevisorasReviser() throws IOException{
        try{
            Profesor profesor = profesorFacade.findByRut(profeSelected.getRutProfesor()).get(0);
            //Propuestas en las que el profesor es guía y propuestas que ha revisado
            propuestasQueRevisa = new ArrayList();
            ComisionRevDatos propuestaQueRevisa;
            ComisionRevisora comRev;
            //Validamos si existen o no revisiones del profesor
            if(!profesor.getProfeRevisionList().isEmpty()){
                for(int i=0; i<profesor.getProfeRevisionList().size(); i++){
                    propuestaQueRevisa = new ComisionRevDatos();
                    comRev = new ComisionRevisora();
                    //Seteamos comisiones revisoras en las que ha sido revisor
                    comRev = profesor.getProfeRevisionList().get(i).getComisionRevisora();
                    propuestaQueRevisa.setFecha(comRev.getFechaRevision());
                    if(comRev.getIdPropuesta().getNombrePropuesta().length()>41)
                        propuestaQueRevisa.setNombrePropuesta(comRev.getIdPropuesta().getNombrePropuesta().substring(0, 42)+"...");
                    else
                        propuestaQueRevisa.setNombrePropuesta(comRev.getIdPropuesta().getNombrePropuesta());
                    Usuario al = usuarioFacade.findByRut(comRev.getIdPropuesta().getRutAlumno().getRutAlumno()).get(0);
                    propuestaQueRevisa.setNombreAlumno(al.getNombreUsuario()+" "+al.getApellidoUsuarioPaterno());
                    propuestaQueRevisa.setIdSemestre(comRev.getIdSemestre().getIdSemestre());
                    if (comRev.getTipoRevision() == 0){
                        propuestaQueRevisa.setTipo("Propuesta en Trabajo de titulación (Prof por hora)");
                        mostrarProfRevsRevisor = true;
                    }
                    if (comRev.getTipoRevision() == 1){
                        propuestaQueRevisa.setTipo("Ramo de Seminario");
                        mostrarProfRevsRevisor = true;
                    }
                    if (comRev.getTipoRevision() == 2){
                        propuestaQueRevisa.setTipo("Acuerdo de Consejo");
                        mostrarProfRevsRevisor = false;
                    }
                    Usuario proQ = usuarioFacade.findByRut(comRev.getProfeRevisionList().get(0).getProfesor().getRutProfesor()).get(0);
                    Usuario proQ2 = usuarioFacade.findByRut(comRev.getProfeRevisionList().get(1).getProfesor().getRutProfesor()).get(0);
                    propuestaQueRevisa.addProfRev(proQ.getNombreUsuario()+" "+proQ.getApellidoUsuarioPaterno());
                    propuestaQueRevisa.addProfRev(proQ2.getNombreUsuario()+" "+proQ2.getApellidoUsuarioPaterno());
                    for(int j=0; j<comRev.getIdPropuesta().getProfePropuestaList().size(); j++){
                        if(comRev.getIdPropuesta().getProfePropuestaList().get(j).getRolGuia() == 0){
                            Usuario proQ3 = usuarioFacade.findByRut(comRev.getIdPropuesta().getProfePropuestaList().get(j).getProfesor().getRutProfesor()).get(0);
                            propuestaQueRevisa.setProfGuia(proQ3.getNombreUsuario()+" "+proQ3.getApellidoUsuarioPaterno());
                        }
                        else{
                            Usuario proQ4 = usuarioFacade.findByRut(comRev.getIdPropuesta().getProfePropuestaList().get(j).getProfesor().getRutProfesor()).get(0);
                            propuestaQueRevisa.setProfCoGuia(proQ4.getNombreUsuario()+" "+proQ4.getApellidoUsuarioPaterno());
                        }
                    }
                    if(propuestaQueRevisa.getProfCoGuia() == null)
                        propuestaQueRevisa.setProfCoGuia("No posee");
                    propuestasQueRevisa.add(propuestaQueRevisa);
                }
            }
        } catch (Exception e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
    
    public void temasProf() throws IOException{
        //Seteamos los temas que tiene
        try{
            Profesor profesor = profesorFacade.findByRut(profeSelected.getRutProfesor()).get(0);
            temas = new ArrayList();
            TemaDatos tema;
            String estadoTema = null, origenTema = null;
            Tema temaTemp = null;
            //Validamos si existen o no temas del profe
            for(int i=0; i<profesor.getProfePropuestaList().size(); i++){
                if(profesor.getProfePropuestaList().get(i).getRolGuia() == 0){
                    tema = new TemaDatos();
                    temaTemp = new Tema();
                    if(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora() != null)
                        if(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema() != null){
                            temaTemp = profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema();
                            if (temaTemp.getEstadoTema() == 0)
                                estadoTema = "Vigente";
                            if (temaTemp.getEstadoTema() == 1)
                                estadoTema = "Titulado";
                            if (temaTemp.getEstadoTema() == 2)
                                estadoTema = "Prolongado";
                            if (temaTemp.getEstadoTema() == 3)
                                estadoTema = "Caduco";
                            if (temaTemp.getEstadoTema() == 4)
                                estadoTema = "En proceso de Examen";
                            if (temaTemp.getEstadoTema() == 5)
                                estadoTema = "Magíster";
                            if (temaTemp.getEstadoTema() == 6)
                                estadoTema = "Vigente con borrador final";
                            if (temaTemp.getIdRevisora().getTipoRevision() == 0)
                                origenTema = ("Propuesta en Trabajo de titulación (Prof por hora)");
                            if (temaTemp.getIdRevisora().getTipoRevision() == 1)
                                origenTema = ("Ramo de Seminario");
                            if (temaTemp.getIdRevisora().getTipoRevision() == 2)
                                origenTema = ("Acuerdo de Consejo");
                            tema.setEstadoTema(estadoTema);
                            tema.setIngresoTema(origenTema);
                            tema.setFechaTema(temaTemp.getFechaTema());
                            tema.setSemestreTema(temaTemp.getIdSemestre().getIdSemestre());
                            Usuario temaUser = usuarioFacade.findByRut(temaTemp.getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno()).get(0);
                            tema.setNombreAlumno(temaUser.getNombreUsuario()+" "+temaUser.getApellidoUsuarioPaterno());
                            if(temaTemp.getNombreTema().length()>41)
                                tema.setNombreTema(temaTemp.getNombreTema().substring(0, 42)+"...");
                            else
                                tema.setNombreTema(temaTemp.getNombreTema());
                            temas.add(tema);
                        }
                    
                }
            }
        } catch (Exception e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
    
    public void comisionesCorrectorasProf() throws IOException{
        //Seteamos comisiones correctoras en las que ha participado
        try{
            Profesor profesor = profesorFacade.findByRut(profeSelected.getRutProfesor()).get(0);
            ComisionCorrecDatos comCorrectora;
            ComisionCorrectora comCorrecTemp;
            comCorrectoras = new ArrayList();
            //Validamos si existen o no correciones del profe
            if (!profesor.getProfeCorreccionList().isEmpty()){
                for(int i=0;i<profesor.getProfeCorreccionList().size();i++){
                    comCorrectora = new ComisionCorrecDatos();
                    comCorrecTemp = new ComisionCorrectora();
                    comCorrecTemp = profesor.getProfeCorreccionList().get(i).getComisionCorrectora();
                    comCorrectora.setFecha(comCorrecTemp.getFechaCorreccion());
                    comCorrectora.setIdSemestre(comCorrecTemp.getIdSemestre().getIdSemestre());
                    for(int j=0; j<comCorrecTemp.getProfeCorreccionList().size(); j++){
                        Usuario profCorre = usuarioFacade.findByRut(comCorrecTemp.getProfeCorreccionList().get(j).getProfesor().getRutProfesor()).get(0);
                        comCorrectora.addProfCorrec(profCorre.getNombreUsuario()+" "+profCorre.getApellidoUsuarioPaterno());
                    }
                    if(comCorrecTemp.getIdTema().getNombreTema().length()>41)
                        comCorrectora.setNombreTema(comCorrecTemp.getIdTema().getNombreTema().substring(0,42)+"...");
                    else
                        comCorrectora.setNombreTema(comCorrecTemp.getIdTema().getNombreTema());
                    if(comCorrecTemp.getProfeCorreccionList().get(0).getNotaCorreccionDefensa()!= null){
                        comCorrectora.setNotaCorrec1Def(comCorrecTemp.getProfeCorreccionList().get(0).getNotaCorreccionDefensa());
                        comCorrectora.setNotaCorrec1Inf(comCorrecTemp.getProfeCorreccionList().get(0).getNotaCorreccionInforme());
                        comCorrectora.setNotaCorrec2Def(comCorrecTemp.getProfeCorreccionList().get(1).getNotaCorreccionDefensa());
                        comCorrectora.setNotaCorrec2Inf(comCorrecTemp.getProfeCorreccionList().get(1).getNotaCorreccionInforme());
                        for (int j=0; j<comCorrecTemp.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().size(); j++)
                            if(comCorrecTemp.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(j).getRolGuia() == 0){
                                comCorrectora.setNotaGuiaDef(comCorrecTemp.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(j).getNotaGuiaDefensa());
                                comCorrectora.setNotaGuiaInf(comCorrecTemp.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(j).getNotaGuiaInforme());
                            }
                    }             
                    //Obtenemos el profesor guía
                    for(int k=0;k<comCorrecTemp.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().size();k++){
                        if(comCorrecTemp.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(k).getRolGuia()==0){
                            Usuario comCorr = usuarioFacade.findByRut(comCorrecTemp.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(k).getProfesor().getRutProfesor()).get(0);
                            comCorrectora.setProfGuia(comCorr.getNombreUsuario()+" "+comCorr.getApellidoUsuarioPaterno());
                        }
                        else{
                            Usuario comCorr2 = usuarioFacade.findByRut(comCorrecTemp.getIdTema().getIdRevisora().getIdPropuesta().getProfePropuestaList().get(k).getProfesor().getRutProfesor()).get(0);
                            comCorrectora.setProfCoGuia(comCorr2.getNombreUsuario()+" "+comCorr2.getApellidoUsuarioPaterno());
                        }
                            
                    }
                    if(comCorrectora.getProfCoGuia() == null)
                        comCorrectora.setProfCoGuia("No posee");
                    Usuario comCorr3 = usuarioFacade.findByRut(comCorrecTemp.getIdTema().getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno()).get(0);
                    comCorrectora.setNombreAlumno(comCorr3.getNombreUsuario());
                    comCorrectoras.add(comCorrectora);
                }
            }
        } catch (Exception e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
    
    public void historialProfIsGuia() throws IOException{
        try{
            historialProf = new ArrayList();
            historialProf = historialFacade.findByIdEntidad(rutProfesor);
        } catch (Exception e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
}
