package managedbeans2.alumnos;

import Util.Util;
import clases.PropuestaDatos;
import clases.TemaDatos;
import entities.Alumno;
import entities.PlanEstudio;
import entities.ProfePropuesta;
import entities.Tema;
import entities.Versionplan;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.PlanestudioFacade;
import sessionbeans.PlanestudioFacadeLocal;
import util.SMUtil;

/**
 *
 * @author David
 */
@Named(value = "verAlumnoMB")
@RequestScoped
public class VerAlumnoMB {

    @EJB
    private AlumnoFacadeLocal alumnoFacade;

    private String rutAlumno;
    private Alumno alumno;
    private List<PropuestaDatos> propDatos;
    private List<TemaDatos> temaDatos;

    @EJB
    private PlanestudioFacadeLocal planFacade;

    /**
     * Creates a new instance of VerAlumnoMB
     */
    public VerAlumnoMB() {
    }

    public void buscarAlumno() {
        if (rutAlumno != null) {
            List<Alumno> alumnoTemp = alumnoFacade.findByRut(rutAlumno);
            if (alumnoTemp.isEmpty()) {
                FacesContext context = FacesContext.getCurrentInstance();
                context.addMessage(null, new FacesMessage("Error", "La página solicitada no existe"));
                return;
            }
            alumno = alumnoFacade.findByRut(rutAlumno).get(0);

            propDatos = new ArrayList();
            PropuestaDatos propDTemp;
            for (int i = 0; i < alumno.getPropuestaList().size(); i++) {
                propDTemp = new PropuestaDatos();
                propDTemp.setIdPropuesta(Integer.toString(alumno.getPropuestaList().get(i).getIdPropuesta()));
                propDTemp.setNombrePropuesta(alumno.getPropuestaList().get(i).getNombrePropuesta());
                propDTemp.setIdPlan(alumno.getPropuestaList().get(i).getIdPlan());
                propDTemp.setVersionPlan(alumno.getPropuestaList().get(i).getVersionPlan());
                propDTemp.setPropuesta(alumno.getPropuestaList().get(i));
//                propDTemp.setNombrePlan(alumno.getPropuestaList().get(i).get);
                if (alumno.getPropuestaList().get(i).getNombrePropuesta().length() > 64) {
                    propDTemp.setNombreCorto(alumno.getPropuestaList().get(i).getNombrePropuesta().substring(0, 65) + "...");
                } else {
                    propDTemp.setNombreCorto(alumno.getPropuestaList().get(i).getNombrePropuesta());
                }
                List<ProfePropuesta> listaProfes = alumno.getPropuestaList().get(i).getProfePropuestaList();
                for (int j = 0; j < listaProfes.size(); j++) {
                    if (listaProfes.get(j).getRolGuia() == 0) {
                        propDTemp.setGuia(listaProfes.get(j).getProfesor());
                    }
                }

                propDatos.add(propDTemp);
            }

            temaDatos = new ArrayList();
            TemaDatos temaDTemp;
            List<Tema> temasTemp = new ArrayList();
            for (int i = 0; i < alumno.getPropuestaList().size(); i++) {
                if (alumno.getPropuestaList().get(i).getIdRevisora() != null) {
                    if (alumno.getPropuestaList().get(i).getIdRevisora().getIdTema() != null) {
                        temaDTemp = new TemaDatos();
                        temaDTemp.setTema(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema());
                        temaDTemp.setIdTema(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getIdTema());
                        temaDTemp.setNombreTema(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getNombreTema());
                      
//                        temaDTemp.setPlanActivo(alumno.getPropuestaList().get(i).getPlanActivo());
                        temaDTemp.setVersionPlanActivo(alumno.getPropuestaList().get(i).getVersionPlan());
                        if (alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getNombreTema().length() > 64) {
                            temaDTemp.setNombreCorto(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getNombreTema().substring(0, 65) + "...");
                        } else {
                            temaDTemp.setNombreCorto(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getNombreTema());
                        }
                        if (alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema() != null) {
                            if (alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema() == 0) {
                                temaDTemp.setEstadoTema("VIGENTE");
                            }
                            if (alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema() == 1) {
                                temaDTemp.setEstadoTema("TITULADO");
                            }
                            if (alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema() == 2) {
                                temaDTemp.setEstadoTema("PRORROGADO");
                            }
                            if (alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema() == 3) {
                                temaDTemp.setEstadoTema("CADUCO");
                            }
                            if (alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema() == 4) {
                                temaDTemp.setEstadoTema("EN PROCESO EXAMEN");
                            }
                            if (alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema() == 5) {
                                temaDTemp.setEstadoTema("MAGISTER");
                            }
                            if (alumno.getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema() == 6) {
                                temaDTemp.setEstadoTema("VIGENTE");
                            }
                        }
                        List<ProfePropuesta> listaProfes = alumno.getPropuestaList().get(i).getProfePropuestaList();
                        for (int j = 0; j < listaProfes.size(); j++) {
                            if (listaProfes.get(j).getRolGuia() == 0) {
                                temaDTemp.setGuia(listaProfes.get(j).getProfesor());
                            }
                        }
                        temaDatos.add(temaDTemp);
                    }
                }
            }
        } else {
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage("Error", "No se ingresó Alumno"));
        }
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

    public List<PropuestaDatos> getPropDatos() {
        return propDatos;
    }

    public void setPropDatos(List<PropuestaDatos> propDatos) {
        this.propDatos = propDatos;
    }

    public List<TemaDatos> getTemaDatos() {
        return temaDatos;
    }

    public void setTemaDatos(List<TemaDatos> temaDatos) {
        this.temaDatos = temaDatos;
    }

    public PlanEstudio getPlanActivo() {
        Integer id_plan = alumno.getIdPlanActivo();
        
        List<PlanEstudio> planesasd = alumno.getPlanes();
//        List<PlanEstudio> planesasd = Util.planFacade.findAll();
        if (id_plan != null) {
            
            for (int i = 0; i < planesasd.size(); i++) {
                if (planesasd.get(i).getId() == Long.parseLong(id_plan + "")) {
                    
                    return planesasd.get(i);
                }
            }
        }
        return null;
    }

    public String getNombrePlan(Integer id_plan, Integer version_plan) {
        List<PlanEstudio> planes = planFacade.findAll();
        PlanEstudio plan = null;
        Versionplan version = null;

        for (int i = 0; i < planes.size(); i++) {
            if (planes.get(i).getId().equals(Long.parseLong(id_plan + ""))) {
                List<Versionplan> versiones = planes.get(i).getVersionplanList();
                for (int j = 0; j < versiones.size(); j++) {
                    Versionplan versionPlan = versiones.get(j);
                    
                    if (versionPlan.getVersion() == Long.parseLong(version_plan + "")) {
                        
                        plan = planes.get(i);
                        version = versionPlan;
                    }
                }
            }
        }
        
        if (plan == null) {
            return "";
        }
        return plan.getCodigo() + version.getAnio() + " " + version_plan + " " + plan.getCarreraId().getNombre();
    }

    public String getAnioPlan(Integer id_plan, Integer version_plan){
        try {
            SMUtil util = new SMUtil();

            PlanEstudio plan = planFacade.findById(id_plan);

            for (Versionplan version : plan.getVersionplanList()) {
                
                if (version.getVersion() == Long.parseLong(version_plan + "")) {
                    return plan.getCodigo() + " " + version.getAnio().toString() + "." + version.getVersion() + " " + plan.getCarreraId().getNombre();
                }
            }
        }catch(Exception e){
            
        }

        return "Ninguno";
//        List<PlanEstudio> planes = planFacade.findAll();
//        PlanEstudio plan = null;
//        System.out.println("Id: " + id_plan);   
//        System.out.println("VE: " + version_plan);
//        for (int i = 0; i < planes.size(); i++) {
//            System.out.println("=======");
//
//            System.out.println(planes.get(i).getId());
//            System.out.println(id_plan);
//            System.out.println("=======");
//            if (planes.get(i).getId().equals(Long.parseLong(id_plan + ""))) {
//                List<Versionplan> versiones = planes.get(i).getVersionplanList();
//                for (int j = 0; j < versiones.size(); j++) {
//                    Versionplan versionPlan = versiones.get(j);
//                    System.out.println("Comparando: " + versionPlan.getVersion() + " con " + Long.parseLong(version_plan + ""));
//                    if (versionPlan.getVersion() == Long.parseLong(version_plan + "")) {
//                        System.out.println("existeeeee");
//                        return versionPlan.getAnio();
//                    }
//                }
//            }
//        }
//        return -1;
    }
}
