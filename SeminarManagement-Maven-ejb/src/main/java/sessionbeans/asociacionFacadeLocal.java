/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.AsociacionPlanEstudioAlumno;
import entities.PlanEstudio;
import entities.Versionplan;
import java.util.List;
import javax.ejb.Local;
import javax.persistence.Query;

/**
 *
 * @author miguel
 */
@Local
public interface asociacionFacadeLocal {
    
    public List<AsociacionPlanEstudioAlumno> findAll();

    public void eliminarPlanAlumno(Integer codigo_plan, String rut_alumno, Integer version_plan);

    public void agregarAsociacion(String rutAlumno, Long id, Integer version_plan);
    
    public List<Integer> getVersionesPlan(String rut, Long id_plan);
    
}
