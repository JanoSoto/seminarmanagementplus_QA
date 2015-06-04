package sessionbeans;

import entities.Carrera;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author stateless
 */
@Local
public interface CarreraFacadeLocal {

    void create(Carrera carrera);

    void edit(Carrera carrera);

    void remove(Carrera carrera);

    Carrera find(Object id);

    List<Carrera> findAll();

    List<Carrera> findRange(int[] range);

    int count();
    
}
