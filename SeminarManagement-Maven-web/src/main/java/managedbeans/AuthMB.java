package managedbeans;

import entities.Tipo;
import entities.Usuario;
import entities.UsuarioTipo;
import java.io.IOException;
import java.io.Serializable;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import org.json.simple.JSONObject;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.inject.Named;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;
import org.apache.log4j.MDC;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import sessionbeans.TipoFacadeLocal;

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
    @EJB
    private TipoFacadeLocal tipoFacade;
    private String uid = null, password = null, nombre = null, apellido = null;
    private long tipo = 0;
    private Tipo tipoUser;
    private static final String USERKEY = "user";

    @PostConstruct
    public void init() {

    }

    //Si el usuario ya inició sesión, e ingresa a la página de login
    //se redirige a la aplicación
    public void redirectUserLogged() {
        FacesContext context = FacesContext.getCurrentInstance();
        ExternalContext externalContext = context.getExternalContext();
        if (!getLoggedUser().equals("")) {
            try {
                Usuario usuario = usuarioFacade.findByRut("175658173").get(0);
                List<UsuarioTipo> tipos = usuario.getUsuarioTipoList();
                System.out.println("Tipos");
                for (int i = 0; i < tipos.size(); i++) {
                    System.out.println("Pene: " + tipos.get(i).getTipo().getNombreTipo());
                }
                if (tipoUser.getNombreTipo().equals("ADMINISTRADOR")) {
                    externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/admin/index.xhtml");
                }
                if (tipoUser.getNombreTipo().equals("SECRETARIA")) {
                    externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/secretaria/index.xhtml");
                }
            } catch (IOException ex) {
                Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public String MD5(String md5) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(md5.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < array.length; ++i) {
                sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
        }
        return null;
    }

    public void login() throws IOException, ServletException, NoSuchAlgorithmException, ParseException {
        FacesContext context = FacesContext.getCurrentInstance();
        ExternalContext externalContext = context.getExternalContext();
        HttpServletRequest request = (HttpServletRequest) externalContext.getRequest();

        HttpClient httpclient = new DefaultHttpClient();
        HttpPost httppost = new HttpPost("http://inicio.diinf.usach.cl/webservice.php");

        // Add your data
        List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2);
        nameValuePairs.add(new BasicNameValuePair("user", uid));
        nameValuePairs.add(new BasicNameValuePair("pass", password));
        nameValuePairs.add(new BasicNameValuePair("keyapi", MD5("c55ecd5c60a5a5b2bea1c92bbc45f8ab")));
        httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs));

        // Execute HTTP Post Request
        HttpResponse response = httpclient.execute(httppost);

        String responseString = new BasicResponseHandler().handleResponse(response);
        System.out.println(responseString);
        List<Usuario> todos = usuarioFacade.findAll();
        for (int index = 0; index < todos.size(); index++) {
            Usuario usuario = todos.get(index);
            List<UsuarioTipo> tipos = usuario.getUsuarioTipoList();
            System.out.println("Tipos");
            if(esDeTipo("ADMINISTRADOR", tipos)) {
                System.out.println("Es Admin");
                externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/admin/index.xhtml");
            }
            if(esDeTipo("SECRETARIA", tipos)){
                System.out.println("Es secretaria");
                externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/secretaria/index.xhtml");
            }
        }

        JSONParser parser = new JSONParser();

        Object obj = parser.parse(responseString);

        JSONObject jsonObject = (JSONObject) obj;

        Boolean valido_response = (Boolean) jsonObject.get("pass_ok");
        if (valido_response == null) {
            valido_response = false;
        }
            //System.out.println("Datos Validos: " + valido_response);

        //MessageDigest md = MessageDigest.getInstance("SHA-256");
        //md.update(password.getBytes("UTF-8"));
        //request.login(username, password);
        if (valido_response == true) {
            Usuario user = usuarioFacade.findByUsername(uid).get(0); //Extraigo el user de la db           
            nombre = user.getNombreUsuario();
            apellido = user.getApellidoUsuarioPaterno();
            tipo = user.getUsuarioTipoList().get(0).getUsuarioTipoPK().getIdTipo();
            Tipo tipoUser;
            tipoUser = tipoFacade.find(tipo);
            externalContext.getSessionMap().put("user", user);
            MDC.put(USERKEY, uid);
            if (tipoUser.getNombreTipo().equals("ADMINISTRADOR")) {
                externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/admin/index.xhtml");
            }
            if (tipoUser.getNombreTipo().equals("SECRETARIA")) {
                externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/secretaria/index.xhtml");
            }
        } else {
            //Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, e);
            context.addMessage(null, new FacesMessage("Ingreso Erróneo", "Los datos ingresados no son correctos."));
            uid = null;
            password = null;
            nombre = null;
            apellido = null;
            tipo = 0;
            //Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, e);
            context.addMessage(null, new FacesMessage("Ingreso Erróneo", "Los datos ingresados no son correctos."));
        }
        //} catch (IOException e) {
        //Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, e);
        // context.addMessage(null, new FacesMessage("Ingreso Erróneo", "Los datos ingresados no son correctos."));
        ///  username = null;
        //  password = null;
        //  nombre = null;
        //  apellido = null;
        // tipo = null;
        //Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, e);
        // context.addMessage(null, new FacesMessage("Ingreso Erróneo", "Los datos ingresados no son correctos."));
        //}
    }

    public String getLoggedUser() {
        HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();
        if (request.getUserPrincipal() != null) {
            return nombre;
        }
        return "";
    }

    public boolean isLogged() {
        HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();
        if (request.getUserPrincipal() != null) {
            return true;
        }
        return false;
    }

    //Función que retornar nombre completo
    public String getFullNameUser() {
        return nombre + " " + apellido;
    }

    public void logout() throws IOException {
        ExternalContext externalContext = FacesContext.getCurrentInstance().getExternalContext();
        externalContext.invalidateSession();
        nombre = null;
        apellido = null;
        password = null;
        tipo = 0;
        MDC.remove(USERKEY);
        externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/login.xhtml");

    }

    public long getTipo() {
        return tipo;
    }

    public void setTipo(long tipo) {
        this.tipo = tipo;
    }

    public String getUsername() {
        return uid;
    }

    public void setUsername(String uid) {
        this.uid = uid;
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

    private Boolean esDeTipo(String administrador, List<UsuarioTipo> tipos) {
        for (int i = 0; i < tipos.size(); i++) {
            if(tipos.get(i).getTipo().getNombreTipo().equals(administrador)) {
                return true;
            }
        }
        return false;
    }

}
