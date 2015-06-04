package managedbeans2.propuestas;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import clases.PropuestaDatos;
import entities.ProfePropuesta;
import entities.Propuesta;
import entities.Semestre;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "propuestasIndexMB")
@RequestScoped
public class PropuestasIndexMB {
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    
    private String semestreActual;
    private List<Propuesta> propuestas;
    private List<PropuestaDatos> propDatos, propDatosFiltrados;

    /**
     * Creates a new instance of PropuestasSemActualMB
     */
    public PropuestasIndexMB() {
    }
    
    @PostConstruct
    public void init() {
        if(semestreActualFacade.findAll().isEmpty())
            semestreActual = "";
        else
            semestreActual = semestreActualFacade.findAll().get(0).getSemestreActual();
        
        propDatos = new ArrayList();
        List <Semestre> sems = semestreFacade.findById(semestreActual);
        Semestre sem;
        if (!sems.isEmpty()){
            sem = sems.get(0);
        } else {
            return;
        }
        propuestas = propuestaFacade.findBySemestre(sem);
        PropuestaDatos propDTemp;
        for (Propuesta propuesta : propuestas) {
            propDTemp = new PropuestaDatos();
            propDTemp.setIdPropuesta(Integer.toString(propuesta.getIdPropuesta()));
            propDTemp.setAlumno(propuesta.getRutAlumno());
            propDTemp.setNombrePropuesta(propuesta.getNombrePropuesta());
            if (propuesta.getNombrePropuesta().length() > 64) {
                propDTemp.setNombreCorto(propuesta.getNombrePropuesta().substring(0, 65) + "...");
            } else {
                propDTemp.setNombreCorto(propuesta.getNombrePropuesta());
            }
            List<ProfePropuesta> listaProfes = propuesta.getProfePropuestaList();
            for (ProfePropuesta listaProfe : listaProfes) {
                if (listaProfe.getRolGuia() == 0) {
                    propDTemp.setGuia(listaProfe.getProfesor());
                } else {
                    propDTemp.setCoGuia(listaProfe.getProfesor());
                }
            }
            propDatos.add(propDTemp);
        }
    }

    public List<PropuestaDatos> getPropDatosFiltrados() {
        return propDatosFiltrados;
    }

    public void setPropDatosFiltrados(List<PropuestaDatos> propDatosFiltrados) {
        this.propDatosFiltrados = propDatosFiltrados;
    }

    public String getSemestreActual() {
        return semestreActual;
    }

    public void setSemestreActual(String semestreActual) {
        this.semestreActual = semestreActual;
    }

    public List<Propuesta> getPropuestas() {
        return propuestas;
    }

    public void setPropuestas(List<Propuesta> propuestas) {
        this.propuestas = propuestas;
    }

    public List<PropuestaDatos> getPropDatos() {
        return propDatos;
    }

    public void setPropDatos(List<PropuestaDatos> propDatos) {
        this.propDatos = propDatos;
    }
    
}
