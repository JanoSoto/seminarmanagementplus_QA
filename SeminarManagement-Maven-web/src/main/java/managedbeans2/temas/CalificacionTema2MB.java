/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

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
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author David
 */
@ManagedBean(name ="calificacionTema2MB")
@RequestScoped
public class CalificacionTema2MB {
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
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    
    private Integer idTema;
    private String rutAlumno,nombreTema,fechaTema,semestreTema,notaProfe1Inf,notaProfe1Def
                   ,notaProfe2Inf,notaProfe2Def,notaProfeGuiaInf,notaProfeGuiaDef,fechaSiac,fechaReal;
    private Tema tema;
    private Date date,date2, dateCorrecP1, dateCorrecP2, dateCorrecPG;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(CalificacionTema2MB.class);
    
    public CalificacionTema2MB() {
    }
    
    public void calificarTema(){
        FacesContext context = FacesContext.getCurrentInstance();
        Float promedio;
        //Se valida que se haya seleccionado Tema
        if((idTema==null)||(idTema==-1)){
            context.addMessage(null, new FacesMessage("Tema","No se ingresó un tema"));
            return;
        }
        
        if(date==null || date.equals("")){
            context.addMessage(null, new FacesMessage("Tema","No se ingresó una fecha"));
            return;
        }
        
        if(date2==null || date2.equals("")){
            context.addMessage(null, new FacesMessage("Tema","No se ingresó una fecha"));
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
        
        if (fNota1Def < 4 && fNota2Def < 4 || fNota1Def < 4 && fNotaGuiaDef < 4 || fNota2Def < 4 && fNotaGuiaDef < 4){
            promedio = notaMenor(fNota1Def,fNota2Def,fNotaGuiaDef);
        }
        else{
            Float promedioInf = (fNota1Inf+fNota2Inf+fNotaGuiaInf)/3, promedioDef = (fNota1Def+fNota2Def+fNotaGuiaDef)/3;
            promedio = (promedioDef+promedioInf)/2;
        }
        //validamos que las notas sean dentro del rango [1,7]
        if((fNota1Inf<1) || (fNota1Def<1) || (fNota2Inf<1) || (fNota2Def<1) || (fNotaGuiaInf<1) || (fNotaGuiaDef<1)){
            context.addMessage(null, new FacesMessage("Notas Tema","Debe ingresar notas mayores a 1.0"));
            return;
        }
        if((fNota1Inf>7) || (fNota1Def>7) || (fNota2Inf>7) || (fNota2Def>7) || (fNotaGuiaInf>7) || (fNotaGuiaDef>7)){
            context.addMessage(null, new FacesMessage("Notas Tema","Debe ingresar notas menores a 7.0"));
            return;
        }
        
        tema = temaFacade.findById(idTema).get(0);
        //Obtenemos los profesores correctores
        Profesor profCorrector1,profCorrector2,profGuia;
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
        profeCorreccionFacade.edit(profeCorreccion1);
        
        profeCorreccion2.setNotaCorreccionInforme(fNota2Inf);
        profeCorreccion2.setNotaCorreccionDefensa(fNota2Def);
        profeCorreccionFacade.edit(profeCorreccion2);
        
        profeProp.setNotaGuiaInforme(fNotaGuiaInf);
        profeProp.setNotaGuiaDefensa(fNotaGuiaDef);
        profePropuestaFacade.edit(profeProp);   
        String semestre = semestreActualFacade.findAll().get(0).getSemestreActual();
        tema.setSemestreTermino(semestre);
        
        //Seteamos estado "Titulado" o "Reprobado" acorde a las notas
        if(promedio<4){
            tema.setEstadoTema(7);
            //Mensaje de confirmación
            context.addMessage(null, new FacesMessage("Calificación: "+promedio, "Se agregaron las notas y el estado del tema seleccionado se modificó a 'Reprobado'"));
            LOGGER.info("Promedio: "+promedio+ " Se agregaron las notas y el estado del tema seleccionado se modificó a Reprobado");
        }
        else{
            tema.setEstadoTema(1);
            //Mensaje de confirmación
            context.addMessage(null, new FacesMessage("Calificación: "+promedio, "Se agregaron las notas y el estado del tema seleccionado se modificó a 'Titulado'"));
            LOGGER.info("Promedio: "+promedio+ " Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado");
        }
        
        fechaReal = dateToString(date);
        fechaSiac = dateToString(date2);
        tema.setFechaRealTema(fechaReal);
        tema.setFechaSiacTema(fechaSiac);
        temaFacade.edit(tema);
        
        /*
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
        String fecha = dateToString(temp);
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
        */
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

    public Date getDate2() {
        return date2;
    }

    public void setDate2(Date date2) {
        this.date2 = date2;
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

    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    private Float notaMenor(Float fNota1Def, Float fNota2Def, Float fNotaGuiaDef) {
        Float aux,aux2;
        aux = Math.min(fNota1Def, fNota2Def);
        aux2= Math.min(aux, fNotaGuiaDef);
        return aux2;
    }
   
}
