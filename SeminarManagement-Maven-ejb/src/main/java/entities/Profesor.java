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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

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
    @NamedQuery(name = "Profesor.findByNombreProfesor", query = "SELECT p FROM Profesor p WHERE p.usuario.nombreUsuario = :nombreProfesor"),
    @NamedQuery(name = "Profesor.findByApellidoProfesor", query = "SELECT p FROM Profesor p WHERE p.usuario.apellidoUsuario = :apellidoProfesor"),
    @NamedQuery(name = "Profesor.findByMailProfesor", query = "SELECT p FROM Profesor p WHERE p.usuario.mailUsuario = :mailProfesor"),
    @NamedQuery(name = "Profesor.findByTelefonoProfesor", query = "SELECT p FROM Profesor p WHERE p.usuario.telefonoUsuario = :telefonoProfesor"),
    @NamedQuery(name = "Profesor.findByTipoProfesor", query = "SELECT p FROM Profesor p WHERE p.tipoProfesor = :tipoProfesor"),
    @NamedQuery(name = "Profesor.findByMaximoGuias", query = "SELECT p FROM Profesor p WHERE p.maximoGuias = :maximoGuias"),
    @NamedQuery(name = "Profesor.findByRutProfesor", query = "SELECT p FROM Profesor p WHERE p.usuario.rutUsuario = :rutProfesor"),
    @NamedQuery(name = "Profesor.findProfesor", query = "SELECT p FROM Profesor p WHERE p.usuario.nombreUsuario LIKE :nombreProfesor OR p.usuario.apellidoUsuario LIKE :apellidoProfesor OR p.usuario.rutUsuario LIKE :rutProfesor")})
public class Profesor implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Basic(optional = false)
    @NotNull
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_profesor")
    private String idProfesor;
    
    @Column(name = "contrato")
    private Integer contrato;
        
    @Column(name = "tipo_profesor")
    private Integer tipoProfesor;
    
    @Column(name = "maximo_guias")
    private Integer maximoGuias;
    
    @Size(max = 30)
    @Column(name = "jerarquia_categoria")
    private String jerarquiaCategoria;
    
    @JoinColumn(name = "rut_usuario", referencedColumnName = "rut_usuario", updatable = false)
    @OneToOne(optional = false)
    private Usuario usuario;
        
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
        usuario = new Usuario();
    }

    public Profesor(String rutUsuario) {
        profePropuestaList = new ArrayList();
        profeRevisionList = new ArrayList();
        profeCorreccionList = new ArrayList();
        this.usuario = new Usuario(rutUsuario);
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

    public String getIdProfesor() {
        return idProfesor;
    }

    public void setIdProfesor(String idProfesor) {
        this.idProfesor = idProfesor;
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

    public Integer getMaximoGuias() {
        return maximoGuias;
    }

    public void setMaximoGuias(Integer maximoGuias) {
        this.maximoGuias = maximoGuias;
    }

    public String getRutFormateadoProfesor() {
        return Util.formatearRut(usuario.getRutUsuario());
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

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getMailProfesor() {
        return usuario.getMailUsuario();
    }

    public void setMailProfesor(String mailProfesor) {
        this.usuario.setMailUsuario(mailProfesor);
    }

    public String getTelefonoProfesor() {
        return usuario.getTelefonoUsuario();
    }

    public void setTelefonoProfesor(String telefonoProfesor) {
        this.usuario.setTelefonoUsuario(telefonoProfesor);
    }

    public String getDireccionProfesor() {
        return usuario.getDireccionUsuario();
    }

    public void setDireccionProfesor(String direccionProfesor) {
        this.usuario.setDireccionUsuario(direccionProfesor);
    }

    public String getRutProfesor() {
        return usuario.getRutUsuario();
    }

    public void setRutProfesor(String rutProfesor) {
        this.usuario.setRutUsuario(rutProfesor);
    }

    public String getNombreProfesor() {
        return usuario.getNombreUsuario();
    }

    public void setNombreProfesor(String nombreProfesor) {
        this.getUsuario().setNombreUsuario(nombreProfesor);
    }

    public String getApellidoProfesor() {
        return usuario.getApellidoUsuario();
    }

    public void setApellidoProfesor(String apellidoProfesor) {
        this.usuario.setApellidoUsuario(apellidoProfesor);
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (usuario.getRutUsuario() != null ? usuario.getRutUsuario().hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Profesor)) {
            return false;
        }
        Profesor other = (Profesor) object;
        if ((this.usuario.getRutUsuario() == null && other.usuario.getRutUsuario() != null) || (this.usuario.getRutUsuario() != null && !this.usuario.getRutUsuario().equals(other.usuario.getRutUsuario()))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Profesor[ rutProfesor=" + usuario.getRutUsuario() + " ]";
    }
    
}
