/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Elagos
 */
@Entity
@Table(name = "historial")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Historial.findAll", query = "SELECT h FROM Historial h"),
    @NamedQuery(name = "Historial.findByDescripcion", query = "SELECT h FROM Historial h WHERE h.descripcion = :descripcion"),
    @NamedQuery(name = "Historial.findByFechaHistorial", query = "SELECT h FROM Historial h WHERE h.fechaHistorial = :fechaHistorial"),
    @NamedQuery(name = "Historial.findByIdEntidad", query = "SELECT h FROM Historial h WHERE h.idEntidad = :idEntidad"),
    @NamedQuery(name = "Historial.findByTipoHistorial", query = "SELECT h FROM Historial h WHERE h.tipoHistorial = :tipoHistorial"),
    @NamedQuery(name = "Historial.findByIdHistorial", query = "SELECT h FROM Historial h WHERE h.idHistorial = :idHistorial")})
public class Historial implements Serializable {
    private static final long serialVersionUID = 1L;
    @Size(max = 200)
    @Column(name = "descripcion")
    private String descripcion;
    @Size(max = 15)
    @Column(name = "fecha_historial")
    private String fechaHistorial;
    @Size(max = 20)
    @Column(name = "id_entidad")
    private String idEntidad;
    @Column(name = "tipo_historial")
    private Integer tipoHistorial;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_historial")
    private Integer idHistorial;

    public Historial() {
    }

    public Historial(Integer idHistorial) {
        this.idHistorial = idHistorial;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getFechaHistorial() {
        return fechaHistorial;
    }

    public void setFechaHistorial(String fechaHistorial) {
        this.fechaHistorial = fechaHistorial;
    }

    public String getIdEntidad() {
        return idEntidad;
    }

    public void setIdEntidad(String idEntidad) {
        this.idEntidad = idEntidad;
    }

    public Integer getTipoHistorial() {
        return tipoHistorial;
    }

    public void setTipoHistorial(Integer tipoHistorial) {
        this.tipoHistorial = tipoHistorial;
    }

    public Integer getIdHistorial() {
        return idHistorial;
    }

    public void setIdHistorial(Integer idHistorial) {
        this.idHistorial = idHistorial;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idHistorial != null ? idHistorial.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Historial)) {
            return false;
        }
        Historial other = (Historial) object;
        if ((this.idHistorial == null && other.idHistorial != null) || (this.idHistorial != null && !this.idHistorial.equals(other.idHistorial))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Historial[ idHistorial=" + idHistorial + " ]";
    }
    
}
