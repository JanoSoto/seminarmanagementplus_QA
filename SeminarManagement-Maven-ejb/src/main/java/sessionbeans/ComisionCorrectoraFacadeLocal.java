package sessionbeans;

import entities.ComisionCorrectora;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Eduardo
 */
@Local
public interface ComisionCorrectoraFacadeLocal {

    void create(ComisionCorrectora comisionCorrectora);

    void edit(ComisionCorrectora comisionCorrectora);

    void remove(ComisionCorrectora comisionCorrectora);

    ComisionCorrectora find(Object id);

    List<ComisionCorrectora> findAll();

    List<ComisionCorrectora> findRange(int[] range);

    int count();

    public List<ComisionCorrectora> findById(Integer idComCorr);
    
    public List<ComisionCorrectora> findBySemestre(String semestre);
}
