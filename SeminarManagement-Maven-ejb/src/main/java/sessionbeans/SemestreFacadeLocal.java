package sessionbeans;

import entities.Semestre;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Eduardo
 */
@Local
public interface SemestreFacadeLocal {

    void create(Semestre semestre);

    void edit(Semestre semestre);

    void remove(Semestre semestre);

    Semestre find(Object id);

    List<Semestre> findAll();

    List<Semestre> findRange(int[] range);

    int count();

    public List<Semestre> findById(String semestre);
    
    public Semestre findOneById(String semestre);
}
