package managedbeans2.reportes;

import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.PlanEstudio;
import entities.ProfePropuesta;
import entities.Profesor;
import entities.Propuesta;
import entities.SemestreActual;
import entities.Tema;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import sessionbeans.ComisionCorrectoraFacadeLocal;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.PlanestudioFacade;
import sessionbeans.PlanestudioFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author stateless
 */
@Named(value = "reportesMB")
@SessionScoped
public class ReportesMB implements Serializable {
    @EJB
    SemestreActualFacadeLocal semActFacade;
    
    @EJB
    ComisionRevisoraFacadeLocal revisoraFacade;
    
    @EJB
    ComisionCorrectoraFacadeLocal correctoraFacade;
    
    @EJB
    TemaFacadeLocal temasFacade;
    
    @EJB
    PlanestudioFacadeLocal planesFacade;
    
    @EJB
    ProfesorFacadeLocal profesorFacade;
    
    SemestreActual semestreActual;
    List<ComisionRevisora> revisoras;
    List<ComisionCorrectora> correctoras;
    List<Tema> temas;
    List<PlanEstudio> planes;
    private List<Profesor> profesoresJC;
    private List<Profesor> profesoresPH;
    private ArrayList<Integer> cuentaPorPlan;
    private ArrayList<Object> cuentaPorProfeJC;
    private ArrayList<Object> cuentaPorProfePH;

    public ReportesMB() {
    }
    
    @PostConstruct
    public void init(){
        List<SemestreActual> sems = semActFacade.findAll();
        //System.out.println("init");
        if ( !sems.isEmpty() ){

            semestreActual = sems.get(0);

            // se asume que los reportes son para temas y propuestas con comision
            //correctoras = correctoraFacade.findBySemestre(semestreActual.getSemestreActual());
            //revisoras = revisoraFacade.findBySemestre(semestreActual.getSemestreActual());
        }
    }
    
    public void findPropuestasSemestre() {
        // propuestas con comision, eliminando las por acuerdo de consejo
        revisoras = revisoraFacade.findBySemestre(semestreActual.getSemestreActual());
        List<ComisionRevisora> porAcuerdo = new ArrayList<>();
        for (ComisionRevisora revisora : revisoras) {
            if ( revisora.getTipoRevision() == 2)
                porAcuerdo.add(revisora);
        }
        revisoras.removeAll(porAcuerdo);
    }
    
    public void findTemasSemestre() {
        // temas en estado borrador entregado
        temas = temasFacade.findByEstado(4);
        //correctoras = correctoraFacade.findBySemestre(semestreActual.getSemestreActual());
        //correctoras = correctoraFacade.
    }
    
    // todos los contadores están en arraylist de enteros
    // por ejemplo cuentaPorProfeJC[3][5] contiene la cantidad de memoristas para el profe 3 en el plan 5
    // pame los quería por plan no por jornada *
    public void findTemasMemoristas(){ 
        planes = planesFacade.findAll();
        
        cuentaPorPlan = new ArrayList<>(Collections.nCopies(planes.size(), 0));
        
        profesoresJC = profesorFacade.findByContrato(0);
        cuentaPorProfeJC = new ArrayList<>();
        
        profesoresPH = profesorFacade.findByContrato(1);
        cuentaPorProfePH = new ArrayList<>();
        
        for (Profesor profe : profesoresJC) {
            List<Integer> cantGuiados = new ArrayList<>( Collections.nCopies(planes.size(), 0));
            List<ProfePropuesta> profeProps = profe.getProfePropuestaList();
            for (ProfePropuesta profePro : profeProps) {
                if ( !(profePro.getRolGuia() == 0) ) //si no es guia, lo salta
                    continue;
                
                Propuesta propuesta = profePro.getPropuesta();
                if ( propuesta.getIdRevisora() != null){
                    ComisionRevisora comRev = propuesta.getIdRevisora();
                    if ( comRev.getIdTema() != null){
                        Tema tema = comRev.getIdTema();
                        if ( ( tema.getEstadoTema() == 0 ) ||     //vigente
                                ( tema.getEstadoTema() == 2 ) ||  // prorrogado
                                ( tema.getEstadoTema() == 4 ) ||  // en proceso de examen
                                ( tema.getEstadoTema() == 6 ) ){  // vigente con borrador final
                            
                            if ( propuesta.getRutAlumno() != null ){
                                if ( propuesta.getRutAlumno().getPlanActivo() != null ){
                                    PlanEstudio planActivoAlumno = propuesta.getRutAlumno().getPlanActivo();
                                    for (int i = 0; i < planes.size(); i++) {
                                        if ( planes.get(i).equals(planActivoAlumno) ){
                                            cantGuiados.set(i, cantGuiados.get(i) + 1);
                                            cuentaPorPlan.set(i, cuentaPorPlan.get(i) + 1);
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
            cuentaPorProfeJC.add(cantGuiados);
        }
        
        for (Profesor profe : profesoresPH) {
            List<Integer> cantGuiados = new ArrayList<>( Collections.nCopies(planes.size(), 0));
            List<ProfePropuesta> profeProps = profe.getProfePropuestaList();
            for (ProfePropuesta profePro : profeProps) {
                if ( !(profePro.getRolGuia() == 0) ) //si no es guia, lo salta
                    continue;
                
                Propuesta propuesta = profePro.getPropuesta();
                if ( propuesta.getIdRevisora() != null){
                    ComisionRevisora comRev = propuesta.getIdRevisora();
                    if ( comRev.getIdTema() != null){
                        Tema tema = comRev.getIdTema();
                        if ( ( tema.getEstadoTema() == 0 ) ||     //vigente
                                ( tema.getEstadoTema() == 2 ) ||  // prorrogado
                                ( tema.getEstadoTema() == 4 ) ||  // en proceso de examen
                                ( tema.getEstadoTema() == 6 ) ){  // vigente con borrador final
                            
                            if ( propuesta.getRutAlumno() != null ){
                                if ( propuesta.getRutAlumno().getPlanActivo() != null ){
                                    PlanEstudio planActivoAlumno = propuesta.getRutAlumno().getPlanActivo();
                                    for (int i = 0; i < planes.size(); i++) {
                                        if ( planes.get(i).equals(planActivoAlumno) ){
                                            cantGuiados.set(i, cantGuiados.get(i) + 1);
                                            cuentaPorPlan.set(i, cuentaPorPlan.get(i) + 1);
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
            cuentaPorProfePH.add(cantGuiados);
        }
    }

    public SemestreActual getSemestreActual() {
        return semestreActual;
    }

    public void setSemestreActual(SemestreActual semestreActual) {
        this.semestreActual = semestreActual;
    }

    public List<ComisionRevisora> getRevisoras() {
        return revisoras;
    }

    public void setRevisoras(List<ComisionRevisora> revisoras) {
        this.revisoras = revisoras;
    }

    public List<ComisionCorrectora> getCorrectoras() {
        return correctoras;
    }

    public void setCorrectoras(List<ComisionCorrectora> correctoras) {
        this.correctoras = correctoras;
    }

    public List<Tema> getTemas() {
        return temas;
    }

    public void setTemas(List<Tema> temas) {
        this.temas = temas;
    }

    public List<PlanEstudio> getPlanes() {
        return planes;
    }

    public void setPlanes(List<PlanEstudio> planes) {
        this.planes = planes;
    }

    public List<Profesor> getProfesoresJC() {
        return profesoresJC;
    }

    public void setProfesoresJC(List<Profesor> profesoresJC) {
        this.profesoresJC = profesoresJC;
    }

    public List<Profesor> getProfesoresPH() {
        return profesoresPH;
    }

    public void setProfesoresPH(List<Profesor> profesoresPH) {
        this.profesoresPH = profesoresPH;
    }

    public ArrayList<Integer> getCuentaPorPlan() {
        return cuentaPorPlan;
    }

    public void setCuentaPorPlan(ArrayList<Integer> cuentaPorPlan) {
        this.cuentaPorPlan = cuentaPorPlan;
    }

    public ArrayList<Object> getCuentaPorProfeJC() {
        return cuentaPorProfeJC;
    }

    public void setCuentaPorProfeJC(ArrayList<Object> cuentaPorProfeJC) {
        this.cuentaPorProfeJC = cuentaPorProfeJC;
    }

    public ArrayList<Object> getCuentaPorProfePH() {
        return cuentaPorProfePH;
    }

    public void setCuentaPorProfePH(ArrayList<Object> cuentaPorProfePH) {
        this.cuentaPorProfePH = cuentaPorProfePH;
    }
    
    
}
