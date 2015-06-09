/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.AsociacionPlanEstudioAlumno;
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
public class asociacionFacade extends AbstractFacade<AsociacionPlanEstudioAlumno> implements asociacionFacadeLocal {
    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public asociacionFacade() {
        super(AsociacionPlanEstudioAlumno.class);
    }
    
    @Override
    public void eliminarPlanAlumno(Integer codigo_plan, String rut_alumno){
        Query query;
        query = em.createNativeQuery("delete from planes_alumno where plan_id='" + codigo_plan + "';");
        query.executeUpdate();
    }
    
}
