package managedbeans;

import entities.Tipousuario;
import entities.Usuario;
import java.io.IOException;
import java.io.Serializable;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
//import org.json.simple.JSONObject;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.inject.Named;
import javax.servlet.RequestDispatcher;
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
import org.primefaces.json.JSONException;
import org.primefaces.json.JSONObject;

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
    
    private List<Tipousuario> roles;


    private String username = null, password = null, nombre = null, apellido = null, tipo = null;

    private static final String USERKEY = "user";
    private String originalURL;

    @PostConstruct
    public void init() {
        ExternalContext externalContext = FacesContext.getCurrentInstance().getExternalContext();
        originalURL = (String) externalContext.getRequestMap().get(RequestDispatcher.FORWARD_REQUEST_URI);

        if (originalURL == null) {
            originalURL = externalContext.getRequestContextPath() + "/index.xhtml";
        } else {
            String originalQuery = (String) externalContext.getRequestMap().get(RequestDispatcher.FORWARD_QUERY_STRING);

            if (originalQuery != null) {
                originalURL += "?" + originalQuery;
            }
        }

    }

    //Si el usuario ya inició sesión, e ingresa a la página de login
    //se redirige a la aplicación
    public void redirectUserLogged() throws InterruptedException, IOException {
        FacesContext context = FacesContext.getCurrentInstance();
        ExternalContext externalContext = context.getExternalContext();
        if (!getLoggedUser().equals("")) {
            try {
                switch (tipo) {
                    case "ADMINISTRADOR":
                        externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/admin/index.xhtml");
                        break;
                    case "PROFESOR":
                        externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/profesor/index.xhtml");
                        break;
                    case "SECRETARIA":
                        externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/secretaria/index.xhtml");
                        break;
                }
            } catch (IOException ex) {
                context.addMessage(null, new FacesMessage("Ingreso Erróneo", "Los datos ingresados no son correctos."));
                //RequestDispatcher rd = externalContext.dispatch(externalContext.getRequestContextPath() + "/2.0/login.xhtml");
                //Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, ex);
                externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/login.xhtml");
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

    public void login() throws IOException, ServletException, NoSuchAlgorithmException, ParseException, org.json.simple.parser.ParseException, JSONException, InterruptedException {
        FacesContext context = FacesContext.getCurrentInstance();
        ExternalContext externalContext = context.getExternalContext();
        HttpServletRequest request = (HttpServletRequest) externalContext.getRequest();

        try {

            HttpClient httpclient = new DefaultHttpClient();
            HttpPost httppost = new HttpPost("http://inicio.diinf.usach.cl/webservice.php");

            // Add your data
            List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2);
            nameValuePairs.add(new BasicNameValuePair("user", username));
            nameValuePairs.add(new BasicNameValuePair("pass", password));
            nameValuePairs.add(new BasicNameValuePair("keyapi", MD5("c55ecd5c60a5a5b2bea1c92bbc45f8ab")));
            httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs));

            // Execute HTTP Post Request
            HttpResponse response = httpclient.execute(httppost);

            String responseString = new BasicResponseHandler().handleResponse(response);
            

            //JSONParser parser = new JSONParser();

            //Object obj = parser.parse(responseString);

            JSONObject jsonObject = new JSONObject(responseString);

            Boolean valido_response = (Boolean) jsonObject.get("pass_ok");
            if(valido_response == null) {
                valido_response = false;
            }
            

            //MessageDigest md = MessageDigest.getInstance("SHA-256");
            //md.update(password.getBytes("UTF-8"));
            
            request.login(username, jsonObject.getString("pass_ok"));
            if(valido_response == true && usuarioFacade.findByUid(username)!= null){
                Usuario usuario = usuarioFacade.findByUid(username);
                setRoles(usuario.getRoles());
                //List <Tipousuario> aux = new ArrayList();
               // List<Map<Tipousuario, Integer>> aux = new ArrayList<>();
                Map<Integer, Tipousuario> auxMap = new HashMap<>();
                List<Integer> numeros= new ArrayList<>();
                for (Tipousuario role : roles) {
                    switch (role.getNombreTipo()) {
                        case "ADMINISTRADOR":
                            //aux.add(roles.get(i));
                            auxMap.put(10, role);
                            numeros.add(10);
                            break;
                        case "PROFESOR":
                            //aux.add(roles.get(i));
                            auxMap.put(5, role);
                            numeros.add(5);
                            break;
                        case "SECRETARIA":
                            //aux.add(roles.get(i));
                            auxMap.put(1, role);
                            numeros.add(1);
                            break;
                    }
                }
                int numeromax = Collections.max(numeros);
                //tipo = aux.get(0).getNombreTipo();
                tipo = auxMap.get(numeromax).getNombreTipo();
                
                switch (tipo) {
                    case "ADMINISTRADOR":
                        externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/admin/index.xhtml");
                        break;
                    case "PROFESOR":
                        externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/profesor/index.xhtml");
                        break;
                    case "SECRETARIA":
                        externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/secretaria/index.xhtml");
                        break;
                }
            }else{
                context.addMessage(null, new FacesMessage("Ingreso Erróneo", "Los datos ingresados no pertenecen a la base de datos."));
                externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/login.xhtml");
                //externalContext.redirect(externalContext.getRequestContextPath());
            }
            /*Usuario user = usuarioFacade.findByUsername(username).get(0); //Extraigo el user de la db           
            nombre = user.getNombreUsuario();
            apellido = user.getApellidoUsuario();
            tipo = user.getUsuarioTipoList().get(0).getNombreTipo().getNombreTipo();
            */
            externalContext.getSessionMap().put("user", username);
            
            MDC.put(USERKEY, username);
        } catch (IOException e) {
            //Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, e);
            context.addMessage(null, new FacesMessage("Ingreso Erróneo", "Los datos ingresados no son correctos."));
            externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/login.xhtml");
           // externalContext.redirect(externalContext.getRequestContextPath()+"/login.xhtml");
        } catch (ServletException e) {
            username = null;
            password = null;
            nombre = null;
            apellido = null;
            tipo = null;
            //Logger.getLogger(AuthMB.class.getName()).log(Level.SEVERE, null, e);
            context.addMessage(null, new FacesMessage("Ingreso Erróneo", "Los datos ingresados no son correctos."));

            externalContext.redirect(externalContext.getRequestContextPath() + "/2.0/login.xhtml");
           // externalContext.redirect(externalContext.getRequestContextPath());
        }
    }

    public String getLoggedUser() {
        HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();
        if (request.getUserPrincipal() != null) {
            return username;
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
        username=null;
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

   public List<Tipousuario> getRoles() {
        return roles;
    }

    public void setRoles(List<Tipousuario> roles) {
        this.roles = roles;
    }

}
