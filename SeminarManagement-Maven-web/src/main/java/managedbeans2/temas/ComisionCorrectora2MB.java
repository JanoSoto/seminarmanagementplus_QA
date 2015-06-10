package managedbeans2.temas;

import clases.ProfeDatos2;
import entities.Alumno;
import entities.ComisionCorrectora;
import entities.Historial;
import entities.ProfeCorreccion;
import entities.Profesor;
import entities.Semestre;
import entities.Tema;
import java.text.ParseException;
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
import static managedbeans2.propuestas.ComisionRevisora2MB.fechaCorrecta;
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
    
    private Integer idTema,idTemaEdit;
    private String rutAlumno,nombreTema,semestreEdit,nombreTemaEdit, semestreTerminoEdit,profesor1,profesor2,fechaTema,semestreTema,fechaCorr,fechaCorr2,fechaRevCorr2,fechaRevCorr, semestreCorr;
    private Date date,date2,date3,date4,fechaEdit,fechaEdit2,fechaEdit3;
    private Tema tema;
    private Alumno alumno;
    private Profesor profGuia,corrector1,corrector2,guia,coguia;
    private List<ComisionCorrectora> comision;
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
    
    public void buscarTema(){
        List<Tema> result = temaFacade.findById(idTema);
        if( result != null ){
            tema = result.get(0);
            //Inicializamos info para editar
            idTemaEdit = tema.getIdTema();
            nombreTemaEdit = tema.getNombreTema();
            semestreEdit = tema.getIdSemestre().getIdSemestre();
            fechaEdit = stringToDate(tema.getFechaTema());
            semestreTerminoEdit = tema.getSemestreTermino();
            if(tema.getFechaRealTema()!= null ){
                fechaEdit2 = stringToDate(tema.getFechaRealTema());
            }
            if(tema.getFechaSiacTema()!= null){
                fechaEdit3 = stringToDate(tema.getFechaSiacTema());
            }
            
            for(int i=0;i<tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().size();i++){
                if(tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia()==0)
                    guia = tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor();
                if(tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia()==1)
                    coguia = tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor();
            }
            
            if(tema.getIdCorrectora()!=null)
                for(int i=0;i<tema.getIdCorrectora().getProfeCorreccionList().size();i++){
                    if(tema.getIdCorrectora().getProfeCorreccionList().get(i).getRolCorreccion()==0)
                        corrector1 = tema.getIdCorrectora().getProfeCorreccionList().get(i).getProfesor();
                    if(tema.getIdCorrectora().getProfeCorreccionList().get(i).getRolCorreccion()==1)
                        corrector2 = tema.getIdCorrectora().getProfeCorreccionList().get(i).getProfesor();
                }
            alumno = tema.getIdRevisora().getIdPropuesta().getRutAlumno();
            
             comision= comisionCorrectoraFacade.findById(tema.getIdCorrectora().getIdCorrectora());
                if(comision.get(0).getFechaCorreccion()!= null){
                    date = stringToDate(comision.get(0).getFechaCorreccion());
                }
                if(comision.get(0).getFechaEntCorreccion()!= null){
                    date2 = stringToDate(comision.get(0).getFechaEntCorreccion());
                }
                if(comision.get(0).getFechaCorreccion2()!= null){
                    date3 = stringToDate(comision.get(0).getFechaCorreccion2());
                }
                if(comision.get(0).getFechaEntCorreccion2()!= null){
                    date4 = stringToDate(comision.get(0).getFechaEntCorreccion2());
                }
        }
        else{
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage("Error","No se ingresó Propuesta"));
        }
    }
    
    public void EditarComisionCorrectora(){
        FacesContext context = FacesContext.getCurrentInstance();
        
        if(idTema==null){
            context.addMessage(null, new FacesMessage("Error","No se ingresó Tema"));
            return;
        }
        
        tema = temaFacade.findById(idTema).get(0);
        
        comision= comisionCorrectoraFacade.findById(tema.getIdCorrectora().getIdCorrectora());
        ComisionCorrectora nuevaComision;
        
        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestreRevision = new Semestre(semestreCorr);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semestreRevision))
            semestreFacade.create(semestreRevision);
        
   
       
        if (date != null ) {
            fechaCorr = dateToString(date);   
        }
        else{
            fechaCorr = null;
        }
        
        if(date2 != null ) {
            fechaRevCorr = dateToString(date2);
        }
        else{
            fechaRevCorr = null;
        }
        
        if(date!= null && date2 != null){
            
            if(fechaCorrecta(fechaCorr, fechaRevCorr) == false){
                return;
            }
        }
        
        
        
        if (date3 != null) {
            fechaCorr2 = dateToString(date3);   
        }
        else{
            fechaCorr2 = null;
        }
        
        if (date4 != null) {
            fechaRevCorr2 = dateToString(date4);   
        }
        else{
            fechaRevCorr2 = null;
        }
        
        if(date3!= null && date4 != null){
            
            if(fechaCorrecta(fechaCorr2, fechaRevCorr2) == false){
                return;
            }
        }
        
        //Seteamos la nueva comision y la creamos
        comision.get(0).setIdTema(comision.get(0).getIdTema());
        comision.get(0).setFechaCorreccion(fechaCorr);
        comision.get(0).setFechaEntCorreccion(fechaRevCorr);
        comision.get(0).setFechaCorreccion2(fechaCorr2);
        comision.get(0).setFechaEntCorreccion2(fechaRevCorr2);
        comision.get(0).setIdSemestre(comision.get(0).getIdSemestre());
        
        comisionCorrectoraFacade.edit(comision.get(0));
        
        

        //Mensaje de confirmación 
        context.addMessage(null, new FacesMessage("Comisión Correctora editada en el sistema"));
        LOGGER.info("La comision correctora del tema "+tema.getNombreTema() +" ha sido modificada en el sistema");
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
        
         if (date != null ) {
            fechaCorr = dateToString(date);   
        }
        else{
            fechaCorr = null;
        }
        
        if(date2 != null ) {
            fechaRevCorr = dateToString(date2);
        }
        else{
            fechaRevCorr = null;
        }
        
        if (date3 != null) {
            fechaCorr2 = dateToString(date3);   
        }
        else{
            fechaCorr2 = null;
        }
        
        if (date4 != null) {
            fechaRevCorr2 = dateToString(date4);   
        }
        else{
            fechaRevCorr2 = null;
        }

        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestre = new Semestre(semestreCorr);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semestre)) {
            semestreFacade.create(semestre);
        }
        
        //Seteamos y creamos la comisión correctora
        ComisionCorrectora comisionC = new ComisionCorrectora();
        comisionC.setFechaCorreccion(fechaCorr);
        comisionC.setFechaEntCorreccion(fechaRevCorr);
        comisionC.setFechaCorreccion2(fechaCorr2);
        comisionC.setFechaEntCorreccion2(fechaRevCorr2);
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
        LOGGER.info("Comision Correctora: El estado del tema cambió de Vigente con borrador final a En proceso de examen");
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

    public Date getDate2() {
        return date2;
    }

    public void setDate2(Date date2) {
        this.date2 = date2;
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

    public String getSemestreEdit() {
        return semestreEdit;
    }

    public void setSemestreEdit(String semestreEdit) {
        this.semestreEdit = semestreEdit;
    }

    public String getNombreTemaEdit() {
        return nombreTemaEdit;
    }

    public void setNombreTemaEdit(String nombreTemaEdit) {
        this.nombreTemaEdit = nombreTemaEdit;
    }

    public Date getFechaEdit() {
        return fechaEdit;
    }

    public void setFechaEdit(Date fechaEdit) {
        this.fechaEdit = fechaEdit;
    }

    public Date getFechaEdit2() {
        return fechaEdit2;
    }

    public void setFechaEdit2(Date fechaEdit2) {
        this.fechaEdit2 = fechaEdit2;
    }

    public Date getFechaEdit3() {
        return fechaEdit3;
    }

    public void setFechaEdit3(Date fechaEdit3) {
        this.fechaEdit3 = fechaEdit3;
    }

    public Profesor getCorrector1() {
        return corrector1;
    }

    public void setCorrector1(Profesor corrector1) {
        this.corrector1 = corrector1;
    }

    public Profesor getCorrector2() {
        return corrector2;
    }

    public void setCorrector2(Profesor corrector2) {
        this.corrector2 = corrector2;
    }

    public Profesor getGuia() {
        return guia;
    }

    public void setGuia(Profesor guia) {
        this.guia = guia;
    }

    public Profesor getCoguia() {
        return coguia;
    }

    public void setCoguia(Profesor coguia) {
        this.coguia = coguia;
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

    public String getFechaCorr2() {
        return fechaCorr2;
    }

    public void setFechaCorr2(String fechaCorr2) {
        this.fechaCorr2 = fechaCorr2;
    }

    public String getFechaRevCorr2() {
        return fechaRevCorr2;
    }

    public void setFechaRevCorr2(String fechaRevCorr2) {
        this.fechaRevCorr2 = fechaRevCorr2;
    }

    public String getFechaRevCorr() {
        return fechaRevCorr;
    }

    public void setFechaRevCorr(String fechaRevCorr) {
        this.fechaRevCorr = fechaRevCorr;
    }

    public Date getDate3() {
        return date3;
    }

    public void setDate3(Date date3) {
        this.date3 = date3;
    }

    public Date getDate4() {
        return date4;
    }

    public void setDate4(Date date4) {
        this.date4 = date4;
    }
     public Date stringToDate (String dateChoosen){
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	try {
            Date date = formatter.parse(dateChoosen);
            return date;
	} catch (ParseException e) {
                return null;
	}
    }
    

}