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
    
    private SemestreActual semestreActual;
    private List<ComisionRevisora> revisoras;
    private List<ComisionCorrectora> correctoras;
    private List<Tema> temas;
    private List<PlanEstudio> planes;
    private List<Profesor> profesoresJC;
    private List<Profesor> profesoresPH;
    private ArrayList<Integer> cuentaPorPlanJC;
    private ArrayList<Integer> cuentaPorPlanPH;
    private ArrayList<Integer> cuentaPorPlanTotal;
    private ArrayList<ArrayList<Integer>> cuentaPorProfeJC;
    private ArrayList<ArrayList<Integer>> cuentaPorProfePH;
    private ArrayList<Integer> cuentaTotalPorProfeJC;
    private ArrayList<Integer> cuentaTotalPorProfePH;

    public ReportesMB() {
    }
    
    @PostConstruct
    public void init(){
        List<SemestreActual> sems = semActFacade.findAll();
        if ( !sems.isEmpty() ){
            semestreActual = sems.get(0);
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
        temas = temasFacade.findByEstado(4);
    }
    
    // todos los contadores están en arraylist de enteros
    // por ejemplo cuentaPorProfeJC[3][5] contiene la cantidad de memoristas para el profe 3 en el plan 5
    // pame los quería por plan no por jornada *
    public void findTemasMemoristas(){ 
        planes = planesFacade.findAll();
        
        cuentaPorPlanJC = new ArrayList<>(Collections.nCopies(planes.size() + 1, 0));
        cuentaPorPlanPH = new ArrayList<>(Collections.nCopies(planes.size() + 1, 0));
        cuentaPorPlanTotal = new ArrayList<>(Collections.nCopies(planes.size() + 1, 0));
        
        profesoresJC = profesorFacade.findByContrato(1);
        cuentaPorProfeJC = new ArrayList<>();
        cuentaTotalPorProfeJC = new ArrayList<>(Collections.nCopies(profesoresJC.size(), 0));
        
        profesoresPH = profesorFacade.findByContrato(0);
        cuentaPorProfePH = new ArrayList<>();
        cuentaTotalPorProfePH = new ArrayList<>(Collections.nCopies(profesoresPH.size(), 0));
        
        contarMemoristasProfesores(profesoresJC, cuentaPorProfeJC, 1);
        contarMemoristasProfesores(profesoresPH, cuentaPorProfePH, 0);
    }
    
    private void contarMemoristasProfesores(List<Profesor> profesores, ArrayList<ArrayList<Integer>> contadoresProfesor, Integer tipoContrato) {
        for (int c = 0; c < profesores.size(); c++) {
            ArrayList<Integer> cantGuiados = new ArrayList<>( Collections.nCopies(planes.size(), 0));
            List<ProfePropuesta> profeProps = profesores.get(c).getProfePropuestaList();
            for (ProfePropuesta profePro : profeProps) {
                if ( !(profePro.getRolGuia() == 0) ) //si no es guia, lo salta
                    continue;
                
                Propuesta propuesta = profePro.getPropuesta();
                if ( propuesta.getIdRevisora() != null){
                    ComisionRevisora comRev = propuesta.getIdRevisora();
                    if ( comRev.getIdTema() != null){
                        Tema tema = comRev.getIdTema();
                        if ( tema.getEstadoTema() != null ){
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
                                                
                                                if (tipoContrato == 1) {
                                                    cuentaPorPlanJC.set(i, cuentaPorPlanJC.get(i) + 1);
                                                    cuentaPorPlanJC.set(cuentaPorPlanJC.size() -1  ,
                                                            cuentaPorPlanJC.get(cuentaPorPlanJC.size() -1) + 1);
                                                    cuentaTotalPorProfeJC.set(c , cuentaTotalPorProfeJC.get(c) + 1);
                                                } else if (tipoContrato == 0) {
                                                    cuentaPorPlanPH.set(i, cuentaPorPlanPH.get(i) + 1);
                                                    cuentaPorPlanPH.set(cuentaPorPlanPH.size() -1  ,
                                                            cuentaPorPlanPH.get(cuentaPorPlanPH.size() -1) + 1);
                                                    cuentaTotalPorProfePH.set(c , cuentaTotalPorProfePH.get(c) + 1);
                                                }
                                                cuentaPorPlanTotal.set(i, cuentaPorPlanTotal.get(i) + 1);
                                                cuentaPorPlanTotal.set(cuentaPorPlanTotal.size() -1  ,
                                                            cuentaPorPlanTotal.get(cuentaPorPlanTotal.size() -1) + 1);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (tipoContrato == 1)
                cuentaPorProfeJC.add(cantGuiados);
            else if (tipoContrato == 0)
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

    public ArrayList<ArrayList<Integer>> getCuentaPorProfeJC() {
        return cuentaPorProfeJC;
    }

    public void setCuentaPorProfeJC(ArrayList<ArrayList<Integer>> cuentaPorProfeJC) {
        this.cuentaPorProfeJC = cuentaPorProfeJC;
    }

    public ArrayList<ArrayList<Integer>> getCuentaPorProfePH() {
        return cuentaPorProfePH;
    }

    public void setCuentaPorProfePH(ArrayList<ArrayList<Integer>> cuentaPorProfePH) {
        this.cuentaPorProfePH = cuentaPorProfePH;
    }

    public ArrayList<Integer> getCuentaPorPlanJC() {
        return cuentaPorPlanJC;
    }

    public void setCuentaPorPlanJC(ArrayList<Integer> cuentaPorPlanJC) {
        this.cuentaPorPlanJC = cuentaPorPlanJC;
    }

    public ArrayList<Integer> getCuentaPorPlanPH() {
        return cuentaPorPlanPH;
    }

    public void setCuentaPorPlanPH(ArrayList<Integer> cuentaPorPlanPH) {
        this.cuentaPorPlanPH = cuentaPorPlanPH;
    }

    public ArrayList<Integer> getCuentaPorPlanTotal() {
        return cuentaPorPlanTotal;
    }

    public void setCuentaPorPlanTotal(ArrayList<Integer> cuentaPorPlanTotal) {
        this.cuentaPorPlanTotal = cuentaPorPlanTotal;
    }

    public ArrayList<Integer> getCuentaTotalPorProfeJC() {
        return cuentaTotalPorProfeJC;
    }

    public void setCuentaTotalPorProfeJC(ArrayList<Integer> cuentaTotalPorProfeJC) {
        this.cuentaTotalPorProfeJC = cuentaTotalPorProfeJC;
    }

    public ArrayList<Integer> getCuentaTotalPorProfePH() {
        return cuentaTotalPorProfePH;
    }

    public void setCuentaTotalPorProfePH(ArrayList<Integer> cuentaTotalPorProfePH) {
        this.cuentaTotalPorProfePH = cuentaTotalPorProfePH;
    }
}
