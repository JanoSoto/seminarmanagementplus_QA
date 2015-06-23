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
    @NamedQuery(name = "Tema.findByFechaSiacTema", query = "SELECT t FROM Tema t WHERE t.fechaSiacTema = :fechaSiacTema"),
    @NamedQuery(name = "Tema.findByFechaRealTema", query = "SELECT t FROM Tema t WHERE t.fechaRealTema = :fechaRealTema"),
    @NamedQuery(name = "Tema.findByEstadoTema", query = "SELECT t FROM Tema t WHERE t.estadoTema = :estadoTema"),
    @NamedQuery(name = "Tema.findByTerminoSemestre", query = "SELECT t FROM Tema t WHERE t.semestreTermino = :semestreTermino"),
    @NamedQuery(name = "Tema.findByIdTema", query = "SELECT t FROM Tema t WHERE t.idTema = :idTema"),
    @NamedQuery(name = "Tema.findTema", query = "SELECT t FROM Tema t WHERE t.nombreTema LIKE :nombreTema")})
public class Tema implements Serializable {
    @Column(name = "precerrado")
    private Boolean precerrado;
    @Size(max = 15)
    private static final long serialVersionUID = 1L;
    @Size(max = 400)
    @Column(name = "nombre_tema")
    private String nombreTema;
    @Size(max = 15)
    
    @Column(name = "fecha_borrador")
    private String fechaBorrador;
    @Size(max = 20)
    
    @Column(name = "fecha_renuncia")
    private String fechaRenuncia;
    @Size(max = 20)
    
    @Column(name = "fecha_caducado")
    private String fechaCaducado;
    @Size(max = 20)
    
    @Column(name = "fecha_informe_avance")
    private String fechaInformeAvance;
    @Size(max = 20)
    
    @Column(name = "fecha_tema")
    private String fechaTema;
    @Size(max = 15)
    @Column(name = "fecha_siac")
    private String fechaSiacTema;
    @Size(max = 15)
    @Column(name = "fecha_real")
    private String fechaRealTema;
    @Size(max = 15)
    @Column(name = "semestre_termino")
    private String semestreTermino;
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

    public String getFechaSiacTema() {
        return fechaSiacTema;
    }

    public void setFechaSiacTema(String fechaSiacTema) {
        this.fechaSiacTema = fechaSiacTema;
    }

    public String getFechaRealTema() {
        return fechaRealTema;
    }

    public void setFechaRealTema(String fechaRealTema) {
        this.fechaRealTema = fechaRealTema;
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

    public String getSemestreTermino() {
        return semestreTermino;
    }

    public void setSemestreTermino(String semestreTermino) {
        this.semestreTermino = semestreTermino;
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
    
    
    public String getFechaBorrador() {
        return fechaBorrador;
    }

    public void setFechaBorrador(String fechaBorrador) {
        this.fechaBorrador = fechaBorrador;
    }

    public String getFechaRenuncia() {
        return fechaRenuncia;
    }

    public void setFechaRenuncia(String fechaRenuncia) {
        this.fechaRenuncia = fechaRenuncia;
    }

    public String getFechaCaducado() {
        return fechaCaducado;
    }

    public void setFechaCaducado(String fechaCaducado) {
        this.fechaCaducado = fechaCaducado;
    }

    public String getFechaInformeAvance() {
        return fechaInformeAvance;
    }

    public void setFechaInformeAvance(String fechaInformeAvance) {
        this.fechaInformeAvance = fechaInformeAvance;
    }

    @XmlTransient
    public List<ComisionRevisora> getComisionRevisoraList() {
        return comisionRevisoraList;
    }

    public void setComisionRevisoraList(List<ComisionRevisora> comisionRevisoraList) {
        this.comisionRevisoraList = comisionRevisoraList;
    }
    
    public boolean getEstadoTemaBoolean() {
        return estadoTema != 1;
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


    public Boolean getPrecerrado() {
        return precerrado;
    }

    public void setPrecerrado(Boolean precerrado) {
        this.precerrado = precerrado;
    }
    
}
