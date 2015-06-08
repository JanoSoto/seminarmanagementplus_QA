package sessionbeans;

import entities.ComisionRevisora;
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
    
    public List<ComisionRevisora> findBySemestre(String semestre);
}
