/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author miguel
 */
@Entity
@Table(name = "logs")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Logs.findAll", query = "SELECT s FROM Logs s"),
    @NamedQuery(name = "Logs.findByLogsId", query = "SELECT s FROM Logs s WHERE s.logsId = :logsId"),
    @NamedQuery(name = "Logs.findByUserId", query = "SELECT s FROM Logs s WHERE s.userId = :userId"),
    @NamedQuery(name = "Logs.findByDated", query = "SELECT s FROM Logs s WHERE s.dated = :dated"),
    @NamedQuery(name = "Logs.findByLogger", query = "SELECT s FROM Logs s WHERE s.logger = :logger"),
    @NamedQuery(name = "Logs.findByLevel", query = "SELECT s FROM Logs s WHERE s.level = :level"),
    @NamedQuery(name = "Logs.findByMessage", query = "SELECT s FROM Logs s WHERE s.message = :message")})
public class Logs implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "logs_id")
    private Integer logsId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "user_id")
    private String userId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dated;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "logger")
    private String logger;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "level")
    private String level;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "message")
    private String message;

    public Logs() {
    }

    public Logs(Integer logsId) {
        this.logsId = logsId;
    }

    public Logs(Integer logsId, String userId, Date dated, String logger, String level, String message) {
        this.logsId = logsId;
        this.userId = userId;
        this.dated = dated;
        this.logger = logger;
        this.level = level;
        this.message = message;
    }

    public Integer getLogsId() {
        return logsId;
    }

    public void setLogsId(Integer logsId) {
        this.logsId = logsId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getDated() {
        return dated;
    }

    public void setDated(Date dated) {
        this.dated = dated;
    }

    public String getLogger() {
        return logger;
    }

    public void setLogger(String logger) {
        this.logger = logger;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (logsId != null ? logsId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Logs)) {
            return false;
        }
        Logs other = (Logs) object;
        if ((this.logsId == null && other.logsId != null) || (this.logsId != null && !this.logsId.equals(other.logsId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Logs[ logsId=" + logsId + " ]";
    }
    
}