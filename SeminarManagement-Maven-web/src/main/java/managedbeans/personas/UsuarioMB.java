/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans.personas;

import entities.Historial;
import entities.Profesor;
import entities.Tipo;
import entities.Usuario;
import entities.UsuarioTipo;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.context.FacesContext;
import managedbeans.ProfesorViewMB;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.TipoFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;
import sessionbeans.UsuarioTipoFacadeLocal;

/**
 *
 * @author Elagos
 */
@ManagedBean(name ="usuarioMB")
@RequestScoped
public class UsuarioMB {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private TipoFacadeLocal tipoFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;
    @EJB
    private UsuarioTipoFacadeLocal usuarioTipoFacade;

    private String username, nombreUsuario, apellidoUsuario, tipoUsuario;
    

    @PostConstruct
    public void init() {
        List<Tipo> tipos = tipoFacade.findAll();
    }

    public String getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(String tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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
    
    //Para encriptar el password
    public static String sha256(String base) {
        try{
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch(Exception ex){
           throw new RuntimeException(ex);
        }
    }
    
    public void agregarNuevoUsuario() throws NoSuchAlgorithmException, UnsupportedEncodingException{
        FacesContext context = FacesContext.getCurrentInstance();
        //Seteamos algunos valores, como el nombre y apellido a mayúsculas
        //Sacamos guión y puntos del rut, además de dejarlo en mayúsculas si tiene -k
        username = username.toUpperCase();
        username = username.replace(".", "");
        username = username.replace("-", "");
        nombreUsuario = nombreUsuario.toUpperCase();
        apellidoUsuario = apellidoUsuario.toUpperCase();

        //Validamos que el rut no exista en el sistema
        if(alumnoFacade.existe(username) || profesorFacade.existe(username) || usuarioFacade.existe(username)){
            context.addMessage(null, new FacesMessage("ERROR: El Rut ingresado ya existe en el sistema.",""));
            return;
        }

        //Ingresamos al usuario
        Usuario nuevoUsuario = new Usuario(username);
        nuevoUsuario.setNombreUsuario(nombreUsuario);
        nuevoUsuario.setPassword(sha256(username.substring(0, 5)));
        nuevoUsuario.setApellidoUsuario(apellidoUsuario);
        nuevoUsuario.setActivo(true);
        usuarioFacade.create(nuevoUsuario);
        
        //Ingresamos el tipo usuario
        Tipo tipo = tipoFacade.find(tipoUsuario);
        UsuarioTipo usuarioTipo = new UsuarioTipo();
        usuarioTipo.setNombreTipo(tipo);
        usuarioTipo.setUsername(nuevoUsuario);
        usuarioTipoFacade.create(usuarioTipo);
        
        //Asignamos el usuario_tipo al usuario
        nuevoUsuario.add(usuarioTipo);
        usuarioFacade.edit(nuevoUsuario);
        
        context.addMessage(null, new FacesMessage("Usuario", nombreUsuario+" "+apellidoUsuario+", ingresado al sistema"));
        
        //Vaciamos el formulario
        username = null;
        nombreUsuario = null;
        apellidoUsuario = null;
        tipoUsuario = "";
    }
}
