package managedbeans2.reportes;

import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.PlanEstudio;
import entities.ProfePropuesta;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
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
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;
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
    SemestreFacadeLocal semFacade;
    
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
    
    @EJB
    PropuestaFacadeLocal propuestaFacade;
    
    private SemestreActual semestreActual;
    private Semestre semestre;
    private List<ComisionRevisora> revisoras;
    private List<Propuesta> propuestas;
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
    private List<String> planesToDisplay;
    private List<String> profesJCToDisplay;
    private List<ProfeDatosTablaMemoristas> profesoresJCDatos;
    private List<ProfeDatosTablaMemoristas> profesoresPHDatos;

    private List<String> totalesJCToDisplay;
    private List<String> totalesPHToDisplay;
    private List<String> totalesToDisplay;
    
    public ReportesMB() {
    }
    
    @PostConstruct
    public void init(){
        List<SemestreActual> sems = semActFacade.findAll();
        if ( !sems.isEmpty() ){
            semestreActual = sems.get(0);
            semestre = semFacade.findOneById(semestreActual.getSemestreActual());
        }
    }
    
    public void findPropuestasSemestre() {
        // propuestas con comision, eliminando las por acuerdo de consejo
        /* Descartado por cambio en los requerimientos (ahora se necesitan todas las propuestas)
        revisoras = revisoraFacade.findBySemestre(semestreActual.getSemestreActual());
        List<ComisionRevisora> porAcuerdo = new ArrayList<>();
        for (ComisionRevisora revisora : revisoras) {
            if ( revisora.getTipoRevision() == 2)
                porAcuerdo.add(revisora);
        }
        revisoras.removeAll(porAcuerdo);
        */
        if (semestre == null)
            return;
        
        propuestas = semestre.getPropuestaList();
        List<Propuesta> propASacar = new ArrayList<>();
        
        for (Propuesta propuesta : propuestas) {
            if ( propuesta.getIdRevisora() != null ){
                if ( propuesta.getIdRevisora().getTipoRevision() == 2 || // consejo
                        propuesta.getIdRevisora().getTipoRevision() == 1 ){ // seminario
                    propASacar.add(propuesta);
                }
            }
        }
        propuestas.removeAll(propASacar);
        
        //for (Propuesta propuesta : propuestas) {
        //    revisoras.add(propuesta.getIdRevisora());
        //}
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
        
        totalesJCToDisplay = new ArrayList<>();
        totalesPHToDisplay = new ArrayList<>();
        totalesToDisplay = new ArrayList<>();
        planesToDisplay = new ArrayList<>();
        for( int i=0; i<planes.size(); i++){
            if (cuentaPorPlanTotal.get(i) > 0){
                planesToDisplay.add(planes.get(i).getCodigo().toString());
                totalesJCToDisplay.add(cuentaPorPlanJC.get(i).toString());
                totalesPHToDisplay.add(cuentaPorPlanPH.get(i).toString());
                totalesToDisplay.add(cuentaPorPlanTotal.get(i).toString());
            }
        }
        
        totalesJCToDisplay.add(cuentaPorPlanJC.get(cuentaPorPlanJC.size()-1).toString());
        totalesPHToDisplay.add(cuentaPorPlanPH.get(cuentaPorPlanPH.size()-1).toString());
        totalesToDisplay.add(cuentaPorPlanTotal.get(cuentaPorPlanTotal.size()-1).toString());
        
        profesoresJCDatos = new ArrayList<>();

        for (int i = 0; i < profesoresJC.size(); i++) {
            if (cuentaTotalPorProfeJC.get(i) > 0){

                ProfeDatosTablaMemoristas p = new ProfeDatosTablaMemoristas(
                        profesoresJC.get(i).getNombreProfesor()+" "+profesoresJC.get(i).getApellidoProfesor(), 
                        cuentaTotalPorProfeJC.get(i));
                List<Integer> cantAluPorPlan = new ArrayList<>();
                for (int j = 0; j < cuentaPorProfeJC.get(i).size(); j++) {
                    if (cuentaPorPlanTotal.get(j) > 0){
                        cantAluPorPlan.add(cuentaPorProfeJC.get(i).get(j));
                    }
                }
                cantAluPorPlan.add(cuentaTotalPorProfeJC.get(i));
                p.setCantAlumnosPorPlan(cantAluPorPlan);
                profesoresJCDatos.add(p);
            }
        }
        
        profesoresPHDatos = new ArrayList<>();

        for (int i = 0; i < profesoresPH.size(); i++) {
            if (cuentaTotalPorProfePH.get(i) > 0){

                ProfeDatosTablaMemoristas p = new ProfeDatosTablaMemoristas(
                        profesoresPH.get(i).getNombreProfesor()+" "+profesoresPH.get(i).getApellidoProfesor(), 
                        cuentaTotalPorProfePH.get(i));
                List<Integer> cantAluPorPlan = new ArrayList<>();
                for (int j = 0; j < cuentaPorProfePH.get(i).size(); j++) {
                    if (cuentaPorPlanTotal.get(j) > 0){
                        cantAluPorPlan.add(cuentaPorProfePH.get(i).get(j));
                    }
                }
                cantAluPorPlan.add(cuentaTotalPorProfePH.get(i));
                p.setCantAlumnosPorPlan(cantAluPorPlan);
                profesoresPHDatos.add(p);
            }
        }
        
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
                                    ( tema.getEstadoTema() == 2 ) ){  // prorrogado
                                    
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

    public List<String> getPlanesToDisplay() {
        return planesToDisplay;
    }

    public void setPlanesToDisplay(List<String> planesToDisplay) {
        this.planesToDisplay = planesToDisplay;
    }

    public List<String> getProfesJCToDisplay() {
        return profesJCToDisplay;
    }

    public void setProfesJCToDisplay(List<String> profesJCToDisplay) {
        this.profesJCToDisplay = profesJCToDisplay;
    }

    public List<ProfeDatosTablaMemoristas> getProfesoresJCDatos() {
        return profesoresJCDatos;
    }

    public void setProfesoresJCDatos(List<ProfeDatosTablaMemoristas> profesoresJCDatos) {
        this.profesoresJCDatos = profesoresJCDatos;
    }

    public List<ProfeDatosTablaMemoristas> getProfesoresPHDatos() {
        return profesoresPHDatos;
    }

    public void setProfesoresPHDatos(List<ProfeDatosTablaMemoristas> profesoresPHDatos) {
        this.profesoresPHDatos = profesoresPHDatos;
    }

    public List<String> getTotalesJCToDisplay() {
        return totalesJCToDisplay;
    }

    public void setTotalesJCToDisplay(List<String> totalesJCToDisplay) {
        this.totalesJCToDisplay = totalesJCToDisplay;
    }

    public List<String> getTotalesPHToDisplay() {
        return totalesPHToDisplay;
    }

    public void setTotalesPHToDisplay(List<String> totalesPHToDisplay) {
        this.totalesPHToDisplay = totalesPHToDisplay;
    }

    public List<String> getTotalesToDisplay() {
        return totalesToDisplay;
    }

    public void setTotalesToDisplay(List<String> totalesToDisplay) {
        this.totalesToDisplay = totalesToDisplay;
    }
    
    
    
    public class ProfeDatosTablaMemoristas {
        private String nombre;
        private List<Integer> cantAlumnosPorPlan;
        private Integer totalAlumnosMemoristas;

        public ProfeDatosTablaMemoristas(String nombre, Integer totalAlumnosMemoristas) {
            this.nombre = nombre;
            this.totalAlumnosMemoristas = totalAlumnosMemoristas;
        }

        public String getNombre() {
            return nombre;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public List<Integer> getCantAlumnosPorPlan() {
            return cantAlumnosPorPlan;
        }

        public void setCantAlumnosPorPlan(List<Integer> cantAlumnosPorPlan) {
            this.cantAlumnosPorPlan = cantAlumnosPorPlan;
        }

        public Integer getTotalAlumnosMemoristas() {
            return totalAlumnosMemoristas;
        }

        public void setTotalAlumnosMemoristas(Integer totalAlumnosMemoristas) {
            this.totalAlumnosMemoristas = totalAlumnosMemoristas;
        }
        
        
    }

    public List<Propuesta> getPropuestas() {
        return propuestas;
    }

    public void setPropuestas(List<Propuesta> propuestas) {
        this.propuestas = propuestas;
    }
        
}
