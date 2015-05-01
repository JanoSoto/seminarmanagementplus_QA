/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Propuesta;
import entities.Semestre;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author David
 */
@Local
public interface PropuestaFacadeLocal {

    void create(Propuesta propuesta);

    void edit(Propuesta propuesta);

    void remove(Propuesta propuesta);

    Propuesta find(Object id);

    List<Propuesta> findAll();

    List<Propuesta> findRange(int[] range);

    int count();

    List<Propuesta> findByName(String nombrePropuesta);

    List<Propuesta> findById(Integer idPropuesta);

    List<Propuesta> findBySemestre(Semestre idSemestre);

    List<Propuesta> findPropuesta(String q);
}
