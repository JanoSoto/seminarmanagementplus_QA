/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.AsociacionPlanEstudioAlumno;
import entities.PlanEstudio;
import entities.Versionplan;
import java.util.ArrayList;
import java.util.List;
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
    public List<AsociacionPlanEstudioAlumno> findAll() {
//        Query query;
//        query = em.createNamedQuery("AsociacionPlanEstudioAlumno.findAll");
        Query query;
        query = em.createNamedQuery("AsociacionPlanEstudioAlumno.findAll");
        return query.getResultList();
    }

    @Override
    public void eliminarPlanAlumno(Integer codigo_plan, String rut_alumno, Integer version_plan) {
        Query query;
        query = em.createNativeQuery("delete from planes_alumno where plan_id='" + codigo_plan + "' and version_plan='" + version_plan + "';");

        query.executeUpdate();
    }

    @Override
    public void agregarAsociacion(String rutAlumno, Long plan_id, Integer version_plan) {
        Query query;
        query = em.createNativeQuery("insert into planes_alumno (alumno_id, plan_id, activo, version_plan) values ('" + rutAlumno + "', '" + plan_id + "', 'true', '" + version_plan + "');");

        query.executeUpdate();
    }

    @Override
    public List<Integer> getVersionesPlan(String rut_alumno, Long id_plan) {
        Query query;
        query = em.createNativeQuery("select version_plan from planes_alumno where plan_id='" + id_plan + "' and alumno_id='" + rut_alumno + "';");

        return query.getResultList();
    }

}
