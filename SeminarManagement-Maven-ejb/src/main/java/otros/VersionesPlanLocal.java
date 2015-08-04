/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package otros;

import entities.Versionplan;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author ariel-linux
 */
@Local
public interface VersionesPlanLocal {
    public List<Versionplan> findByIdPlan(long idPlan);
    public List<Versionplan> findByPlanificado(boolean planificado);
    public int findMaxCorrelativo();
    public List<Versionplan> findAll();
}

