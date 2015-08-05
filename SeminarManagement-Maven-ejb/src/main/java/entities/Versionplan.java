package entities;

import java.io.Serializable;
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
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author miguel
 */
@Entity
@Table(name = "versionplan")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Versionplan.findAll", query = "SELECT v FROM Versionplan v"),
    @NamedQuery(name = "Versionplan.findById", query = "SELECT v FROM Versionplan v WHERE v.id = :id"),
    @NamedQuery(name = "Versionplan.findByVersion", query = "SELECT v FROM Versionplan v WHERE v.version = :version"),
    @NamedQuery(name = "Versionplan.findByAnio", query = "SELECT v FROM Versionplan v WHERE v.anio = :anio"),
    @NamedQuery(name = "Versionplan.findByIdPlan", query = "SELECT vp FROM Versionplan vp WHERE vp.id = :idPlan"),
    @NamedQuery(name = "Versionplan.findByPlanificado", query = "SELECT vp FROM Versionplan vp WHERE vp.planificado = :planificado"),
    @NamedQuery(name = "Versionplan.findMaxCorrelativo", query = "SELECT MAX(vp.correlativo) FROM Versionplan vp"),})
public class Versionplan implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "version")
    private Integer version;
    @Column(name = "anio")
    private Integer anio;
    @JoinColumn(name = "planestudio_id", referencedColumnName = "id")
    @ManyToOne
    private PlanEstudio planestudioId;

    private int resolucion;
    private int anio_resolucion;
    private boolean planificado;
    private int correlativo;

    public int getCorrelativo() {
        return correlativo;
    }

    public void setCorrelativo(int correlativo) {
        this.correlativo = correlativo;
    }

    public int getResolucion() {
        return resolucion;
    }

    public void setResolucion(int resolucion) {
        this.resolucion = resolucion;
    }

    public int getAnio_resolucion() {
        return anio_resolucion;
    }

    public void setAnio_resolucion(int anio_resolucion) {
        this.anio_resolucion = anio_resolucion;
    }

    public boolean isPlanificado() {
        return planificado;
    }

    public void setPlanificado(boolean planificado) {
        this.planificado = planificado;
    }

    public Versionplan() {
    }

    public Versionplan(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Integer getAnio() {
        return anio;
    }

    public void setAnio(Integer anio) {
        this.anio = anio;
    }

    public PlanEstudio getPlanestudioId() {
        return planestudioId;
    }

    public PlanEstudio getPlanestudio() {
        return planestudioId;
    }

    public void setPlanestudioId(PlanEstudio planestudioId) {
        this.planestudioId = planestudioId;
    }

    public void setPlanestudio(PlanEstudio planestudioId) {
        this.planestudioId = planestudioId;
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
        if (!(object instanceof Versionplan)) {
            return false;
        }
        Versionplan other = (Versionplan) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Versionplan[ id=" + id + " ]";
    }

}
