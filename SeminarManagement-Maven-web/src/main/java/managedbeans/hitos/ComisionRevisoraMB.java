/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans.hitos;

import clases.ProfeDatos;
import entities.Alumno;
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
@ManagedBean(name ="comisionRevisoraMB")
@RequestScoped
public class ComisionRevisoraMB {
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
    private String nombrePropuesta,rutAlumno,fechaProp,semestreProp,nombreProp,rutProfeRev1, rutProfeRev2, fechaRev, semestreRev;
    private Propuesta propuesta;
    private Profesor profGuia;
    private Date date;
    private List<ProfeDatos> profesores;
    private List<Alumno> alumnos,alumnosPH,alumnosJC;
    private List<Propuesta> propuestas,propuestasPH,propuestasJC;
    
    public ComisionRevisoraMB() {
    }
    
    @PostConstruct
    public void init() {
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        System.out.println(user.toString());
        
        FacesContext context = FacesContext.getCurrentInstance();
        
        //Buscamos a todos los alumnos con propuesta no revisada y sin temas no caducos
        alumnos = alumnoFacade.findAll();
        List<Alumno> listaAlumTemp = new ArrayList();
        for(int i=0;i<alumnos.size();i++){
            int noCaducos=0;
            int propNoRevisada=0;
            for(int j=0;j<alumnos.get(i).getPropuestaList().size();j++){
                propNoRevisada++;
                if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora()!=null){
                    propNoRevisada--;
                    if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema()!=null)
                        if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema().getEstadoTema()!=3)
                            noCaducos++;
                }
            }
            if((noCaducos==0)&&(propNoRevisada>0))
                    listaAlumTemp.add(alumnos.get(i));
            }
        alumnos=listaAlumTemp;
        
        //Buscamos todas las propuestas no revisadas de alumnos sin temas no caducos
        propuestas = propuestaFacade.findAll();
        List<Propuesta> listTemp = new ArrayList();
        for(int i=0;i<propuestas.size();i++)
            if(alumnos.contains(propuestas.get(i).getRutAlumno())&&(propuestas.get(i).getIdRevisora()==null))
                listTemp.add(propuestas.get(i));
        propuestas=listTemp;
        
        //Recortamos los nombres de las propuestas para mostrarlos en la vista
        for(int i=0;i<propuestas.size();i++)
            if(propuestas.get(i).getNombrePropuesta().length()>38)
                propuestas.get(i).setNombrePropuesta(propuestas.get(i).getNombrePropuesta().substring(0,39)+"...");
        
        //Separamos propuestas segun contrato del profesor guía
        propuestasPH = new ArrayList();
        propuestasJC = new ArrayList();
        for(int i=0;i<propuestas.size();i++)
            for(int j=0;j<propuestas.get(i).getProfePropuestaList().size();j++){
                if((propuestas.get(i).getProfePropuestaList().get(j).getRolGuia()==0)&&
                        (propuestas.get(i).getProfePropuestaList().get(j).getProfesor().getContrato()==0))
                    propuestasPH.add(propuestas.get(i));
                if((propuestas.get(i).getProfePropuestaList().get(j).getRolGuia()==0)&&
                        (propuestas.get(i).getProfePropuestaList().get(j).getProfesor().getContrato()==1))
                    propuestasJC.add(propuestas.get(i));
            }
        
        //Separamos alumnos segun contrato de los profesores guias de sus propuestas
        alumnosPH = new ArrayList();
        alumnosJC = new ArrayList();
        for(int i=0;i<propuestasPH.size();i++)
            if(!alumnosPH.contains(propuestasPH.get(i).getRutAlumno()))
                alumnosPH.add(propuestasPH.get(i).getRutAlumno());
        for(int i=0;i<propuestasJC.size();i++)
            if(!alumnosJC.contains(propuestasJC.get(i).getRutAlumno()))
                alumnosJC.add(propuestasJC.get(i).getRutAlumno());
        
        //Seteamos el semestre a semestre actual
        if(semestreActualFacade.findAll().isEmpty()){
            semestreRev = "";
            context.addMessage(null, new FacesMessage("Aviso","No se ha ingresado semestre actual en el sistema"));
        }
        else
            semestreRev = semestreActualFacade.findAll().get(0).getSemestreActual();
        
        //Generamos las listas de posibles Profesores Revisores y Guías
        int guiaProp,revisorTemp,revProp,revSem,guiaTem;
        ProfeDatos profeDatosTemp;
        profesores = new ArrayList();
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
                            if(profProp.get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema()==0)
                                guiaTem++;
                }
            profeDatosTemp = new ProfeDatos(guiaProp,guiaTem,revisorTemp,-1,
                    profes.get(i).getRutProfesor(),profes.get(i).getNombreProfesor(),profes.get(i).getApellidoProfesor());
            profeDatosTemp.setRevProp(revProp);
            profeDatosTemp.setRevSem(revSem);
            profesores.add(profeDatosTemp);
        }
    }
    
    public void updateByAlumno(){
        if(rutAlumno == null){
            //Buscamos todas las propuestas no revisadas de alumnos sin temas no caducos
            propuestas = propuestaFacade.findAll();
            List<Propuesta> listTemp = new ArrayList();
            for(int i=0;i<propuestas.size();i++)
                if(alumnos.contains(propuestas.get(i).getRutAlumno())&&(propuestas.get(i).getIdRevisora()==null))
                    listTemp.add(propuestas.get(i));
            propuestas=listTemp;

            //Recortamos los nombres de las propuestas para mostrarlos en la vista
            for(int i=0;i<propuestas.size();i++)
                if(propuestas.get(i).getNombrePropuesta().length()>38)
                    propuestas.get(i).setNombrePropuesta(propuestas.get(i).getNombrePropuesta().substring(0,39)+"...");
            
            //Separamos propuestas segun contrato del profesor guía
            propuestasPH = new ArrayList();
            propuestasJC = new ArrayList();
            for(int i=0;i<propuestas.size();i++)
                for(int j=0;j<propuestas.get(i).getProfePropuestaList().size();j++){
                    if((propuestas.get(i).getProfePropuestaList().get(j).getRolGuia()==0)&&
                            (propuestas.get(i).getProfePropuestaList().get(j).getProfesor().getContrato()==0))
                        propuestasPH.add(propuestas.get(i));
                    if((propuestas.get(i).getProfePropuestaList().get(j).getRolGuia()==0)&&
                            (propuestas.get(i).getProfePropuestaList().get(j).getProfesor().getContrato()==1))
                        propuestasJC.add(propuestas.get(i));
                }
            
            propuesta = new Propuesta();
            profGuia = new Profesor();
            fechaProp="";
            semestreProp="";
            nombreProp="";
            return;
        }
        //Buscamos todas las propuestas no revisadas del alumno seleccionado
        propuestas = propuestaFacade.findAll();
        List<Propuesta> listTemp = new ArrayList();
        for(int i=0;i<propuestas.size();i++)
            if(propuestas.get(i).getRutAlumno().getRutAlumno().equals(rutAlumno)&&(propuestas.get(i).getIdRevisora()==null))
                listTemp.add(propuestas.get(i));
        propuestas=listTemp;
        
        //Recortamos los nombres de las propuestas para mostrarlos en la vista
        for(int i=0;i<propuestas.size();i++)
            if(propuestas.get(i).getNombrePropuesta().length()>38)
                propuestas.get(i).setNombrePropuesta(propuestas.get(i).getNombrePropuesta().substring(0,39)+"...");
        
        propuesta = new Propuesta();
        profGuia = new Profesor();
        fechaProp="";
        semestreProp="";
        nombreProp="";
    }
    
    public void updateByPropuesta(){
        if(idProp == -1){
            updateByAlumno();
            return;
        }
        propuesta = propuestaFacade.findById(idProp).get(0);
        rutAlumno=propuesta.getRutAlumno().getRutAlumno();
        updateByAlumno();
        propuesta = propuestaFacade.findById(idProp).get(0);
        for(int i=0;i<propuesta.getProfePropuestaList().size();i++)
            if(propuesta.getProfePropuestaList().get(i).getRolGuia()==0)
                profGuia=propuesta.getProfePropuestaList().get(i).getProfesor();
        semestreProp=propuesta.getIdSemestre().getIdSemestre();
        fechaProp=propuesta.getFechaPropuesta();
        nombreProp=propuesta.getNombrePropuesta();
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

    public List<Alumno> getAlumnosPH() {
        return alumnosPH;
    }

    public void setAlumnosPH(List<Alumno> alumnosPH) {
        this.alumnosPH = alumnosPH;
    }

    public List<Alumno> getAlumnosJC() {
        return alumnosJC;
    }

    public void setAlumnosJC(List<Alumno> alumnosJC) {
        this.alumnosJC = alumnosJC;
    }

    public List<Propuesta> getPropuestasPH() {
        return propuestasPH;
    }

    public void setPropuestasPH(List<Propuesta> propuestasPH) {
        this.propuestasPH = propuestasPH;
    }

    public List<Propuesta> getPropuestasJC() {
        return propuestasJC;
    }

    public void setPropuestasJC(List<Propuesta> propuestasJC) {
        this.propuestasJC = propuestasJC;
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
    
    public List<Alumno> getAlumnos() {
        return alumnos;
    }

    public List<Propuesta> getPropuestas() {
        return propuestas;
    }

    public void setPropuestas(List<Propuesta> propuestas) {
        this.propuestas = propuestas;
    }

    public void setAlumnos(List<Alumno> alumnos) {
        this.alumnos = alumnos;
    }

    public List<ProfeDatos> getProfesores() {
        return profesores;
    }

    public void setProfesores(List<ProfeDatos> profesores) {
        this.profesores = profesores;
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
    
    public void setTipoRevisionTrabajo(){
        this.tipoRevision=0;
    }
    
    public void setTipoRevisionSeminario(){
        this.tipoRevision=1;
    }
    
    public void setTipoRevisionAcuerdo(){
        this.tipoRevision=2;
    }
    
    public void addComisionRevisora() {
        FacesContext context = FacesContext.getCurrentInstance();
        //Se valida que se halla seleccionado propuesta
        if(idProp==-1){
            context.addMessage(null, new FacesMessage("Nombre Propuesta","Debe seleccionar una propuesta"));
            return;
        }
        
        //Se valida que se halla seleccionado profesor1
        if(rutProfeRev1.equals("-")){
            context.addMessage(null, new FacesMessage("Profesor Revisor 1","Debe seleccionar un profesor"));
            return;
        }
        
        //Se valida que se halla seleccionado Profesor2
        if(rutProfeRev2.equals("-")){
            context.addMessage(null, new FacesMessage("Profesor Revisor 2","Debe seleccionar un Profesor"));
            return;
        }
        
        propuesta = propuestaFacade.findById(idProp).get(0);
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
        
        //fecha
        if(date==null){
            context.addMessage(null, new FacesMessage("Fecha","Debe ingresar la fecha del Tema"));
            return;
        }
        
        //Validamos errores de semestre
        if (Integer.valueOf(semestreRev.substring(2, 6).toString()) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre","Año del semestre debe ser después de 1972"));
            return;
        }
        
        if ((Integer.valueOf(semestreRev.substring(0, 1)) != 1) && (Integer.valueOf(semestreRev.substring(0, 1)) != 2)){
            context.addMessage(null, new FacesMessage("Semestre Revisión","Semestre ingresado debe ser '1' o '2'"));
            return;
        }
        
        fechaRev = dateToString(date);
        
        ComisionRevisora nuevaComision;
        
        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestreRevision = new Semestre(semestreRev);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semestreRevision))
            semestreFacade.create(semestreRevision);
        
        //Seteamos la nueva comision y la creamos
        nuevaComision = new ComisionRevisora();
        nuevaComision.setIdPropuesta(propuesta);
        nuevaComision.setFechaRevision(fechaRev);
        nuevaComision.setIdSemestre(semestreRevision);
        nuevaComision.setTipoRevision(tipoRevision);
        comisionRevisoraFacade.create(nuevaComision);
        
        //Agregamos la comision a la lista de comisiones del semestre
        semestreRevision.add(nuevaComision);
        semestreFacade.edit(semestreRevision);
        
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
        
        //Asignamos la Comision a la Propuesta
        propuesta.setIdRevisora(nuevaComision);
        propuestaFacade.edit(propuesta);
        
        //Mensaje de confirmación 
        context.addMessage(null, new FacesMessage("Comisión Revisora", propuesta.getNombrePropuesta()+", ingresada al sistema"));
    }
    
    public void addComisionRevisoraAcuerdo() {
        FacesContext context = FacesContext.getCurrentInstance();
        //Se valida que se halla seleccionado propuesta
        if(idProp==-1){
            context.addMessage(null, new FacesMessage("Nombre Propuesta","Debe seleccionar una propuesta"));
            return;
        }
        
        //fecha
        if(date==null){
            context.addMessage(null, new FacesMessage("Fecha","Debe ingresar la fecha del Tema"));
            return;
        }
        
        //Validamos errores de semestre
        if (Integer.valueOf(semestreRev.substring(2, 6).toString()) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre","Año del semestre debe ser después de 1972"));
            return;
        }
        
        if ((Integer.valueOf(semestreRev.substring(0, 1)) != 1) && (Integer.valueOf(semestreRev.substring(0, 1)) != 2)){
            context.addMessage(null, new FacesMessage("Semestre Revisión","Semestre ingresado debe ser '1' o '2'"));
            return;
        }
        
        fechaRev = dateToString(date);
        
        propuesta = propuestaFacade.findById(idProp).get(0);
        
        ComisionRevisora nuevaComision;
        
        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestreRevision = new Semestre(semestreRev);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semestreRevision))
            semestreFacade.create(semestreRevision);
        
        //Seteamos la nueva comision y la creamos
        nuevaComision = new ComisionRevisora();
        nuevaComision.setIdPropuesta(propuesta);
        nuevaComision.setFechaRevision(fechaRev);
        nuevaComision.setIdSemestre(semestreRevision);
        nuevaComision.setTipoRevision(tipoRevision);
        comisionRevisoraFacade.create(nuevaComision);
        
        //Agregamos la comision a la lista de comisiones del semestre
        semestreRevision.add(nuevaComision);
        semestreFacade.edit(semestreRevision);
        
        //Asignamos la Comision a la Propuesta
        propuesta.setIdRevisora(nuevaComision);
        propuestaFacade.edit(propuesta);
        
        //Añadimos al historial 
        Date temp = new Date();
        String dateHist = dateToString(temp);
        Historial histComRevAlum = new Historial();
        histComRevAlum.setDescripcion("Se le asignó Comisión Revisora. La ingresó el usuario "+user.getFullNameUser());
        histComRevAlum.setFechaHistorial(dateHist);
        histComRevAlum.setTipoHistorial(2);
        histComRevAlum.setIdEntidad(propuesta.getRutAlumno().getRutAlumno());
        historialFacade.create(histComRevAlum);
        
        
        //Añadimos al historial del usuario que creo la comisión revisora
        Historial histComRevUser = new Historial();
        histComRevUser.setDescripcion("Ingresó Comisión Revisora de la propuesta del alumno "+propuesta.getRutAlumno().getNombreAlumno()+" "+propuesta.getRutAlumno().getApellidoAlumno());
        histComRevUser.setFechaHistorial(dateHist);
        histComRevUser.setTipoHistorial(3);
        histComRevUser.setIdEntidad(user.getUsername());
        historialFacade.create(histComRevUser);
        
        //Mensaje de confirmación 
        context.addMessage(null, new FacesMessage("Comisión Revisora", "Revisión de "+propuesta.getNombrePropuesta()+", ingresada al sistema"));
    }
}