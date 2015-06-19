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
@Table(name = "propuesta")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Propuesta.findAll", query = "SELECT p FROM Propuesta p"),
    @NamedQuery(name = "Propuesta.findByNombrePropuesta", query = "SELECT p FROM Propuesta p WHERE p.nombrePropuesta = :nombrePropuesta"),
    @NamedQuery(name = "Propuesta.findByFechaPropuesta", query = "SELECT p FROM Propuesta p WHERE p.fechaPropuesta = :fechaPropuesta"),
    @NamedQuery(name = "Propuesta.findByIdPropuesta", query = "SELECT p FROM Propuesta p WHERE p.idPropuesta = :idPropuesta"),
    @NamedQuery(name = "Propuesta.findByPet", query = "SELECT p FROM Propuesta p WHERE p.pet = :pet"),
    @NamedQuery(name = "Propuesta.findByIdSemestre", query = "SELECT p FROM Propuesta p WHERE p.idSemestre = :idSemestre"),
    @NamedQuery(name = "Propuesta.findPropuesta", query = "SELECT p FROM Propuesta p WHERE p.nombrePropuesta LIKE :nombrePropuesta"),
    @NamedQuery(name = "Propuesta.findOneById", query = "SELECT p FROM Propuesta p WHERE p.idPropuesta = :id")})
public class Propuesta implements Serializable {
    private static final long serialVersionUID = 1L;
    @Size(max = 400)
    @Column(name = "nombre_propuesta")
    private String nombrePropuesta;
    @Column(name = "pet")
    private Boolean pet;
    @Size(max = 15)
    @Column(name = "fecha_propuesta")
    private String fechaPropuesta;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_propuesta")
    private Integer idPropuesta;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "propuesta")
    private List<ProfePropuesta> profePropuestaList;
    @JoinColumn(name = "id_semestre", referencedColumnName = "id_semestre")
    @ManyToOne(optional = false)
    private Semestre idSemestre;
    @JoinColumn(name = "id_revisora", referencedColumnName = "id_revisora")
    @ManyToOne
    private ComisionRevisora idRevisora;
    @JoinColumn(name = "rut_alumno", referencedColumnName = "rut_alumno")
    @ManyToOne(optional = false)
    private Alumno rutAlumno;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idPropuesta")
    private List<ComisionRevisora> comisionRevisoraList;
    @Column(name = "magister")
    private Boolean magister;

    public Propuesta() {
        profePropuestaList = new ArrayList();
        comisionRevisoraList = new ArrayList();
    }

    public Propuesta(Integer idPropuesta) {
        profePropuestaList = new ArrayList();
        comisionRevisoraList = new ArrayList();
        this.idPropuesta = idPropuesta;
    }
    
    public void add(ProfePropuesta object){
        profePropuestaList.add(object);
    }
    
    public void add(ComisionRevisora object){
        comisionRevisoraList.add(object);
    }

    public Boolean getPet() {
        return pet;
    }

    public void setPet(Boolean pet) {
        this.pet = pet;
    }

    
    public String getNombrePropuesta() {
        return nombrePropuesta;
    }

    public void setNombrePropuesta(String nombrePropuesta) {
        this.nombrePropuesta = nombrePropuesta;
    }

    public String getFechaPropuesta() {
        return fechaPropuesta;
    }

    public void setFechaPropuesta(String fechaPropuesta) {
        this.fechaPropuesta = fechaPropuesta;
    }

    public Integer getIdPropuesta() {
        return idPropuesta;
    }

    public void setIdPropuesta(Integer idPropuesta) {
        this.idPropuesta = idPropuesta;
    }

    @XmlTransient
    public List<ProfePropuesta> getProfePropuestaList() {
        return profePropuestaList;
    }

    public void setProfePropuestaList(List<ProfePropuesta> profePropuestaList) {
        this.profePropuestaList = profePropuestaList;
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

    public Alumno getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(Alumno rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public Boolean getMagister() {
        return magister;
    }

    public void setMagister(Boolean magister) {
        this.magister = magister;
    }
    
    @XmlTransient
    public List<ComisionRevisora> getComisionRevisoraList() {
        return comisionRevisoraList;
    }

    public void setComisionRevisoraList(List<ComisionRevisora> comisionRevisoraList) {
        this.comisionRevisoraList = comisionRevisoraList;
    }

    public Profesor getProfesorGuia(){
        Profesor guia = null;
        List<ProfePropuesta> listaProf =  getProfePropuestaList();
        listaProf.size();
        for (ProfePropuesta profeProp : listaProf) {
            if ( profeProp.getRolGuia() == 0){
                guia = profeProp.getProfesor();
                break;
            }
        }
        return guia;
    }
    
    public Profesor getProfesorCoGuia(){
        Profesor coGuia = null;
        List<ProfePropuesta> listaProf =  getProfePropuestaList();
        listaProf.size();
        for (ProfePropuesta profeProp : listaProf) {
            if ( profeProp.getRolGuia() == 1){
                coGuia = profeProp.getProfesor();
                break;
            }
        }
        return coGuia;
    }
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idPropuesta != null ? idPropuesta.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Propuesta)) {
            return false;
        }
        Propuesta other = (Propuesta) object;
        if ((this.idPropuesta == null && other.idPropuesta != null) || (this.idPropuesta != null && !this.idPropuesta.equals(other.idPropuesta))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Propuesta[ idPropuesta=" + idPropuesta + " ]";
    }
    
}
