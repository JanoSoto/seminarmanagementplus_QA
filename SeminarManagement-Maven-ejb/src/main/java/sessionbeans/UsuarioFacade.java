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
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author miguel
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
    public Usuario findByUid(String uid) {
        Query query = em.createNamedQuery("Usuario.findByUid").setParameter("uid", uid);
        try{
            return (Usuario) query.getSingleResult();
        }
        catch(NoResultException e){
            return null;
        }
    }
    
    @Override
    public Boolean existeByRut(String rut) {
        Query query = em.createNamedQuery("Usuario.findByRutUsuario").setParameter("rutUsuario", rut);
        try{
            return !query.getResultList().isEmpty();
        }
        catch(NoResultException e){
            return null;
        }
    }
    
    @Override
    public List<Usuario> findByRut(String rut) {
        Query query = em.createNamedQuery("Usuario.findByRutUsuario").setParameter("rutUsuario", rut);
        try{
            return query.getResultList();
        }
        catch(NoResultException e){
            return null;
        }
    }
    
    
    @Override
    public boolean existe(String uid){
        Query query;
        query = em.createNamedQuery("Usuario.findByUid")
                .setParameter("uid", uid);
        return !query.getResultList().isEmpty();
    }
    
}
