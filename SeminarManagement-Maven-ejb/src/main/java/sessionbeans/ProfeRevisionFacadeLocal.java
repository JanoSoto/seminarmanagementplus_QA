/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sessionbeans;

import entities.ProfeRevision;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Eduardo
 */
@Local
public interface ProfeRevisionFacadeLocal {

    void create(ProfeRevision profeRevision);

    void edit(ProfeRevision profeRevision);

    void remove(ProfeRevision profeRevision);

    ProfeRevision find(Object id);

    List<ProfeRevision> findAll();

    List<ProfeRevision> findRange(int[] range);

    int count();
    
}
