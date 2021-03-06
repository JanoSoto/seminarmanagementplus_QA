/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package otros;

import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author jano
 */
@Local
public interface AsignaturasLocal {
    public List<Asignatura> getAllProfesorAsignatura();
    public List<Asignatura> findByCarreraAndPlan( long version);
    public Asignatura findByCodigoAsgAndIdVersion(String codigo, long idVersion);
    public List<Integer> findNivelesByPlan(long idVersionPlan);
    public List<Asignatura> findByNivelAndPlan(int nivel, long versionPlan);
    public List<Asignatura> findByAsignaturaAsignada(String rutProfesor, int anio, int semestre);
    public List<Asignatura> getEspejos(String alias);   
    public List<Asignatura> findByVersionPlanificado();
}