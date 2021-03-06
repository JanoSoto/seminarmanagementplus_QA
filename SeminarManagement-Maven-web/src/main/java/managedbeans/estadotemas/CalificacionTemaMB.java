/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans.estadotemas;

import entities.Alumno;
import entities.Historial;
import entities.Profesor;
import entities.Tema;
import entities.ProfeCorreccion;
import entities.ProfePropuesta;
import entities.Propuesta;
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
import sessionbeans.ComisionCorrectoraFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfeCorreccionFacadeLocal;
import sessionbeans.ProfePropuestaFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author David
 */
@ManagedBean(name ="calificacionTemaMB")
@RequestScoped
public class CalificacionTemaMB {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private ComisionCorrectoraFacadeLocal comisionCorrectoraFacade;
    @EJB
    private ProfePropuestaFacadeLocal profePropuestaFacade;
    @EJB
    private ProfeCorreccionFacadeLocal profeCorreccionFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    
    private Integer idTema;
    private String rutAlumno,nombreTema,fechaTema,semestreTema,notaProfe1Inf,notaProfe1Def
                   ,notaProfe2Inf,notaProfe2Def,notaProfeGuiaInf,notaProfeGuiaDef;
    private Tema tema;
    private Profesor profGuia,profCorrector1,profCorrector2;
    private Date date, dateCorrecP1, dateCorrecP2, dateCorrecPG;
    private List<Alumno> alumnos;
    private List<Profesor> profes;
    private List<Tema> temas;
    
    public CalificacionTemaMB() {
    }
    
    @PostConstruct
    public void init(){
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        
        //Buscamos todos los alumnos con tema en proceso examen
        alumnos = alumnoFacade.findAll();
        List<Alumno> listaAlumTemp = new ArrayList();
        for(int i=0;i<alumnos.size();i++)
            for(int j=0;j<alumnos.get(i).getPropuestaList().size();j++)
                if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora()!=null)
                    if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema()!=null)
                        if(alumnos.get(i).getPropuestaList().get(j).getIdRevisora().getIdTema().getEstadoTema()==4)
                            listaAlumTemp.add(alumnos.get(i));
        alumnos=listaAlumTemp;
        
        //Buscamos todos los temas en proceso examen
        temas = temaFacade.findAll();
        List<Tema> listaTemaTemp = new ArrayList();
        for(int i=0;i<temas.size();i++)
            if(temas.get(i).getEstadoTema()==4)
                listaTemaTemp.add(temas.get(i));
        temas=listaTemaTemp;
        
        //Recortamos los nombres de los temas para mostrarlos en la vista
        for(int i=0;i<temas.size();i++)
            if(temas.get(i).getNombreTema().length()>38)
                temas.get(i).setNombreTema(temas.get(i).getNombreTema().substring(0, 39)+"...");
        
        profes = profesorFacade.findAll();
    }
    
    public void updateByAlumno(){
        if(rutAlumno == null){
            //Buscamos todos los temas en proceso de examen
            temas = temaFacade.findAll();
            List<Tema> listaTemaTemp = new ArrayList();
            for(int i=0;i<temas.size();i++)
                if(temas.get(i).getEstadoTema()==4)
                    listaTemaTemp.add(temas.get(i));
            temas=listaTemaTemp;

            //Recortamos los nombres de los temas para mostrarlos en la vista
            for(int i=0;i<temas.size();i++)
                if(temas.get(i).getNombreTema().length()>38)
                    temas.get(i).setNombreTema(temas.get(i).getNombreTema().substring(0, 39)+"...");
            
            profGuia = new Profesor();
            tema = new Tema();
            fechaTema="";
            semestreTema="";
            nombreTema="";
            return;
        }
        //Buscamos los temas en proceso de examen del alumno seleccionado
        Alumno alumnoTemp = alumnoFacade.findByRut(rutAlumno).get(0);
        List<Propuesta> propsTemp = alumnoTemp.getPropuestaList();
        List<Tema> listTemp = new ArrayList();
        for(int i=0;i<propsTemp.size();i++)
            if(propsTemp.get(i).getIdRevisora()!=null)
                if(propsTemp.get(i).getIdRevisora().getIdTema()!=null)
                    if(propsTemp.get(i).getIdRevisora().getIdTema().getEstadoTema()==4)
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
        profCorrector1 = null;
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
        for(int i=0;i<tema.getIdCorrectora().getProfeCorreccionList().size();i++){
            if(tema.getIdCorrectora().getProfeCorreccionList().get(i).getRolCorreccion()==0)
                profCorrector1=tema.getIdCorrectora().getProfeCorreccionList().get(i).getProfesor();
            if(tema.getIdCorrectora().getProfeCorreccionList().get(i).getRolCorreccion()==1)
                profCorrector2=tema.getIdCorrectora().getProfeCorreccionList().get(i).getProfesor();
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

    public Date getDateCorrecP1() {
        return dateCorrecP1;
    }

    public void setDateCorrecP1(Date dateCorrecP1) {
        this.dateCorrecP1 = dateCorrecP1;
    }

    public Date getDateCorrecP2() {
        return dateCorrecP2;
    }

    public void setDateCorrecP2(Date dateCorrecP2) {
        this.dateCorrecP2 = dateCorrecP2;
    }

    public Date getDateCorrecPG() {
        return dateCorrecPG;
    }

    public void setDateCorrecPG(Date dateCorrecPG) {
        this.dateCorrecPG = dateCorrecPG;
    }
    
    public Profesor getProfCorrector1() {
        return profCorrector1;
    }

    public void setProfCorrector1(Profesor profCorrector1) {
        this.profCorrector1 = profCorrector1;
    }

    public Profesor getProfCorrector2() {
        return profCorrector2;
    }

    public void setProfCorrector2(Profesor profCorrector2) {
        this.profCorrector2 = profCorrector2;
    }

    public String getNotaProfe1Inf() {
        return notaProfe1Inf;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setNotaProfe1Inf(String notaProfe1Inf) {
        this.notaProfe1Inf = notaProfe1Inf;
    }

    public String getNotaProfe1Def() {
        return notaProfe1Def;
    }

    public void setNotaProfe1Def(String notaProfe1Def) {
        this.notaProfe1Def = notaProfe1Def;
    }

    public String getNotaProfe2Inf() {
        return notaProfe2Inf;
    }

    public void setNotaProfe2Inf(String notaProfe2Inf) {
        this.notaProfe2Inf = notaProfe2Inf;
    }

    public String getNotaProfe2Def() {
        return notaProfe2Def;
    }

    public void setNotaProfe2Def(String notaProfe2Def) {
        this.notaProfe2Def = notaProfe2Def;
    }

    public String getNotaProfeGuiaInf() {
        return notaProfeGuiaInf;
    }

    public void setNotaProfeGuiaInf(String notaProfeGuiaInf) {
        this.notaProfeGuiaInf = notaProfeGuiaInf;
    }

    public String getNotaProfeGuiaDef() {
        return notaProfeGuiaDef;
    }

    public void setNotaProfeGuiaDef(String notaProfeGuiaDef) {
        this.notaProfeGuiaDef = notaProfeGuiaDef;
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
    
    
    public void calificarTema(){
        FacesContext context = FacesContext.getCurrentInstance();
        
        //Se valida que se haya seleccionado Tema
        if((idTema==null)||(idTema==-1)){
            context.addMessage(null, new FacesMessage("Nombre Tema","Debe seleccionar un tema"));
            return;
        }
        
        //Se valida que se hayan ingresado notas de Informe
        if(notaProfe1Inf.equals("") || notaProfe2Inf.equals("") || notaProfeGuiaInf.equals("")) {
            context.addMessage(null, new FacesMessage("Notas Tema","Debe ingresar las notas de Informe de todos los profesores"));
            return;
        }
        
        //Se valida que se hayan ingresado notas de Defensa
        if(notaProfe1Def.equals("") || notaProfe2Def.equals("") || notaProfeGuiaDef.equals("")) {
            context.addMessage(null, new FacesMessage("Notas Tema","Debe ingresar las notas de Defensa de todos los profesores"));
            return;
        }
        
        Float fNota1Inf = Float.parseFloat(notaProfe1Inf),fNota1Def = Float.parseFloat(notaProfe1Def),
              fNota2Inf = Float.parseFloat(notaProfe2Inf),fNota2Def = Float.parseFloat(notaProfe2Def),
              fNotaGuiaInf = Float.parseFloat(notaProfeGuiaInf),fNotaGuiaDef = Float.parseFloat(notaProfeGuiaDef);
        Float promedioInf = (fNota1Inf+fNota2Inf+fNotaGuiaInf)/3, promedioDef = (fNota1Def+fNota2Def+fNotaGuiaDef)/3;
        Float promedio = (promedioDef+promedioInf)/2;
        
        //validamos que las notas sean dentro del rango [1,7]
        if((fNota1Inf<1) || (fNota1Def<1) || (fNota2Inf<1) || (fNota2Def<1) || (fNotaGuiaInf<1) || (fNotaGuiaDef<1)){
            context.addMessage(null, new FacesMessage("Notas Tema","Debe ingresar notas mayores a 1.0"));
            return;
        }
        if((fNota1Inf>7) || (fNota1Def>7) || (fNota2Inf>7) || (fNota2Def>7) || (fNotaGuiaInf>7) || (fNotaGuiaDef>7)){
            context.addMessage(null, new FacesMessage("Notas Tema","Debe ingresar notas menores a 7.0"));
            return;
        }
        
        //Se valida la fecha
        if(date==null || dateCorrecP1==null || dateCorrecP2==null || dateCorrecPG==null ){
            context.addMessage(null, new FacesMessage("Fecha","Debe seleccionar las fechas de la calificación"));
            return;
        }
        
        tema = temaFacade.findById(idTema).get(0);
        //Obtenemos los profesores correctores
        ProfeCorreccion profeCorreccion1 = new ProfeCorreccion();
        ProfeCorreccion profeCorreccion2 = new ProfeCorreccion();
        for(int i=0;i<tema.getIdCorrectora().getProfeCorreccionList().size();i++){
            if(tema.getIdCorrectora().getProfeCorreccionList().get(i).getRolCorreccion()==0){
                profCorrector1 = tema.getIdCorrectora().getProfeCorreccionList().get(i).getProfesor();
                profeCorreccion1 = tema.getIdCorrectora().getProfeCorreccionList().get(i);
            }
            if(tema.getIdCorrectora().getProfeCorreccionList().get(i).getRolCorreccion()==1){
                profCorrector2 = tema.getIdCorrectora().getProfeCorreccionList().get(i).getProfesor();
                profeCorreccion2 = tema.getIdCorrectora().getProfeCorreccionList().get(i);
            }
        }
        //Obtenemos el profesor guía
        ProfePropuesta profeProp = new ProfePropuesta();
        for(int i=0;i<tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().size();i++)
            if(tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia()==0){
                profGuia=tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor();
                profeProp = tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i);
            }
        
        //Seteamos las notas y la fecha
        profeCorreccion1.setNotaCorreccionInforme(fNota1Inf);
        profeCorreccion1.setNotaCorreccionDefensa(fNota1Def);
        //profeCorreccion1.setFechaCorreccion(dateToString(dateCorrecP1));
        profeCorreccionFacade.edit(profeCorreccion1);
        
        profeCorreccion2.setNotaCorreccionInforme(fNota2Inf);
        profeCorreccion2.setNotaCorreccionDefensa(fNota2Def);
        //profeCorreccion2.setFechaCorreccion(dateToString(dateCorrecP2));
        profeCorreccionFacade.edit(profeCorreccion2);
        
        profeProp.setNotaGuiaInforme(fNotaGuiaInf);
        profeProp.setNotaGuiaDefensa(fNotaGuiaDef);
        profePropuestaFacade.edit(profeProp);
        
        //Seteamos estado "Titulado" o "Caduco" acorde a las notas
        if(promedio<4){
            tema.setEstadoTema(3);
            //Mensaje de confirmación
            context.addMessage(null, new FacesMessage("Calificación: "+promedio, "Se agregarón las notas y el estado del tema seleccionado se modificó a 'Caduco'"));
        }
        else{
            tema.setEstadoTema(1);
            //Mensaje de confirmación
            context.addMessage(null, new FacesMessage("Calificación: "+promedio, "Se agregarón las notas y el estado del tema seleccionado se modificó a 'Titulado'"));
        }
        temaFacade.edit(tema);
        
        //Añadimos al historial del alumno
        Date temp = new Date();
        String dateHist = dateToString(temp);
        Historial histTemaAlum = new Historial();
        histTemaAlum.setDescripcion("Se añadieron Notas de correción. Lo ingresó el usuario "+user.getFullNameUser());
        histTemaAlum.setFechaHistorial(dateHist);
        histTemaAlum.setTipoHistorial(2);
        histTemaAlum.setIdEntidad(tema.getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno());
        historialFacade.create(histTemaAlum);
        
        
        //Añadimos al historial del usuario que creo la comisión revisora
        Historial histNotasUser = new Historial();
        histNotasUser.setDescripcion("Ingresó Notas al alumno "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno()+" "+tema.getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno());
        histNotasUser.setFechaHistorial(dateHist);
        histNotasUser.setTipoHistorial(3);
        histNotasUser.setIdEntidad(user.getUsername());
        historialFacade.create(histNotasUser);
        
        //Agregamos el historial de cambio de estado y de agregar notas
        Historial historial = new Historial();
        String fecha = dateToString(date);
        if(tema.getEstadoTema() == 1){
            historial.setDescripcion("Calificación:  el estado de tema cambió de 'Vigente' a 'Titulado', promedio: "+promedio);
        }
        if(tema.getEstadoTema() == 3){
            historial.setDescripcion("Calificación: el estado de tema cambió de 'Vigente' a 'Caduco', promedio: "+promedio);
        }
        historial.setFechaHistorial(fecha);
        historial.setIdEntidad(String.valueOf(idTema));
        historial.setTipoHistorial(1);
        historialFacade.create(historial);
    }
}
