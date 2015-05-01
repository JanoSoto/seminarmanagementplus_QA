/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sessionbeans;

import entities.SemestreActual;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Eduardo
 */
@Local
public interface SemestreActualFacadeLocal {

    void create(SemestreActual semestreActual);

    void edit(SemestreActual semestreActual);

    void remove(SemestreActual semestreActual);

    SemestreActual find(Object id);

    List<SemestreActual> findAll();

    List<SemestreActual> findRange(int[] range);

    int count();
    
}
