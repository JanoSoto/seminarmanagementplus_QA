/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author miguel
 */
@Entity
@Table(name = "usuario")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Usuario.findAll", query = "SELECT u FROM Usuario u"),
    @NamedQuery(name = "Usuario.findByUid", query = "SELECT u FROM Usuario u WHERE u.uid = :uid"),
    @NamedQuery(name = "Usuario.findByRutUsuario", query = "SELECT u FROM Usuario u WHERE u.rutUsuario = :rutUsuario"),
    @NamedQuery(name = "Usuario.findByMailUsuario", query = "SELECT u FROM Usuario u WHERE u.mailUsuario = :mailUsuario"),
    @NamedQuery(name = "Usuario.findByTelefonoUsuario", query = "SELECT u FROM Usuario u WHERE u.telefonoUsuario = :telefonoUsuario"),
    @NamedQuery(name = "Usuario.findByDireccionUsuario", query = "SELECT u FROM Usuario u WHERE u.direccionUsuario = :direccionUsuario"),
    @NamedQuery(name = "Usuario.findByNombreUsuario", query = "SELECT u FROM Usuario u WHERE u.nombreUsuario = :nombreUsuario"),
    @NamedQuery(name = "Usuario.findByApellidoUsuario", query = "SELECT u FROM Usuario u WHERE u.apellidoUsuario = :apellidoUsuario"),
    @NamedQuery(name = "Usuario.findByActivo", query = "SELECT u FROM Usuario u WHERE u.activo = :activo")})
public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;
    @Size(min = 1, max = 20)
    @Column(name = "uid")
    private String uid;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "rut_usuario")
    private String rutUsuario;
    @Size(max = 50)
    @Column(name = "nombre_usuario")
    private String nombreUsuario;
    @Size(max = 50)
    @Column(name = "apellido_usuario")
    private String apellidoUsuario;
    @Column(name = "activo")
    private Boolean activo;
    @Size(max = 100)
    @Column(name = "mail_usuario")
    private String mailUsuario;
    @Size(max = 15)
    @Column(name = "telefono_usuario")
    private String telefonoUsuario;
    @Size(max = 100)
    @Column(name = "direccion_usuario")
    private String direccionUsuario;
    @Size(max = 50)
    @Column(name = "tema_usuario")
    private String temaUsuario;
    
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "usuario")
    private Alumno alumno;
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "usuario")
    private Profesor profesor;    
    @JoinColumn(name = "comuna", referencedColumnName = "COMUNA_ID")
    @ManyToOne
    private Comuna comuna;
    

    @ManyToMany(mappedBy = "usuarios")
    private List<Tipousuario> tipos;
    
    public String getTema() {
        return temaUsuario;
    }

    public void setTema(String tema) {
        this.temaUsuario = tema;
    }

    public void setTipos(List<Tipousuario> tipos) {
        this.tipos = tipos;
    }

    public List<Tipousuario> getTipos() {
        return tipos;
    }

    public List<Tipousuario> getRoles() {
        return tipos;
    }

    public void setRoles(List<Tipousuario> roles) {
        this.tipos = roles;
    }

    public Usuario() {
    }

    public Usuario(String rutUsuario) {
        this.rutUsuario = rutUsuario;
    }

    public Usuario(String rutUsuario, String uid) {
        this.rutUsuario = rutUsuario;
        this.uid = uid;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getRutUsuario() {
        return rutUsuario;
    }

    public void setRutUsuario(String rutUsuario) {
        this.rutUsuario = rutUsuario;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getApellidoUsuario() {
        return apellidoUsuario;
    }

    public void setApellidoUsuario(String apellidoUsuario) {
        this.apellidoUsuario = apellidoUsuario;
    }

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }

    public String getMailUsuario() {
        return mailUsuario;
    }

    public void setMailUsuario(String mailUsuario) {
        this.mailUsuario = mailUsuario;
    }

    public String getTelefonoUsuario() {
        return telefonoUsuario;
    }

    public void setTelefonoUsuario(String telefonoUsuario) {
        this.telefonoUsuario = telefonoUsuario;
    }

    public String getDireccionUsuario() {
        return direccionUsuario;
    }

    public void setDireccionUsuario(String direccionUsuario) {
        this.direccionUsuario = direccionUsuario;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public Profesor getProfesor() {
        return profesor;
    }

    public void setProfesor(Profesor profesor) {
        this.profesor = profesor;
    }

    public String getTemaUsuario() {
        return temaUsuario;
    }

    public void setTemaUsuario(String temaUsuario) {
        this.temaUsuario = temaUsuario;
    }

    public Comuna getComuna() {
        return comuna;
    }

    public void setComuna(Comuna comuna) {
        this.comuna = comuna;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (rutUsuario != null ? rutUsuario.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Usuario)) {
            return false;
        }
        Usuario other = (Usuario) object;
        if ((this.rutUsuario == null && other.rutUsuario != null) || (this.rutUsuario != null && !this.rutUsuario.equals(other.rutUsuario))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Usuario[ rutUsuario=" + rutUsuario + " ]";
    }

}
