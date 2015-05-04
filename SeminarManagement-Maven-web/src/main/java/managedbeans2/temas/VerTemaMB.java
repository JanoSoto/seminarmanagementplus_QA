/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

import entities.Alumno;
import entities.Profesor;
import entities.Semestre;
import entities.Tema;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.SemestreFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "verTemaMB")
@RequestScoped
public class VerTemaMB {
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    
    private Integer idTema, idTemaEdit;
    private Profesor guia,coguia,corrector1,corrector2;
    private Tema tema;
    private Date fechaEdit;
    private String semestreEdit, nombreTemaEdit;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(VerTemaMB.class);
    private Alumno alumno;
    
    /**
     * Creates a new instance of VerTemaMB
     */
    public VerTemaMB() {
    }
    
    public void buscarTema(){
        List<Tema> result = temaFacade.findById(idTema);
        if(result!=null){
            tema = result.get(0);
            //Inicializamos info para editar
            idTemaEdit = tema.getIdTema();
            nombreTemaEdit = tema.getNombreTema();
            semestreEdit = tema.getIdSemestre().getIdSemestre();
            fechaEdit = stringToDate(tema.getFechaTema());
            
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
        }
        else{
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage("Error","No se ingresó Propuesta"));
        }
    }
    
    public void descaducarTema(Integer id) throws IOException{
        FacesContext context = FacesContext.getCurrentInstance();
        
        if(id==null){
            context.addMessage(null, new FacesMessage("Error","No se ingresó Id"));
            return;
        }
        Tema temaTemp = temaFacade.findById(id).get(0);
        temaTemp.setEstadoTema(0);
        temaFacade.edit(temaTemp);
        
        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Tema",temaTemp.getNombreTema()+", editado en el sistema"));
        LOGGER.info("Tema "+temaTemp.getNombreTema()+ " editado en el sistema");
        

        //externalContext.getFlash().setKeepMessages(true); //Para mantener los mensaje aunque se pase de página
        FacesContext.getCurrentInstance().getExternalContext().redirect("tema.xhtml?tema="+id);
    }
    
    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
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
    
    public void editarTema() {
        FacesContext context = FacesContext.getCurrentInstance();
        
        Tema temaTemp = temaFacade.findById(idTemaEdit).get(0);
        
        if((nombreTemaEdit==null)||(nombreTemaEdit.equals(""))){
            context.addMessage(null, new FacesMessage("Nombre Tema","Debe asignar nombre al Tema"));
            return;
        }
        
        if(fechaEdit==null || fechaEdit.equals("")){
            context.addMessage(null, new FacesMessage("Fecha","Debe seleccionar la fecha del Tema"));
            return;
        }
        
        //Validamos que no haya otro tema con el mismo nombre
        if(!temaFacade.findByName(nombreTemaEdit).isEmpty() && !temaTemp.getNombreTema().equals(nombreTemaEdit)) {
            context.addMessage(null, new FacesMessage("Nombre Tema","Ya existe un tema con ese nombre, por favor escoja otro."));
            return;
        }
        
        //Validaciones del Semestre
        if (semestreEdit == null || semestreEdit.equals("")) {
            context.addMessage(null, new FacesMessage("Semestre Tema","Debe ingresar semestre"));
            return;
        }
        
        if (Integer.valueOf(semestreEdit.substring(2, 6)) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre Tema","Año del semestre debe ser después de 1972"));
            return;
        }
        
        if ((Integer.valueOf(semestreEdit.substring(0, 1)) != 1) && (Integer.valueOf(semestreEdit.substring(0, 1)) != 2)){
            context.addMessage(null, new FacesMessage("Semestre Tema","Semestre ingresado debe ser '1' o '2'"));
            return;
        }
        
        //Editamos el tema
        nombreTemaEdit = nombreTemaEdit.toUpperCase();
        temaTemp.setNombreTema(nombreTemaEdit);
        temaTemp.setFechaTema(dateToString(fechaEdit));
        //Accedemos a la tabla semestre, e ingresamos semestre si no ha sido ingresado
        Semestre semTemp = new Semestre(semestreEdit);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semTemp)) {
            semestreFacade.create(semTemp);
        }
        temaTemp.setIdSemestre(semTemp);
        temaFacade.edit(temaTemp);
        
        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Tema", "El tema ha sido editado exitosamente"));
        LOGGER.info("Tema "+nombreTemaEdit+ " editado exitosamente");
        
    }

    public Integer getIdTemaEdit() {
        return idTemaEdit;
    }

    public void setIdTemaEdit(Integer idTemaEdit) {
        this.idTemaEdit = idTemaEdit;
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

    public Integer getIdTema() {
        return idTema;
    }

    public void setIdTema(Integer idTema) {
        this.idTema = idTema;
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

    public Tema getTema() {
        return tema;
    }

    public void setTema(Tema tema) {
        this.tema = tema;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }
}
