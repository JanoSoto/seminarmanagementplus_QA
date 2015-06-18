/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans.hitos;

import entities.Alumno;
import entities.ComisionRevisora;
import entities.Historial;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import entities.Tema;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
@ManagedBean(name ="temaOficialMB")
@RequestScoped
public class TemaOficialMB{
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
    
    public TemaOficialMB() {
    }
    
    @PostConstruct
    public void init() {
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        
        FacesContext context = FacesContext.getCurrentInstance();
        
        //Buscamos a todos los alumnos con propuesta revisada y sin temas no caducos
        alumnos = alumnoFacade.findAll();
        List<Alumno> listaAlumTemp = new ArrayList();
        for(int i=0;i<alumnos.size();i++){
            int noCaducos=0;
            int propRevisada=0;
            for(int j=0;j<alumnos.get(i).getPropuestaList().size();j++)
                if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora()!=null){
                    propRevisada++;
                    if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema()!=null)
                        if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema().getEstadoTema()!=3)
                            noCaducos++;
                }
            if((noCaducos==0)&&(propRevisada>0))
                    listaAlumTemp.add(alumnos.get(i));
            }
        alumnos=listaAlumTemp;
        
        //Buscamos todas las comisiones revisoras, sin tema asignado
        comisionesRev = comisionRevisoraFacade.findAll();
        List<ComisionRevisora> listTemp = new ArrayList();
        for(int i=0;i<comisionesRev.size();i++)
            if(comisionesRev.get(i).getIdTema()==null)
                listTemp.add(comisionesRev.get(i));
        comisionesRev=listTemp;
        //Sacamos las comisiones de alumnos con temas no caducos
        listTemp = new ArrayList();
        for(int i=0;i<comisionesRev.size();i++)
            if(alumnos.contains(comisionesRev.get(i).getIdPropuesta().getRutAlumno()))
                listTemp.add(comisionesRev.get(i));
        comisionesRev=listTemp;
        
        //Recortamos los nombres de las propuestas para mostrarlos en la vista
        for(int i=0;i<comisionesRev.size();i++)
            if(comisionesRev.get(i).getIdPropuesta().getNombrePropuesta().length()>38)
                comisionesRev.get(i).getIdPropuesta().setNombrePropuesta(comisionesRev.get(i).getIdPropuesta().getNombrePropuesta().substring(0,39)+"...");
        
        //Seteamos el semestre a semestre actual
        if(semestreActualFacade.findAll().isEmpty()){
            semestreTema = "";
            context.addMessage(null, new FacesMessage("Aviso","No se ha ingresado semestre actual en el sistema"));
        }
        else
            semestreTema = semestreActualFacade.findAll().get(0).getSemestreActual();
    }
    
    public void updateByAlumno(){
        if(rutAlumno == null){
            //Buscamos todas las comisiones revisoras, sin tema asignado
            comisionesRev = comisionRevisoraFacade.findAll();
            List<ComisionRevisora> listTemp = new ArrayList();
            for(int i=0;i<comisionesRev.size();i++)
                if(comisionesRev.get(i).getIdTema()==null)
                    listTemp.add(comisionesRev.get(i));
            comisionesRev=listTemp;
            //Sacamos las comisiones de alumnos con temas no caducos
            listTemp = new ArrayList();
            for(int i=0;i<comisionesRev.size();i++)
                if(alumnos.contains(comisionesRev.get(i).getIdPropuesta().getRutAlumno()))
                    listTemp.add(comisionesRev.get(i));
            comisionesRev=listTemp;
            
            //Recortamos los nombres de las propuestas para mostrarlos en la vista
            for(int i=0;i<comisionesRev.size();i++)
                if(comisionesRev.get(i).getIdPropuesta().getNombrePropuesta().length()>38)
                    comisionesRev.get(i).getIdPropuesta().setNombrePropuesta(comisionesRev.get(i).getIdPropuesta().getNombrePropuesta().substring(0, 39)+"...");
            
            comRev = new ComisionRevisora();
            profGuia = new Profesor();
            profGuiaRev=null;
            profGuiaTem=null;
            fechaRev="";
            semestreRev="";
            nombreTema="";
            return;
        }
        //Buscamos todas las comisiones revisoras, sin tema del alumno seleccionado
        Alumno alumnoTemp = alumnoFacade.findByRut(rutAlumno).get(0);
        List<Propuesta> propsTemp = alumnoTemp.getPropuestaList();
        List<ComisionRevisora> listTemp = new ArrayList();
        for(int i=0;i<propsTemp.size();i++)
            if(propsTemp.get(i).getIdRevisora()!=null)
                if(propsTemp.get(i).getIdRevisora().getIdTema()==null)
                    listTemp.add(propsTemp.get(i).getIdRevisora());
        comisionesRev=listTemp;
        
        //Recortamos los nombres de las propuestas para mostrarlos en la vista
        for(int i=0;i<comisionesRev.size();i++)
            if(comisionesRev.get(i).getIdPropuesta().getNombrePropuesta().length()>38)
                comisionesRev.get(i).getIdPropuesta().setNombrePropuesta(comisionesRev.get(i).getIdPropuesta().getNombrePropuesta().substring(0, 39)+"...");
        
        comRev = new ComisionRevisora();
        profGuia = new Profesor();
        profGuiaRev=null;
        profGuiaTem=null;
        fechaRev="";
        semestreRev="";
        nombreTema="";
    }
    
    public void updateByPropuesta(){
        if(idRev == -1){
            updateByAlumno();
            return;
        }
        comRev = comisionRevisoraFacade.findById(idRev).get(0);
        rutAlumno=comRev.getIdPropuesta().getRutAlumno().getRutAlumno();
        updateByAlumno();
        comRev = comisionRevisoraFacade.findById(idRev).get(0);
        for(int i=0;i<comRev.getIdPropuesta().getProfePropuestaList().size();i++)
            if(comRev.getIdPropuesta().getProfePropuestaList().get(i).getRolGuia()==0)
                profGuia=comRev.getIdPropuesta().getProfePropuestaList().get(i).getProfesor();
        semestreRev=comRev.getIdSemestre().getIdSemestre();
        profGuiaRev=0;
        //Extraemos la cantidad de propuestas guiadas este semestre por el profesor
        for(int j=0;j<profGuia.getProfePropuestaList().size();j++)
            if(profGuia.getProfePropuestaList().get(j).getRolGuia()==0)
                if(profGuia.getProfePropuestaList().get(j).getPropuesta().getIdSemestre().getIdSemestre().equals(semestreRev))
                    profGuiaRev++;
        profGuiaTem=0;
        //Extraemos la cantidad de Temas vigentes guiados por el profesor
        for(int j=0;j<profGuia.getProfePropuestaList().size();j++)
            if(profGuia.getProfePropuestaList().get(j).getPropuesta().getIdRevisora()!=null)
                if(profGuia.getProfePropuestaList().get(j).getPropuesta().getIdRevisora().getIdTema()!=null)
                    if(profGuia.getProfePropuestaList().get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema()==0)
                        profGuiaTem++;
        fechaRev=comRev.getFechaRevision();
        nombreTema=comRev.getIdPropuesta().getNombrePropuesta();
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
    
    public void addTema() {
        FacesContext context = FacesContext.getCurrentInstance();
        
        if((idRev==null)||(idRev==-1)){
            context.addMessage(null, new FacesMessage("Nombre Propuesta","Debe seleccionar una propuesta"));
            return;
        }
        
        if((nombreTema==null)||(nombreTema.equals(""))){
            context.addMessage(null, new FacesMessage("Nombre Tema","Debe asignar nombre al nuevo Tema"));
            return;
        }
        
        if(date==null){
            context.addMessage(null, new FacesMessage("Fecha","Debe seleccionar la fecha del Tema"));
            return;
        }
        
        //Validamos que no haya otro tema con el mismo nombre
        if(!temaFacade.findByName(nombreTema).isEmpty()) {
            context.addMessage(null, new FacesMessage("Nombre Tema","Ya existe un tema con ese nombre, por favor escoja otro."));
            return;
        }
        
        //Validaciones del Semestre
        if (semestreTema == null) {
            context.addMessage(null, new FacesMessage("Semestre Tema","Debe ingresar semestre"));
            return;
        }
        
        if (Integer.valueOf(semestreTema.substring(2, 6).toString()) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre Tema","Año del semestre debe ser después de 1972"));
            return;
        }
        
        if ((Integer.valueOf(semestreTema.substring(0, 1)) != 1) && (Integer.valueOf(semestreTema.substring(0, 1)) != 2)){
            context.addMessage(null, new FacesMessage("Semestre Tema","Semestre ingresado debe ser '1' o '2'"));
            return;
        }
        
        //Obtenemos la Comisión Revisora
        comRev = comisionRevisoraFacade.findById(Integer.valueOf(idRev)).get(0);
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
            if(temasVigentes>=profGuia.getMaximoGuias()){
                context.addMessage(null, new FacesMessage("Aviso: Profesor Guía","El Profesor guía seleccionado ya tiene el máximo de Temas vigentes que puede realizar ("+profGuia.getMaximoGuias()+")"));
                return;
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
        
        //Mensaje de confirmación  
        context.addMessage(null, new FacesMessage("Tema", tema.getNombreTema()+", ingresado al sistema"));
    }
}
