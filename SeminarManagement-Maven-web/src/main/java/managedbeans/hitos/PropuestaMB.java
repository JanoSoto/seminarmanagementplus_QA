/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans.hitos;

import clases.ProfeDatos;
import entities.Alumno;
import entities.Historial;
import entities.ProfePropuesta;
import entities.ProfeRevision;
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
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
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
@ManagedBean(name ="propuestaMB")
@RequestScoped
public class PropuestaMB {
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
    private List<Alumno> alumnos;
    private Date date;
    private List<ProfeDatos> profesores, profesoresGuias;
    
    public PropuestaMB() {
    }
    
    @PostConstruct
    public void init() {
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        System.out.println(user.toString());
        
        FacesContext context = FacesContext.getCurrentInstance();
        
        //Buscamos a todos los alumnos sin temas no caducos
        alumnos = alumnoFacade.findAll();
        List<Alumno> listaAlumTemp = new ArrayList();
        for(int i=0;i<alumnos.size();i++){
            int noCaducos=0;
            for(int j=0;j<alumnos.get(i).getPropuestaList().size();j++)
                if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora()!=null)
                    if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema()!=null)
                        if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema().getEstadoTema()!=null)
                            if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema().getEstadoTema()!=3)
                                noCaducos++;
            if(noCaducos==0)
                    listaAlumTemp.add(alumnos.get(i));
            }
        alumnos=listaAlumTemp;
        
        //Seteamos el semestre a semestre actual
        if(semestreActualFacade.findAll().isEmpty()){
            semestreProp = "";
            context.addMessage(null, new FacesMessage("Aviso","No se ha ingresado semestre actual en el sistema"));
        }
        else
            semestreProp = semestreActualFacade.findAll().get(0).getSemestreActual();
        
        //Generamos la lista de posibles Profesores Guías
        int guiaProp,revisorTemp,revProp,revSem,guiaTem;
        ProfeDatos profeDatosTemp;
        profesores = new ArrayList();
        profesoresGuias = new ArrayList();
        List<Profesor> profes = profesorFacade.findAll();
        List<ProfeRevision> profRev;
        List<ProfePropuesta> profProp;
        for(int i=0;i<profes.size();i++){
            profRev=profes.get(i).getProfeRevisionList();
            revisorTemp=0;
            revProp=0;
            revSem=0;
            //Extraemos la cantidad de propuestas revisadas este semestre por el profesor
            for(int j=0;j<profRev.size();j++)
                if(profRev.get(j).getComisionRevisora().getIdSemestre().getIdSemestre().equals(semestreProp)){
                    revisorTemp++;
                    if(profRev.get(j).getComisionRevisora().getTipoRevision()==0)
                        revProp++;
                    if(profRev.get(j).getComisionRevisora().getTipoRevision()==1)
                        revSem++;
                }
            guiaTem=0;
            guiaProp=0;
            profProp=profes.get(i).getProfePropuestaList();
            //Extraemos la cantidad de Temas vigentes y las Propuestas del semestre actual guiadas por el profesor
            for(int j=0;j<profProp.size();j++)
                if(profProp.get(j).getRolGuia()==0){
                    if(profProp.get(j).getPropuesta().getIdSemestre().getIdSemestre().equals(semestreProp))
                        guiaProp++;
                    if(profProp.get(j).getPropuesta().getIdRevisora()!=null)
                        if(profProp.get(j).getPropuesta().getIdRevisora().getIdTema()!=null)
                            if(profProp.get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema()!=null)
                                if(profProp.get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema()==0)
                                    guiaTem++;
                }
            profeDatosTemp = new ProfeDatos(guiaProp,guiaTem,revisorTemp,-1,
                    profes.get(i).getRutProfesor(),profes.get(i).getNombreProfesor(),profes.get(i).getApellidoProfesor());
            profeDatosTemp.setRevProp(revProp);
            profeDatosTemp.setRevSem(revSem);
            if(profes.get(i).getTipoProfesor()==0)
                profesoresGuias.add(profeDatosTemp);
            profesores.add(profeDatosTemp);
        }
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

    public List<Alumno> getAlumnos() {
        return alumnos;
    }

    public void setAlumnos(List<Alumno> alumnos) {
        this.alumnos = alumnos;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
    
    public List<ProfeDatos> getProfesores() {
        return profesores;
    }

    public void setProfesores(List<ProfeDatos> profesores) {
        this.profesores = profesores;
    }

    public List<ProfeDatos> getProfesoresGuias() {
        return profesoresGuias;
    }

    public void setProfesoresGuias(List<ProfeDatos> profesoresGuias) {
        this.profesoresGuias = profesoresGuias;
    }
    
    public void addPropuesta(){
        FacesContext context = FacesContext.getCurrentInstance();
        //Se valida que los profesorer guia co-guia sean distintos
        if(rutProfGuia.equals(rutProfcoGuia)) {
            context.addMessage(null, new FacesMessage("Profesor co-Guía","Los Profesores Guias y co-Guias deben ser distintos"));
            return;
        }
        
        //Se valida que no exista otra propuesta con el mismo nombre
        List<Propuesta> propuestas = propuestaFacade.findByName(nombrePropuesta);
        if(!propuestas.isEmpty()) {
            context.addMessage(null, new FacesMessage("Nombre Propuesta","Ya existe una propuesta con ese nombre"));
            return;
        }
        
        //Validamos errores de semestre
        if (Integer.valueOf(semestreProp.substring(2, 6).toString()) <= 1972) {
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
            if(temasVigentes>=profGuia.getMaximoGuias()){
                context.addMessage(null, new FacesMessage("Aviso: Profesor Guía","El Profesor guía seleccionado ya tiene el máximo de Temas vigentes que puede realizar ("+profGuia.getMaximoGuias()+")"));
                return;
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
    }
}
