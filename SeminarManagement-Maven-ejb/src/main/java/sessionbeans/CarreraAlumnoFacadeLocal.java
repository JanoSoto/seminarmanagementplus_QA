package sessionbeans;

import entities.CarreraAlumno;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author stateless
 */
@Local
public interface CarreraAlumnoFacadeLocal {

    void create(CarreraAlumno carreraAlumno);

    void edit(CarreraAlumno carreraAlumno);

    void remove(CarreraAlumno carreraAlumno);

    CarreraAlumno find(Object id);

    List<CarreraAlumno> findAll();

    List<CarreraAlumno> findRange(int[] range);

    int count();
    
}
