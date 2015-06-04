/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Planestudio;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author miguel
 */
@Local
public interface PlanestudioFacadeLocal {

    void create(Planestudio planestudio);

    void edit(Planestudio planestudio);

    void remove(Planestudio planestudio);

    Planestudio find(Object id);

    List<Planestudio> findAll();

    List<Planestudio> findRange(int[] range);

    int count();
    
}
