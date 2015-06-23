package sessionbeans;

import entities.Versionplan;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author miguel
 */
@Local
public interface VersionplanFacadeLocal {

    void create(Versionplan versionplan);

    void edit(Versionplan versionplan);

    void remove(Versionplan versionplan);

    Versionplan find(Object id);

    List<Versionplan> findAll();

    List<Versionplan> findRange(int[] range);

    int count();
    
    List<Versionplan> findByVersion(Integer version);
    
}
