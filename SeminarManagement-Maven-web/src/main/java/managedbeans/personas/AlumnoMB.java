package managedbeans.personas;

import entities.Alumno;
import entities.Comuna;
import entities.PlanEstudio;
import entities.Profesor;
import entities.Usuario;
import entities.Versionplan;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.inject.Named;
import managedbeans.AuthMB;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.PlanestudioFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author Eduardo
 */
@SessionScoped
@Named("alumnoMB")
public class AlumnoMB implements Serializable {

    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;

    @EJB
    private PlanestudioFacadeLocal planesFacade;

    private String nombreAlumno, apellidoAlumno, rutAlumno, mailAlumno, celularAlumno, direccionAlumno;
    private Integer carreraAlumno, jornadaAlumno, comuna;
    private List<PlanEstudio> planes;
    private List<Alumno> alumnos;

    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(AlumnoMB.class);
    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value = "#{authMB}")
    private AuthMB user;
    private Alumno alumno;
    private Usuario usuario;

    public AlumnoMB() {
    }

    @PostConstruct
    public void init() {
        //Para inicializar el managed property, si no no se puede acceder a esos datos
    }

    public String prepareCreate() {
        alumno = new Alumno();
        usuario = new Usuario();
        return "agregar";
    }

    public AuthMB getUser() {
        return user;
    }

    public void setUser(AuthMB user) {
        this.user = user;
    }

    public String getDireccionAlumno() {
        return direccionAlumno;
    }

    public void setDireccionAlumno(String direccionAlumno) {
        this.direccionAlumno = direccionAlumno;
    }

    public Integer getJornadaAlumno() {
        return jornadaAlumno;
    }

    public void setJornadaAlumno(Integer jornadaAlumno) {
        this.jornadaAlumno = jornadaAlumno;
    }

    public String getNombreAlumno() {
        return nombreAlumno;
    }

    public void setNombreAlumno(String nombreAlumno) {
        this.nombreAlumno = nombreAlumno;
    }

    public String getApellidoAlumno() {
        return apellidoAlumno;
    }

    public void setApellidoAlumno(String apellidoAlumno) {
        this.apellidoAlumno = apellidoAlumno;
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public String getMailAlumno() {
        return mailAlumno;
    }

    public void setMailAlumno(String mailAlumno) {
        this.mailAlumno = mailAlumno;
    }

    public String getCelularAlumno() {
        return celularAlumno;
    }

    public void setCelularAlumno(String celularAlumno) {
        this.celularAlumno = celularAlumno;
    }

    public Integer getCarreraAlumno() {
        return carreraAlumno;
    }

    public void setCarreraAlumno(Integer carreraAlumno) {
        this.carreraAlumno = carreraAlumno;
    }

    public List<Alumno> getAlumnos() {
        return alumnos;
    }

    public void setAlumnos(List<Alumno> alumnos) {
        this.alumnos = alumnos;
    }

    public Integer getComuna() {
        return comuna;
    }

    public void setComuna(Integer comuna) {
        this.comuna = comuna;
    }

    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public void addStudent() {
        FacesContext context = FacesContext.getCurrentInstance();
        //Sacamos guión y puntos del rut, además de dejarlo en mayúsculas si tiene -k
        rutAlumno = rutAlumno.toUpperCase();
        rutAlumno = rutAlumno.replace(".", "");
        rutAlumno = rutAlumno.replace("-", "");
        List<Profesor> profesoresIngresados = profesorFacade.findByRut(rutAlumno);
        List<Alumno> alumnosIngresados = alumnoFacade.findByRut(rutAlumno);

        //Validamos que el rut no exista en el sistema
        if (!profesoresIngresados.isEmpty() || !alumnosIngresados.isEmpty()) {
            context.addMessage(null, new FacesMessage("ERROR: El Rut ingresado ya existe en el sistema.", ""));
            return;
        }

        //Ingresamos el alumno
        Alumno nuevoAlumno = new Alumno(rutAlumno);
        nuevoAlumno.setNombreAlumno(nombreAlumno.toUpperCase());
        nuevoAlumno.setApellidoAlumno(apellidoAlumno.toUpperCase());
        nuevoAlumno.setMailAlumno(mailAlumno.toUpperCase());
        nuevoAlumno.setTelefonoAlumno(celularAlumno);
        nuevoAlumno.setDireccionAlumno(direccionAlumno);

        //nuevoAlumno.setJornada(jornadaAlumno); deprecado
        nuevoAlumno.setPlanes(planes);
        alumnoFacade.create(nuevoAlumno);

        /*
         //Añadimos al historial del alumno cuándo fue agregado
         Date temp = new Date();
         String dateHist = dateToString(temp);
         Historial histAlumAgregado = new Historial();
         histAlumAgregado.setDescripcion("Se ingresó alumno al sistema. Lo ingresó el usuario "+user.getFullNameUser());
         histAlumAgregado.setFechaHistorial(dateHist);
         histAlumAgregado.setTipoHistorial(2);
         histAlumAgregado.setIdEntidad(rutAlumno);
         historialFacade.create(histAlumAgregado);
        
        
         //Añadimos al historial del usuario que lo ingresó
         Historial histAlumAgregadoUser = new Historial();
         histAlumAgregadoUser.setDescripcion("Ingresó al sistema al alumno "+nombreAlumno.toUpperCase()+" "+apellidoAlumno.toUpperCase());
         histAlumAgregadoUser.setFechaHistorial(dateHist);
         histAlumAgregadoUser.setTipoHistorial(3);
         histAlumAgregadoUser.setIdEntidad(user.getUsername());
         historialFacade.create(histAlumAgregadoUser);
         */
        context.addMessage(null, new FacesMessage("Alumno", nombreAlumno + " " + apellidoAlumno + ", ingresado al sistema"));
        LOGGER.info("Se ha agregado el alumno " + nombreAlumno + " " + apellidoAlumno);
        //Vaciamos el formulario
        nombreAlumno = null;
        apellidoAlumno = null;
        rutAlumno = null;
        mailAlumno = null;
        celularAlumno = null;
        carreraAlumno = null;
        jornadaAlumno = null;
        direccionAlumno = null;
    }

    public String create() {
        try {
            FacesContext context = FacesContext.getCurrentInstance();
            alumno.setRutAlumno(alumno.getRutAlumno().replace(".", ""));
            alumno.setRutAlumno(alumno.getRutAlumno().replace("-", ""));
            List<Alumno> alumnosIngresados = alumnoFacade.findByRut(alumno.getRutAlumno());
            List<Profesor> profesoresIngresados = profesorFacade.findByRut(alumno.getRutAlumno());
            List<Usuario> usuariosIngresados = usuarioFacade.findByRut(alumno.getRutAlumno());

            //Validamos que el rut no exista en el sistema
            if (!alumnosIngresados.isEmpty()) {
                context.addMessage(null, new FacesMessage("ERROR: El alumno ingresado ya existe en el sistema.", ""));
                return null;
            } else if (!profesoresIngresados.isEmpty()) {
                alumno.setUsuario(profesoresIngresados.get(0).getUsuario());
                alumnoFacade.create(alumno);
                context.addMessage(null, new FacesMessage("Alumno", alumno.getNombreAlumno()
                        + " " + alumno.getApellidoAlumno() + ", ingresado al sistema"));
//                LOGGER.info("Se ha agregado el alumno " + alumno.getNombreAlumno() + " " + alumno.getApellidoAlumno());

                return prepareCreate();
            }
            else if (!usuariosIngresados.isEmpty()) {
                System.out.println(usuariosIngresados);
                alumno.setUsuario(usuariosIngresados.get(0));
                alumnoFacade.create(alumno);
                context.addMessage(null, new FacesMessage("Alumno", alumno.getNombreAlumno()
                        + " " + alumno.getApellidoAlumno() + ", ingresado al sistema"));
//                LOGGER.info("Se ha agregado el alumno " + alumno.getNombreAlumno() + " " + alumno.getApellidoAlumno());

                return prepareCreate();
            }
            alumno.setNombreAlumno(alumno.getNombreAlumno().toUpperCase());
            alumno.setApellidoAlumno(alumno.getApellidoAlumno().toUpperCase());
            alumno.setMailAlumno(alumno.getMailAlumno().toUpperCase());
            alumno.getUsuario().setUid(alumno.getUsuario().getUid().toLowerCase());
            alumno.getUsuario().setComuna(new Comuna(comuna));
            usuarioFacade.create(alumno.getUsuario());
            alumnoFacade.create(alumno);

            context.addMessage(null, new FacesMessage("Alumno", alumno.getNombreAlumno()
                    + " " + alumno.getApellidoAlumno() + ", ingresado al sistema"));
//            LOGGER.info("Se ha agregado el alumno " + alumno.getNombreAlumno() + " " + alumno.getApellidoAlumno());

            return prepareCreate();
        } catch (Exception e) {
            return null;
        }
    }

    public void buscarAlumno(ActionEvent actionEvent){
        try {
            FacesContext context = FacesContext.getCurrentInstance();
            if (!alumnoFacade.findByRut(alumno.getUsuario().getRutUsuario()).isEmpty()) {
                context.addMessage(null, new FacesMessage("ADVERTENCIA: El rut ingresado ya existe y se encuentra registrado como alumno.", ""));
            }
            else{
                usuario = usuarioFacade.findByRut(alumno.getUsuario().getRutUsuario()).get(0);
                alumno.setUsuario(usuario);
            }
        } catch (Exception e) {
        }
    }
    
    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public Integer getAnioPlan(Integer id_plan, Integer version_plan) {
        List<PlanEstudio> planes = planesFacade.findAll();
        PlanEstudio plan = null;

        for (int i = 0; i < planes.size(); i++) {
            if (planes.get(i).getId().equals(Long.parseLong(id_plan + ""))) {
                List<Versionplan> versiones = planes.get(i).getVersionplanList();
                for (int j = 0; j < versiones.size(); j++) {
                    Versionplan versionPlan = versiones.get(j);

                    if (versionPlan.getVersion() == Long.parseLong(version_plan + "")) {

                        return versionPlan.getAnio();
                    }
                }
            }
        }
        return -1;
    }
}
