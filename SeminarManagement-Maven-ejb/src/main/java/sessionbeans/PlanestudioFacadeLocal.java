/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.PlanEstudio;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author miguel
 */
@Local
public interface PlanestudioFacadeLocal {

    void create(PlanEstudio planestudio);

    void edit(PlanEstudio planestudio);

    void remove(PlanEstudio planestudio);

    PlanEstudio find(Object id);

    List<PlanEstudio> findAll();

    List<PlanEstudio> findRange(int[] range);

    int count();

    public PlanEstudio findById(Integer id);
    
}
