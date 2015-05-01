/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

import entities.Historial;
import entities.Profesor;
import entities.Tema;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import managedbeans.AuthMB;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.UploadedFile;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author David
 */
@ManagedBean(name ="avanceYCaducarMB")
@RequestScoped
public class AvanceYCaducarMB {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private TemaFacadeLocal temaFacade;

    private Integer idTema;
    private String rutAlumno,nombreTema,fechaTema,semestreTema;
    private Tema tema;
    private Profesor profGuia;
    private Date date;
    private UploadedFile informe;

    public UploadedFile getInforme() {
        return informe;
    }

    public void setInforme(UploadedFile informe) {
        this.informe = informe;
    }
    
    public AvanceYCaducarMB() {
    }
    
    public void addInformedeAvance(){
        FacesContext context = FacesContext.getCurrentInstance();

        //Se valida que se halla seleccionado Tema
        if((idTema==null)||(idTema==-1)){
            context.addMessage(null, new FacesMessage("Tema","No se ingresó un tema"));
            return;
        }

        //Validamos la fecha
        if(date==null || date.equals("")){
            context.addMessage(null, new FacesMessage("Fecha","Debe seleccionar la fecha de entrega del Informe de Avance"));
            return;
        }
        tema = temaFacade.findById(idTema).get(0);
        //Seteamos estado "Prolongado"
        tema.setEstadoTema(2);
        temaFacade.edit(tema);

        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Tema modificado", "El estado del tema seleccionado se modificó a 'Prorrogado'"));

        //Agregamos el historial de cambio de estado
        Historial historial = new Historial();
        String fecha = dateToString(date);
        historial.setDescripcion("Informe de Avance: El estado del tema cambió de 'Vigente' a 'Prorrogado'");
        historial.setFechaHistorial(fecha);
        historial.setIdEntidad(String.valueOf(idTema));
        historial.setTipoHistorial(1);
        historialFacade.create(historial);
    }
    
    public void caducarTema(){
        FacesContext context = FacesContext.getCurrentInstance();
        
        //Se valida que se halla seleccionado Tema
        if((idTema==null)||(idTema==-1)){
            context.addMessage(null, new FacesMessage("Tema","No se ingresó un tema"));
            return;
        }
        
        if(date==null || date.equals("")){
            context.addMessage(null, new FacesMessage("Fecha","Debe seleccionar la fecha de entrega de la renuncia"));
            return;
        }
        
        tema = temaFacade.findById(idTema).get(0);
        //Seteamos estado "Prolongado"
        tema.setEstadoTema(3);
        temaFacade.edit(tema);
        
        /*
        //Añadimos al historial del alumno
        Date temp = new Date();
        String dateHist = dateToString(temp);
        Historial histTemaAlum = new Historial();
        histTemaAlum.setDescripcion("Alumno entregó Informe de Avance. Lo ingresó el usuario "+user.getFullNameUser());
        histTemaAlum.setFechaHistorial(dateHist);
        histTemaAlum.setTipoHistorial(2);
        histTemaAlum.setIdEntidad(tema.getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno());
        historialFacade.create(histTemaAlum);
        
        //Añadimos al historial del usuario que ingresó el borrador
        Historial histBorradorUser = new Historial();
        histBorradorUser.setDescripcion("Ingresó Informe de Avance del alumno "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno()+" "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno());
        histBorradorUser.setFechaHistorial(dateHist);
        histBorradorUser.setTipoHistorial(3);
        histBorradorUser.setIdEntidad(user.getUsername());
        historialFacade.create(histBorradorUser);
        
        //Agregamos el historial de cambio de estado
        Historial historial = new Historial();
        //String fecha = dateToString(date);
        historial.setDescripcion("Renuncia: El estado del tema cambió de 'Vigente' a 'Caduco'");
        historial.setFechaHistorial(dateHist);
        historial.setIdEntidad(String.valueOf(idTema));
        historial.setTipoHistorial(1);
        historialFacade.create(historial);
        */
        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Tema modificado", "El estado del tema seleccionado se modificó a 'Caduco'"));
    }
    
    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value="#{authMB}")
    private AuthMB user;
    
    public AuthMB getUser() {
        return user;
    }

    public void setUser(AuthMB user) {
        this.user = user;
    }

    public Integer getIdTema() {
        return idTema;
    }

    public void setIdTema(Integer idTema) {
        this.idTema = idTema;
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public String getNombreTema() {
        return nombreTema;
    }

    public void setNombreTema(String nombreTema) {
        this.nombreTema = nombreTema;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getFechaTema() {
        return fechaTema;
    }

    public void setFechaTema(String fechaTema) {
        this.fechaTema = fechaTema;
    }

    public String getSemestreTema() {
        return semestreTema;
    }

    public void setSemestreTema(String semestreTema) {
        this.semestreTema = semestreTema;
    }

    public Tema getTema() {
        return tema;
    }

    public void setTema(Tema tema) {
        this.tema = tema;
    }

    public Profesor getProfGuia() {
        return profGuia;
    }

    public void setProfGuia(Profesor profGuia) {
        this.profGuia = profGuia;
    }
    
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }
}
