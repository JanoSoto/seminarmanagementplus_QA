/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sessionbeans;

import entities.ComisionRevisora;
import entities.Tema;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Eduardo
 */
@Local
public interface ComisionRevisoraFacadeLocal {

    void create(ComisionRevisora comisionRevisora);

    void edit(ComisionRevisora comisionRevisora);

    void remove(ComisionRevisora comisionRevisora);

    ComisionRevisora find(Object id);

    List<ComisionRevisora> findAll();

    List<ComisionRevisora> findRange(int[] range);

    int count();

    public List<ComisionRevisora> findById(Integer idRevisora);
    
}
