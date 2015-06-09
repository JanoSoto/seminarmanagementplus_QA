/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.PlanEstudio;
import java.util.List;
import javax.ejb.Local;
import javax.persistence.Query;

/**
 *
 * @author miguel
 */
@Local
public interface asociacionFacadeLocal {

    public void eliminarPlanAlumno(Integer codigo_plan, String rut_alumno);
    
}
