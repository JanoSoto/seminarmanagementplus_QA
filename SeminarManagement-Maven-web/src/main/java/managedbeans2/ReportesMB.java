package managedbeans2;

import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.Semestre;
import entities.SemestreActual;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.bean.ViewScoped;
import sessionbeans.ComisionCorrectoraFacadeLocal;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;

/**
 *
 * @author stateless
 */
@Named(value = "reportesMB")
@ViewScoped
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
        System.out.println("init");
        List<SemestreActual> sems = semActFacade.findAll();
        if (!sems.isEmpty()){
            System.out.println("no vacio");
            semestreActual = sems.get(0);
            System.out.println("sem act "+semestreActual.getSemestreActual());
            findPropuestasSemestre();
            findTemasSemestre();
        }
    }
    
    public void findPropuestasSemestre() {
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
