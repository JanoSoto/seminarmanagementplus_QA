package managedbeans2;

import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.SemestreActual;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import sessionbeans.ComisionCorrectoraFacadeLocal;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;

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
    
    SemestreActual semestreActual;
    List<ComisionRevisora> revisoras;
    List<ComisionCorrectora> correctoras;

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
    
    public void findPropuestasSemestre() {//System.out.println("propuestas");
        revisoras = revisoraFacade.findBySemestre(semestreActual.getSemestreActual());
    }
    
    public void findTemasSemestre() {
        correctoras = correctoraFacade.findBySemestre(semestreActual.getSemestreActual());
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
    
    
}
