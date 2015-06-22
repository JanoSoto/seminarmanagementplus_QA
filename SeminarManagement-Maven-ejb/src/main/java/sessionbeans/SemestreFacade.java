package sessionbeans;

import entities.Semestre;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Eduardo
 */
@Stateless
public class SemestreFacade extends AbstractFacade<Semestre> implements SemestreFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SemestreFacade() {
        super(Semestre.class);
    }

    @Override
    public List<Semestre> findById(String idSemestre) {
        Query query;
        query = em.createNamedQuery("Semestre.findByIdSemestre")
                .setParameter("idSemestre", idSemestre);
        return query.getResultList();
    }
    
    @Override
    public Semestre findOneById(String semestre){
        Query q = em.createNamedQuery("Semestre.findOneById")
                .setParameter("semestre", semestre);
        List<Semestre> sems = q.getResultList();
        if (sems.isEmpty())
            return null;
        else
            return sems.get(0);
    }
}
