package managedbeans2.alumnos;

import entities.Alumno;
import entities.AsociacionPlanEstudioAlumno;
import entities.PlanEstudio;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import managedbeans.AuthMB;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.PlanestudioFacadeLocal;

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
    @EJB
    private PlanestudioFacadeLocal planEstudioFacade;

    private Alumno alumno;
    private String rutAlumno;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(EditarAlumnoMB.class);
    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value = "#{authMB}")
    private AuthMB user;

    private Integer planEstudioAlumno;

    public Integer getPlanEstudioAlumno() {
        return planEstudioAlumno;
    }

    public void setPlanEstudioAlumno(Integer planEstudioAlumno) {
        this.planEstudioAlumno = planEstudioAlumno;
    }

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
        alumnoEdit.setMailAlumno(alumno.getMailAlumno().toUpperCase());
        alumnoEdit.setNombreAlumno(alumno.getNombreAlumno().toUpperCase());
        alumnoEdit.setApellidoAlumno(alumno.getApellidoAlumno().toUpperCase());
        alumnoEdit.setTelefonoAlumno(alumno.getTelefonoAlumno());
        alumnoEdit.setDireccionAlumno(alumno.getDireccionAlumno().toUpperCase());
        alumnoEdit.setRutAlumno(alumno.getRutAlumno());
        alumnoEdit.setPropuestaList(alumno.getPropuestaList());

//        alumno.getPlanEstudioAlumno();
        List<AsociacionPlanEstudioAlumno> planesEstudioAlumno = alumno.getAsociacionPlanEstudioAlumno();

        Boolean existe = false;
        for (int i = 0; i < planesEstudioAlumno.size(); i++) {
            Integer id = Integer.parseInt(planesEstudioAlumno.get(i).getPlanEstudio().getId()+"");
            System.out.println(id + " == " + this.planEstudioAlumno);
            if (id == this.planEstudioAlumno) {
                System.out.println("Existe !!!!");
                existe = true;
            } else {
//                planesEstudioAlumno.get(i).setActivo(false);
            }
        }

        List<AsociacionPlanEstudioAlumno> asociacion_antigua = alumno.getAsociacionPlanEstudioAlumno();

        PlanEstudio a = planEstudioFacade.findById(this.planEstudioAlumno);
        if (!existe) {
            AsociacionPlanEstudioAlumno nueva_asociacion = new AsociacionPlanEstudioAlumno();

//            asociacion_antigua.get(0).setActivo(false);
            nueva_asociacion.setActivo(true);
            nueva_asociacion.setAlumno(alumnoEdit);
            nueva_asociacion.setAlumnoId(alumnoEdit.getRutAlumno());
            nueva_asociacion.setPlanEstudio(a);
            nueva_asociacion.setPlanId(this.planEstudioAlumno);

            for (int i = 0; i < asociacion_antigua.size(); i++) {
                System.out.println(asociacion_antigua.get(i).isActivo());
//                asociacion_antigua.get(i).setActivo(false);
            }
            asociacion_antigua.add(nueva_asociacion);
            a.setAsociacionPlanEstudioAlumno(asociacion_antigua);

            a.setAsociacionPlanEstudioAlumno(asociacion_antigua);
        }
        
        alumno.setAsociacionPlanEstudioAlumno(asociacion_antigua);
        alumnoEdit.setAsociacionPlanEstudioAlumno(asociacion_antigua);
        a.setAsociacionPlanEstudioAlumno(asociacion_antigua);
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
        context.addMessage(null, new FacesMessage("Editar Alumno", alumnoEdit.getNombreAlumno() + " " + alumnoEdit.getApellidoAlumno() + " editado exitosamente"));
        LOGGER.info("El alumno " + alumnoEdit.getNombreAlumno() + " " + alumnoEdit.getApellidoAlumno() + " ha sido editado exitosamente");

    }

}
