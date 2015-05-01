/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.ProfeCorreccion;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author David
 */
@Local
public interface ProfeCorreccionFacadeLocal {

    void create(ProfeCorreccion profeCorreccion);

    void edit(ProfeCorreccion profeCorreccion);

    void remove(ProfeCorreccion profeCorreccion);

    ProfeCorreccion find(Object id);

    List<ProfeCorreccion> findAll();

    List<ProfeCorreccion> findRange(int[] range);

    int count();
    
}
