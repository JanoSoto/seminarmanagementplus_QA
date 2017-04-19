/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package otros;

import entities.Carrera;
import javax.ejb.Local;

@Local
public interface CarrerasLocal {
    public Carrera findByNombre(String nombre);
    //public Carrera findByCodigo(int codigo);
}