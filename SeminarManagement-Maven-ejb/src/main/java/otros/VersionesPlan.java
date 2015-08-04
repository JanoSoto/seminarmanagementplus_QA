/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package otros;

import entities.Versionplan;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author ariel-linux
 */
@Stateless
public class VersionesPlan implements VersionesPlanLocal {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;
    
    @Override
    public List<Versionplan> findByIdPlan(long idPlan){
        Query query = em.createNamedQuery("Versionplan.findByIdPlan").setParameter("idPlan", idPlan);
        try{
            return (List<Versionplan>) query.getResultList();
        }catch(NoResultException e){
            return new ArrayList<>();
        }
    }

    @Override
    public List<Versionplan> findByPlanificado(boolean planificado) {
        Query query = em.createNamedQuery("Versionplan.findByPlanificado").setParameter("planificado", planificado);
        try{
            return (List<Versionplan>) query.getResultList();
        }
        catch(NoResultException e){
            return new ArrayList();
        }
    }

    @Override
    public int findMaxCorrelativo() {
        Query query = em.createNamedQuery("Versionplan.findMaxCorrelativo");
        try{
            return (int) query.getSingleResult();
        }
        catch(NoResultException e){
            return -1;
        }
    }
    
    @Override
    public List<Versionplan> findAll(){
        Query query = em.createNamedQuery("Versionplan.findAll");
        try{
            return (List<Versionplan>) query.getResultList();
        }catch(NoResultException e){
            return new ArrayList<>();
        }
    }
}
