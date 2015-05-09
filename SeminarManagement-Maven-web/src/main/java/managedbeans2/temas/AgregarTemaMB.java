/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

import entities.Alumno;
import entities.ComisionRevisora;
import entities.Historial;
import entities.Profesor;
import entities.Semestre;
import entities.Tema;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;
import managedbeans.AuthMB;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author David
 */
@ManagedBean(name ="agregarTemaMB")
@RequestScoped
public class AgregarTemaMB{
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    @EJB
    private ComisionRevisoraFacadeLocal comisionRevisoraFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;

    private Integer idRev,origenTema,estadoTema,profGuiaTem,profGuiaRev;
    private String rutAlumno="",fechaRev,semestreRev,nombreTema,semestreTema,fechaTema;
    private ComisionRevisora comRev;
    private Profesor profGuia;
    private Date date;
    private List<Alumno> alumnos;
    private List<ComisionRevisora> comisionesRev;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(AgregarTemaMB.class);
    
    public AgregarTemaMB() {
    }
    
    @PostConstruct
    public void init() {
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        System.out.println(user.toString());
        
        FacesContext context = FacesContext.getCurrentInstance();
        
        //Seteamos el semestre a semestre actual
        if(semestreActualFacade.findAll().isEmpty()){
            semestreTema = "";
            context.addMessage(null, new FacesMessage("Aviso","No se ha ingresado semestre actual en el sistema"));
        }
        else
            semestreTema = semestreActualFacade.findAll().get(0).getSemestreActual();
    }
    
    public void addTema() {
        FacesContext context = FacesContext.getCurrentInstance();
        
        if(idRev==null){
            context.addMessage(null, new FacesMessage("Error","No se ingresó Comisión"));
            return;
        }
        //Obtenemos la Comisión Revisora
        comRev = comisionRevisoraFacade.findById(idRev).get(0);
        //Se valida que la propuesta no tenga Tema
        if(comRev.getIdTema()!=null){
            context.addMessage(null, new FacesMessage("Tema","La propuesta seleccionada ya tiene un Tema asignado"));
            return;
        }
        
        if((idRev==null)||(idRev==-1)){
            context.addMessage(null, new FacesMessage("Propuesta","No se ingresó ninguna propuesta"));
            return;
        }
        
        if((nombreTema==null)||(nombreTema.equals(""))){
            context.addMessage(null, new FacesMessage("Nombre Tema","Debe asignar nombre al nuevo Tema"));
            return;
        }
        
        if(date==null || date.equals("")){
            context.addMessage(null, new FacesMessage("Fecha","Debe seleccionar la fecha del Tema"));
            return;
        }
        
        //Validamos que no haya otro tema con el mismo nombre
        if(!temaFacade.findByName(nombreTema).isEmpty()) {
            context.addMessage(null, new FacesMessage("Nombre Tema","Ya existe un tema con ese nombre, por favor escoja otro."));
            return;
        }
        
        //Validaciones del Semestre
        if (semestreTema == null || semestreTema.equals("")) {
            context.addMessage(null, new FacesMessage("Semestre Tema","Debe ingresar semestre"));
            return;
        }
        
        if (Integer.valueOf(semestreTema.substring(2, 6)) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre Tema","Año del semestre debe ser después de 1972"));
            return;
        }
        
        if ((Integer.valueOf(semestreTema.substring(0, 1)) != 1) && (Integer.valueOf(semestreTema.substring(0, 1)) != 2)){
            context.addMessage(null, new FacesMessage("Semestre Tema","Semestre ingresado debe ser '1' o '2'"));
            return;
        }
        
        
        //Obtenemos el profesor guía
        for(int i=0;i<comRev.getIdPropuesta().getProfePropuestaList().size();i++)
            if(comRev.getIdPropuesta().getProfePropuestaList().get(i).getRolGuia()==0)
                profGuia=comRev.getIdPropuesta().getProfePropuestaList().get(i).getProfesor();
        //Se valida que los profesores por hora sólo pueden guiar su máximo por semestre
        if(profGuia.getContrato()==0){
            int temasVigentes=0;
                for(int i=0;i<profGuia.getProfePropuestaList().size();i++){
                    if(profGuia.getProfePropuestaList().get(i).getPropuesta().getIdRevisora()!=null)
                        if(profGuia.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema()!=null)
                            if((profGuia.getProfePropuestaList().get(i).getRolGuia()==0)&&(profGuia.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema()==0))
                                temasVigentes++;
                }
            if (profGuia.getMaximoGuias() != null){   
                if(temasVigentes>=profGuia.getMaximoGuias()){
                    context.addMessage(null, new FacesMessage("Aviso: Profesor Guía","El Profesor guía seleccionado ya tiene el máximo de Temas vigentes que puede realizar ("+profGuia.getMaximoGuias()+")"));
                    return;
                }
            }
        }

        fechaTema = dateToString(date);
        
        //Asignamos el semestre
        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semTemp = new Semestre(semestreTema);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semTemp)) {
            semestreFacade.create(semTemp);
        }
        
        //Seteamos y creamos el tema
        Tema tema = new Tema();
        estadoTema = 0;
        
        nombreTema = nombreTema.toUpperCase();
        tema.setNombreTema(nombreTema);
        tema.setFechaTema(fechaTema);
        tema.setEstadoTema(estadoTema);
        tema.setIdRevisora(comRev);
        tema.setIdSemestre(semTemp);
        temaFacade.create(tema);
        
        //Agregamos el tema a lista de temas del semestre
        semTemp.add(tema);
        semestreFacade.edit(semTemp);
        
        //Le asignamos el tema a la comisión revisora
        comRev.setIdTema(tema);
        comisionRevisoraFacade.edit(comRev);        
        
        /*
        //Añadimos al historial del alumno
        Date temp = new Date();
        String dateHist = dateToString(temp);
        Historial histTemaAlum = new Historial();
        histTemaAlum.setDescripcion("Se le asignó Tema. Lo ingresó el usuario "+user.getFullNameUser());
        histTemaAlum.setFechaHistorial(dateHist);
        histTemaAlum.setTipoHistorial(2);
        histTemaAlum.setIdEntidad(tema.getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno());
        historialFacade.create(histTemaAlum);
        
        
        //Añadimos al historial del usuario que creo la comisión revisora
        Historial histComRevUser = new Historial();
        histComRevUser.setDescripcion("Ingresó Tema al alumno "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno()+" "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno());
        histComRevUser.setFechaHistorial(dateHist);
        histComRevUser.setTipoHistorial(3);
        histComRevUser.setIdEntidad(user.getUsername());
        historialFacade.create(histComRevUser);
        
        //Agregamos el historial de cambio de estado
        Historial historial = new Historial();
        historial.setDescripcion("Se creó el tema, con estado 'Vigente'");
        historial.setFechaHistorial(fechaTema);
        historial.setIdEntidad(String.valueOf(tema.getIdTema()));
        historial.setTipoHistorial(1);
        historialFacade.create(historial);
                */
        
        //Mensaje de confirmación  
        context.addMessage(null, new FacesMessage("Tema", tema.getNombreTema()+", ingresado al sistema"));
        LOGGER.info("El tema "+tema.getNombreTema()+" ha sido ingresado al sistema");
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
    

    public Integer getIdRev() {
        return idRev;
    }

    public void setIdRev(Integer idRev) {
        this.idRev = idRev;
    }

    public Integer getProfGuiaTem() {
        return profGuiaTem;
    }

    public void setProfGuiaTem(Integer profGuiaTem) {
        this.profGuiaTem = profGuiaTem;
    }

    public Integer getProfGuiaRev() {
        return profGuiaRev;
    }

    public void setProfGuiaRev(Integer profGuiaRev) {
        this.profGuiaRev = profGuiaRev;
    }

    public String getFechaRev() {
        return fechaRev;
    }

    public void setFechaRev(String fechaRev) {
        this.fechaRev = fechaRev;
    }

    public Integer getOrigenTema() {
        return origenTema;
    }

    public void setOrigenTema(Integer origenTema) {
        this.origenTema = origenTema;
    }

    public Integer getEstadoTema() {
        return estadoTema;
    }

    public void setEstadoTema(Integer estadoTema) {
        this.estadoTema = estadoTema;
    }

    public String getNombreTema() {
        return nombreTema;
    }

    public void setNombreTema(String nombreTema) {
        this.nombreTema = nombreTema;
    }

    public String getSemestreTema() {
        return semestreTema;
    }

    public void setSemestreTema(String semestreTema) {
        this.semestreTema = semestreTema;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
    
    public String getSemestreRev() {
        return semestreRev;
    }

    public void setSemestreRev(String semestreRev) {
        this.semestreRev = semestreRev;
    }
    
    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public ComisionRevisora getComRev() {
        return comRev;
    }

    public void setComRev(ComisionRevisora comRev) {
        this.comRev = comRev;
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

    public String getFechaTema() {
        return fechaTema;
    }

    public void setFechaTema(String fechaTema) {
        this.fechaTema = fechaTema;
    }

    public List<ComisionRevisora> getComisionesRev() {
        return comisionesRev;
    }

    public void setComisionesRev(List<ComisionRevisora> comisionesRev) {
        this.comisionesRev = comisionesRev;
    }
    
    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }
}
