/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans.personas;

import entities.Alumno;
import entities.Historial;
import entities.Profesor;
import java.text.SimpleDateFormat;
import java.util.Date;
import sessionbeans.AlumnoFacadeLocal;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import managedbeans.AuthMB;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;


/**
 *
 * @author Eduardo
 */
@ManagedBean(name ="alumnoMB")
@RequestScoped
public class AlumnoMB {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;

    private String nombreAlumno,apellidoAlumno, rutAlumno, mailAlumno, celularAlumno, direccionAlumno;
    private Integer carreraAlumno, jornadaAlumno, pet;
    private List<Alumno> alumnos;
    
    
    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value="#{authMB}")
    private AuthMB user;
    
    public AlumnoMB() {
    }
    
    @PostConstruct
    public void init(){
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        System.out.println(user.toString());
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
    
    public Integer getPet() {
        return pet;
    }

    public void setPet(Integer pet) {
        this.pet = pet;
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
    
    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public void addStudent(){
        FacesContext context = FacesContext.getCurrentInstance();
        //Sacamos guión y puntos del rut, además de dejarlo en mayúsculas si tiene -k
        rutAlumno = rutAlumno.toUpperCase();
        rutAlumno = rutAlumno.replace(".", "");
        rutAlumno = rutAlumno.replace("-", "");
        List<Profesor> profesoresIngresados = profesorFacade.findByRut(rutAlumno);
        List<Alumno> alumnosIngresados = alumnoFacade.findByRut(rutAlumno);
        
        //Validamos que el rut no exista en el sistema
        if(!profesoresIngresados.isEmpty() || !alumnosIngresados.isEmpty() ){
            context.addMessage(null, new FacesMessage("ERROR: El Rut ingresado ya existe en el sistema.",""));
            return;
        }
        
        //Ingresamos el alumno
        Alumno nuevoAlumno = new Alumno(rutAlumno);
        nuevoAlumno.setNombreAlumno(nombreAlumno.toUpperCase());
        nuevoAlumno.setApellidoAlumno(apellidoAlumno.toUpperCase());
        nuevoAlumno.setMailAlumno(mailAlumno.toUpperCase());
        nuevoAlumno.setTelefonoAlumno(celularAlumno);
        nuevoAlumno.setDireccionAlumno(direccionAlumno);
        if (pet == 0)
            nuevoAlumno.setPet(false);
        if (pet == 1)
            nuevoAlumno.setPet(true);
        nuevoAlumno.setJornada(jornadaAlumno);
        nuevoAlumno.setCarreraAlumno(carreraAlumno); 
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
        context.addMessage(null, new FacesMessage("Alumno", nombreAlumno+" "+apellidoAlumno+", ingresado al sistema"));
        
        //Vaciamos el formulario
        nombreAlumno = null;
        apellidoAlumno = null;
        rutAlumno = null;
        mailAlumno = null;
        celularAlumno = null;
        carreraAlumno = null;
        jornadaAlumno = null;
        direccionAlumno = null;
        pet = null;
    }
}
