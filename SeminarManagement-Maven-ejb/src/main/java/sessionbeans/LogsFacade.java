/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Logs;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author miguel
 */
@Stateless
public class LogsFacade extends AbstractFacade<Logs> implements LogsFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public LogsFacade() {
        super(Logs.class);
    }
    
}
