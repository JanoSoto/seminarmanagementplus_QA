/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import entities.PlanEstudio;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import sessionbeans.PlanestudioFacadeLocal;

/**
 *
 * @author giovanni
 */
@Named(value = "planEstudioMB")
@RequestScoped
public class planEstudioMB {

    @EJB
    PlanestudioFacadeLocal planEstudioFacade;
    
    public planEstudioMB() {
    }
    
    public List<PlanEstudio> getPlanesEstudio(){
        return planEstudioFacade.findAll();
    }
   
}
