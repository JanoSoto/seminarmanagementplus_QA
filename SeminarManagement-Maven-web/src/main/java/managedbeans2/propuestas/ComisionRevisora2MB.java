/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.propuestas;

import clases.ProfeDatos;
import clases.ProfeDatos2;
import entities.ComisionRevisora;
import entities.Historial;
import entities.ProfePropuesta;
import entities.ProfeRevision;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.ProfeRevisionFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import managedbeans.AuthMB;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.PropuestaFacadeLocal;

/**
 *
 * @author Eduardo
 */
@ManagedBean(name ="comisionRevisora2MB")
@RequestScoped
public class ComisionRevisora2MB {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private ProfeRevisionFacadeLocal profeRevisionFacade;
    @EJB
    private ComisionRevisoraFacadeLocal comisionRevisoraFacade;

    private Integer idProp,tipoRevision;
    private String nombrePropuesta,rutAlumno,fechaProp,semestreProp,nombreProp,rutProfeRev1, rutProfeRev2, fechaRev,fechaEntRev, semestreRev;
    private Propuesta propuesta;
    private List<Profesor> profesores;
    private Profesor profGuia;
    private Date date,date2;
    private List<ProfeDatos2> profeDatos;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(ComisionRevisora2MB.class);
    
    public ComisionRevisora2MB() {
    }
    
    @PostConstruct
    public void init() {
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        System.out.println(user.toString());
        
        FacesContext context = FacesContext.getCurrentInstance();
        
        //Seteamos el semestre a semestre actual
        if(semestreActualFacade.findAll().isEmpty()){
            semestreRev = "";
            context.addMessage(null, new FacesMessage("Aviso","No se ha ingresado semestre actual en el sistema"));
        }
        else
            semestreRev = semestreActualFacade.findAll().get(0).getSemestreActual();
        
        profesores = profesorFacade.findAll();
        
        //Seteamos el semestre a semestre actual
        if(semestreActualFacade.findAll().isEmpty()){
            semestreRev = "";
            context.addMessage(null, new FacesMessage("Aviso","No se ha ingresado semestre actual en el sistema"));
        }
        else
            semestreRev = semestreActualFacade.findAll().get(0).getSemestreActual();
        
        //Generamos las listas de posibles Profesores Revisores y Guías
        int guiaProp,revisorTemp,revProp,revSem,guiaTem;
        ProfeDatos2 profeDatosTemp;
        profeDatos = new ArrayList();
        List<Profesor> profes = profesorFacade.findAll();
        List<ProfeRevision> profRev;
        List<ProfePropuesta> profProp;
        for(int i=0;i<profes.size();i++){
            profeDatosTemp = new ProfeDatos2();
            profRev=profes.get(i).getProfeRevisionList();
            revisorTemp=0;
            revProp=0;
            revSem=0;
            //Extraemos la cantidad de propuestas revisadas este semestre por el profesor
            for(int j=0;j<profRev.size();j++)
                if(profRev.get(j).getComisionRevisora().getIdSemestre().getIdSemestre().equals(semestreRev)){
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
                    if(profProp.get(j).getPropuesta().getIdSemestre().getIdSemestre().equals(semestreRev))
                        guiaProp++;
                    if(profProp.get(j).getPropuesta().getIdRevisora()!=null)
                        if(profProp.get(j).getPropuesta().getIdRevisora().getIdTema()!=null)
                            if(profProp.get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema()!=null)
                                if(profProp.get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema()==0)
                                    guiaTem++;
                }
            profeDatosTemp.setRevSemActual(revProp);
            profeDatosTemp.setProfesor(profes.get(i));
            profeDatosTemp.setCorrSemActual(0);
            profeDatosTemp.setPropSemActual(guiaProp);
            profeDatosTemp.setTemasVigentes(guiaTem);
            profeDatos.add(profeDatosTemp);
        }
        
        
    }

    public List<ProfeDatos2> getProfeDatos() {
        return profeDatos;
    }

    public void setProfeDatos(List<ProfeDatos2> profeDatos) {
        this.profeDatos = profeDatos;
    }
    
    public void addComisionRevisora() {
        FacesContext context = FacesContext.getCurrentInstance();
        
        if(idProp==null){
            context.addMessage(null, new FacesMessage("Error","No se ingresó Propuesta"));
            return;
        }
        
        propuesta = propuestaFacade.findById(idProp).get(0);
        //Se valida que la propuesta no tenga Comisión Revisora
        if(propuesta.getIdRevisora()!=null){
            context.addMessage(null, new FacesMessage("Propuesta","La propuesta seleccionada ya tiene una Comisión Revisora asignada"));
            return;
        }
        
        //Se valida el tipo de revisión seleccionada y los profesores
        if(tipoRevision == null){
            context.addMessage(null, new FacesMessage("Tipo Revisión","Debe seleccionar un tipo de Revisión"));
            return;
        }
        if(tipoRevision == 2){
            for(int i=0;i<propuesta.getProfePropuestaList().size();i++)
                if(propuesta.getProfePropuestaList().get(i).getRolGuia()==0)
                    if(propuesta.getProfePropuestaList().get(i).getProfesor().getContrato()!=1){
                        context.addMessage(null, new FacesMessage("Tipo Revisión","El Profesor Guía de la propuesta seleccionada no es de Jornada Completa"));
                        return;
                    }
            if(!rutProfeRev1.equals("-") || !rutProfeRev2.equals("-")){
                context.addMessage(null, new FacesMessage("Tipo Revisión","Una Comisión por Acuerdo de Consejo no tiene profesores, deje estos espacios en blanco o cambie el Tipo de Revisión"));
                return;
            }
        }
        else{
            //Se valida que se halla seleccionado profesor1
            if(rutProfeRev1.equals("-")){
                context.addMessage(null, new FacesMessage("Profesor Revisor 1","Debe seleccionar Profesor"));
                return;
            }

            //Se valida que se halla seleccionado Profesor2
            if(rutProfeRev2.equals("-")){
                context.addMessage(null, new FacesMessage("Profesor Revisor 2","Debe seleccionar Profesor"));
                return;
            }
            //Se valida que se hallan seleccionado profesores revisores distintos al guia
            for(int i =0;i<propuesta.getProfePropuestaList().size();i++)
                if(propuesta.getProfePropuestaList().get(i).getRolGuia()==0)
                    profGuia = propuesta.getProfePropuestaList().get(i).getProfesor();
            if(profGuia.getRutProfesor().equals(rutProfeRev1) || profGuia.getRutProfesor().equals(rutProfeRev2)) {
                context.addMessage(null, new FacesMessage("Profesor Revisor","El Profesor guía no puede ser seleccionado como Profesor Revisor"));
                return;
            }
            //Se valida que se hallan seleccionado profesores revisores distintos entre si
            if(rutProfeRev1.equals(rutProfeRev2)) {
                context.addMessage(null, new FacesMessage("Profesor Revisor","Los Profesores revisores deben ser distintos"));
                return;
            }
        }
        //fecha
        
        System.out.println(date);
        System.out.println(date2);
        if(date==null){
            context.addMessage(null, new FacesMessage("Fecha","Debe ingresar la fecha del Tema"));
            return;
        }
        
        if(date2==null){
            context.addMessage(null, new FacesMessage("Fecha","Debe ingresar la fecha del Tema"));
            return;
        }
        
        //Validamos errores de semestre
        if (Integer.valueOf(semestreRev.substring(2, 6)) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre","Año del semestre debe ser después de 1972"));
            return;
        }
        
        if ((Integer.valueOf(semestreRev.substring(0, 1)) != 1) && (Integer.valueOf(semestreRev.substring(0, 1)) != 2)){
            context.addMessage(null, new FacesMessage("Semestre Revisión","Semestre ingresado debe ser '1' o '2'"));
            return;
        }
        
        ComisionRevisora nuevaComision;
        
        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestreRevision = new Semestre(semestreRev);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semestreRevision))
            semestreFacade.create(semestreRevision);
      
        fechaEntRev = dateToString(date2);
        fechaRev = dateToString(date);
        //Seteamos la nueva comision y la creamos
        nuevaComision = new ComisionRevisora();
        nuevaComision.setIdPropuesta(propuesta);
        nuevaComision.setFechaRevision(fechaRev);
        nuevaComision.setFechaEntregaRevision(fechaEntRev);
        nuevaComision.setIdSemestre(semestreRevision);
        nuevaComision.setTipoRevision(tipoRevision);
        comisionRevisoraFacade.create(nuevaComision);
        
        //Agregamos la comision a la lista de comisiones del semestre
        semestreRevision.add(nuevaComision);
        semestreFacade.edit(semestreRevision);
        
        if(tipoRevision!=2){
            //Profes
            Profesor profRev1 = profesorFacade.findByRut(rutProfeRev1).get(0);
            Profesor profRev2 = profesorFacade.findByRut(rutProfeRev2).get(0);

            //Inicializamos las revisiones de los profesores
            ProfeRevision nuevoProfeRevision1 = new ProfeRevision(nuevaComision.getIdRevisora(), rutProfeRev1);
            ProfeRevision nuevoProfeRevision2 = new ProfeRevision(nuevaComision.getIdRevisora(), rutProfeRev2);

            //Creamos las relaciones entre los profes y la comisión
            //Profe 1
            nuevoProfeRevision1.setRolRevision(0);
            nuevoProfeRevision1.setProfesor(profRev1);
            nuevoProfeRevision1.setComisionRevisora(nuevaComision);
            profeRevisionFacade.create(nuevoProfeRevision1);
            //Profe 2
            nuevoProfeRevision2.setRolRevision(1);
            nuevoProfeRevision2.setProfesor(profRev2);
            nuevoProfeRevision2.setComisionRevisora(nuevaComision);
            profeRevisionFacade.create(nuevoProfeRevision2);

            //Asignamos revisiones a la comision
            nuevaComision.add(nuevoProfeRevision1);
            nuevaComision.add(nuevoProfeRevision2);
            comisionRevisoraFacade.edit(nuevaComision);

            //Asignamos las revisiones a los profesores
            profRev1.add(nuevoProfeRevision1);
            profesorFacade.edit(profRev1);
            profRev2.add(nuevoProfeRevision2);
            profesorFacade.edit(profRev2);
        }
        
        //Asignamos la Comision a la Propuesta
        propuesta.setIdRevisora(nuevaComision);
        propuestaFacade.edit(propuesta);
        
        //Mensaje de confirmación 
        context.addMessage(null, new FacesMessage("Comisión Revisora", propuesta.getNombrePropuesta()+", ingresada al sistema"));
        LOGGER.info("La propuesta "+propuesta.getNombrePropuesta()+" ha sido ingresada al sistema");
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

    public Integer getTipoRevision() {
        return tipoRevision;
    }

    public List<Profesor> getProfesores() {
        return profesores;
    }

    public void setProfesores(List<Profesor> profesores) {
        this.profesores = profesores;
    }

    public void setTipoRevision(Integer tipoRevision) {
        this.tipoRevision = tipoRevision;
    }
    
    public String getSemestreRev() {
        return semestreRev;
    }

    public void setSemestreRev(String semestreRev) {
        this.semestreRev = semestreRev;
    }
    
    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public Integer getIdProp() {
        return idProp;
    }

    public void setIdProp(Integer idProp) {
        this.idProp = idProp;
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public String getFechaProp() {
        return fechaProp;
    }

    public void setFechaProp(String fechaProp) {
        this.fechaProp = fechaProp;
    }

    public String getSemestreProp() {
        return semestreProp;
    }

    public void setSemestreProp(String semestreProp) {
        this.semestreProp = semestreProp;
    }

    public String getNombreProp() {
        return nombreProp;
    }

    public void setNombreProp(String nombreProp) {
        this.nombreProp = nombreProp;
    }

    public Propuesta getPropuesta() {
        return propuesta;
    }

    public void setPropuesta(Propuesta propuesta) {
        this.propuesta = propuesta;
    }

    public Profesor getProfGuia() {
        return profGuia;
    }

    public void setProfGuia(Profesor profGuia) {
        this.profGuia = profGuia;
    }
    
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getDate2() {
        return date2;
    }

    public void setDate2(Date date2) {
        this.date2 = date2;
    }
    
    
    public String getNombrePropuesta() {
        return nombrePropuesta;
    }

    public void setNombrePropuesta(String nombrePropuesta) {
        this.nombrePropuesta = nombrePropuesta;
    }

    public String getRutProfeRev1() {
        return rutProfeRev1;
    }

    public void setRutProfeRev1(String rutProfeRev1) {
        this.rutProfeRev1 = rutProfeRev1;
    }

    public String getRutProfeRev2() {
        return rutProfeRev2;
    }

    public void setRutProfeRev2(String rutProfeRev2) {
        this.rutProfeRev2 = rutProfeRev2;
    }

    public String getFechaRev() {
        return fechaRev;
    }

    public void setFechaRev(String fechaRev) {
        this.fechaRev = fechaRev;
    }
}