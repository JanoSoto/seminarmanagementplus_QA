package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Elagos
 */
@Entity
@Table(name = "semestre_actual")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SemestreActual.findAll", query = "SELECT s FROM SemestreActual s"),
    @NamedQuery(name = "SemestreActual.findBySemestreActual", query = "SELECT s FROM SemestreActual s WHERE s.semestreActual = :semestreActual")})
public class SemestreActual implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 15)
    @Column(name = "semestre_actual")
    private String semestreActual;

    public SemestreActual() {
    }

    public SemestreActual(String semestreActual) {
        this.semestreActual = semestreActual;
    }

    public String getSemestreActual() {
        return semestreActual;
    }

    public void setSemestreActual(String semestreActual) {
        this.semestreActual = semestreActual;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (semestreActual != null ? semestreActual.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SemestreActual)) {
            return false;
        }
        SemestreActual other = (SemestreActual) object;
        if ((this.semestreActual == null && other.semestreActual != null) || (this.semestreActual != null && !this.semestreActual.equals(other.semestreActual))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.SemestreActual[ semestreActual=" + semestreActual + " ]";
    }
    
}
