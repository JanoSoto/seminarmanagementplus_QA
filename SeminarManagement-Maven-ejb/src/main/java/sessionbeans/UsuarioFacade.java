/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Usuario;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Elagos
 */
@Stateless
public class UsuarioFacade extends AbstractFacade<Usuario> implements UsuarioFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsuarioFacade() {
        super(Usuario.class);
    }
    
    @Override
    public List<Usuario> findByUsername(String username) {
        Query query;
        query = em.createNamedQuery("Usuario.findByUsername")
                .setParameter("username", username);
       return query.getResultList();
    }
    
    @Override
    public boolean existe(String username) {
        Query query;
        query = em.createNamedQuery("Usuario.findByUsername")
                .setParameter("username", username);
        return !query.getResultList().isEmpty();
    }
    
}
