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
 * @author Elagos
 */
@Entity
@Table(name = "profesor")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Profesor.findAll", query = "SELECT p FROM Profesor p"),
    @NamedQuery(name = "Profesor.findByContrato", query = "SELECT p FROM Profesor p WHERE p.contrato = :contrato"),
    @NamedQuery(name = "Profesor.findByNombreProfesor", query = "SELECT p FROM Profesor p WHERE p.nombreProfesor = :nombreProfesor"),
    @NamedQuery(name = "Profesor.findByApellidoProfesor", query = "SELECT p FROM Profesor p WHERE p.apellidoProfesor = :apellidoProfesor"),
    @NamedQuery(name = "Profesor.findByMailProfesor", query = "SELECT p FROM Profesor p WHERE p.mailProfesor = :mailProfesor"),
    @NamedQuery(name = "Profesor.findByTelefonoProfesor", query = "SELECT p FROM Profesor p WHERE p.telefonoProfesor = :telefonoProfesor"),
    @NamedQuery(name = "Profesor.findByTipoProfesor", query = "SELECT p FROM Profesor p WHERE p.tipoProfesor = :tipoProfesor"),
    @NamedQuery(name = "Profesor.findByMaximoGuias", query = "SELECT p FROM Profesor p WHERE p.maximoGuias = :maximoGuias"),
    @NamedQuery(name = "Profesor.findByRutProfesor", query = "SELECT p FROM Profesor p WHERE p.rutProfesor = :rutProfesor"),
    @NamedQuery(name = "Profesor.findProfesor", query = "SELECT p FROM Profesor p WHERE p.nombreProfesor LIKE :nombreProfesor OR p.apellidoProfesor LIKE :apellidoProfesor OR p.rutProfesor LIKE :rutProfesor")})
public class Profesor implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "rut_profesor")
    private String rutProfesor;
    
    @Column(name = "contrato")
    private Integer contrato;
    
    @Size(max = 50)
    @Column(name = "nombre_profesor")
    private String nombreProfesor;
    
    @Size(max = 50)
    @Column(name = "apellido_profesor")
    private String apellidoProfesor;
    
    @Size(max = 100)
    @Column(name = "mail_profesor")
    private String mailProfesor;
    
    @Size(max = 20)
    @Column(name = "telefono_profesor")
    private String telefonoProfesor;
    
    @Column(name = "tipo_profesor")
    private Integer tipoProfesor;
    
    @Column(name = "maximo_guias")
    private Integer maximoGuias;
    
    @Size(max = 30)
    @Column(name = "jerarquia_categoria")
    private String jerarquiaCategoria;
    
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

    public String getNombreProfesor() {
        return nombreProfesor;
    }

    public void setNombreProfesor(String nombreProfesor) {
        this.nombreProfesor = nombreProfesor;
    }

    public String getApellidoProfesor() {
        return apellidoProfesor;
    }

    public void setApellidoProfesor(String apellidoProfesor) {
        this.apellidoProfesor = apellidoProfesor;
    }

    public String getMailProfesor() {
        return mailProfesor;
    }

    public void setMailProfesor(String mailProfesor) {
        this.mailProfesor = mailProfesor;
    }

    public String getTelefonoProfesor() {
        return telefonoProfesor;
    }

    public void setTelefonoProfesor(String telefonoProfesor) {
        this.telefonoProfesor = telefonoProfesor;
    }

    public Integer getTipoProfesor() {
        return tipoProfesor;
    }

    public void setTipoProfesor(Integer tipoProfesor) {
        this.tipoProfesor = tipoProfesor;
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

    public String getJerarquiaCategoria() {
        return jerarquiaCategoria;
    }

    public void setJerarquiaCategoria(String jerarquiaCategoria) {
        this.jerarquiaCategoria = jerarquiaCategoria;
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
