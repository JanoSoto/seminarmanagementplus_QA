/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.alumnos;

import entities.Alumno;
import entities.Historial;
import java.io.IOException;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import managedbeans.AuthMB;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.HistorialFacadeLocal;

/**
 *
 * @author Elagos
 */
@Named(value = "editarAlumnoMB")
@SessionScoped
public class EditarAlumnoMB implements Serializable {

    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;

    private Alumno alumno;
    private String rutAlumno;

    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value = "#{authMB}")
    private AuthMB user;

    /**
     * Creates a new instance of EditarAlumnoMB
     */
    public void buscarAlumno() {
        if (rutAlumno != null) {
            List<Alumno> alumnoTemp = alumnoFacade.findByRut(rutAlumno);
            if (alumnoTemp.isEmpty()) {
                FacesContext context = FacesContext.getCurrentInstance();
                context.addMessage(null, new FacesMessage("Error", "La página solicitada no existe"));
                return;
            }
            alumno = alumnoFacade.findByRut(rutAlumno).get(0);
        }
    }

    public EditarAlumnoMB() {
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public void editAlumno() throws IOException {
        FacesContext context = FacesContext.getCurrentInstance();
        Alumno alumnoEdit = new Alumno();
        alumnoEdit.setJornada(alumno.getJornada());
        alumnoEdit.setMailAlumno(alumno.getMailAlumno().toUpperCase());
        alumnoEdit.setNombreAlumno(alumno.getNombreAlumno().toUpperCase());
        alumnoEdit.setApellidoAlumno(alumno.getApellidoAlumno().toUpperCase());
        alumnoEdit.setCarreraAlumno(alumno.getCarreraAlumno());
        alumnoEdit.setTelefonoAlumno(alumno.getTelefonoAlumno());
        alumnoEdit.setDireccionAlumno(alumno.getDireccionAlumno().toUpperCase());
        alumnoEdit.setPet(alumno.getPet());
        alumnoEdit.setRutAlumno(alumno.getRutAlumno());
        alumnoEdit.setPropuestaList(alumno.getPropuestaList());
        alumnoFacade.edit(alumnoEdit);

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
        
        context.addMessage(null, new FacesMessage("Editar Alumno", alumnoEdit.getNombreAlumno()+" "+alumnoEdit.getApellidoAlumno()+" editado exitosamente"));

    }

}
