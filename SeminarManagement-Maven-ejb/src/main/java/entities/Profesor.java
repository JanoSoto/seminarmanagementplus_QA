/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import Util.Util;

/**
 *
 * @author miguel
 */
@Entity
@Table(name = "profesor")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Profesor.findAll", query = "SELECT p FROM Profesor p"),
    @NamedQuery(name = "Profesor.findByContrato", query = "SELECT p FROM Profesor p WHERE p.contrato = :contrato"),
    @NamedQuery(name = "Profesor.findByTipoProfesor", query = "SELECT p FROM Profesor p WHERE p.tipoProfesor = :tipoProfesor"),
    @NamedQuery(name = "Profesor.findByJerarquiaCategoria", query = "SELECT p FROM Profesor p WHERE p.jerarquiaCategoria = :jerarquiaCategoria"),
    @NamedQuery(name = "Profesor.findByMaximoGuias", query = "SELECT p FROM Profesor p WHERE p.maximoGuias = :maximoGuias"),
    @NamedQuery(name = "Profesor.findByRutProfesor", query = "SELECT p FROM Profesor p WHERE p.rutProfesor = :rutProfesor"),
    @NamedQuery(name = "Profesor.findByEstaSeminar", query = "SELECT p FROM Profesor p WHERE p.estaSeminar = :estaSeminar"),
    @NamedQuery(name = "Profesor.findByPuedeGuiar", query = "SELECT p FROM Profesor p WHERE p.puedeGuiar = :puedeGuiar"),
    @NamedQuery(name = "Profesor.findByPuedeCorregir", query = "SELECT p FROM Profesor p WHERE p.puedeCorregir = :puedeCorregir"),
    @NamedQuery(name = "Profesor.findByAlias", query = "SELECT p FROM Profesor p WHERE p.alias = :alias")})
public class Profesor implements Serializable {
    private static final long serialVersionUID = 1L;
    @Column(name = "contrato")
    private Integer contrato;
    @Column(name = "tipo_profesor")
    private Integer tipoProfesor;
    @Column(name = "jerarquia_categoria")
    private Integer jerarquiaCategoria;
    @Column(name = "maximo_guias")
    private Integer maximoGuias;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "rut_profesor")
    private String rutProfesor;
    @Column(name = "esta_seminar")
    private Boolean estaSeminar;
    @Column(name = "puede_guiar")
    private Integer puedeGuiar;
    @Column(name = "puede_corregir")
    private Integer puedeCorregir;
    @Size(max = 30)
    @Column(name = "alias")
    private String alias;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "profesor")
    private List<ProfePropuesta> profePropuestaList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "profesor")
    private List<ProfeRevision> profeRevisionList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "profesor")
    private List<ProfeCorreccion> profeCorreccionList;

    public Profesor() {
        profePropuestaList = new ArrayList();
        profeRevisionList = new ArrayList();
        profeCorreccionList = new ArrayList();
    }

    public Profesor(String rutProfesor) {
        profePropuestaList = new ArrayList();
        profeRevisionList = new ArrayList();
        profeCorreccionList = new ArrayList();
        this.rutProfesor = rutProfesor;
    }

    public void add(ProfePropuesta object){
        profePropuestaList.add(object);
    }
    
    public void add(ProfeRevision object){
        profeRevisionList.add(object);
    }
    
    public void add(ProfeCorreccion object){
        profeCorreccionList.add(object);
    }

    public Integer getContrato() {
        return contrato;
    }

    public void setContrato(Integer contrato) {
        this.contrato = contrato;
    }

    public Integer getTipoProfesor() {
        return tipoProfesor;
    }

    public void setTipoProfesor(Integer tipoProfesor) {
        this.tipoProfesor = tipoProfesor;
    }

    public Integer getJerarquiaCategoria() {
        return jerarquiaCategoria;
    }

    public void setJerarquiaCategoria(Integer jerarquiaCategoria) {
        this.jerarquiaCategoria = jerarquiaCategoria;
    }

    public Integer getMaximoGuias() {
        return maximoGuias;
    }

    public void setMaximoGuias(Integer maximoGuias) {
        this.maximoGuias = maximoGuias;
    }

    public String getRutProfesor() {
        return rutProfesor;
    }

    public String getRutFormateadoProfesor() {
        return Util.formatearRut(rutProfesor);
    }

    public void setRutProfesor(String rutProfesor) {
        this.rutProfesor = rutProfesor;
    }
    
    @XmlTransient
    public List<ProfePropuesta> getProfePropuestaList() {
        return profePropuestaList;
    }
    
    public void setProfePropuestaList(List<ProfePropuesta> profePropuestaList) {
        this.profePropuestaList = profePropuestaList;
    }

    @XmlTransient
    public List<ProfeRevision> getProfeRevisionList() {
        return profeRevisionList;
    }
    
    public void setProfeRevisionList(List<ProfeRevision> profeRevisionList) {
        this.profeRevisionList = profeRevisionList;
    }

    @XmlTransient
    public List<ProfeCorreccion> getProfeCorreccionList() {
        return profeCorreccionList;
    }

    public void setProfeCorreccionList(List<ProfeCorreccion> profeCorreccionList) {
        this.profeCorreccionList = profeCorreccionList;
    }
    
    public Boolean getEstaSeminar() {
        return estaSeminar;
    }

    public void setEstaSeminar(Boolean estaSeminar) {
        this.estaSeminar = estaSeminar;
    }

    public Integer getPuedeGuiar() {
        return puedeGuiar;
    }

    public void setPuedeGuiar(Integer puedeGuiar) {
        this.puedeGuiar = puedeGuiar;
    }

    public Integer getPuedeCorregir() {
        return puedeCorregir;
    }

    public void setPuedeCorregir(Integer puedeCorregir) {
        this.puedeCorregir = puedeCorregir;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (rutProfesor != null ? rutProfesor.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Profesor)) {
            return false;
        }
        Profesor other = (Profesor) object;
        if ((this.rutProfesor == null && other.rutProfesor != null) || (this.rutProfesor != null && !this.rutProfesor.equals(other.rutProfesor))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Profesor[ rutProfesor=" + rutProfesor + " ]";
    }
    
}
