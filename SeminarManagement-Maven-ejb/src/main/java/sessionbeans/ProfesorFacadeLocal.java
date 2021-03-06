package sessionbeans;

import entities.Profesor;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Eduardo
 */
@Local
public interface ProfesorFacadeLocal {

    void create(Profesor profesor);

    void edit(Profesor profesor);

    void remove(Profesor profesor);

    Profesor find(Object id);

    List<Profesor> findAll();

    List<Profesor> findRange(int[] range);

    int count();

    public List<Profesor> findByRut(String rutProfesor);

    public boolean existe(String rutProfesor);

    List<Profesor> findProfesor(String q);
    
    List<Profesor> findByContrato(Integer tipoContrato);
    
}
