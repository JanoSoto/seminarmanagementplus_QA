/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Planestudio;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author miguel
 */
@Stateless
public class PlanestudioFacade extends AbstractFacade<Planestudio> implements PlanestudioFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PlanestudioFacade() {
        super(Planestudio.class);
    }
    
}
