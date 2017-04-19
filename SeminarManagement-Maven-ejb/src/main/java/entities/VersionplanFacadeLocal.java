/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author ariel-linux
 */
@Local
public interface VersionplanFacadeLocal {

    void create(Versionplan versionPlan);

    void edit(Versionplan versionPlan);

    void remove(Versionplan versionPlan);

    Versionplan find(Object id);

    List<Versionplan> findAll();

    List<Versionplan> findRange(int[] range);

    int count();
    
}
