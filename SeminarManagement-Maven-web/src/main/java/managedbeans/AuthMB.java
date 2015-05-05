/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package managedbeans;

import entities.Usuario;
import java.io.IOException;
import java.io.Serializable;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.inject.Named;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;
import org.apache.log4j.MDC;

/**
 *
 * @author Eduardo
 */
@Named(value = "authMB")
@SessionScoped
public class AuthMB implements Serializable {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;

    private String username=null, password=null, nombre=null, apellido=null, tipo=null;
    
    private static final String USERKEY = "user";
    
    @PostConstruct
    public void init() {
        
    }
    //Si el usuario ya inició sesión, e ingresa a la página de login
    //se redirige a la aplicación
    public void redirectUserLogged() {
        FacesContext context = FacesContext.getCurrentInstance();
        ExternalContext externalContext = context.getExternalContext();
        if(!getLoggedUser().equals("")){
            try {
                if(tipo.equals("ADMINISTRADOR"))
                    externalContext.redirect(externalContext.getRequestContextPath() +"/2.0/admin/index.xhtml");
                if(tipo.equals("SECRETARIA"))
                    externalContext.redirect(externalContext.getRequestContextPath() +"/2.0/secretaria/index.xhtml");
            } catch (IOException ex) {
                Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    public void login() throws IOException, ServletException, NoSuchAlgorithmException {
        FacesContext context = FacesContext.getCurrentInstance();
        ExternalContext externalContext = context.getExternalContext();
        HttpServletRequest request = (HttpServletRequest) externalContext.getRequest();

        try {
            //MessageDigest md = MessageDigest.getInstance("SHA-256");
            //md.update(password.getBytes("UTF-8"));
            request.login(username, password);
            
            Usuario user = usuarioFacade.findByUsername(username).get(0); //Extraigo el user de la db           
            nombre = user.getNombreUsuario();
            apellido = user.getApellidoUsuario();
            tipo = user.getUsuarioTipoList().get(0).getNombreTipo().getNombreTipo();
            externalContext.getSessionMap().put("user", user);
            MDC.put(USERKEY, nombre);
            if(tipo.equals("ADMINISTRADOR"))
                externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/admin/index.xhtml");
            if(tipo.equals("SECRETARIA"))
                externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/secretaria/index.xhtml");
        } catch (IOException e) {
            //Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, e);
            context.addMessage(null, new FacesMessage("Ingreso Erróneo","Los datos ingresados no son correctos."));
        } catch (ServletException e) {
            username = null;
            password = null;
            nombre = null;
            apellido = null;
            tipo = null;
            //Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, e);
            context.addMessage(null, new FacesMessage("Ingreso Erróneo","Los datos ingresados no son correctos."));
        }
    }
    
    public String getLoggedUser(){
        HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();
        if(request.getUserPrincipal() != null)
            return nombre;
        return "";
    }
    
    public boolean isLogged() {
        HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();
        if(request.getUserPrincipal() != null)
            return true;
        return false;
    }
    
    //Función que retornar nombre completo
    public String getFullNameUser(){
        return nombre+" "+apellido;
    }
    
    public void logout() throws IOException {
        ExternalContext externalContext = FacesContext.getCurrentInstance().getExternalContext();
        externalContext.invalidateSession();
        nombre = null;
        apellido = null;
        password = null;
        tipo = null;
        MDC.remove(USERKEY);
        externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/login.xhtml");
        
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }
    
}

