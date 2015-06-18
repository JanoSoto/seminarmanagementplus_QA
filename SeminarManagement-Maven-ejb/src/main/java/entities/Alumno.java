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
import java.math.BigInteger;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

/**
 *
 * @author miguel
 */
@Entity
@Table(name = "alumno")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Alumno.findAll", query = "SELECT a FROM Alumno a"),
    @NamedQuery(name = "Alumno.findByRutAlumno", query = "SELECT a FROM Alumno a WHERE a.rutAlumno = :rutAlumno"),
    @NamedQuery(name = "Alumno.findByIdPlanActivo", query = "SELECT a FROM Alumno a WHERE a.idPlanActivo = :idPlanActivo")})
public class Alumno implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "rut_alumno")
    private String rutAlumno;
     @Column(name = "id_plan_activo")
    private Integer idPlanActivo;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "rutAlumno")
    private List<Propuesta> propuestaList;

    @ManyToMany
    @JoinTable(
            name = "planes_alumno",
            joinColumns = {
                @JoinColumn(name = "alumno_id", referencedColumnName = "rut_alumno")},
            inverseJoinColumns = {
                @JoinColumn(name = "plan_id", referencedColumnName = "id")})
    private List<PlanEstudio> planes;

    @OneToMany(mappedBy = "alumno")
    private List<AsociacionPlanEstudioAlumno> asociacionPlanEstudioAlumno;

    public List<AsociacionPlanEstudioAlumno> getAsociacionPlanEstudioAlumno() {
        return asociacionPlanEstudioAlumno;
    }

    public Integer getJornadaParcial() {
        if (this.getAsociacionPlanEstudioAlumno().size() > 0) {
            return this.getAsociacionPlanEstudioAlumno().get(0).getPlanEstudio().getJornada();
        }
        return 0;
    }

    public void setAsociacionPlanEstudioAlumno(List<AsociacionPlanEstudioAlumno> asociacionPlanEstudioAlumno) {
        this.asociacionPlanEstudioAlumno = asociacionPlanEstudioAlumno;
    }

    public Alumno() {
        propuestaList = new ArrayList();
    }

    public Alumno(String rutAlumno) {
        propuestaList = new ArrayList();
        this.rutAlumno = rutAlumno;
    }
    
    public void add(Propuesta object) {
        propuestaList.add(object);
    }
    
    public String getRutAlumno() {
        return rutAlumno;
    }

    public String getRutAlumnoFormateado() {
        return Util.formatearRut(rutAlumno);
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public int getIdPlanActivo() {
        return idPlanActivo;
    }

    public void setIdPlanActivo(Integer idPlanActivo) {
        this.idPlanActivo = idPlanActivo;
    }

    public PlanEstudio getPlanActivo(){
        List<AsociacionPlanEstudioAlumno> alumnoPlanes = this.getAsociacionPlanEstudioAlumno();
        alumnoPlanes.size();
        AsociacionPlanEstudioAlumno activo = null;
        for (AsociacionPlanEstudioAlumno aluPlan : alumnoPlanes) {
            if ( aluPlan.isActivo() ){
                activo = aluPlan;
                break;
            }
        }
        return activo == null ? null : activo.getPlanEstudio();
    }

    @XmlTransient
    public List<Propuesta> getPropuestaList() {
        return propuestaList;
    }

    public void setPropuestaList(List<Propuesta> propuestaList) {
        this.propuestaList = propuestaList;
    }

    public List<PlanEstudio> getPlanes() {
        return planes;
    }

    public void setPlanes(List<PlanEstudio> planes) {
        this.planes = planes;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (rutAlumno != null ? rutAlumno.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Alumno)) {
            return false;
        }
        Alumno other = (Alumno) object;
        if ((this.rutAlumno == null && other.rutAlumno != null) || (this.rutAlumno != null && !this.rutAlumno.equals(other.rutAlumno))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Alumno[ rutAlumno=" + rutAlumno + " ]";
    }

}
