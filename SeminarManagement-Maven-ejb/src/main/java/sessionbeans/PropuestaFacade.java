package sessionbeans;

import entities.Propuesta;
import entities.Semestre;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author David
 */
@Stateless
public class PropuestaFacade extends AbstractFacade<Propuesta> implements PropuestaFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PropuestaFacade() {
        super(Propuesta.class);
    }

    @Override
    public List<Propuesta> findByName(String nombrePropuesta) {
        Query query;
        query = em.createNamedQuery("Propuesta.findByNombrePropuesta")
                .setParameter("nombrePropuesta", nombrePropuesta);
        return query.getResultList();
    }

    @Override
    public List<Propuesta> findById(Integer idPropuesta) {
        Query query;
        query = em.createNamedQuery("Propuesta.findByIdPropuesta")
                .setParameter("idPropuesta", idPropuesta);
        return query.getResultList();
    }

    @Override
    public List<Propuesta> findBySemestre(Semestre idSemestre) {
        Query query;
        query = em.createNamedQuery("Propuesta.findByIdSemestre")
                .setParameter("idSemestre", idSemestre);
        return query.getResultList();
    }

    @Override
    public List<Propuesta> findPropuesta(String q) {
        q = q.toUpperCase();
        Query query;
        query = em.createNamedQuery("Propuesta.findPropuesta")
                .setParameter("nombrePropuesta", "%"+q+"%");
       return query.getResultList();
    }
    
    @Override
    public Propuesta findOneById( Integer id ){
        Query q = em.createNamedQuery("Propuesta.findOneById")
                .setParameter("id", id);
        return (Propuesta) q.getSingleResult();
    }
}
