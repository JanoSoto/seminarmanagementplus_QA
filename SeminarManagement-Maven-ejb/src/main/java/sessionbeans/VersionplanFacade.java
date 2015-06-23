package sessionbeans;

import entities.Versionplan;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author miguel
 */
@Stateless
public class VersionplanFacade extends AbstractFacade<Versionplan> implements VersionplanFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public VersionplanFacade() {
        super(Versionplan.class);
    }

    @Override
    public List<Versionplan> findByVersion(Integer version) {
        Query q = em.createNamedQuery("Versionplan.findByVersion")
                .setParameter("version", version);
        return q.getResultList();
    }
    
}
