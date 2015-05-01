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
@Table(name = "tema")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tema.findAll", query = "SELECT t FROM Tema t"),
    @NamedQuery(name = "Tema.findByNombreTema", query = "SELECT t FROM Tema t WHERE t.nombreTema = :nombreTema"),
    @NamedQuery(name = "Tema.findByFechaTema", query = "SELECT t FROM Tema t WHERE t.fechaTema = :fechaTema"),
    @NamedQuery(name = "Tema.findByEstadoTema", query = "SELECT t FROM Tema t WHERE t.estadoTema = :estadoTema"),
    @NamedQuery(name = "Tema.findByIdTema", query = "SELECT t FROM Tema t WHERE t.idTema = :idTema"),
    @NamedQuery(name = "Tema.findTema", query = "SELECT t FROM Tema t WHERE t.nombreTema LIKE :nombreTema")})
public class Tema implements Serializable {
    private static final long serialVersionUID = 1L;
    @Size(max = 400)
    @Column(name = "nombre_tema")
    private String nombreTema;
    @Size(max = 15)
    @Column(name = "fecha_tema")
    private String fechaTema;
    @Column(name = "estado_tema")
    private Integer estadoTema;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tema")
    private Integer idTema;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTema")
    private List<ComisionCorrectora> comisionCorrectoraList;
    @JoinColumn(name = "id_semestre", referencedColumnName = "id_semestre")
    @ManyToOne(optional = false)
    private Semestre idSemestre;
    @JoinColumn(name = "id_revisora", referencedColumnName = "id_revisora")
    @ManyToOne(optional = false)
    private ComisionRevisora idRevisora;
    @JoinColumn(name = "id_correctora", referencedColumnName = "id_correctora")
    @ManyToOne
    private ComisionCorrectora idCorrectora;
    @OneToMany(mappedBy = "idTema")
    private List<ComisionRevisora> comisionRevisoraList;

    public Tema() {
        comisionCorrectoraList = new ArrayList();
        comisionRevisoraList = new ArrayList();
    }

    public Tema(Integer idTema) {
        comisionCorrectoraList = new ArrayList();
        comisionRevisoraList = new ArrayList();
        this.idTema = idTema;
    }
    
    public void add(ComisionCorrectora object){
        comisionCorrectoraList.add(object);
    }
    
    public void add(ComisionRevisora object){
        comisionRevisoraList.add(object);
    }

    public String getNombreTema() {
        return nombreTema;
    }

    public void setNombreTema(String nombreTema) {
        this.nombreTema = nombreTema;
    }

    public String getFechaTema() {
        return fechaTema;
    }

    public void setFechaTema(String fechaTema) {
        this.fechaTema = fechaTema;
    }

    public Integer getEstadoTema() {
        return estadoTema;
    }

    public void setEstadoTema(Integer estadoTema) {
        this.estadoTema = estadoTema;
    }

    public Integer getIdTema() {
        return idTema;
    }

    public void setIdTema(Integer idTema) {
        this.idTema = idTema;
    }

    @XmlTransient
    public List<ComisionCorrectora> getComisionCorrectoraList() {
        return comisionCorrectoraList;
    }

    public void setComisionCorrectoraList(List<ComisionCorrectora> comisionCorrectoraList) {
        this.comisionCorrectoraList = comisionCorrectoraList;
    }

    public Semestre getIdSemestre() {
        return idSemestre;
    }

    public void setIdSemestre(Semestre idSemestre) {
        this.idSemestre = idSemestre;
    }

    public ComisionRevisora getIdRevisora() {
        return idRevisora;
    }

    public void setIdRevisora(ComisionRevisora idRevisora) {
        this.idRevisora = idRevisora;
    }

    public ComisionCorrectora getIdCorrectora() {
        return idCorrectora;
    }

    public void setIdCorrectora(ComisionCorrectora idCorrectora) {
        this.idCorrectora = idCorrectora;
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
        hash += (idTema != null ? idTema.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tema)) {
            return false;
        }
        Tema other = (Tema) object;
        if ((this.idTema == null && other.idTema != null) || (this.idTema != null && !this.idTema.equals(other.idTema))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Tema[ idTema=" + idTema + " ]";
    }
    
}
