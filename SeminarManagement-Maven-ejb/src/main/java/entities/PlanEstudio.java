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
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author miguel
 */
@Entity
@Table(name = "planestudio")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PlanEstudio.findAll", query = "SELECT p FROM PlanEstudio p"),
    @NamedQuery(name = "PlanEstudio.findById", query = "SELECT p FROM PlanEstudio p WHERE p.id = :id"),
    @NamedQuery(name = "PlanEstudio.findByCodigo", query = "SELECT p FROM PlanEstudio p WHERE p.codigo = :codigo"),
    @NamedQuery(name = "PlanEstudio.findByJornada", query = "SELECT p FROM PlanEstudio p WHERE p.jornada = :jornada")})
public class PlanEstudio implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "codigo")
    private Integer codigo;

    @Column(name = "jornada")
    private Integer jornada;

    @JoinColumn(name = "carrera_id", referencedColumnName = "id")
    @ManyToOne
    private Carrera carreraId;

    @OneToMany(mappedBy = "planestudioId", cascade = CascadeType.PERSIST)
    private List<Versionplan> versionplanList;

    public void addVersion(Versionplan version) {
        if (versionplanList == null) {
            versionplanList = new ArrayList<>();
        }
        versionplanList.add(version);
    }

    @OneToMany(mappedBy = "planEstudio")
    private List<AsociacionPlanEstudioAlumno> asociacionPlanEstudioAlumno;

    public List<AsociacionPlanEstudioAlumno> getAsociacionPlanEstudioAlumno() {
        return asociacionPlanEstudioAlumno;
    }

    public void setAsociacionPlanEstudioAlumno(List<AsociacionPlanEstudioAlumno> asociacionPlanEstudioAlumno) {
        this.asociacionPlanEstudioAlumno = asociacionPlanEstudioAlumno;
    }

    public PlanEstudio() {
    }

    public PlanEstudio(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public Integer getJornada() {
        return jornada;
    }

    public void setJornada(Integer jornada) {
        this.jornada = jornada;
    }

    public Carrera getCarreraId() {
        return carreraId;
    }

    public void setCarreraId(Carrera carreraId) {
        this.carreraId = carreraId;
    }

    public Carrera getCarrera() {
        return carreraId;
    }

    public void setCarrera(Carrera carreraId) {
        this.carreraId = carreraId;
    }

    public List<Versionplan> getVersionplanList() {
        return versionplanList;
    }

    public void setVersionplanList(List<Versionplan> versionplanList) {
        this.versionplanList = versionplanList;
    }

    public String versionesAsString() {
        String salida = "";
        for (Versionplan versionplan : versionplanList) {
            salida += versionplan.getId() + " ";
        }
        return salida;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PlanEstudio)) {
            return false;
        }
        PlanEstudio other = (PlanEstudio) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Planestudio[ id=" + id + " ]";
    }

    public String getJornadaAsString() {
        return this.jornada == 0 ? "Diurno" : "Vespertino";
    }

}
