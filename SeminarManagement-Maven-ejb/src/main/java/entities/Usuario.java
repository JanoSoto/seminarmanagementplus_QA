/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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

/**
 *
 * @author miguel
 */
@Entity
@Table(name = "usuario")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Usuario.findAll", query = "SELECT u FROM Usuario u"),
    @NamedQuery(name = "Usuario.findByRutUsuario", query = "SELECT u FROM Usuario u WHERE u.rutUsuario = :rutUsuario"),
    @NamedQuery(name = "Usuario.findByUid", query = "SELECT u FROM Usuario u WHERE u.uid = :uid"),
    @NamedQuery(name = "Usuario.findByNombreUsuario", query = "SELECT u FROM Usuario u WHERE u.nombreUsuario = :nombreUsuario"),
    @NamedQuery(name = "Usuario.findBySegundoNombreUsuario", query = "SELECT u FROM Usuario u WHERE u.segundoNombreUsuario = :segundoNombreUsuario"),
    @NamedQuery(name = "Usuario.findByApellidoUsuarioPaterno", query = "SELECT u FROM Usuario u WHERE u.apellidoUsuarioPaterno = :apellidoUsuarioPaterno"),
    @NamedQuery(name = "Usuario.findByApellidoUsuarioMaterno", query = "SELECT u FROM Usuario u WHERE u.apellidoUsuarioMaterno = :apellidoUsuarioMaterno"),
    @NamedQuery(name = "Usuario.findByMailUsuario", query = "SELECT u FROM Usuario u WHERE u.mailUsuario = :mailUsuario"),
    @NamedQuery(name = "Usuario.findByTelefonoUsuario", query = "SELECT u FROM Usuario u WHERE u.telefonoUsuario = :telefonoUsuario"),
    @NamedQuery(name = "Usuario.findByDireccionUsuario", query = "SELECT u FROM Usuario u WHERE u.direccionUsuario = :direccionUsuario"),
    @NamedQuery(name = "Usuario.findByActivo", query = "SELECT u FROM Usuario u WHERE u.activo = :activo")})
public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "rut_usuario")
    private String rutUsuario;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "uid")
    private String uid;
    @Size(max = 50)
    @Column(name = "nombre_usuario")
    private String nombreUsuario;
    @Size(max = 50)
    @Column(name = "segundo_nombre_usuario")
    private String segundoNombreUsuario;
    @Size(max = 50)
    @Column(name = "apellido_usuario_paterno")
    private String apellidoUsuarioPaterno;
    @Size(max = 50)
    @Column(name = "apellido_usuario_materno")
    private String apellidoUsuarioMaterno;
    @Size(max = 100)
    @Column(name = "mail_usuario")
    private String mailUsuario;
    @Size(max = 20)
    @Column(name = "telefono_usuario")
    private String telefonoUsuario;
    @Size(max = 100)
    @Column(name = "direccion_usuario")
    private String direccionUsuario;
    @Column(name = "activo")
    private Boolean activo;


    @OneToMany(mappedBy = "usuario")
    private List<UsuarioTipo> usuarioTipoList;
    
    public List<UsuarioTipo> getUsuarioTipoList(){
        return this.usuarioTipoList;
    }
    
    public Usuario() {
        usuarioTipoList = new ArrayList();
    }

    public Usuario(String rutUsuario) {
        usuarioTipoList = new ArrayList();
        this.rutUsuario = rutUsuario;
    }

    public void add(UsuarioTipo object) {
        usuarioTipoList.add(object);
    }

    public String getRutUsuario() {
        return rutUsuario;
    }

    public void setRutUsuario(String rutUsuario) {
        this.rutUsuario = rutUsuario;
    }

    public String getMailUsuario() {
        return mailUsuario;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getSegundoNombreUsuario() {
        return segundoNombreUsuario;
    }

    public void setSegundoNombreUsuario(String segundoNombreUsuario) {
        this.segundoNombreUsuario = segundoNombreUsuario;
    }

    public String getApellidoUsuarioPaterno() {
        return apellidoUsuarioPaterno;
    }

    public void setApellidoUsuarioPaterno(String apellidoUsuarioPaterno) {
        this.apellidoUsuarioPaterno = apellidoUsuarioPaterno;
    }

    public String getApellidoUsuarioMaterno() {
        return apellidoUsuarioMaterno;
    }

    public void setApellidoUsuarioMaterno(String apellidoUsuarioMaterno) {
        this.apellidoUsuarioMaterno = apellidoUsuarioMaterno;
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

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
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
