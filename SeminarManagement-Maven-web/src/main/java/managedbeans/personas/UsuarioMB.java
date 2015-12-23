/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans.personas;


import entities.Comuna;
import entities.Region;
import entities.Theme;
import entities.Tipousuario;
import entities.Usuario;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import javax.faces.event.AjaxBehaviorEvent;
import javax.servlet.http.HttpServletRequest;
import managedbeans.RegionesMB;
import org.primefaces.component.themeswitcher.ThemeSwitcher;
import org.primefaces.model.DualListModel;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.ComunaFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.RegionFacadeLocal;
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
    @EJB
    private ComunaFacadeLocal comunaFacade;
    @EJB
    private RegionFacadeLocal regionFacade;

    private String username, nombreUsuario, apellidoUsuario, telefonoUsuario, mailUsuario, direccionUsuario;
    private Integer comuna;
    private List<Region> regiones;
    private List<Comuna> comunas;
    private Integer regionElegida;
    private List<String> tipoUsuario;
    private List<String> tiposNoDelUsuario;
    private List<String> tiposDelUsuario;
    private DualListModel<String> tiposDualList;
    private Boolean estaEditando = true;
    private List<Theme> themes;

    private String theme = "usachborde";

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

    public String getTelefonoUsuario() {
        return telefonoUsuario;
    }

    public void setTelefonoUsuario(String telefonoUsuario) {
        this.telefonoUsuario = telefonoUsuario;
    }

    public String getMailUsuario() {
        return mailUsuario;
    }

    public void setMailUsuario(String mailUsuario) {
        this.mailUsuario = mailUsuario;
    }

    public String getDireccionUsuario() {
        return direccionUsuario;
    }

    public void setDireccionUsuario(String direccionUsuario) {
        this.direccionUsuario = direccionUsuario;
    }

    public Integer getComuna() {
        return comuna;
    }

    public void setComuna(Integer comuna) {
        this.comuna = comuna;
    }

    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(UsuarioMB.class);

    @PostConstruct
    public void init() {
        regiones = regionFacade.findAll();
        themes = new ArrayList<Theme>();
        themes.add(new Theme(0, "Afterdark", "afterdark"));
        themes.add(new Theme(1, "Afternoon", "afternoon"));
        themes.add(new Theme(2, "Afterwork", "afterwork"));
        themes.add(new Theme(3, "Aristo", "aristo"));
        themes.add(new Theme(4, "Black-Tie", "black-tie"));
        themes.add(new Theme(5, "Blitzer", "blitzer"));
        themes.add(new Theme(6, "Bluesky", "bluesky"));
        themes.add(new Theme(7, "Bootstrap", "bootstrap"));
        themes.add(new Theme(8, "Casablanca", "casablanca"));
        themes.add(new Theme(9, "Cupertino", "cupertino"));
        themes.add(new Theme(10, "Cruze", "cruze"));
        themes.add(new Theme(11, "Dark-Hive", "dark-hive"));
        themes.add(new Theme(12, "Delta", "delta"));
        themes.add(new Theme(13, "Dot-Luv", "dot-luv"));
        themes.add(new Theme(14, "Eggplant", "eggplant"));
        themes.add(new Theme(15, "Excite-Bike", "excite-bike"));
        themes.add(new Theme(16, "Flick", "flick"));
        themes.add(new Theme(17, "Glass-X", "glass-x"));
        themes.add(new Theme(18, "Home", "home"));
        themes.add(new Theme(19, "Hot-Sneaks", "hot-sneaks"));
        themes.add(new Theme(20, "Humanity", "humanity"));
        themes.add(new Theme(21, "Le-Frog", "le-frog"));
        themes.add(new Theme(22, "Midnight", "midnight"));
        themes.add(new Theme(23, "Mint-Choc", "mint-choc"));
        themes.add(new Theme(24, "Overcast", "overcast"));
        themes.add(new Theme(25, "Pepper-Grinder", "pepper-grinder"));
        themes.add(new Theme(26, "Redmond", "redmond"));
        themes.add(new Theme(27, "Rocket", "rocket"));
        themes.add(new Theme(28, "Sam", "sam"));
        themes.add(new Theme(29, "Smoothness", "smoothness"));
        themes.add(new Theme(30, "South-Street", "south-street"));
        themes.add(new Theme(31, "Start", "start"));
        themes.add(new Theme(32, "Sunny", "sunny"));
        themes.add(new Theme(33, "Swanky-Purse", "swanky-purse"));
        themes.add(new Theme(34, "Trontastic", "trontastic"));
        themes.add(new Theme(35, "UI-Darkness", "ui-darkness"));
        themes.add(new Theme(36, "UI-Lightness", "ui-lightness"));
        themes.add(new Theme(37, "USACH", "usachborde"));
        themes.add(new Theme(38, "Vader", "vader"));
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
        Usuario usuario = usuarioFacade.findByUid(uid);
        this.estaEditando = true;
        this.username = usuario.getRutUsuario();
        this.nombreUsuario = usuario.getNombreUsuario();
        if(usuario.getComuna() != null){
            this.regionElegida = usuario.getComuna().getComunaProvinciaId().getProvinciaRegionId().getRegionId();
            this.comuna = usuario.getComuna().getComunaId();
        }
        this.buscaComunas();
        this.apellidoUsuario = usuario.getApellidoUsuario();
        this.comuna = usuario.getComuna().getComunaId();
        this.uid = uid.toUpperCase();
        this.estaEditando = true;
        List<Tipousuario> tipos = usuario.getTipos();

        this.tiposDelUsuario = new ArrayList<>();
        List<Tipousuario> roles = usuario.getRoles();
        List<Tipousuario> roles_todos = tipoFacade.findAll();

        for (Tipousuario rol : roles) {
            this.tiposDelUsuario.add(rol.getNombreTipo());
        }
        roles_todos.removeAll(roles);
        this.tiposNoDelUsuario = new ArrayList<>();
        for (Tipousuario rol : roles_todos) {
            this.tiposNoDelUsuario.add(rol.getNombreTipo());
        }
        this.tiposDualList = new DualListModel<>(tiposNoDelUsuario, tiposDelUsuario);
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
        for (int i = 0; i < tiposDualList.getSource().size(); i++) {
            Tipousuario tipo = tipoFacade.findByNombreTipo(tiposDualList.getSource().get(i));
            List<Usuario> usuarios_tipo = tipo.getUsuarios();
            usuarios_tipo.remove(usuario);
            tipoFacade.edit(tipo);
        }
        for (int i = 0; i < tiposDualList.getTarget().size(); i++) {
            Tipousuario tipo = tipoFacade.findByNombreTipo(tiposDualList.getTarget().get(i));
            List<Usuario> usuarios_tipo = tipo.getUsuarios();
            usuarios_tipo.add(usuario);
            tipo.setUsuarios(usuarios_tipo);

            tipoFacade.edit(tipo);
            aux.add(tipo);
        }
        usuario.setComuna(new Comuna(comuna));
        usuario.setTipos(aux);
        usuario.setNombreUsuario(this.nombreUsuario);
        usuario.setApellidoUsuario(this.apellidoUsuario);
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
        uid = uid.toLowerCase();

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
        nuevoUsuario.setTema("usachborde");
        if(comuna != null)
            nuevoUsuario.setComuna(new Comuna(comuna));
        nuevoUsuario.setDireccionUsuario(direccionUsuario);
        nuevoUsuario.setMailUsuario(mailUsuario);
        nuevoUsuario.setTelefonoUsuario(telefonoUsuario);
        List<Tipousuario> aux = new ArrayList();
        //Ingresamos el tipo usuario
        for (int i = 0; i < tiposDualList.getSource().size(); i++) {
            Tipousuario tipo = tipoFacade.findByNombreTipo(tiposDualList.getSource().get(i));
            List<Usuario> usuarios_tipo = tipo.getUsuarios();
            usuarios_tipo.remove(nuevoUsuario);
            tipoFacade.edit(tipo);
        }
        for (int i = 0; i < tiposDualList.getTarget().size(); i++) {
//            Long tipo_id = Long.parseLong(tiposDualList.getTarget().get(i));
            Tipousuario tipo = tipoFacade.findByNombreTipo(tiposDualList.getTarget().get(i));
//            Tipousuario tipo = tipoFacade.find(Long.parseLong("1"));
            List<Usuario> usuarios_tipo = tipo.getUsuarios();
            usuarios_tipo.add(nuevoUsuario);
            tipo.setUsuarios(usuarios_tipo);

            tipoFacade.edit(tipo);
            aux.add(tipo);
        }
        nuevoUsuario.setTipos(aux);
//        nuevoUsuario.setTipos(tiposDualList.getTarget());
        context.addMessage(null, new FacesMessage("Usuario " + this.uid + " creado correctamente."));
        //LOGGER.info("Se ha editado al usuario " + nombreUsuario + " " + apellidoUsuario);
        usuarioFacade.edit(nuevoUsuario);

        //Vaciamos el formulario
//        username = null;
//        nombreUsuario = null;
//        apellidoUsuario = null;
//        tipoUsuario = null;
    }

    public void eliminarUsuario() {
        Usuario usuario = usuarioFacade.findByUid(this.uid.toLowerCase());
        List<Tipousuario> roles = usuario.getRoles();
        for (Tipousuario rol : roles) {
            rol.getUsuarios().remove(usuario);
            tipoFacade.edit(rol);
        }
        usuarioFacade.remove(usuario);
        FacesContext context = FacesContext.getCurrentInstance();
        context.addMessage(null, new FacesMessage("Usuario " + this.uid + " eliminado correctamente."));
    }
    
    public String getTheme() {
       HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();
       //this.theme = "usachborde";
       if (request.getUserPrincipal() != null) {
           Usuario user = usuarioFacade.findByUid(request.getUserPrincipal().toString());
           if(user.getTema()!=null){             
            this.theme = user.getTema();
           }
       }
       
       return this.theme; 
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }
    
        public List<Theme> getThemes() {
        return themes;
    }

    public void setThemes(List<Theme> themes) {
        this.themes = themes;
    }
    
    public void saveTheme(AjaxBehaviorEvent ajax) {
       //System.out.println("Tema anterior: " + this.theme);
       String tema=this.theme;
       //String tema = (String) ((ThemeSwitcher)ajax.getSource()).getValue();
       //System.out.println("Tema: " + tema);
       //System.out.println("Tema this.theme: " + this.theme);
       HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();
       Usuario user = usuarioFacade.findByUid(request.getUserPrincipal().toString());
       //System.out.println("UID:" + request.getUserPrincipal().toString());
       //System.out.println("Tema this.theme: " + this.theme);
       user.setTema(tema);
       
       Usuario usuarioEditado = user;
       //System.out.println("Cambio de tema a: "+ tema);
       usuarioFacade.edit(usuarioEditado);
        
       setTheme(tema);
       //System.out.println("Cambio de tema a: "+ this.theme);
       
    }
    
    public void buscaComunas(){
        comunas = comunaFacade.findByRegion(new Region(regionElegida));
    }
    
    public void buscaComunas(Region region){
        comunas = comunaFacade.findByRegion(region);
    }
    
    public List<Region> getRegiones() {
        return regiones;
    }

    public void setRegiones(List<Region> regiones) {
        this.regiones = regiones;
    }

    public List<Comuna> getComunas() {
        return comunas;
    }

    public void setComunas(List<Comuna> comunas) {
        this.comunas = comunas;
    }

    public Integer getRegionElegida() {
        return regionElegida;
    }

    public void setRegionElegida(Integer regionElegida) {
        this.regionElegida = regionElegida;
    }
}
