import entities.PlanEstudio;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.Dependent;
import sessionbeans.PlanestudioFacadeLocal;

/**
 *
 * @author giovanni
 */
@Named(value = "planesEstudioMB")
@Dependent
public class planesEstudioMB {

    @EJB
    PlanestudioFacadeLocal planesEstudioFacade;
    
    public planesEstudioMB() {
    }
    
    public List<PlanEstudio> getPlanesEstudio() {
        return planesEstudioFacade.findAll();
    }
    
}
