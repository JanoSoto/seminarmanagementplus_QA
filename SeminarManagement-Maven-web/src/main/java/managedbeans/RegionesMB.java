/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans;

import entities.Comuna;
import entities.Provincia;
import entities.Region;
import entities.Usuario;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.event.ValueChangeEvent;
import javax.inject.Named;
import sessionbeans.ComunaFacadeLocal;
import sessionbeans.ProvinciaFacadeLocal;
import sessionbeans.RegionFacadeLocal;

/**
 *
 * @author Elagos
 */
@ManagedBean
@Named(value = "regionesMB")
@SessionScoped
public class RegionesMB implements Serializable{
    @EJB
    private ComunaFacadeLocal comunaFacade;
    @EJB
    private RegionFacadeLocal regionFacade;
    
    private List<Region> regiones;
    private List<Comuna> comunas;
    private Integer regionElegida;
    
    /**
     * Creates a new instance of RegionesMB
     */
    public RegionesMB() {
    }
    
    @PostConstruct
    public void init() {
        regiones = regionFacade.findAll();
    }
    
    public void buscaComunas(){
        comunas = comunaFacade.findByRegion(new Region(regionElegida));
    }
    
    public void buscaComunas(Region region){
        comunas = comunaFacade.findByRegion(region);
    }
    
    public List<Region> getRegiones() {
        return regiones;
    }

    public void setRegiones(List<Region> regiones) {
        this.regiones = regiones;
    }

    public List<Comuna> getComunas() {
        return comunas;
    }

    public void setComunas(List<Comuna> comunas) {
        this.comunas = comunas;
    }

    public Integer getRegionElegida() {
        return regionElegida;
    }

    public void setRegionElegida(Integer regionElegida) {
        this.regionElegida = regionElegida;
    }

}
