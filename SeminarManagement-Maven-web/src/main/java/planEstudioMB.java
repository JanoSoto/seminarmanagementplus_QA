
import entities.Alumno;
import entities.AsociacionPlanEstudioAlumno;
import entities.PlanEstudio;
import entities.Versionplan;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.PlanestudioFacadeLocal;
import sessionbeans.asociacionFacadeLocal;

/**
 *
 * @author giovanni
 */
@Named(value = "planEstudioMB")
@RequestScoped
public class planEstudioMB {

    @EJB
    PlanestudioFacadeLocal planEstudioFacade;

    @EJB
    AlumnoFacadeLocal alumnoFacade;

    @EJB
    asociacionFacadeLocal asociacionFacade;

    List<PlanEstudio> planesEstudio;
    List<PlanEstudio> planesEstudioAlumno;
    private List<AsociacionPlanEstudioAlumno> asociacionPlanes;
    private List<AsociacionPlanEstudioAlumno> asociacionPlanesAlumno;

    public planEstudioMB() {

    }

    public void cargarPlanes(String rut) {
        List<PlanEstudio> todos = planEstudioFacade.findAll();
        Alumno alumno = alumnoFacade.findByRut(rut).get(0);
        List<AsociacionPlanEstudioAlumno> mios = alumno.getAsociacionPlanEstudioAlumno();
        this.planesEstudio = new ArrayList<>();
        this.planesEstudioAlumno = new ArrayList<>();
        for (int i = 0; i < todos.size(); i++) {
            Boolean existe = false;
            PlanEstudio plan = todos.get(i);
            for (int j = 0; j < mios.size(); j++) {
                AsociacionPlanEstudioAlumno asociacion = mios.get(j);
                if (plan.getId() == asociacion.getPlanId()) {
                    existe = true;
                    break;
                }
            }
            if (existe) {
                this.planesEstudioAlumno.add(plan);
            } else {
                this.planesEstudio.add(plan);
            }
        }
    }

    public void cargarAsociacionPlanes(String rut) {
        List<PlanEstudio> todos = planEstudioFacade.findAll();
        Alumno alumno = alumnoFacade.findByRut(rut).get(0);
        List<AsociacionPlanEstudioAlumno> mios = alumno.getAsociacionPlanEstudioAlumno();
        this.asociacionPlanes = new ArrayList<>();
        this.asociacionPlanesAlumno = new ArrayList<>();

        List<AsociacionPlanEstudioAlumno> asd = asociacionFacade.findAll();
        for (int i = 0; i < asd.size(); i++) {
//            System.out.println(asd.get(i).getPlanId() + " -> " + asd.get(i).getVersionPlan());
        }

        for (int i = 0; i < todos.size(); i++) {
            PlanEstudio plan = todos.get(i);
//            List<Versionplan> versiones = asociacionFacade.getVersionesPlan(plan.getId());
            List<Integer> ab = asociacionFacade.getVersionesPlan(alumno.getRutAlumno(), plan.getId());
//            System.out.println("Plan: " + plan.getId());
            for (int j = 0; j < ab.size(); j++) {
//                System.out.println("\tAsociacion: " + ab.get(j));
                AsociacionPlanEstudioAlumno nueva_asociacion = new AsociacionPlanEstudioAlumno();
                nueva_asociacion.setActivo(true);
                nueva_asociacion.setAlumno(alumno);
                nueva_asociacion.setAlumnoId(alumno.getRutAlumno());
                nueva_asociacion.setPlanEstudio(plan);
                nueva_asociacion.setPlanId(plan.getId());
                nueva_asociacion.setVersionPlan(ab.get(j));
                this.asociacionPlanesAlumno.add(nueva_asociacion);
            }
        }

        this.asociacionPlanes = new ArrayList<>();
        for (int i = 0; i < todos.size(); i++) {
            PlanEstudio plan = todos.get(i);
            List<Versionplan> versiones = plan.getVersionplanList();
            for (int j = 0; j < versiones.size(); j++) {
                Boolean existe = false;
                Versionplan version = versiones.get(j);
//                System.out.println("Plan " + plan.getId());
                List<Integer> asociaciones = asociacionFacade.getVersionesPlan(alumno.getRutAlumno(), plan.getId());
                for (int k = 0; k < asociaciones.size(); k++) {
                    Integer version_asociacion = asociaciones.get(k);
//                    System.out.println("\t....." + version.getVersion() + " == " + version_asociacion);
                    if (version.getVersion().equals(version_asociacion)) {
//                        System.out.println("existe");
                        existe = true;
                    }
                }
                if (!existe) {
//                    System.out.println("Añadiendo plan " + plan.getId()+ ", version " + version.getVersion());
                    AsociacionPlanEstudioAlumno nueva_asociacion = new AsociacionPlanEstudioAlumno();
                    nueva_asociacion.setActivo(true);
                    nueva_asociacion.setAlumno(alumno);
                    nueva_asociacion.setAlumnoId(alumno.getRutAlumno());
                    nueva_asociacion.setPlanEstudio(plan);
                    nueva_asociacion.setPlanId(plan.getId());
                    nueva_asociacion.setVersionPlan(version.getVersion());
                    this.asociacionPlanes.add(nueva_asociacion);
                }
            }

        }
    }

    public List<AsociacionPlanEstudioAlumno> getAsociacionPlanesEstudio(String rut) {
        if (this.asociacionPlanes == null) {
            cargarAsociacionPlanes(rut);
        }
        return this.asociacionPlanes;
    }

    public List<AsociacionPlanEstudioAlumno> getAsociacionPlanesEstudioAlumno(String rut) {
        if (this.asociacionPlanesAlumno == null) {
            cargarAsociacionPlanes(rut);
        }
        return this.asociacionPlanesAlumno;
    }

    public List<PlanEstudio> getPlanesEstudio(String rut) {
        if (this.planesEstudio == null) {
            cargarPlanes(rut);
        }
        return this.planesEstudio;
    }

    public List<PlanEstudio> getPlanesEstudioAlumno(String rut) {
        if (this.planesEstudioAlumno == null) {
            cargarPlanes(rut);
        }
        return this.planesEstudioAlumno;
    }

    public List<AsociacionPlanEstudioAlumno> getAsociacionesPlanesEstudioAlumno(String rut) {
        Alumno alumno = alumnoFacade.findByRut(rut).get(0);
        List<AsociacionPlanEstudioAlumno> mios = alumno.getAsociacionPlanEstudioAlumno();
        List<AsociacionPlanEstudioAlumno> planes = new ArrayList<>();
        for (int i = 0; i < mios.size(); i++) {
            AsociacionPlanEstudioAlumno a = mios.get(i);
//            System.out.println("asd => " + a.getVersionPlan());
            planes.add(a);
        }
        return planes;
    }

    public String getNombrePlanActivo(String rut) {
        Integer a = alumnoFacade.findByRut(rut).get(0).getIdPlanActivo();
        if (a != null) {
            PlanEstudio plan = planEstudioFacade.findById(a);
            return plan.getCodigo() + " " + plan.getCarreraId().getNombre();
        }
        return "Ninguno";
    }

    public Integer getIdPlanActivo(String rut) {
        Integer a = alumnoFacade.findByRut(rut).get(0).getIdPlanActivo();
        return a == null ? -1 : a;
    }

    public Integer getVersionPlanActivo(String rut) {
        Integer a = alumnoFacade.findByRut(rut).get(0).getVersionPlanActivo();
        return a == null ? -1 : a;
    }

    public Integer getAnioPlan(Integer id_plan, Integer version_plan) {
        List<PlanEstudio> planes = planEstudioFacade.findAll();
        PlanEstudio plan = null;
        System.out.println("Id: " + id_plan);
        System.out.println("VE: " + version_plan);
        for (int i = 0; i < planes.size(); i++) {
            if (planes.get(i).getId().equals(Long.parseLong(id_plan + ""))) {
                List<Versionplan> versiones = planes.get(i).getVersionplanList();
                for (int j = 0; j < versiones.size(); j++) {
                    Versionplan versionPlan = versiones.get(j);
                    System.out.println("Comparando: " + versionPlan.getVersion() + " con " + Long.parseLong(version_plan + ""));
                    if (versionPlan.getVersion() == Long.parseLong(version_plan + "")) {
                        System.out.println("existeeeee");
                        return versionPlan.getAnio();
                    }
                }
            }
        }
        return -1;
    }
}
