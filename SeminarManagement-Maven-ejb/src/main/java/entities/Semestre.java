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

/**
 *
 * @author Elagos
 */
@Entity
@Table(name = "semestre")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Semestre.findAll", query = "SELECT s FROM Semestre s"),
    @NamedQuery(name = "Semestre.findByIdSemestre", query = "SELECT s FROM Semestre s WHERE s.idSemestre = :idSemestre")})
public class Semestre implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 15)
    @Column(name = "id_semestre")
    private String idSemestre;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idSemestre")
    private List<ComisionCorrectora> comisionCorrectoraList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idSemestre")
    private List<Propuesta> propuestaList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idSemestre")
    private List<Tema> temaList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idSemestre")
    private List<ComisionRevisora> comisionRevisoraList;

    public Semestre() {
        comisionCorrectoraList = new ArrayList();
        propuestaList = new ArrayList();
        temaList = new ArrayList();
        comisionRevisoraList = new ArrayList();
    }

    public Semestre(String idSemestre) {
        comisionCorrectoraList = new ArrayList();
        propuestaList = new ArrayList();
        temaList = new ArrayList();
        comisionRevisoraList = new ArrayList();
        this.idSemestre = idSemestre;
    }
    
    public void add(ComisionCorrectora object){
        comisionCorrectoraList.add(object);
    }
    
    public void add(Propuesta object){
        propuestaList.add(object);
    }
    
    public void add(Tema object){
        temaList.add(object);
    }
    
    public void add(ComisionRevisora object){
        comisionRevisoraList.add(object);
    }    

    public String getIdSemestre() {
        return idSemestre;
    }

    public void setIdSemestre(String idSemestre) {
        this.idSemestre = idSemestre;
    }

    @XmlTransient
    public List<ComisionCorrectora> getComisionCorrectoraList() {
        return comisionCorrectoraList;
    }

    public void setComisionCorrectoraList(List<ComisionCorrectora> comisionCorrectoraList) {
        this.comisionCorrectoraList = comisionCorrectoraList;
    }

    @XmlTransient
    public List<Propuesta> getPropuestaList() {
        return propuestaList;
    }

    public void setPropuestaList(List<Propuesta> propuestaList) {
        this.propuestaList = propuestaList;
    }

    @XmlTransient
    public List<Tema> getTemaList() {
        return temaList;
    }

    public void setTemaList(List<Tema> temaList) {
        this.temaList = temaList;
    }

    @XmlTransient
    public List<ComisionRevisora> getComisionRevisoraList() {
        return comisionRevisoraList;
    }

    public void setComisionRevisoraList(List<ComisionRevisora> comisionRevisoraList) {
        this.comisionRevisoraList = comisionRevisoraList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idSemestre != null ? idSemestre.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Semestre)) {
            return false;
        }
        Semestre other = (Semestre) object;
        if ((this.idSemestre == null && other.idSemestre != null) || (this.idSemestre != null && !this.idSemestre.equals(other.idSemestre))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Semestre[ idSemestre=" + idSemestre + " ]";
    }
    
}
