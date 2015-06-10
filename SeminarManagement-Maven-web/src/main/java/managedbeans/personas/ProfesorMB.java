/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package managedbeans.personas;

import entities.Alumno;
import entities.Historial;
import entities.Profesor;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import sessionbeans.ProfesorFacadeLocal;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import managedbeans.AuthMB;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.HistorialFacadeLocal;

/**
 *
 * @author Eduardo
 */

@ManagedBean(name ="profesorMB")
@RequestScoped
public class ProfesorMB implements Serializable{
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;

    private String nombreProfesor,apellidoProfesor,celularProfesor,rutProfesor,mailProfesor;
    private Integer contratoProfesor, jornadaProfesor, isProfGuia;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(ProfesorMB.class);
    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value="#{authMB}")
    private AuthMB user;
    
    @PostConstruct
    public void init(){
        //Para inicializar el managed property, si no no se puede acceder a esos datos
    }
    
    public ProfesorMB() {
    }
    
    public AuthMB getUser() {
        return user;
    }

    public void setUser(AuthMB user) {
        this.user = user;
    }
    
    public Integer getIsProfGuia() {
        return isProfGuia;
    }

    public void setIsProfGuia(Integer isProfGuia) {
        this.isProfGuia = isProfGuia;
    }
    
    public String getNombreProfesor() {
        return nombreProfesor;
    }

    public void setNombreProfesor(String nombreProfesor) {
        this.nombreProfesor = nombreProfesor;
    }

    public String getApellidoProfesor() {
        return apellidoProfesor;
    }

    public void setApellidoProfesor(String apellidoProfesor) {
        this.apellidoProfesor = apellidoProfesor;
    }

    public String getMailProfesor() {
        return mailProfesor;
    }

    public void setMailProfesor(String mailProfesor) {
        this.mailProfesor = mailProfesor;
    }

    public String getRutProfesor() {
        return rutProfesor;
    }

    public void setRutProfesor(String rutProfesor) {
        this.rutProfesor = rutProfesor;
    }

    public String getCelularProfesor() {
        return celularProfesor;
    }

    public void setCelularProfesor(String celularProfesor) {
        this.celularProfesor = celularProfesor;
    }

    public Integer getContratoProfesor() {
        return contratoProfesor;
    }

    public void setContratoProfesor(Integer contratoProfesor) {
        this.contratoProfesor = contratoProfesor;
    }
    
    public Integer getJornadaProfesor() {
        return jornadaProfesor;
    }

    public void setJornadaProfesor(Integer jornadaProfesor) {
        this.jornadaProfesor = jornadaProfesor;
    }
    
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }
    
    public void addProfesor() {
        FacesContext context = FacesContext.getCurrentInstance();
        rutProfesor = rutProfesor.toUpperCase();
        rutProfesor = rutProfesor.replace(".", "");
        rutProfesor = rutProfesor.replace("-", "");
        List<Profesor> profesoresIngresados = profesorFacade.findByRut(rutProfesor);
        List<Alumno> alumnosIngresados = alumnoFacade.findByRut(rutProfesor);
        
        //Validamos que el rut no exista
        if(!profesoresIngresados.isEmpty() || !alumnosIngresados.isEmpty() ){
            context.addMessage(null, new FacesMessage("ERROR: El Rut ingresado ya existe.",""));
            return;
        }
        
        //Ingresamos al profesor
        Profesor profesor;
        profesor = new Profesor(rutProfesor);
        profesor.setNombreProfesor(nombreProfesor.toUpperCase());
        profesor.setApellidoProfesor(apellidoProfesor.toUpperCase());
        profesor.setMailProfesor(mailProfesor);
        profesor.setTelefonoProfesor(celularProfesor);
        profesor.setContrato(contratoProfesor);
        
        
        //Si es JC, puede guiar siempre, si no, se setea la opción escogida
        if(contratoProfesor==1)
            profesor.setTipoProfesor(0);
            profesor.setMaximoGuias(7);
        if(contratoProfesor==0)
            profesor.setTipoProfesor(1);
            profesor.setMaximoGuias(0);
        
        profesorFacade.create(profesor);
       
        /*
        //Agregar registro al historial
        Historial historialAddProf = new Historial();
        Date date = new Date();
        String fechaGuia = dateToString(date);
        if(isProfGuia == 0)
            historialAddProf.setDescripcion("Permiso guía: Se le permitió ser profesor guía al ingresar al sistema");
        else
            historialAddProf.setDescripcion("Permiso guía: No se le permitió ser profesor guía al ingresar al sistema");
        historialAddProf.setFechaHistorial(fechaGuia);
        historialAddProf.setIdEntidad(rutProfesor);
        historialAddProf.setTipoHistorial(0);
        historialFacade.create(historialAddProf);
        
        //Añadimos al historial del profesor de cuándo fue agregado
        Date temp = new Date();
        String dateHist = dateToString(temp);
        Historial histProfeAgregado = new Historial();
        histProfeAgregado.setDescripcion("Se ingresó profesor al sistema. Lo ingresó el usuario "+user.getFullNameUser());
        histProfeAgregado.setFechaHistorial(dateHist);
        histProfeAgregado.setTipoHistorial(2);
        histProfeAgregado.setIdEntidad(rutProfesor);
        historialFacade.create(histProfeAgregado);
        
        
        //Añadimos al historial del usuario que lo ingresó
        Historial histProfEditadoUser = new Historial();
        histProfEditadoUser.setDescripcion("Ingresó al sistema al profesor "+nombreProfesor.toUpperCase()+" "+apellidoProfesor.toUpperCase());
        histProfEditadoUser.setFechaHistorial(dateHist);
        histProfEditadoUser.setTipoHistorial(3);
        histProfEditadoUser.setIdEntidad(user.getUsername());
        historialFacade.create(histProfEditadoUser);
        */
        //Mensaje de confirmación 
        LOGGER.info("Se ha agregado el profesor "+ nombreProfesor.toUpperCase()+" "+apellidoProfesor.toUpperCase() );
        context.addMessage(null, new FacesMessage("Agregar Profesor",nombreProfesor.toUpperCase()+" "+apellidoProfesor.toUpperCase()+", ingresado al sistema"));
        
        //Vaciamos el formulario
        rutProfesor = null;
        nombreProfesor = null;
        apellidoProfesor = null;
        mailProfesor = null;
        celularProfesor = null;
        contratoProfesor = null;
        isProfGuia = null;
    }
}