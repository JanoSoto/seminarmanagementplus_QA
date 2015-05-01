/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.ProfePropuesta;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author David
 */
@Local
public interface ProfePropuestaFacadeLocal {

    void create(ProfePropuesta profePropuesta);

    void edit(ProfePropuesta profePropuesta);

    void remove(ProfePropuesta profePropuesta);

    ProfePropuesta find(Object id);

    List<ProfePropuesta> findAll();

    List<ProfePropuesta> findRange(int[] range);

    int count();
    
}
