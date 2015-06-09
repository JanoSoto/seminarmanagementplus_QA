package managedbeans2.reportes;

import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.SemestreActual;
import entities.Tema;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import sessionbeans.ComisionCorrectoraFacadeLocal;
import sessionbeans.ComisionRevisoraFacadeLocal;
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
    
    SemestreActual semestreActual;
    List<ComisionRevisora> revisoras;
    List<ComisionCorrectora> correctoras;
    List<Tema> temas;

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
}
