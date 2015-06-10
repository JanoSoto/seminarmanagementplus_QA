/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.propuestas;

import entities.Alumno;
import entities.Historial;
import entities.ProfePropuesta;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import javax.inject.Named;
import managedbeans.AuthMB;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfePropuestaFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "agregarPropuestaMB")
@RequestScoped
public class AgregarPropuestaMB {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private ProfePropuestaFacadeLocal profePropuestaFacade;
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    
    private String nombrePropuesta,rutAlumnoPropuesta, rutProfGuia, rutProfcoGuia, fecha, semestreProp;
    private Date date;
    private Integer pet;
    private List<Profesor> profesores,profesoresGuias;
    private boolean magister;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(AgregarPropuestaMB.class);
    
    public AgregarPropuestaMB() {
    }
    
    @PostConstruct
    public void init() {
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        
        
        FacesContext context = FacesContext.getCurrentInstance();
        
        //Seteamos el semestre a semestre actual
        if(semestreActualFacade.findAll().isEmpty()){
            semestreProp = "";
            context.addMessage(null, new FacesMessage("Aviso","No se ha ingresado semestre actual en el sistema"));
        }
        else
            semestreProp = semestreActualFacade.findAll().get(0).getSemestreActual();
        
        //Generamos la lista de posibles Profesores Guías
        profesoresGuias = new ArrayList();
        profesores = profesorFacade.findAll();
        for(int i=0;i<profesores.size();i++)
            if(profesores.get(i).getTipoProfesor()==0)
                profesoresGuias.add(profesores.get(i));
    }
    /*
    public void profGChosen() {
        for (int i=0; i<profesores.size(); i++){
            
            if(profesores.get(i).getRutProfesor().equals(rutProfGuia))
                profesores.remove(profesores.get(i));
        }
    }*/
    
    public void addPropuesta(){
        FacesContext context = FacesContext.getCurrentInstance();
        
        if(rutAlumnoPropuesta==null){
            context.addMessage(null, new FacesMessage("Error","No se ingresó Alumno"));
            return;
        }
        if(rutProfGuia == null) {
            context.addMessage(null, new FacesMessage("Profesor Guía","Debe escoger profesor guía"));
            return;
        }
        
        if(nombrePropuesta == null) {
            context.addMessage(null, new FacesMessage("Nombre Propuesta","Debe ingresar nombre propuesta"));
            return;
        }
        
        if(semestreProp == null || semestreProp.equals("")) {
            context.addMessage(null, new FacesMessage("Semestre Propuesta","Debe ingresar semestre propuesta"));
            return;
        }
        
        if (pet != 0 && pet != 1){
            context.addMessage(null, new FacesMessage("Semestre Propuesta","Debe ingresar si es PET o no la propuesta"));
            return;
        }
        
        
        //Se valida que los profesorer guia co-guia sean distintos
        if(rutProfGuia.equals(rutProfcoGuia)) {
            context.addMessage(null, new FacesMessage("Profesor co-Guía","Los Profesores Guias y co-Guias deben ser distintos"));
            return;
        }
        
        //Se valida que no exista otra propuesta con el mismo nombre
        List<Propuesta> propuestas = propuestaFacade.findByName(nombrePropuesta);
        if(!propuestas.isEmpty()) {
            context.addMessage(null, new FacesMessage("Nombre Propuesta","Escriba el nombre de la propuesta"));
            return;
        }
        
        //Validamos errores de semestre
        if (Integer.valueOf(semestreProp.substring(2, 6)) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre","Año del semestre debe ser después de 1972"));
            return;
        }
        
        if ((Integer.valueOf(semestreProp.substring(0, 1)) != 1) && (Integer.valueOf(semestreProp.substring(0, 1)) != 2)){
            context.addMessage(null, new FacesMessage("Semestre Revisión","Semestre ingresado debe ser '1' o '2'"));
            return;
        }
        
        //Se valida que los profesores por hora sólo pueden guiar su máximo por semestre
        Profesor profGuia = profesorFacade.findByRut(rutProfGuia).get(0);
        if(profGuia.getContrato()==0){
            int temasVigentes=0;
                for(int i=0;i<profGuia.getProfePropuestaList().size();i++){
                    if(profGuia.getProfePropuestaList().get(i).getPropuesta().getIdRevisora()!=null)
                        if(profGuia.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema()!=null)
                            if(profGuia.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema()!=null)
                                if((profGuia.getProfePropuestaList().get(i).getRolGuia()==0)&&(profGuia.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema()==0))
                                    temasVigentes++;
                }
            if (profGuia.getMaximoGuias() != null) {    
                if(temasVigentes>=profGuia.getMaximoGuias()){
                    context.addMessage(null, new FacesMessage("Aviso: Profesor Guía","El Profesor guía seleccionado ya tiene el máximo de Temas vigentes que puede realizar ("+profGuia.getMaximoGuias()+")"));
                    return;
                }
            }
        }
        
        fecha = dateToString(date);
        
        Propuesta nuevaPropuesta;
        
        Alumno alumnoPropuesta = alumnoFacade.findByRut(rutAlumnoPropuesta).get(0);
        
        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestrePropuesta = new Semestre(semestreProp);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semestrePropuesta))
            semestreFacade.create(semestrePropuesta);
        
        //Seteamos la nueva comision y la creamos
        nuevaPropuesta = new Propuesta();
        nuevaPropuesta.setNombrePropuesta(nombrePropuesta.toUpperCase());
        nuevaPropuesta.setFechaPropuesta(fecha);
        nuevaPropuesta.setRutAlumno(alumnoPropuesta);
        nuevaPropuesta.setIdSemestre(semestrePropuesta);
        nuevaPropuesta.setMagister(magister);
        if (pet == 0){
            nuevaPropuesta.setPet(false);
        }
        if (pet == 1){
            nuevaPropuesta.setPet(true);
        }
       
        
        propuestaFacade.create(nuevaPropuesta);
        
        //Agregamos la comision a la lista de comisiones del semestre
        semestrePropuesta.add(nuevaPropuesta);
        semestreFacade.edit(semestrePropuesta);
        
        //Profes
        //Inicializamos las guias de los profesores
        ProfePropuesta profePropGuia = new ProfePropuesta(nuevaPropuesta.getIdPropuesta(), rutProfGuia);
        //Seteamos roles
        //Asignamos los roles y profesores a las guias
        profePropGuia.setRolGuia(0);
        profePropGuia.setProfesor(profGuia);
        profePropGuia.setPropuesta(nuevaPropuesta);
        profePropuestaFacade.create(profePropGuia);
        //Asignamos revisiones a la comision
        nuevaPropuesta.add(profePropGuia);
        propuestaFacade.edit(nuevaPropuesta);
        //Asignamos las revisiones a los profesores
        profGuia.add(profePropGuia);
        profesorFacade.edit(profGuia);
        
        //Profesor co-Guia
        if(!rutProfcoGuia.equals("-")){
            Profesor profcoGuia = profesorFacade.findByRut(rutProfcoGuia).get(0);
            ProfePropuesta profePropcoGuia = new ProfePropuesta(nuevaPropuesta.getIdPropuesta(), rutProfcoGuia);
            //Seteamos roles
            //Asignamos los roles y profesores a las guias
            profePropcoGuia.setRolGuia(1);
            profePropcoGuia.setProfesor(profcoGuia);
            profePropcoGuia.setPropuesta(nuevaPropuesta);
            profePropuestaFacade.create(profePropcoGuia);
            //Asignamos revisiones a la comision
            nuevaPropuesta.add(profePropcoGuia);
            propuestaFacade.edit(nuevaPropuesta);
            //Asignamos las revisiones a los profesores
            profcoGuia.add(profePropcoGuia);
            profesorFacade.edit(profcoGuia);
        }
        
        //Asignamos la propuesta al alumno
        alumnoPropuesta.add(nuevaPropuesta);
        alumnoFacade.edit(alumnoPropuesta);
        
        //Añadimos al historial del alumno
        /*Date temp = new Date();
        String dateHist = dateToString(temp);
        Historial histPropAlum = new Historial();
        histPropAlum.setDescripcion("Se le asignó propuesta de tema: "+nombrePropuesta+". La ingresó el usuario "+user.getFullNameUser());
        histPropAlum.setFechaHistorial(dateHist);
        histPropAlum.setTipoHistorial(2);
        histPropAlum.setIdEntidad(alumnoPropuesta.getRutAlumno());
        historialFacade.create(histPropAlum);
        
        
        //Añadimos quién ingresó la propuesta
        Historial histPropUser = new Historial();
        histPropUser.setDescripcion("Ingresó Propuesta al alumno "+alumnoPropuesta.getNombreAlumno()+" "+alumnoPropuesta.getApellidoAlumno());
        histPropUser.setFechaHistorial(dateHist);
        histPropUser.setTipoHistorial(3);
        histPropUser.setIdEntidad(user.getUsername());
        historialFacade.create(histPropUser);
        */
        //Mensaje de confirmación 
        context.addMessage(null, new FacesMessage("Propuesta",nombrePropuesta+", ingresada al sistema"));
        LOGGER.info("La propuesta "+nombrePropuesta+" ha sido ingresada al sistema");
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
    
    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public String getNombrePropuesta() {
        return nombrePropuesta;
    }

    public void setNombrePropuesta(String nombrePropuesta) {
        this.nombrePropuesta = nombrePropuesta;
    }

    public String getRutAlumnoPropuesta() {
        return rutAlumnoPropuesta;
    }

    public void setRutAlumnoPropuesta(String rutAlumnoPropuesta) {
        this.rutAlumnoPropuesta = rutAlumnoPropuesta;
    }

    public String getRutProfGuia() {
        return rutProfGuia;
    }

    public void setRutProfGuia(String rutProfGuia) {
        this.rutProfGuia = rutProfGuia;
    }

    public String getRutProfcoGuia() {
        return rutProfcoGuia;
    }

    public void setRutProfcoGuia(String rutProfcoGuia) {
        this.rutProfcoGuia = rutProfcoGuia;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getSemestreProp() {
        return semestreProp;
    }

    public void setSemestreProp(String semestreProp) {
        this.semestreProp = semestreProp;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public List<Profesor> getProfesores() {
        return profesores;
    }

    public void setProfesores(List<Profesor> profesores) {
        this.profesores = profesores;
    }

    public List<Profesor> getProfesoresGuias() {
        return profesoresGuias;
    }

    public void setProfesoresGuias(List<Profesor> profesoresGuias) {
        this.profesoresGuias = profesoresGuias;
    }

    public boolean isMagister() {
        return magister;
    }

    public void setMagister(boolean magister) {
        this.magister = magister;
    }

    public Integer getPet() {
        return pet;
    }

    public void setPet(Integer pet) {
        this.pet = pet;
    }


    
}
