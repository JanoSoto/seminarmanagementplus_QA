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
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
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

        this.planEstudioAlumno = null;
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

    public void agregarPlanAlumno(Integer planEstudioAlumno, Integer version_plan) throws IOException {
        this.planEstudioAlumno = planEstudioAlumno;
        Alumno alumnoEdit = alumnoFacade.findByRut(alumno.getRutAlumno()).get(0);
        List<AsociacionPlanEstudioAlumno> planesEstudioAlumno = alumno.getAsociacionPlanEstudioAlumno();
        List<AsociacionPlanEstudioAlumno> asociacion = planesEstudioAlumno;

        Boolean existe = false;
        for (int i = 0; i < asociacion.size(); i++) {
            Integer id = Integer.parseInt(asociacion.get(i).getPlanEstudio().getId() + "");
            if (id == this.planEstudioAlumno && asociacion.get(i).getVersionPlan() == version_plan) {
//                System.out.println("existe");
                existe = true;
            }
        }

        List<AsociacionPlanEstudioAlumno> asociacion_antigua = alumno.getAsociacionPlanEstudioAlumno();

        PlanEstudio a = planEstudioFacade.findById(this.planEstudioAlumno);

//        System.out.println("Existe: " + existe);
        if (!existe) {
            AsociacionPlanEstudioAlumno nueva_asociacion = new AsociacionPlanEstudioAlumno();

            nueva_asociacion.setActivo(true);
            nueva_asociacion.setVersionPlan(version_plan);

            nueva_asociacion.setAlumno(alumnoEdit);
            nueva_asociacion.setAlumnoId(alumnoEdit.getRutAlumno());
            nueva_asociacion.setPlanEstudio(a);
            nueva_asociacion.setPlanId(a.getId());

            for (AsociacionPlanEstudioAlumno asociacion_antigua1 : asociacion_antigua) {
                asociacion_antigua1.setActivo(false);
            }

//            System.out.println("Agregare el plan: " + version_plan + ", version: " + version_plan);
            asociacion_antigua.add(nueva_asociacion);
            asociacionFacade.agregarAsociacion(alumnoEdit.getRutAlumno(), a.getId(), version_plan);
        }

//        a.setAsociacionPlanEstudioAlumno(asociacion_antigua);
//        alumnoEdit.setAsociacionPlanEstudioAlumno(asociacion_antigua);
        List<AsociacionPlanEstudioAlumno> asociacion_final = new ArrayList<>();
        for (int i = 0; i < asociacion_antigua.size(); i++) {
            AsociacionPlanEstudioAlumno asd = asociacion_antigua.get(i);
            asociacion_final.add(asd);
        }

        for (int i = 0; i < asociacion_final.size(); i++) {
            AsociacionPlanEstudioAlumno asd = asociacion_final.get(i);
            Alumno ab = asd.getAlumno();
            ab.setAsociacionPlanEstudioAlumno(asociacion_final);
            alumnoFacade.edit(ab);
//            System.out.println("Asociaciones: " + asd.getPlanId() + ", " + asd.getVersionPlan());
        }

        alumnoEdit.setIdPlanActivo(Integer.parseInt(planEstudioAlumno + ""));
        alumnoEdit.setVersionPlanActivo(version_plan);

        a.setAsociacionPlanEstudioAlumno(asociacion_final);

        alumnoEdit.setAsociacionPlanEstudioAlumno(asociacion_final);
        alumnoFacade.edit(alumnoEdit);
        ExternalContext contexto = FacesContext.getCurrentInstance().getExternalContext();

        contexto.redirect(contexto.getRequestContextPath() + "/2.0/admin/alumnos/editar.xhtml?alum=" + alumnoEdit.getRutAlumno());
    }

    public void setPlanActivoAlumno(String rutAlumno, Integer codigo_plan, Integer version_plan, Integer codigo, String nombre) throws IOException {
        FacesContext context = FacesContext.getCurrentInstance();
        Alumno alumnoEdit = alumnoFacade.findByRut(rutAlumno).get(0);
        List<AsociacionPlanEstudioAlumno> asociacion = alumnoEdit.getAsociacionPlanEstudioAlumno();
        alumnoEdit.setIdPlanActivo(codigo_plan);
        alumnoEdit.setVersionPlanActivo(version_plan);
        alumnoFacade.edit(alumnoEdit);
        context.addMessage(null, new FacesMessage("Se ha dejado el plan " + codigo + " " + nombre + ", version " + version_plan + ", como activo."));
        ExternalContext contexto = FacesContext.getCurrentInstance().getExternalContext();
        contexto.redirect(contexto.getRequestContextPath() + "/2.0/admin/alumnos/editar.xhtml?alum=" + alumnoEdit.getRutAlumno() + "&mensaje=Se ha dejado el plan " + codigo + " " + nombre + ", version " + version_plan + ", como activo.");
    }

    public void eliminarPlan(String rutAlumno, Integer codigo_plan, Integer version_plan) throws IOException {
        FacesContext context = FacesContext.getCurrentInstance();
        Alumno alumnoEdit = alumnoFacade.findByRut(rutAlumno).get(0);
        List<AsociacionPlanEstudioAlumno> asociacion = alumnoEdit.getAsociacionPlanEstudioAlumno();

        for (int i = 0; i < asociacion.size(); i++) {
            AsociacionPlanEstudioAlumno asoc = asociacion.get(i);
//            System.out.println("Comparando " + Integer.parseInt(asoc.getVersionPlan() + "") + " con " + version_plan);
            if (Integer.parseInt(asoc.getPlanId() + "") == codigo_plan && Integer.parseInt(asoc.getVersionPlan() + "") == version_plan) {
//                System.out.println("Elimine");
                asociacion.remove(asoc);
            }
        }

//        System.out.println("Asociacion: " + alumnoEdit.getVersionPlanActivo() + " con " + version_plan);
//        System.out.println(alumnoEdit.getIdPlanActivo() + " == " + codigo_plan + " && " + alumnoEdit.getVersionPlanActivo() + " == " + version_plan);
        if (Objects.equals(codigo_plan, alumnoEdit.getIdPlanActivo()) && Objects.equals(alumnoEdit.getVersionPlanActivo(), version_plan)) {
            if (asociacion.size() > 0) {
//                System.out.println("AAAAAAAAAAAAAAAAAA");
                alumnoEdit.setIdPlanActivo(Integer.parseInt(asociacion.get(0).getPlanId() + ""));
                alumnoEdit.setVersionPlanActivo(Integer.parseInt(asociacion.get(0).getVersionPlan() + ""));
            } else {
//                System.out.println("BBBBBBBBBBBBBBBBBB");
                alumnoEdit.setIdPlanActivo(null);
                alumnoEdit.setVersionPlanActivo(null);
            }
        }
//        System.out.println("Plan actuaal: " + alumnoEdit.getIdPlanActivo() + ", " + alumnoEdit.getVersionPlanActivo());
        alumnoEdit.setAsociacionPlanEstudioAlumno(asociacion);
        asociacionFacade.eliminarPlanAlumno(codigo_plan, alumnoEdit.getRutAlumno(), version_plan);
        alumnoFacade.edit(alumnoEdit);
        ExternalContext contexto = FacesContext.getCurrentInstance().getExternalContext();
        contexto.redirect(contexto.getRequestContextPath() + "/2.0/admin/alumnos/editar.xhtml?alum=" + alumnoEdit.getRutAlumno());
        context.addMessage(null, new FacesMessage("Plan " + codigo_plan + " eliminado correctamente."));
    }

    public String jornadaToString(Integer jornada) {
        return Util.jornadaToString(jornada);
    }

    public String jornadaToStringUpperCase(Integer jornada) {
        return Util.jornadaToString(jornada).toUpperCase();
    }

}
