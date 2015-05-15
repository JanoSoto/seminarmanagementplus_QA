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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Elagos
 */
@Entity
@Table(name = "comision_revisora")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ComisionRevisora.findAll", query = "SELECT c FROM ComisionRevisora c"),
    @NamedQuery(name = "ComisionRevisora.findByFechaRevision", query = "SELECT c FROM ComisionRevisora c WHERE c.fechaRevision = :fechaRevision"),
    @NamedQuery(name = "ComisionRevisora.findByFechaEntregaRevision", query = "SELECT c FROM ComisionRevisora c WHERE c.fechaEntregaRevision = :fechaEntregaRevision"),
    @NamedQuery(name = "ComisionRevisora.findByTipoRevision", query = "SELECT c FROM ComisionRevisora c WHERE c.tipoRevision = :tipoRevision"),
    @NamedQuery(name = "ComisionRevisora.findByIdRevisora", query = "SELECT c FROM ComisionRevisora c WHERE c.idRevisora = :idRevisora")})
public class ComisionRevisora implements Serializable {
    private static final long serialVersionUID = 1L;
    @Size(max = 15)
    @Column(name = "fecha_revision")
    private String fechaRevision;
    @Size(max = 15)
    @Column(name = "fecha_entrega_revision")
    private String fechaEntregaRevision;
    @Column(name = "tipo_revision")
    private Integer tipoRevision;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_revisora")
    private Integer idRevisora;
    @OneToMany(mappedBy = "idRevisora")
    private List<Propuesta> propuestaList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "comisionRevisora")
    private List<ProfeRevision> profeRevisionList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idRevisora")
    private List<Tema> temaList;
    @JoinColumn(name = "id_tema", referencedColumnName = "id_tema")
    @ManyToOne
    private Tema idTema;
    @JoinColumn(name = "id_semestre", referencedColumnName = "id_semestre")
    @ManyToOne(optional = false)
    private Semestre idSemestre;
    @JoinColumn(name = "id_propuesta", referencedColumnName = "id_propuesta")
    @ManyToOne(optional = false)
    private Propuesta idPropuesta;

    public ComisionRevisora() {
        propuestaList = new ArrayList();
        profeRevisionList = new ArrayList();
        temaList = new ArrayList();
    }

    public ComisionRevisora(Integer idRevisora) {
        propuestaList = new ArrayList();
        profeRevisionList = new ArrayList();
        temaList = new ArrayList();
        this.idRevisora = idRevisora;
    }
    
    public void add(Propuesta object){
        propuestaList.add(object);
    }
    
    public void add(ProfeRevision object){
        profeRevisionList.add(object);
    }
    
    public void add(Tema object){
        temaList.add(object);
    }

    public String getFechaRevision() {
        return fechaRevision;
    }

    public void setFechaRevision(String fechaRevision) {
        this.fechaRevision = fechaRevision;
    }

    public Integer getTipoRevision() {
        return tipoRevision;
    }

    public void setTipoRevision(Integer tipoRevision) {
        this.tipoRevision = tipoRevision;
    }

    public Integer getIdRevisora() {
        return idRevisora;
    }

    public String getFechaEntregaRevision() {
        return fechaEntregaRevision;
    }

    public void setFechaEntregaRevision(String fechaEntregaRevision) {
        this.fechaEntregaRevision = fechaEntregaRevision;
    }
    
    

    public void setIdRevisora(Integer idRevisora) {
        this.idRevisora = idRevisora;
    }

    @XmlTransient
    public List<Propuesta> getPropuestaList() {
        return propuestaList;
    }

    public void setPropuestaList(List<Propuesta> propuestaList) {
        this.propuestaList = propuestaList;
    }

    @XmlTransient
    public List<ProfeRevision> getProfeRevisionList() {
        return profeRevisionList;
    }

    public void setProfeRevisionList(List<ProfeRevision> profeRevisionList) {
        this.profeRevisionList = profeRevisionList;
    }

    @XmlTransient
    public List<Tema> getTemaList() {
        return temaList;
    }

    public void setTemaList(List<Tema> temaList) {
        this.temaList = temaList;
    }

    public Tema getIdTema() {
        return idTema;
    }

    public void setIdTema(Tema idTema) {
        this.idTema = idTema;
    }

    public Semestre getIdSemestre() {
        return idSemestre;
    }

    public void setIdSemestre(Semestre idSemestre) {
        this.idSemestre = idSemestre;
    }

    public Propuesta getIdPropuesta() {
        return idPropuesta;
    }

    public void setIdPropuesta(Propuesta idPropuesta) {
        this.idPropuesta = idPropuesta;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRevisora != null ? idRevisora.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ComisionRevisora)) {
            return false;
        }
        ComisionRevisora other = (ComisionRevisora) object;
        if ((this.idRevisora == null && other.idRevisora != null) || (this.idRevisora != null && !this.idRevisora.equals(other.idRevisora))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ComisionRevisora[ idRevisora=" + idRevisora + " ]";
    }
    
}
