/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans;

import clases.ProfeEstadistica;
import entities.Profesor;
import entities.Semestre;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.bean.ManagedBean;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.SemestreFacadeLocal;

/**
 *
 * @author David
 */
@ManagedBean(name ="estadisticasProfesMB")
@RequestScoped
public class EstadisticasProfesMB {
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    
    private List<ProfeEstadistica> profes;
    
    public EstadisticasProfesMB() {
    }
    
    @PostConstruct
    public void init() {
        List<Profesor> profesores = profesorFacade.findAll();
        List<Semestre> semestres = semestreFacade.findAll();
        
        profes = new ArrayList();
        
        int semestresConProp = 0;
        for(int i=0;i<semestres.size();i++)
            if(semestres.get(i).getPropuestaList()!=null)
                semestresConProp++;
        
        ProfeEstadistica profeETemp;
        for(int i=0;i<profesores.size();i++){
            profeETemp = new ProfeEstadistica(profesores.get(i),semestresConProp);
            profes.add(profeETemp);
        }
    }

    public List<ProfeEstadistica> getProfes() {
        return profes;
    }

    public void setProfes(List<ProfeEstadistica> profes) {
        this.profes = profes;
    }
    
}
