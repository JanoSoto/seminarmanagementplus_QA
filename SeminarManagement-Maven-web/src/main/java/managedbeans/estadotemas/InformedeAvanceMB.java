/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans.estadotemas;

import entities.Alumno;
import entities.Historial;
import entities.Profesor;
import entities.Propuesta;
import entities.Tema;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
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
@ManagedBean(name ="informedeAvanceMB")
@RequestScoped
public class InformedeAvanceMB {
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
    private List<Alumno> alumnos;
    private List<Profesor> profes;
    private List<Tema> temas;
    private UploadedFile informe;

    public UploadedFile getInforme() {
        return informe;
    }

    public void setInforme(UploadedFile informe) {
        this.informe = informe;
    }
    
    public InformedeAvanceMB() {
    }
    
    @PostConstruct
    public void init(){
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        
        //Buscamos todos los alumnos con tema vigente
        alumnos = alumnoFacade.findAll();
        List<Alumno> listaAlumTemp = new ArrayList();
        for(int i=0;i<alumnos.size();i++)
            for(int j=0;j<alumnos.get(i).getPropuestaList().size();j++)
                if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora()!=null)
                    if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema()!=null)
                        if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema().getEstadoTema()==0)
                            listaAlumTemp.add(alumnos.get(i));
        alumnos=listaAlumTemp;
        
        //Buscamos todos los temas vigentes
        temas = temaFacade.findAll();
        List<Tema> listaTemaTemp = new ArrayList();
        for(int i=0;i<temas.size();i++)
            if(temas.get(i).getEstadoTema()==0)
                listaTemaTemp.add(temas.get(i));
        temas=listaTemaTemp;
        
        //Recortamos los nombres de los temas para mostrarlos en la vista
        for(int i=0;i<temas.size();i++)
            if(temas.get(i).getNombreTema().length()>41)
                temas.get(i).setNombreTema(temas.get(i).getNombreTema().substring(0, 42)+"...");
        
        profes = profesorFacade.findAll();
    }
    
    public void updateByAlumno(){
        if(rutAlumno == null){
            //Buscamos todos los temas vigentes
            temas = temaFacade.findAll();
            List<Tema> listaTemaTemp = new ArrayList();
            for(int i=0;i<temas.size();i++)
                if(temas.get(i).getEstadoTema()==0)
                    listaTemaTemp.add(temas.get(i));
            temas=listaTemaTemp;

            //Recortamos los nombres de los temas para mostrarlos en la vista
            for(int i=0;i<temas.size();i++)
                if(temas.get(i).getNombreTema().length()>39)
                    temas.get(i).setNombreTema(temas.get(i).getNombreTema().substring(0, 38)+"...");
            
            profGuia = new Profesor();
            tema = new Tema();
            profGuia = new Profesor();
            fechaTema="";
            semestreTema="";
            nombreTema="";
            return;
        }
        //Buscamos los temas vigentes del alumno seleccionado
        Alumno alumnoTemp = alumnoFacade.findByRut(rutAlumno).get(0);
        List<Propuesta> propsTemp = alumnoTemp.getPropuestaList();
        List<Tema> listTemp = new ArrayList();
        for(int i=0;i<propsTemp.size();i++)
            if(propsTemp.get(i).getIdRevisora()!=null)
                if(propsTemp.get(i).getIdRevisora().getIdTema()!=null)
                    if(propsTemp.get(i).getIdRevisora().getIdTema().getEstadoTema()==0)
                        listTemp.add(propsTemp.get(i).getIdRevisora().getIdTema());
        temas=listTemp;
        
        //Recortamos los nombres de los temas para mostrarlos en la vista
        for(int i=0;i<temas.size();i++)
            if(temas.get(i).getNombreTema().length()>38)
                temas.get(i).setNombreTema(temas.get(i).getNombreTema().substring(0, 39)+"...");
        tema = new Tema();
        profGuia = new Profesor();
        fechaTema="";
        semestreTema="";
        nombreTema="";
    }
    
    public void updateByTema(){
        if(idTema == -1){
            updateByAlumno();
            return;
        }
        tema = temaFacade.findById(idTema).get(0);
        rutAlumno=tema.getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno();
        updateByAlumno();
        tema = temaFacade.findById(idTema).get(0);
        for(int i=0;i<tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().size();i++)
            if(tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia()==0)
                profGuia=tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor();
        fechaTema=tema.getFechaTema();
        semestreTema=tema.getIdSemestre().getIdSemestre();
        nombreTema=tema.getNombreTema();
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

    public List<Alumno> getAlumnos() {
        return alumnos;
    }

    public void setAlumnos(List<Alumno> alumnos) {
        this.alumnos = alumnos;
    }

    public List<Profesor> getProfes() {
        return profes;
    }

    public void setProfes(List<Profesor> profes) {
        this.profes = profes;
    }

    public List<Tema> getTemas() {
        return temas;
    }

    public void setTemas(List<Tema> temas) {
        this.temas = temas;
    }
    
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }
    
    public void guardarInforme() throws IOException {
        String filename = FilenameUtils.getName(informe.getFileName());
        InputStream input = informe.getInputstream();
        OutputStream output = new FileOutputStream(new File("/informes/avance/", filename));

        try {
            IOUtils.copy(input, output);
        } finally {
            IOUtils.closeQuietly(input);
            IOUtils.closeQuietly(output);
        }
    }
    
    public void addInformedeAvance(){
        try {
            FacesContext context = FacesContext.getCurrentInstance();
            
            //Se valida que se halla seleccionado Tema
            if((idTema==null)||(idTema==-1)){
                context.addMessage(null, new FacesMessage("Nombre Tema","Debe seleccionar un tema"));
                return;
            }
            
            //Validamos la fecha
            if(date==null){
                context.addMessage(null, new FacesMessage("Fecha","Debe seleccionar la fecha de entrega del Informe de Avance"));
                return;
            }
            guardarInforme();
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
        } catch (IOException ex) {
            Logger.getLogger(InformedeAvanceMB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void caducarTema(){
        FacesContext context = FacesContext.getCurrentInstance();
        
        //Se valida que se halla seleccionado Tema
        if((idTema==null)||(idTema==-1)){
            context.addMessage(null, new FacesMessage("Nombre Tema","Debe seleccionar un tema"));
            return;
        }
        
        //Se valida la fecha
        //QUIZÁS HAYA QUE ARREGLARLO
        /*if(date==null){
            context.addMessage(null, new FacesMessage("Fecha","Debe seleccionar la fecha de renuncia"));
            return;
        }*/
        
        tema = temaFacade.findById(idTema).get(0);
        //Seteamos estado "Prolongado"
        tema.setEstadoTema(3);
        temaFacade.edit(tema);
        
        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Tema modificado", "El estado del tema seleccionado se modificó a 'Caduco'"));
    }
    
    
}
