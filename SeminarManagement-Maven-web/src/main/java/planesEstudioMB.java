/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import entities.Carrera;
import entities.PlanEstudio;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.Dependent;
import sessionbeans.CarreraFacadeLocal;
import sessionbeans.PlanestudioFacadeLocal;

/**
 *
 * @author giovanni
 */
@Named(value = "planesEstudioMB")
@Dependent
public class planesEstudioMB {

    @EJB
    PlanestudioFacadeLocal planesEstudioFacade;
    
    public planesEstudioMB() {
    }
    
    public List<PlanEstudio> getPlanesEstudio() {
        return planesEstudioFacade.findAll();
    }
    
}
