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
import javax.ejb.EJB;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import sessionbeans.PlanestudioFacadeLocal;

/**
 *
 * @author Elagos
 */
@Entity
@Table(name = "alumno")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Alumno.findAll", query = "SELECT a FROM Alumno a"),
    //@NamedQuery(name = "Alumno.findByJornada", query = "SELECT a FROM Alumno a WHERE a.jornada = :jornada"),
    //@NamedQuery(name = "Alumno.findByCarreraAlumno", query = "SELECT a FROM Alumno a WHERE a.carreraAlumno = :carreraAlumno"),
    @NamedQuery(name = "Alumno.findByRutAlumno", query = "SELECT a FROM Alumno a WHERE a.usuario.rutUsuario = :rutAlumno"),
    @NamedQuery(name = "Alumno.findByDireccionAlumno", query = "SELECT a FROM Alumno a WHERE a.usuario.direccionUsuario = :direccionAlumno"),
    @NamedQuery(name = "Alumno.findByNombreAlumno", query = "SELECT a FROM Alumno a WHERE a.usuario.nombreUsuario = :nombreAlumno"),
    @NamedQuery(name = "Alumno.findByApellidoAlumno", query = "SELECT a FROM Alumno a WHERE a.usuario.apellidoUsuario = :apellidoAlumno"),
    @NamedQuery(name = "Alumno.findByTelefonoAlumno", query = "SELECT a FROM Alumno a WHERE a.usuario.telefonoUsuario = :telefonoAlumno"),
    @NamedQuery(name = "Alumno.findByMailAlumno", query = "SELECT a FROM Alumno a WHERE a.usuario.mailUsuario = :mailAlumno"),
    @NamedQuery(name = "Alumno.findAlumno", query = "SELECT a FROM Alumno a WHERE a.usuario.nombreUsuario LIKE :nombreAlumno OR a.usuario.apellidoUsuario LIKE :apellidoAlumno OR a.usuario.rutUsuario LIKE :rutAlumno")})
public class Alumno implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @Basic(optional = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull
    @Column(name = "id_alumno")
    private String idAlumno;
    
    @Column(name = "id_plan_activo")
    Integer idPlanActivo;
    
    @Column(name = "version_plan_activo")
    Integer versionPlanActivo;

    @JoinColumn(name = "rut_usuario", referencedColumnName = "rut_usuario", updatable = false)
    @OneToOne(optional = false)
    private Usuario usuario;
    
    public Integer getVersionPlanActivo() {
        return versionPlanActivo;
    }

    public void setVersionPlanActivo(Integer versionPlanActivo) {
        this.versionPlanActivo = versionPlanActivo;
    }

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
        usuario = new Usuario();
    }
    
    public Alumno (String rutUsuario){
        propuestaList = new ArrayList();       
        this.usuario = new Usuario(rutUsuario);
    }

    public void add(Propuesta object) {
        propuestaList.add(object);
    }

    @XmlTransient
    public List<Propuesta> getPropuestaList() {
        return propuestaList;
    }

    public String getIdAlumno() {
        return idAlumno;
    }

    public void setIdAlumno(String idAlumno) {
        this.idAlumno = idAlumno;
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

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getMailAlumno() {
        return usuario.getMailUsuario();
    }

    public void setMailAlumno(String mailAlumno) {
        this.usuario.setMailUsuario(mailAlumno);
    }

    public String getTelefonoAlumno() {
        return usuario.getTelefonoUsuario();
    }

    public void setTelefonoAlumno(String telefonoAlumno) {
        this.usuario.setTelefonoUsuario(telefonoAlumno);
    }

    public String getDireccionAlumno() {
        return usuario.getDireccionUsuario();
    }

    public void setDireccionAlumno(String direccionAlumno) {
        this.usuario.setDireccionUsuario(direccionAlumno);
    }

    public String getRutAlumno() {
        return usuario.getRutUsuario();
    }

    public void setRutAlumno(String rutAlumno) {
        this.usuario.setRutUsuario(rutAlumno);
    }

    public String getNombreAlumno() {
        return usuario.getNombreUsuario();
    }

    public void setNombreAlumno(String nombreAlumno) {
        this.usuario.setNombreUsuario(nombreAlumno);
    }

    public String getApellidoAlumno() {
        return usuario.getApellidoUsuario();
    }

    public void setApellidoAlumno(String apellidoAlumno) {
        this.usuario.setApellidoUsuario(apellidoAlumno);
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
        if (!(object instanceof Alumno)) {
            return false;
        }
        Alumno other = (Alumno) object;
        if ((this.usuario.getRutUsuario() == null && other.usuario.getRutUsuario() != null) || (this.usuario.getRutUsuario() != null && !this.usuario.getRutUsuario().equals(other.usuario.getRutUsuario()))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Alumno[ rutAlumno=" + usuario.getRutUsuario() + " ]";
    }

    public Integer getIdPlanActivo() {
        return idPlanActivo;
    }

    public void setIdPlanActivo(Integer idPlanActivo) {
        this.idPlanActivo = idPlanActivo;
    }
    
    public PlanEstudio getPlanActivo() {
        Integer id_plan = this.idPlanActivo;
        
        List<PlanEstudio> planesasd = this.getPlanes();
        
        if (id_plan != null){
            for (int i = 0; i < planesasd.size(); i++) {
                
                if(planesasd.get(i).getId() == Long.parseLong(id_plan+"")){
                    
                    return planesasd.get(i);
                }
            }
        }
        return null;
    }

}
