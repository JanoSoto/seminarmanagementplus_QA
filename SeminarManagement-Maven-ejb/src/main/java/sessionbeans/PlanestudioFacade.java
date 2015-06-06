/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.PlanEstudio;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author miguel
 */
@Stateless
public class PlanestudioFacade extends AbstractFacade<PlanEstudio> implements PlanestudioFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PlanestudioFacade() {
        super(PlanEstudio.class);
    }
    
    @Override
    public PlanEstudio findById(Integer id) {
        Query query;
        query = em.createNamedQuery("PlanEstudio.findById")
                .setParameter("id", id);
       return (PlanEstudio) query.getSingleResult();
    }
    
}
