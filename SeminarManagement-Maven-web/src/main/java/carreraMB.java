/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import entities.Carrera;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.Dependent;
import sessionbeans.CarreraFacadeLocal;

/**
 *
 * @author giovanni
 */
@Named(value = "carreraMB")
@Dependent
public class carreraMB {

    @EJB
    CarreraFacadeLocal carreraFacade;
    
    public carreraMB() {
    }
    
    public List<Carrera> getCarreras() {
        return carreraFacade.findAll();
    }
    
}
