package sessionbeans;

import entities.CarreraAlumno;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author stateless
 */
@Stateless
public class CarreraAlumnoFacade extends AbstractFacade<CarreraAlumno> implements CarreraAlumnoFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CarreraAlumnoFacade() {
        super(CarreraAlumno.class);
    }
    
}
