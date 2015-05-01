/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.UsuarioTipo;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Elagos
 */
@Local
public interface UsuarioTipoFacadeLocal {

    void create(UsuarioTipo usuarioTipo);

    void edit(UsuarioTipo usuarioTipo);

    void remove(UsuarioTipo usuarioTipo);

    UsuarioTipo find(Object id);

    List<UsuarioTipo> findAll();

    List<UsuarioTipo> findRange(int[] range);

    int count();
    
}
