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
@Table(name = "comision_correctora")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ComisionCorrectora.findAll", query = "SELECT c FROM ComisionCorrectora c"),
    @NamedQuery(name = "ComisionCorrectora.findByFechaCorreccion", query = "SELECT c FROM ComisionCorrectora c WHERE c.fechaCorreccion = :fechaCorreccion"),
    @NamedQuery(name = "ComisionCorrectora.findByFechaEntregaCorreccion", query = "SELECT c FROM ComisionCorrectora c WHERE c.fechaEntCorreccion = :fechaEntCorreccion"),
    @NamedQuery(name = "ComisionCorrectora.findByFechaCorreccion2", query = "SELECT c FROM ComisionCorrectora c WHERE c.fechaCorreccion2 = :fechaCorreccion2"),
    @NamedQuery(name = "ComisionCorrectora.findByFechaEntregaCorreccion2", query = "SELECT c FROM ComisionCorrectora c WHERE c.fechaEntCorreccion2 = :fechaEntCorreccion2"),
    @NamedQuery(name = "ComisionCorrectora.findByIdCorrectora", query = "SELECT c FROM ComisionCorrectora c WHERE c.idCorrectora = :idCorrectora"),
    @NamedQuery(name = "ComisionCorrectora.findBySemestre", query = "SELECT c FROM ComisionCorrectora c WHERE c.idSemestre.idSemestre = :semestre")})
public class ComisionCorrectora implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Size(max = 15)
    @Column(name = "fecha_correccion")
    private String fechaCorreccion;
    
    @Size(max = 15)
    @Column(name = "fecha_entrega_correccion")
    private String fechaEntCorreccion;
    
    @Size(max = 15)
    @Column(name = "fecha_correccion2")
    private String fechaCorreccion2;
    
    @Size(max = 15)
    @Column(name = "fecha_entrega_correccion2")
    private String fechaEntCorreccion2;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_correctora")
    private Integer idCorrectora;
    
    @JoinColumn(name = "id_tema", referencedColumnName = "id_tema")
    @ManyToOne(optional = false)
    private Tema idTema;
    
    @JoinColumn(name = "id_semestre", referencedColumnName = "id_semestre")
    @ManyToOne(optional = false)
    private Semestre idSemestre;
    
    @OneToMany(mappedBy = "idCorrectora")
    private List<Tema> temaList;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "comisionCorrectora")
    private List<ProfeCorreccion> profeCorreccionList;

    public ComisionCorrectora() {
        temaList = new ArrayList();
        profeCorreccionList = new ArrayList();
    }

    public ComisionCorrectora(Integer idCorrectora) {
        temaList = new ArrayList();
        profeCorreccionList = new ArrayList();
        this.idCorrectora = idCorrectora;
    }
    
    public void add(Tema object){
        temaList.add(object);
    }
    
    public void add(ProfeCorreccion object){
        profeCorreccionList.add(object);
    }

    public String getFechaCorreccion() {
        return fechaCorreccion;
    }

    public String getFechaEntCorreccion() {
        return fechaEntCorreccion;
    }

    public void setFechaEntCorreccion(String fechaEntCorreccion) {
        this.fechaEntCorreccion = fechaEntCorreccion;
    }

    public void setFechaCorreccion(String fechaCorreccion) {
        this.fechaCorreccion = fechaCorreccion;
    }

    public Integer getIdCorrectora() {
        return idCorrectora;
    }

    public void setIdCorrectora(Integer idCorrectora) {
        this.idCorrectora = idCorrectora;
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

    @XmlTransient
    public List<Tema> getTemaList() {
        return temaList;
    }

    public void setTemaList(List<Tema> temaList) {
        this.temaList = temaList;
    }

    @XmlTransient
    public List<ProfeCorreccion> getProfeCorreccionList() {
        return profeCorreccionList;
    }

    public void setProfeCorreccionList(List<ProfeCorreccion> profeCorreccionList) {
        this.profeCorreccionList = profeCorreccionList;
    }
    
    public Profesor getCorrector1(){
        Profesor corr1 = null;
        List<ProfeCorreccion> profesores;
        profesores = getProfeCorreccionList();
        profesores.size();
        for (ProfeCorreccion p : profesores) {
            if ( p.getRolCorreccion() == 0 ){
                corr1 = p.getProfesor();
            }
        }
        return corr1;
    }

    public Profesor getCorrector2(){
        Profesor corr2 = null;
        List<ProfeCorreccion> profesores;
        profesores = getProfeCorreccionList();
        profesores.size();
        for (ProfeCorreccion p : profesores) {
            if ( p.getRolCorreccion() == 1 ){
                corr2 = p.getProfesor();
            }
        }
        return corr2;
    }
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idCorrectora != null ? idCorrectora.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ComisionCorrectora)) {
            return false;
        }
        ComisionCorrectora other = (ComisionCorrectora) object;
        if ((this.idCorrectora == null && other.idCorrectora != null) || (this.idCorrectora != null && !this.idCorrectora.equals(other.idCorrectora))) {
            return false;
        }
        return true;
    }

    public String getFechaCorreccion2() {
        return fechaCorreccion2;
    }

    public void setFechaCorreccion2(String fechaCorreccion2) {
        this.fechaCorreccion2 = fechaCorreccion2;
    }

    public String getFechaEntCorreccion2() {
        return fechaEntCorreccion2;
    }

    public void setFechaEntCorreccion2(String fechaEntCorreccion2) {
        this.fechaEntCorreccion2 = fechaEntCorreccion2;
    }
    
    

    @Override
    public String toString() {
        return "entities.ComisionCorrectora[ idCorrectora=" + idCorrectora + " ]";
    }
    
}
