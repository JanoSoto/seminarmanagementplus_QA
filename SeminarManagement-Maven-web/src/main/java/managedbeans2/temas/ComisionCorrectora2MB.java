/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

import clases.ProfeDatos;
import clases.ProfeDatos2;
import entities.Alumno;
import entities.ComisionCorrectora;
import entities.Historial;
import entities.ProfeCorreccion;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import entities.Tema;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import sessionbeans.ComisionCorrectoraFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.TemaFacadeLocal;
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
import sessionbeans.ProfeCorreccionFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;

/**
 *
 * @author Eduardo
 */
@ManagedBean(name ="comisionCorrectora2MB")
@RequestScoped
public class ComisionCorrectora2MB {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private ProfeCorreccionFacadeLocal profeCorreccionFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private ComisionCorrectoraFacadeLocal comisionCorrectoraFacade;
    
    private Integer idTema;
    private String rutAlumno,nombreTema, profesor1,profesor2,fechaTema,semestreTema,fechaCorr, semestreCorr;
    private Date date;
    private Tema tema;
    private Profesor profGuia;
    private List<Alumno> alumnos;
    private List<Tema> temas;
    private List<Profesor> profesores;
    private List<ProfeDatos2> profeDatos;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(ComisionCorrectora2MB.class);
    
    public ComisionCorrectora2MB() {
    }
    
    @PostConstruct
    public void init(){
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        System.out.println(user.toString());
        
        FacesContext context = FacesContext.getCurrentInstance();
        
        profesores = profesorFacade.findAll();
        
        //Seteamos el semestre a semestre actual
        if(semestreActualFacade.findAll().isEmpty()){
            semestreCorr = "";
            context.addMessage(null, new FacesMessage("Aviso","No se ha ingresado semestre actual en el sistema"));
        }
        else
            semestreCorr = semestreActualFacade.findAll().get(0).getSemestreActual();
        
        //Generamos profesores
        int corrTemp;
        ProfeDatos2 profeDatosTemp;
        profeDatos = new ArrayList();
        List<Profesor> profes = profesorFacade.findAll();
        List<ProfeCorreccion> profCorr;
        //Extraemos la cantidad de temas corregidos en el semestre actual por cada profesor
        for(int i=0;i<profes.size();i++){
            profeDatosTemp = new ProfeDatos2();
            profCorr=profes.get(i).getProfeCorreccionList();
            corrTemp=0;
            for(int j=0;j<profCorr.size();j++)
                if(profCorr.get(j).getComisionCorrectora().getIdSemestre().getIdSemestre().equals(semestreCorr))
                    corrTemp++;
            profeDatosTemp.setProfesor(profes.get(i));
            profeDatosTemp.setCorrSemActual(corrTemp);
            profeDatos.add(profeDatosTemp);
        }
        
    }
    
    public void addComisionCorrectora(){
        FacesContext context = FacesContext.getCurrentInstance();
        
        if(idTema==null){
            context.addMessage(null, new FacesMessage("Error","No se ingresó Tema"));
            return;
        }
        tema = temaFacade.findById(idTema).get(0);
        //Se valida que el Tema no tenga Comisión Correctora
        if(tema.getIdCorrectora()!=null){
            context.addMessage(null, new FacesMessage("Tema","El Tema seleccionado ya tiene una Comisión Correctora asignada"));
            return;
        }
        
        //Se valida que se halla seleccionado Tema
        if((idTema==null)||(idTema==-1)){
            context.addMessage(null, new FacesMessage("Tema","Debe seleccionar un tema"));
            return;
        }
        
        //Se valida que se halla seleccionado profesor1
        if((profesor1==null)||(profesor1.equals(""))){
            context.addMessage(null, new FacesMessage("Profesor Corrector 1","Debe seleccionar un Profesor"));
            return;
        }
        
        //Se valida que se halla seleccionado Profesor2
        if((profesor2==null)||(profesor2.equals(""))){
            context.addMessage(null, new FacesMessage("Profesor Corrector 2","Debe seleccionar un Profesor"));
            return;
        }

        if(date==null || date.equals("")){
            context.addMessage(null, new FacesMessage("Fecha","Debe ingresar las fecha correspondiente"));
            return;
        }
        
        //Validaciones del Semestre
        if (semestreCorr == null || semestreCorr.equals("")) {
            context.addMessage(null, new FacesMessage("Semestre Correccion","Debe ingresar semestre"));
            return;
        }
        
        if (Integer.valueOf(semestreCorr.substring(2, 6).toString()) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre Corrección","Año del semestre debe ser después de 1972"));
            return;
        }
        
        if ((Integer.valueOf(semestreCorr.substring(0, 1)) != 1) && (Integer.valueOf(semestreCorr.substring(0, 1)) != 2)){
            context.addMessage(null, new FacesMessage("Semestre Corrección","Semestre ingresado debe ser '1' o '2'"));
            return;
        }
        
        //Se valida que se seleccionaron profesores distintos para corregir
        for(int i=0;i<tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().size();i++)
            if(tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia()==0)
                profGuia=tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor();
        if(profGuia.getRutProfesor().equals(profesor1) || profGuia.getRutProfesor().equals(profesor2)) {
            context.addMessage(null, new FacesMessage("Comisión Correctora","Debe seleccionar Profesores correctores distintos del Profesor Guía"));
            return;
        }
        if(profesor1.equals(profesor2)) {
            context.addMessage(null, new FacesMessage("Comisión Correctora","Los Profesores correctores deben ser distintos entre si"));
            return;
        }
        
        fechaCorr = dateToString(date);
            
        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestre = new Semestre(semestreCorr);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semestre)) {
            semestreFacade.create(semestre);
        }
        
        //Seteamos y creamos la comisión correctora
        ComisionCorrectora comisionC = new ComisionCorrectora();
        comisionC.setFechaCorreccion(fechaCorr);
        comisionC.setIdSemestre(semestre);
        comisionC.setIdTema(tema);
        comisionCorrectoraFacade.create(comisionC);
        
        //Agregamos el tema a lista de temas del semestre
        semestre.add(comisionC);
        semestreFacade.edit(semestre);
        
        //Profes
        Profesor profe1 = profesorFacade.findByRut(profesor1).get(0);
        Profesor profe2 = profesorFacade.findByRut(profesor2).get(0);
        
        //Creamos las relaciones entre los profes y la comisión
        //Profe 1
        ProfeCorreccion profeCorreccion1 = new ProfeCorreccion(comisionC.getIdCorrectora(),profesor1);
        profeCorreccion1.setRolCorreccion(0);
        profeCorreccion1.setProfesor(profe1);
        profeCorreccion1.setComisionCorrectora(comisionC);
        profeCorreccionFacade.create(profeCorreccion1);
        //Profe 2
        ProfeCorreccion profeCorreccion2 = new ProfeCorreccion(comisionC.getIdCorrectora(),profesor2);
        profeCorreccion2.setRolCorreccion(1);
        profeCorreccion2.setProfesor(profe2);
        profeCorreccion2.setComisionCorrectora(comisionC);
        profeCorreccionFacade.create(profeCorreccion2);
        
        //Agregamos la relacion a la comisión
        comisionC.add(profeCorreccion1);
        comisionC.add(profeCorreccion2);
        comisionCorrectoraFacade.edit(comisionC);
        
        
        profe1.add(profeCorreccion1);
        profesorFacade.edit(profe1);
        profe2.add(profeCorreccion2);
        profesorFacade.edit(profe2);
        
        //Agregamos comision al tema
        tema.setIdCorrectora(comisionC);
        //Seteamos estado "En proceso de examen"
        tema.setEstadoTema(4);
        temaFacade.edit(tema);
        
        //Añadimos al historial del alumno
        Date temp = new Date();
        String dateHist = dateToString(temp);
        Historial histTemaAlum = new Historial();
        histTemaAlum.setDescripcion("Se le asignó Comisión Correctora. Lo ingresó el usuario "+user.getFullNameUser());
        LOGGER.info("Se asignó Comisión Correctora al tema" + tema.getNombreTema());
        histTemaAlum.setFechaHistorial(dateHist);
        histTemaAlum.setTipoHistorial(2);
        histTemaAlum.setIdEntidad(tema.getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno());
        historialFacade.create(histTemaAlum);
        
        
        //Añadimos al historial del usuario que creo la comisión revisora
        Historial histComCorrecUser = new Historial();
        histComCorrecUser.setDescripcion("Ingresó Comisión Correctora al alumno "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno()+" "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno());
        LOGGER.info("Ingresó Comisión Correctora al alumno "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno()+" "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno());
        histComCorrecUser.setFechaHistorial(dateHist);
        histComCorrecUser.setTipoHistorial(3);
        histComCorrecUser.setIdEntidad(user.getUsername());
        historialFacade.create(histComCorrecUser);
        
        //Agregamos el historial de cambio de estado
        Historial historial = new Historial();
        historial.setDescripcion("Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen");
        LOGGER.info("Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen");
        historial.setFechaHistorial(fechaCorr);
        historial.setIdEntidad(String.valueOf(idTema));
        historial.setTipoHistorial(1);
        historialFacade.create(historial);
        
        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Comisión Correctora", "Comisión ingresada al sistema, el estado del tema seleccionado se modificó a 'En proceso de examen'"));
        LOGGER.info("Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen");
        
    }
    
    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value="#{authMB}")
    private AuthMB user;

    public List<ProfeDatos2> getProfeDatos() {
        return profeDatos;
    }

    public void setProfeDatos(List<ProfeDatos2> profeDatos) {
        this.profeDatos = profeDatos;
    }
    
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

    public String getSemestreCorr() {
        return semestreCorr;
    }

    public void setSemestreCorr(String semestreCorr) {
        this.semestreCorr = semestreCorr;
    }

    public List<Profesor> getProfesores() {
        return profesores;
    }

    public void setProfesores(List<Profesor> profesores) {
        this.profesores = profesores;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }    
    
    public String getNombreTema() {
        return nombreTema;
    }

    public void setNombreTema(String nombreTema) {
        this.nombreTema = nombreTema;
    }

    public Integer getIdTema() {
        return idTema;
    }

    public void setIdTema(Integer idTema) {
        this.idTema = idTema;
    }

    public String getFechaCorr() {
        return fechaCorr;
    }

    public void setFechaCorr(String fechaCorr) {
        this.fechaCorr = fechaCorr;
    }
    
    public ComisionCorrectoraFacadeLocal getComisionCorrectoraFacade() {
        return comisionCorrectoraFacade;
    }

    public void setComisionCorrectoraFacade(ComisionCorrectoraFacadeLocal comisionCorrectoraFacade) {
        this.comisionCorrectoraFacade = comisionCorrectoraFacade;
    }


    public TemaFacadeLocal getTemaFacade() {
        return temaFacade;
    }

    public void setTemaFacade(TemaFacadeLocal temaFacade) {
        this.temaFacade = temaFacade;
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

    public ProfesorFacadeLocal getProfesorFacade() {
        return profesorFacade;
    }

    public void setProfesorFacade(ProfesorFacadeLocal profesorFacade) {
        this.profesorFacade = profesorFacade;
    }

    public String getProfesor1() {
        return profesor1;
    }

    public void setProfesor1(String profesorC1) {
        this.profesor1 = profesorC1;
    }

    public String getProfesor2() {
        return profesor2;
    }

    public void setProfesor2(String profesorC2) {
        this.profesor2 = profesorC2;
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
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

    public List<Tema> getTemas() {
        return temas;
    }

    public void setTemas(List<Tema> temas) {
        this.temas = temas;
    }

}