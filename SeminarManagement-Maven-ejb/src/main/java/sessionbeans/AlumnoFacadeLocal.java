package sessionbeans;

import entities.Alumno;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Eduardo
 */
@Local
public interface AlumnoFacadeLocal {

    void create(Alumno alumno);

    void edit(Alumno alumno);

    void remove(Alumno alumno);

    Alumno find(Object id);

    List<Alumno> findAll();

    List<Alumno> findRange(int[] range);

    int count();

    public List<Alumno> findByRut(String rutAlumno);

    public boolean existe(String rutAlumno);

    List<Alumno> findAlumno(String q);

    
}
