/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sessionbeans;

import entities.Profesor;
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
public class ProfesorFacade extends AbstractFacade<Profesor> implements ProfesorFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProfesorFacade() {
        super(Profesor.class);
    }
    
    @Override
    public List<Profesor> findByRut(String rutProfesor) {
        Query query;
        query = em.createNamedQuery("Profesor.findByRutProfesor")
                .setParameter("rutProfesor", rutProfesor);
       return query.getResultList();
    }
    
    @Override
    public boolean existe(String rutProfesor) {
        Query query;
        query = em.createNamedQuery("Profesor.findByRutProfesor")
                .setParameter("rutProfesor", rutProfesor);
        return !query.getResultList().isEmpty(); //Retornamos si el rut ya está ingresado
    }

    @Override
    public List<Profesor> findProfesor(String q) {
        q = q.toUpperCase();
        Query query;
        query = em.createNamedQuery("Profesor.findProfesor")
                .setParameter("rutProfesor", "%"+q+"%")
                .setParameter("nombreProfesor", "%"+q+"%")
                .setParameter("apellidoProfesor", "%"+q+"%");
       return query.getResultList();
    }
    
    
}
