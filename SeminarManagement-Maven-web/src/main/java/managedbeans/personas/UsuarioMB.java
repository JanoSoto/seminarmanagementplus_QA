/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans.personas;

import entities.Historial;
import entities.Profesor;
import entities.Tipousuario;
import entities.Usuario;
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
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import managedbeans.ProfesorViewMB;
import org.primefaces.model.DualListModel;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.TipousuarioFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author Elagos
 */
@ManagedBean(name = "usuarioMB")
@RequestScoped
public class UsuarioMB {

    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private TipousuarioFacadeLocal tipoFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;

    private String username, nombreUsuario, apellidoUsuario;
    private List<String> tipoUsuario;
    private List<String> tiposNoDelUsuario;
    private List<String> tiposDelUsuario;
    private DualListModel<String> tiposDualList;
    private Boolean estaEditando = true;
    private Boolean activo;

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }

    private String uid;

    public List<String> getTiposNoDelUsuario() {
        return tiposNoDelUsuario;
    }

    public void setTiposNoDelUsuario(List<String> tiposNoDelUsuario) {
        this.tiposNoDelUsuario = tiposNoDelUsuario;
    }

    public List<String> getTiposDelUsuario() {
        return tiposDelUsuario;
    }

    public void setTiposDelUsuario(List<String> tiposDelUsuario) {
        this.tiposDelUsuario = tiposDelUsuario;
    }

    public DualListModel<String> getTiposDualList() {
        return tiposDualList;
    }

    public void setTiposDualList(DualListModel<String> tiposDualList) {
        this.tiposDualList = tiposDualList;
    }

    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(UsuarioMB.class);

    @PostConstruct
    public void init() {
        System.out.println("Init");
        this.activo = true;
        this.estaEditando = false;
        if (this.uid != null && !this.uid.equals("")) {
            this.estaEditando = true;
        }
//        List<Tipousuario> tipos = tipoFacade.findAll();
        if (this.uid == null) {
            tiposDelUsuario = new ArrayList<>();
            tiposNoDelUsuario = new ArrayList<>();
            List<Tipousuario> tipos = tipoFacade.findAll();
            for (Tipousuario tipo : tipos) {
                tiposNoDelUsuario.add(tipo.getNombreTipo());
            }
        }
        this.tiposDualList = new DualListModel<>(tiposNoDelUsuario, tiposDelUsuario);
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
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public void cargarUsuario(String uid) {
        System.out.println("asdasd");
        System.out.println("asdasd");
        System.out.println("Buscando usuario");
        Usuario usuario = usuarioFacade.findByUid(uid);
        this.estaEditando = true;
        this.username = usuario.getRutUsuario();
        this.nombreUsuario = usuario.getNombreUsuario();
        this.apellidoUsuario = usuario.getApellidoUsuario();
        this.uid = uid.toUpperCase();
        this.activo = usuario.getActivo();
        System.out.println(usuario);
        this.estaEditando = true;
        System.out.println(this.estaEditando);
        List<Tipousuario> tipos = usuario.getTipos();
        System.out.println("Tipos: " + tipos.size());

        this.tiposDelUsuario = new ArrayList<>();
        List<Tipousuario> roles = usuario.getRoles();
        List<Tipousuario> roles_todos = tipoFacade.findAll();

        for (Tipousuario rol : roles) {
            this.tiposDelUsuario.add(rol.getNombreTipo());
        }
        roles_todos.removeAll(roles);
        this.tiposNoDelUsuario = new ArrayList<>();
        for (Tipousuario rol : roles_todos) {
            System.out.println("Añadi: " + rol.getNombreTipo());
            this.tiposNoDelUsuario.add(rol.getNombreTipo());
        }
        this.tiposDualList = new DualListModel<>(tiposNoDelUsuario, tiposDelUsuario);
        System.out.println("Editando final:");
        System.out.println(this.estaEditando);
    }

    public void guardarUsuario() throws NoSuchAlgorithmException, UnsupportedEncodingException, IOException {
        FacesContext context = FacesContext.getCurrentInstance();
        this.estaEditando = true;

        if (this.uid == null || "".equals(this.uid)) {
            context.addMessage(null, new FacesMessage("ERROR: Ingrese UID porfavor.", ""));
            return;
        }

        Usuario usuario = usuarioFacade.findByUid(this.uid.toLowerCase());

        //Seteamos algunos valores, como el nombre y apellido a mayúsculas
        //Sacamos guión y puntos del rut, además de dejarlo en mayúsculas si tiene -k
        username = username.toUpperCase();
        username = username.replace(".", "");
        username = username.replace("-", "");
        nombreUsuario = nombreUsuario.toUpperCase();
        apellidoUsuario = apellidoUsuario.toUpperCase();

        List<Tipousuario> aux = new ArrayList();
        //Ingresamos el tipo usuario
        System.out.println("Tamaño: " + this.tiposDualList.getTarget().size());
        System.out.println("Tamaño: " + this.tiposDelUsuario.size());
        System.out.println("TIPOS:");
        for (int i = 0; i < tiposDualList.getSource().size(); i++) {
            Tipousuario tipo = tipoFacade.findByNombreTipo(tiposDualList.getSource().get(i));
            List<Usuario> usuarios_tipo = tipo.getUsuarios();
            usuarios_tipo.remove(usuario);
            tipoFacade.edit(tipo);
        }
        for (int i = 0; i < tiposDualList.getTarget().size(); i++) {
//            Long tipo_id = Long.parseLong(tiposDualList.getTarget().get(i));
            System.out.println(tiposDualList.getTarget().get(i));
            Tipousuario tipo = tipoFacade.findByNombreTipo(tiposDualList.getTarget().get(i));
//            Tipousuario tipo = tipoFacade.find(Long.parseLong("1"));
            List<Usuario> usuarios_tipo = tipo.getUsuarios();
            usuarios_tipo.add(usuario);
            tipo.setUsuarios(usuarios_tipo);

            tipoFacade.edit(tipo);
            aux.add(tipo);
        }
        usuario.setTipos(aux);
        System.out.println("KKKKK:");
        System.out.println(this.activo);
        usuario.setNombreUsuario(this.nombreUsuario);
        usuario.setApellidoUsuario(this.apellidoUsuario);
        usuario.setActivo(this.activo);
//        nuevoUsuario.setTipos(tiposDualList.getTarget());

        usuarioFacade.edit(usuario);

        context.addMessage(null, new FacesMessage("Usuario", nombreUsuario + " " + apellidoUsuario + ", editado correctamente"));
        LOGGER.info("Se ha editado al usuario " + nombreUsuario + " " + apellidoUsuario);
        //Vaciamos el formulario
//        username = null;
//        nombreUsuario = null;
//        apellidoUsuario = null;
//        tipoUsuario = null;
    }

    public void agregarNuevoUsuario() throws NoSuchAlgorithmException, UnsupportedEncodingException {
        FacesContext context = FacesContext.getCurrentInstance();
        this.estaEditando = false;

        if (this.uid == null || "".equals(this.uid)) {
            context.addMessage(null, new FacesMessage("ERROR: Ingrese UID porfavor.", ""));
            return;
        }

        Usuario usuario = usuarioFacade.findByUid(this.uid.toLowerCase());
        System.out.println("Editando:");
        System.out.println(this.estaEditando);
        if (usuario != null && !this.estaEditando) {
            context.addMessage(null, new FacesMessage("ERROR: El UID ingresado ya se encuentra registrado en el sistema.", ""));
            return;
        }

        //Validamos que el rut no exista en el sistema
        if (usuarioFacade.existe(username)) {
            context.addMessage(null, new FacesMessage("ERROR: El Rut ingresado ya existe en el sistema.", ""));
            return;
        }

        //Seteamos algunos valores, como el nombre y apellido a mayúsculas
        //Sacamos guión y puntos del rut, además de dejarlo en mayúsculas si tiene -k
        username = username.toUpperCase();
        username = username.replace(".", "");
        username = username.replace("-", "");
        nombreUsuario = nombreUsuario.toUpperCase();
        apellidoUsuario = apellidoUsuario.toUpperCase();

        //Ingresamos al usuario
        Usuario nuevoUsuario = null;
        if (usuario == null) {
            nuevoUsuario = new Usuario(username);
        } else {
            nuevoUsuario = usuario;
        }
        this.uid = this.uid.toLowerCase();
        nuevoUsuario.setUid(this.uid);
        nuevoUsuario.setNombreUsuario(nombreUsuario);
        //nuevoUsuario.setPassword(sha256(username.substring(0, 5)));
        nuevoUsuario.setApellidoUsuario(apellidoUsuario);
        nuevoUsuario.setActivo(true);

        List<Tipousuario> aux = new ArrayList();
        //Ingresamos el tipo usuario
        System.out.println("Tamaño: " + this.tiposDualList.getTarget().size());
        System.out.println("Tamaño: " + this.tiposDelUsuario.size());
        System.out.println("TIPOS:");
        for (int i = 0; i < tiposDualList.getSource().size(); i++) {
            Tipousuario tipo = tipoFacade.findByNombreTipo(tiposDualList.getSource().get(i));
            List<Usuario> usuarios_tipo = tipo.getUsuarios();
            usuarios_tipo.remove(nuevoUsuario);
            tipoFacade.edit(tipo);
        }
        for (int i = 0; i < tiposDualList.getTarget().size(); i++) {
//            Long tipo_id = Long.parseLong(tiposDualList.getTarget().get(i));
            System.out.println(tiposDualList.getTarget().get(i));
            Tipousuario tipo = tipoFacade.findByNombreTipo(tiposDualList.getTarget().get(i));
//            Tipousuario tipo = tipoFacade.find(Long.parseLong("1"));
            List<Usuario> usuarios_tipo = tipo.getUsuarios();
            usuarios_tipo.add(nuevoUsuario);
            tipo.setUsuarios(usuarios_tipo);

            tipoFacade.edit(tipo);
            aux.add(tipo);
        }
        nuevoUsuario.setTipos(aux);
        System.out.println("KKKKK:");
        System.out.println(this.activo);
        nuevoUsuario.setActivo(this.activo);
//        nuevoUsuario.setTipos(tiposDualList.getTarget());

        usuarioFacade.edit(nuevoUsuario);

        if (this.estaEditando) {
            context.addMessage(null, new FacesMessage("Usuario", nombreUsuario + " " + apellidoUsuario + ", editado correctamente"));
            LOGGER.info("Se ha agregado al usuario " + nombreUsuario + " " + apellidoUsuario);
        } else {
            context.addMessage(null, new FacesMessage("Usuario", nombreUsuario + " " + apellidoUsuario + ", ingresado al sistema"));
            LOGGER.info("Se ha editado al usuario " + nombreUsuario + " " + apellidoUsuario);
        }
        //Vaciamos el formulario
//        username = null;
//        nombreUsuario = null;
//        apellidoUsuario = null;
//        tipoUsuario = null;
    }
}
