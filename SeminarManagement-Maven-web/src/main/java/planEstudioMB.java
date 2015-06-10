import entities.Alumno;
import entities.AsociacionPlanEstudioAlumno;
import entities.PlanEstudio;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.PlanestudioFacadeLocal;

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

    List<PlanEstudio> planesEstudio;
    List<PlanEstudio> planesEstudioAlumno;

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

}
