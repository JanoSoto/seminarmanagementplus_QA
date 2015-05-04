/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.propuestas;

import clases.PropuestaDatos;
import entities.Alumno;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.SemestreFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "verPropuestaMB")
@RequestScoped
public class VerPropuestaMB {
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    
    private Integer idPropuesta, idPropEdit;
    private String nombreCorto, semestrePropEdit, nombrePropEdit;
    private Profesor guia, coguia, revisor1, revisor2;
    private Propuesta propuesta;
    private Date fechaPropEdit;
    private Alumno alumno;

    /**
     * Creates a new instance of VerPropuestaMB
     */
    public VerPropuestaMB() {
    }
    
    public void buscarPropuesta(){
        if(idPropuesta!=null){
            List<Propuesta> result = propuestaFacade.findById(idPropuesta);
            if(result!=null){
                propuesta = result.get(0);
                //Inicializamos datos para editar
                idPropEdit = propuesta.getIdPropuesta();
                nombrePropEdit = propuesta.getNombrePropuesta();
                fechaPropEdit = stringToDate(propuesta.getFechaPropuesta());
                semestrePropEdit = propuesta.getIdSemestre().getIdSemestre();
                if(propuesta.getNombrePropuesta().length()>68)
                    nombreCorto = propuesta.getNombrePropuesta().substring(0, 69)+"...";
                else
                    nombreCorto = propuesta.getNombrePropuesta();

                for(int i=0;i<propuesta.getProfePropuestaList().size();i++){
                    if(propuesta.getProfePropuestaList().get(i).getRolGuia()==0)
                        guia = propuesta.getProfePropuestaList().get(i).getProfesor();
                    if(propuesta.getProfePropuestaList().get(i).getRolGuia()==1)
                        coguia = propuesta.getProfePropuestaList().get(i).getProfesor();
                }

                if(propuesta.getIdRevisora()!=null)
                    for(int i=0;i<propuesta.getIdRevisora().getProfeRevisionList().size();i++){
                        if(propuesta.getIdRevisora().getProfeRevisionList().get(i).getRolRevision()==0)
                            revisor1 = propuesta.getIdRevisora().getProfeRevisionList().get(i).getProfesor();
                        if(propuesta.getIdRevisora().getProfeRevisionList().get(i).getRolRevision()==1)
                            revisor2 = propuesta.getIdRevisora().getProfeRevisionList().get(i).getProfesor();
                    }
                
                alumno = propuesta.getRutAlumno();
                
            }
        }
        else{
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage("Error","No se ingresó Propuesta"));
        }
    }
    
    public void editarPropuesta(){
        FacesContext context = FacesContext.getCurrentInstance();
        Propuesta propTemp = propuestaFacade.findById(idPropEdit).get(0);
        
        if(nombrePropEdit == null) {
            context.addMessage(null, new FacesMessage("Nombre Propuesta","Debe ingresar nombre propuesta"));
            return;
        }
        
        if(semestrePropEdit == null || semestrePropEdit.equals("")) {
            context.addMessage(null, new FacesMessage("Semestre Propuesta","Debe ingresar semestre propuesta"));
            return;
        }
        
        //Se valida que no exista otra propuesta con el mismo nombre
        List<Propuesta> propuestas = propuestaFacade.findByName(nombrePropEdit);
        if(!propuestas.isEmpty() && !propTemp.equals(nombrePropEdit)) {
            context.addMessage(null, new FacesMessage("Nombre Propuesta","Ya existe una propuesta con ese nombre"));
            return;
        }
        
        //Validamos errores de semestre
        if (Integer.valueOf(semestrePropEdit.substring(2, 6)) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre","Año del semestre debe ser después de 1972"));
            return;
        }
        
        if ((Integer.valueOf(semestrePropEdit.substring(0, 1)) != 1) && (Integer.valueOf(semestrePropEdit.substring(0, 1)) != 2)){
            context.addMessage(null, new FacesMessage("Semestre Revisión","Semestre ingresado debe ser '1' o '2'"));
            return;
        }
        
        //Accedemos a la tabla semestre, e ingresamos semestre si no ha sido ingresado
        Semestre semTemp = new Semestre(semestrePropEdit);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semTemp)) {
            semestreFacade.create(semTemp);
        }
        
        nombrePropEdit = nombrePropEdit.toUpperCase();
        propTemp.setNombrePropuesta(nombrePropEdit);
        propTemp.setFechaPropuesta(dateToString(fechaPropEdit));
        propTemp.setIdSemestre(semTemp);
        propuestaFacade.edit(propTemp);
        
        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Propuesta", "La propuesta ha sido editada exitósamente"));
        
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
    
    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public String getNombrePropEdit() {
        return nombrePropEdit;
    }

    public void setNombrePropEdit(String nombrePropEdit) {
        this.nombrePropEdit = nombrePropEdit;
    }

    public Integer getIdPropEdit() {
        return idPropEdit;
    }

    public void setIdPropEdit(Integer idPropEdit) {
        this.idPropEdit = idPropEdit;
    }

    public String getSemestrePropEdit() {
        return semestrePropEdit;
    }

    public void setSemestrePropEdit(String semestrePropEdit) {
        this.semestrePropEdit = semestrePropEdit;
    }

    public Date getFechaPropEdit() {
        return fechaPropEdit;
    }

    public void setFechaPropEdit(Date fechaPropEdit) {
        this.fechaPropEdit = fechaPropEdit;
    }
    
    public Propuesta getPropuesta() {
        return propuesta;
    }

    public void setPropuesta(Propuesta propuesta) {
        this.propuesta = propuesta;
    }

    public Integer getIdPropuesta() {
        return idPropuesta;
    }

    public void setIdPropuesta(Integer idPropuesta) {
        this.idPropuesta = idPropuesta;
    }

    public Profesor getGuia() {
        return guia;
    }

    public String getNombreCorto() {
        return nombreCorto;
    }

    public void setNombreCorto(String nombreCorto) {
        this.nombreCorto = nombreCorto;
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

    public Profesor getRevisor1() {
        return revisor1;
    }

    public void setRevisor1(Profesor revisor1) {
        this.revisor1 = revisor1;
    }

    public Profesor getRevisor2() {
        return revisor2;
    }

    public void setRevisor2(Profesor revisor2) {
        this.revisor2 = revisor2;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }
    
}
