/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sessionbeans;

import entities.ComisionCorrectora;
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
public class ComisionCorrectoraFacade extends AbstractFacade<ComisionCorrectora> implements ComisionCorrectoraFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ComisionCorrectoraFacade() {
        super(ComisionCorrectora.class);
    }
    
    @Override
    public List<ComisionCorrectora> findById(Integer idComCorr) {
        Query query;
        query = em.createNamedQuery("ComisionCorrectora.findByIdCorrectora")
                .setParameter("idCorrectora", idComCorr);
        return query.getResultList();
    }
    
}
