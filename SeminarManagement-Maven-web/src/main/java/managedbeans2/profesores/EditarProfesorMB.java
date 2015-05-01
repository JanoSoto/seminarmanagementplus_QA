/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.profesores;

import entities.Profesor;
import java.io.IOException;
import javax.inject.Named;
import java.io.Serializable;
import java.util.Date;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;

/**
 *
 * @author Elagos
 */
@Named(value = "editarProfesorMB")
@RequestScoped
public class EditarProfesorMB implements Serializable {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    
    private String rutProfesor, rutProfeEdit;
    private Profesor profesor;
    private Profesor profesorEdit = new Profesor();
    private Date dateMaxGuia;
    /**
     * Creates a new instance of EditarProfesorMB
     */
    public EditarProfesorMB() {
    }

    public Date getDateMaxGuia() {
        return dateMaxGuia;
    }

    public void setDateMaxGuia(Date dateMaxGuia) {
        this.dateMaxGuia = dateMaxGuia;
    }

    public String getRutProfesor() {
        return rutProfesor;
    }

    public void setRutProfesor(String rutProfesor) {
        this.rutProfesor = rutProfesor;
    }

    public Profesor getProfesor() {
        return profesor;
    }

    public void setProfesor(Profesor profesor) {
        this.profesor = profesor;
    }
    
    public void buscarProfesor(){
        if(rutProfesor!=null){
            profesor = profesorFacade.findByRut(rutProfesor).get(0);
        }
    }
    
    public void editProfesor() {
        FacesContext context = FacesContext.getCurrentInstance();
        Profesor datosAntiguos = profesorFacade.findByRut(rutProfeEdit).get(0);
        
        Profesor profTemp = datosAntiguos;
        profTemp.setApellidoProfesor(profesorEdit.getApellidoProfesor().toUpperCase());
        profTemp.setNombreProfesor(profesorEdit.getNombreProfesor().toUpperCase());
        profTemp.setContrato(profesorEdit.getContrato());
        profTemp.setTelefonoProfesor(profesorEdit.getTelefonoProfesor());
        
        //Si el profesor es JC, se deja por defecto que SÍ puede ser prof guía
        if(profesorEdit.getContrato()==1){
            profTemp.setTipoProfesor(0);
            profTemp.setTipoProfesor(0);
        }
        else {
            profTemp.setTipoProfesor(profesorEdit.getTipoProfesor());
        }
        
        //Se setea el máximo de guías según el tipo de profesor (en caso que se haya cambiado)
        //por hora = 0, jc=1
        
        //Si pasó de ser Por Hora a JC o si continua siendo JC
        if((datosAntiguos.getTipoProfesor()==0 && profesorEdit.getTipoProfesor()==1) || 
            (datosAntiguos.getTipoProfesor()==1 && profesorEdit.getTipoProfesor()==1)){
            profTemp.setMaximoGuias(null); //Prof JC no tiene máximo
            
            //Se debe setear historial acá
        }
        else {
            //Si pasó de ser JC a Por Hora y SI puede guiar
            if((datosAntiguos.getTipoProfesor()==1 && profesorEdit.getTipoProfesor()==0) && profesor.getTipoProfesor()==0){
                System.out.println("de JC a por hora");
                profesorEdit.setMaximoGuias(7); //Máximo guías por defecto es 7
            }
            else {
                //Si pasó de ser JC a Por Hora y NO puede puede guiar
                if((datosAntiguos.getTipoProfesor()==1 && profesorEdit.getTipoProfesor()==0) && profesor.getTipoProfesor()==1){
                    profTemp.setMaximoGuias(0);
                }
                else {
                    //Si se mantuvo siendo Por Hora
                    profTemp.setMaximoGuias(datosAntiguos.getMaximoGuias());
                }
            }
        }
        
        profesorFacade.edit(profTemp);

        //Añadimos al historial del alumno cuándo lo editaron
        /*
         Date temp = new Date();
         String dateHist = dateToString(temp);
         Historial histEditAlum = new Historial();
         histEditAlum.setDescripcion("Se editó el alumno. Lo editó el usuario "+user.getFullNameUser());
         histEditAlum.setFechaHistorial(dateHist);
         histEditAlum.setTipoHistorial(2);
         histEditAlum.setIdEntidad(alumnoSelected.getRutAlumno());
         historialFacade.create(histEditAlum);


         //Añadimos al historial del usuario que editó al alumno
         Historial histProfAgregadoUser = new Historial();
         histProfAgregadoUser.setDescripcion("Editó al alumno "+alumno.getNombreAlumno()+" "+alumno.getApellidoAlumno());
         histProfAgregadoUser.setFechaHistorial(dateHist);
         histProfAgregadoUser.setTipoHistorial(3);
         histProfAgregadoUser.setIdEntidad(user.getUsername());
         historialFacade.create(histProfAgregadoUser);
         */
        
        context.addMessage(null, new FacesMessage("Editar Profesor", profesorEdit.getNombreProfesor()+" "+profesorEdit.getApellidoProfesor()+" editado exitosamente"));

    }
    
    public void editMaxGuias() {
        FacesContext context = FacesContext.getCurrentInstance();
        
        Profesor datosAntiguos = profesorFacade.findByRut(profesor.getRutProfesor()).get(0);
        Profesor profEditGuias = new Profesor();
        profEditGuias.setRutProfesor(profesor.getRutProfesor());
        profEditGuias.setProfeCorreccionList(datosAntiguos.getProfeCorreccionList());
        profEditGuias.setProfePropuestaList(datosAntiguos.getProfePropuestaList());
        profEditGuias.setProfeRevisionList(datosAntiguos.getProfeRevisionList());
        profEditGuias.setMaximoGuias(profesor.getMaximoGuias());
        context.addMessage(null, new FacesMessage("Editar Máximo Guías", profEditGuias.getNombreProfesor()+" "+profEditGuias.getApellidoProfesor()+" pasó de "+datosAntiguos.getMaximoGuias()+" a poder guiar "+profEditGuias.getMaximoGuias()+"."));
    }
}
