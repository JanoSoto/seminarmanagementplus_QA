/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sessionbeans;

import entities.Tema;
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
public class TemaFacade extends AbstractFacade<Tema> implements TemaFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TemaFacade() {
        super(Tema.class);
    }
    
    @Override
    public List<Tema> findByName(String nombreTema) {
        Query query;
        query = em.createNamedQuery("Tema.findByNombreTema")
                .setParameter("nombreTema", nombreTema);
       return query.getResultList();
    }
    
    @Override
    public List<Tema> findById(Integer idTema) {
        Query query;
        query = em.createNamedQuery("Tema.findByIdTema")
                .setParameter("idTema", idTema);
        return query.getResultList();
    }

    @Override
    public List<Tema> findByEstado(Integer estadoTema) {
        Query query;
        query = em.createNamedQuery("Tema.findByEstadoTema")
                .setParameter("estadoTema", estadoTema);
        return query.getResultList();
    }

    @Override
    public List<Tema> findTema(String q) {
        q = q.toUpperCase();
        Query query;
        query = em.createNamedQuery("Tema.findTema")
                .setParameter("nombreTema", "%"+q+"%");
       return query.getResultList();
    }
}
