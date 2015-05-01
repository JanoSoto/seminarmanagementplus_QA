package managedbeans2.propuestas;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import clases.PropuestaDatos;
import entities.ProfePropuesta;
import entities.Propuesta;
import java.util.ArrayList;
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
        propuestas = propuestaFacade.findBySemestre(semestreFacade.findById(semestreActual).get(0));
        PropuestaDatos propDTemp;
        for(int i=0;i<propuestas.size();i++){
            propDTemp = new PropuestaDatos();
            propDTemp.setIdPropuesta(Integer.toString(propuestas.get(i).getIdPropuesta()));
            propDTemp.setAlumno(propuestas.get(i).getRutAlumno());
            propDTemp.setNombrePropuesta(propuestas.get(i).getNombrePropuesta());
            if(propuestas.get(i).getNombrePropuesta().length()>64)
                propDTemp.setNombreCorto(propuestas.get(i).getNombrePropuesta().substring(0,65)+"...");
            else
                propDTemp.setNombreCorto(propuestas.get(i).getNombrePropuesta());
            List<ProfePropuesta> listaProfes = propuestas.get(i).getProfePropuestaList();
            for(int j=0;j<listaProfes.size();j++)
                if(listaProfes.get(j).getRolGuia()==0)
                    propDTemp.setGuia(listaProfes.get(j).getProfesor());
                else
                    propDTemp.setCoGuia(listaProfes.get(j).getProfesor());

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
