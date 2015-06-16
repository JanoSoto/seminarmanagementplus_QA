package managedbeans2.alumnos;

import Util.Util;
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
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import managedbeans.AuthMB;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.PlanestudioFacadeLocal;
import sessionbeans.asociacionFacadeLocal;

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

    @EJB
    private asociacionFacadeLocal asociacionFacade;

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
        Alumno alumnoEdit = alumnoFacade.findByRut(alumno.getRutAlumno()).get(0);
//        Alumno alumnoEdit = new Alumno();
        alumnoEdit.setMailAlumno(alumno.getMailAlumno().toUpperCase());
        alumnoEdit.setNombreAlumno(alumno.getNombreAlumno().toUpperCase());
        alumnoEdit.setApellidoAlumno(alumno.getApellidoAlumno().toUpperCase());
        alumnoEdit.setTelefonoAlumno(alumno.getTelefonoAlumno());
        alumnoEdit.setDireccionAlumno(alumno.getDireccionAlumno().toUpperCase());
        alumnoEdit.setRutAlumno(alumno.getRutAlumno());
        alumnoEdit.setPropuestaList(alumno.getPropuestaList());

        if (this.planEstudioAlumno != null) {
//        alumno.getPlanEstudioAlumno();
            List<AsociacionPlanEstudioAlumno> planesEstudioAlumno = alumno.getAsociacionPlanEstudioAlumno();

            Boolean existe = false;
            for (int i = 0; i < planesEstudioAlumno.size(); i++) {
                Integer id = Integer.parseInt(planesEstudioAlumno.get(i).getPlanEstudio().getId() + "");
                if (id == this.planEstudioAlumno) {
                    existe = true;
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
                nueva_asociacion.setPlanId(a.getId());
//            nueva_asociacion.setPlanId(Long.parseLong(a.getCodigo()+""));

                for (AsociacionPlanEstudioAlumno asociacion_antigua1 : asociacion_antigua) {
                    asociacion_antigua1.setActivo(false);
                }

                asociacion_antigua.add(nueva_asociacion);
            }

//        a.setAsociacionPlanEstudioAlumno(asociacion_antigua);
//        alumnoEdit.setAsociacionPlanEstudioAlumno(asociacion_antigua);
            List<AsociacionPlanEstudioAlumno> asociacion_final = new ArrayList<>();
            for (int i = 0; i < asociacion_antigua.size(); i++) {
                AsociacionPlanEstudioAlumno asd = asociacion_antigua.get(i);

                if (Integer.parseInt(asd.getPlanId() + "") == this.planEstudioAlumno) {
                    asd.setActivo(true);
                } else {
                    asd.setActivo(false);
                }

                asociacion_final.add(asd);
            }

            for (int i = 0; i < asociacion_antigua.size(); i++) {
                AsociacionPlanEstudioAlumno asd = asociacion_antigua.get(i);
                Alumno ab = asd.getAlumno();
                ab.setAsociacionPlanEstudioAlumno(asociacion_final);
                alumnoFacade.edit(ab);
            }

            alumnoEdit.setIdPlanActivo(Integer.parseInt(this.planEstudioAlumno + ""));

            a.setAsociacionPlanEstudioAlumno(asociacion_final);
            alumnoEdit.setAsociacionPlanEstudioAlumno(asociacion_final);
        }

        alumnoFacade.edit(alumnoEdit);

        context.addMessage(null, new FacesMessage("Editar Alumno", alumnoEdit.getNombreAlumno() + " " + alumnoEdit.getApellidoAlumno() + " editado exitosamente"));
        LOGGER.info("El alumno " + alumnoEdit.getNombreAlumno() + " " + alumnoEdit.getApellidoAlumno() + " ha sido editado exitosamente");

    }

    public void setPlanActivoAlumno(String rutAlumno, Integer codigo_plan, Integer codigo, String nombre) {
        FacesContext context = FacesContext.getCurrentInstance();
        Alumno alumnoEdit = alumnoFacade.findByRut(rutAlumno).get(0);
        List<AsociacionPlanEstudioAlumno> asociacion = alumnoEdit.getAsociacionPlanEstudioAlumno();
        alumnoEdit.setIdPlanActivo(codigo_plan);
        alumnoFacade.edit(alumnoEdit);
        context.addMessage(null, new FacesMessage("Se ha dejado el plan " + codigo + " " + nombre + " como activo."));
    }

    public void eliminarPlan(String rutAlumno, Integer codigo_plan) {
        FacesContext context = FacesContext.getCurrentInstance();
        Alumno alumnoEdit = alumnoFacade.findByRut(rutAlumno).get(0);
        List<AsociacionPlanEstudioAlumno> asociacion = alumnoEdit.getAsociacionPlanEstudioAlumno();

        for (int i = 0; i < asociacion.size(); i++) {
            AsociacionPlanEstudioAlumno asoc = asociacion.get(i);
            if (Integer.parseInt(asoc.getPlanId() + "") == codigo_plan) {
                asociacion.remove(asoc);
            }
        }

        if (alumnoEdit.getIdPlanActivo() == codigo_plan) {
            if (asociacion.size() > 0) {
                alumnoEdit.setIdPlanActivo(Integer.parseInt(asociacion.get(0).getPlanId() + ""));
            } else {
                alumnoEdit.setIdPlanActivo(null);
            }
        }
        alumnoEdit.setAsociacionPlanEstudioAlumno(asociacion);
        asociacionFacade.eliminarPlanAlumno(codigo_plan, alumnoEdit.getRutAlumno());
        alumnoFacade.edit(alumnoEdit);
        context.addMessage(null, new FacesMessage("Plan " + codigo_plan + " eliminado correctamente."));
    }

    public String jornadaToString(Integer jornada) {
        return Util.jornadaToString(jornada);
    }

    public String jornadaToStringUpperCase(Integer jornada) {
        return Util.jornadaToString(jornada).toUpperCase();
    }

}
