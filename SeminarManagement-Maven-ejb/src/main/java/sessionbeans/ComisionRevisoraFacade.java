package sessionbeans;

import entities.ComisionRevisora;
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
public class ComisionRevisoraFacade extends AbstractFacade<ComisionRevisora> implements ComisionRevisoraFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ComisionRevisoraFacade() {
        super(ComisionRevisora.class);
    }
    
    @Override
    public List<ComisionRevisora> findById(Integer idRevisora) {
        Query query;
        query = em.createNamedQuery("ComisionRevisora.findByIdRevisora")
                .setParameter("idRevisora", idRevisora);
        return query.getResultList();
 
    }

    @Override
    public List<ComisionRevisora> findBySemestre(String semestre){
        Query q;
        q = em.createNamedQuery("ComisionRevisora.findBySemestre")
                .setParameter("semestre", semestre);
        return q.getResultList();
    }
    
    @Override
    public List<ComisionRevisora> findByTema(Integer id_tema){
        Query q;
        q = em.createNamedQuery("ComisionRevisora.findBySemestre")
                .setParameter("tema", id_tema);
        return q.getResultList();
    }
}
