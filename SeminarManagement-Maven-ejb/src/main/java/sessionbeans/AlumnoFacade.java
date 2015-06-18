package sessionbeans;

import entities.Alumno;
import entities.AsociacionPlanEstudioAlumno;
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
public class AlumnoFacade extends AbstractFacade<Alumno> implements AlumnoFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AlumnoFacade() {
        super(Alumno.class);
    }
    
    @Override
    public List<Alumno> findByRut(String rutAlumno) {
        Query query;
        query = em.createNamedQuery("Alumno.findByRutAlumno")
                .setParameter("rutAlumno", rutAlumno);
       return query.getResultList();
    }
    
    @Override
    public boolean existe(String rutAlumno) {
        Query query;
        query = em.createNamedQuery("Alumno.findByRutAlumno")
                .setParameter("rutAlumno", rutAlumno);
        return !query.getResultList().isEmpty(); //Retornamos si el rut ya está ingresado
    }

    @Override
    public List<Alumno> findAlumno(String q) {
        q = q.toUpperCase();
        Query query;
        query = em.createNamedQuery("Alumno.findAlumno")
                .setParameter("rutAlumno", "%"+q+"%");
       return query.getResultList();
    }
}
