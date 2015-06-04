package managedbeans;

import clases.AlumnoDatos;
import clases.ComisionCorrecDatos;
import clases.ComisionRevDatos;
import clases.PropuestaDatos;
import clases.TemaDatos;
import entities.Alumno;
import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.Historial;
import entities.Tema;
import java.io.IOException;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import javax.inject.Named;
import javax.servlet.http.HttpSession;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author Eduardo
 */
@Named(value = "alumnoViewMB")
@SessionScoped
public class AlumnoViewMB implements Serializable {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    private boolean mostrarProfRevs;
    /**
     * Creates a new instance of AlumnoViewMB
     */
    private AlumnoDatos alumnoSelected, alumnoEdit;
    private List<ComisionRevDatos> comRevisoras;
    private List<PropuestaDatos> propuestas;
    private List<ComisionCorrecDatos> comCorrectoras;
    private List<TemaDatos> temas;
    private String rutAlum;
    private List<Historial> histAlum;
    
    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value="#{authMB}")
    private AuthMB user;
    
    public AuthMB getUser() {
        return user;
    }

    public void setUser(AuthMB user) {
        this.user = user;
    }
    
    @PostConstruct
    public void init(){
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        System.out.println(user.toString());
    }
    
    public AlumnoViewMB() {
    }

    public List<Historial> getHistAlum() {
        return histAlum;
    }

    public void setHistAlum(List<Historial> histAlum) {
        this.histAlum = histAlum;
    }

    public boolean isMostrarProfRevs() {
        return mostrarProfRevs;
    }

    public void setMostrarProfRevs(boolean mostrarProfRevs) {
        this.mostrarProfRevs = mostrarProfRevs;
    }

    public List<ComisionRevDatos> getComRevisoras() {
        return comRevisoras;
    }

    public void setComRevisoras(List<ComisionRevDatos> comRevisoras) {
        this.comRevisoras = comRevisoras;
    }

    public String getRutAlum() {
        return rutAlum;
    }

    public void setRutAlum(String rutAlum) {
        this.rutAlum = rutAlum;
    }

    public AlumnoDatos getAlumnoEdit() {
        return alumnoEdit;
    }

    public void setAlumnoEdit(AlumnoDatos alumnoEdit) {
        this.alumnoEdit = alumnoEdit;
    }

    public List<ComisionCorrecDatos> getComCorrectoras() {
        return comCorrectoras;
    }

    public void setComCorrectoras(List<ComisionCorrecDatos> comCorrectoras) {
        this.comCorrectoras = comCorrectoras;
    }

    public List<TemaDatos> getTemas() {
        return temas;
    }

    public void setTemas(List<TemaDatos> temas) {
        this.temas = temas;
    }

    public List<PropuestaDatos> getPropuestas() {
        return propuestas;
    }

    public void setPropuestas(List<PropuestaDatos> propuestas) {
        this.propuestas = propuestas;
    }

    public AlumnoDatos getAlumnoSelected() {
        return alumnoSelected;
    }

    public void setAlumnoSelected(AlumnoDatos alumnoSelected) {
        this.alumnoSelected = alumnoSelected;
    }
    
    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public void handleErrorView() throws IOException{
        try{
            if(alumnoSelected.getNombreAlumno()== null)
                FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
        catch (IOException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void viewSelectAlum() throws IOException {
        //Obtenemos el valor del rut por la URL
        rutAlum = FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap().get("alum");
        List<Alumno> alumno = alumnoFacade.findByRut(rutAlum);
        Tema temaVigente = null;
        if (!alumno.isEmpty()) {
            alumnoSelected = new AlumnoDatos();
            if(alumno.get(0).getJornada() == 0)
                alumnoSelected.setJornadaAlumno("Diurno");
            else
                alumnoSelected.setJornadaAlumno("Vespertino");

            //Seteamos el tema activo que tiene
            //Verificamos que no lista no esté vacía para evitar nullPointerException
            
            //Seteamos tema activo del alumno, su profesor guía y co guía
            for(int i=0; i<alumno.get(0).getPropuestaList().size(); i++)
                if(alumno.get(0).getPropuestaList().get(i).getIdRevisora() != null)
                    if(alumno.get(0).getPropuestaList().get(i).getIdRevisora().getIdTema() != null)
                        if(alumno.get(0).getPropuestaList().get(i).getIdRevisora().getIdTema().getEstadoTema() != 3){
                            temaVigente = alumno.get(0).getPropuestaList().get(i).getIdRevisora().getIdTema();
                            alumnoSelected.setNombreTema(temaVigente.getNombreTema());
                            for(int k=0; k<alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().size(); k++){
                                if(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getRolGuia() == 0)
                                    alumnoSelected.setProfesorGuia(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getProfesor().getNombreProfesor()+" "+alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getProfesor().getApellidoProfesor());
                                else
                                    alumnoSelected.setProfCoGuia(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getProfesor().getNombreProfesor()+" "+alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getProfesor().getApellidoProfesor());
                            }
                        }
            //Si tiene temas, pero ninguno activo
            if (temaVigente == null) {
                alumnoSelected.setNombreTema("No tiene tema activo");
                alumnoSelected.setProfesorGuia("No tiene tema activo");
            }
            alumnoSelected.setRutAlumno(rutAlum);
            if (!alumno.get(0).getTelefonoAlumno().isEmpty())
                alumnoSelected.setTelefonoAlumno(alumno.get(0).getTelefonoAlumno());
            else
                alumnoSelected.setTelefonoAlumno("No tiene teléfono registrado");
            alumnoSelected.setNombreAlumno(alumno.get(0).getNombreAlumno());
            alumnoSelected.setApellidoAlumno(alumno.get(0).getApellidoAlumno());
            if(!alumno.get(0).getMailAlumno().isEmpty())
                alumnoSelected.setMailAlumno(alumno.get(0).getMailAlumno());
            else
                alumnoSelected.setMailAlumno("No tiene mail registrado");
            if(alumno.get(0).getCarreraAlumno() == 0)
                alumnoSelected.setCarreraAlumno("Civil Informática");
            else
                alumnoSelected.setCarreraAlumno("Ejecución Informática");
            init();
        }
        else
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
    }
    
    public void loadEditPage() throws IOException {
        try {
            alumnoEdit = new AlumnoDatos();
            if(alumnoSelected.getJornadaAlumno() == "Diurno")
                alumnoEdit.setJornadaAlumno("0");
            if(alumnoSelected.getJornadaAlumno() == "Vespertino")
                alumnoEdit.setJornadaAlumno("1");
            alumnoEdit.setRutAlumno(alumnoSelected.getRutAlumno());
            if(alumnoSelected.getMailAlumno() == "No tiene mail registrado")
                alumnoEdit.setMailAlumno("");
            else
                alumnoEdit.setMailAlumno(alumnoSelected.getMailAlumno());
            if(alumnoSelected.getTelefonoAlumno() == "No tiene teléfono registrado")
                alumnoEdit.setTelefonoAlumno("");
            else
                alumnoEdit.setTelefonoAlumno(alumnoSelected.getTelefonoAlumno());
            if(alumnoSelected.getCarreraAlumno() == "Civil Informática")
                alumnoEdit.setCarreraAlumno("0");
            else
                alumnoEdit.setCarreraAlumno("1");
            alumnoEdit.setProfesorGuia(alumnoSelected.getProfesorGuia());
            alumnoEdit.setNombreTema(alumnoSelected.getNombreTema());
            alumnoEdit.setNombreAlumno(alumnoSelected.getNombreAlumno().toUpperCase());
            alumnoEdit.setApellidoAlumno(alumnoSelected.getApellidoAlumno().toUpperCase());
            FacesContext.getCurrentInstance().getExternalContext().redirect("../editar/alumno.xhtml");
        } catch (IOException e){
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void editAlumno() throws IOException {
        try {
            Alumno alumno = new Alumno();
            alumno.setJornada(Integer.valueOf(alumnoEdit.getJornadaAlumno()));
            alumno.setMailAlumno(alumnoEdit.getMailAlumno());
            alumno.setNombreAlumno(alumnoEdit.getNombreAlumno().toUpperCase());
            alumno.setApellidoAlumno(alumnoEdit.getApellidoAlumno().toUpperCase());
            alumno.setCarreraAlumno(Integer.valueOf(alumnoEdit.getCarreraAlumno()));
            alumno.setRutAlumno(alumnoEdit.getRutAlumno());
            alumno.setTelefonoAlumno(alumnoEdit.getTelefonoAlumno());
            alumnoFacade.edit(alumno);
            FacesContext context = FacesContext.getCurrentInstance();
            
            //Añadimos al historial del alumno cuándo lo editaron
            Date temp = new Date();
            String dateHist = dateToString(temp);
            Historial histEditAlum = new Historial();
            histEditAlum.setDescripcion("Se editó el alumno. Lo editó el usuario "+user.getFullNameUser());
            histEditAlum.setFechaHistorial(dateHist);
            histEditAlum.setTipoHistorial(2);
            histEditAlum.setIdEntidad(alumnoSelected.getRutAlumno());
            historialFacade.create(histEditAlum);


            //Añadimos al historial del usuario que editó al alumno
            Historial histProfAgregadoUser = new Historial();
            histProfAgregadoUser.setDescripcion("Editó al alumno "+alumno.getNombreAlumno()+" "+alumno.getApellidoAlumno());
            histProfAgregadoUser.setFechaHistorial(dateHist);
            histProfAgregadoUser.setTipoHistorial(3);
            histProfAgregadoUser.setIdEntidad(user.getUsername());
            historialFacade.create(histProfAgregadoUser);
            
            context.addMessage(null, new FacesMessage("Editar Alumno", alumnoEdit.getNombreAlumno()+" "+alumnoEdit.getApellidoAlumno()+" editado exitosamente"));
        } catch (NumberFormatException e){
            Logger.getLogger(AlumnoViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void propuestasAlum() throws IOException {
        try{
            propuestas = new ArrayList();
            Alumno alumno = alumnoFacade.findByRut(alumnoSelected.getRutAlumno()).get(0);
            for(int i=0; i<alumno.getPropuestaList().size(); i++){
                PropuestaDatos propuesta = new PropuestaDatos();
                propuesta.setFecha(alumno.getPropuestaList().get(i).getFechaPropuesta());
                propuesta.setIdSemestre(alumno.getPropuestaList().get(i).getIdSemestre().getIdSemestre());
                propuesta.setNombreAlumno(alumno.getNombreAlumno());
                propuesta.setNombrePropuesta(alumno.getPropuestaList().get(i).getNombrePropuesta());
                for(int j=0; j<alumno.getPropuestaList().get(i).getProfePropuestaList().size(); j++){
                    if(alumno.getPropuestaList().get(i).getProfePropuestaList().get(j).getRolGuia() == 0)
                        propuesta.setProfGuia(alumno.getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getNombreProfesor()+" "+alumno.getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getApellidoProfesor());
                    if(alumno.getPropuestaList().get(i).getProfePropuestaList().get(j).getRolGuia() == 1)
                        propuesta.setProfCoGuia(alumno.getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getNombreProfesor()+" "+alumno.getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getApellidoProfesor());
                }
                if(propuesta.getProfCoGuia() == null)
                    propuesta.setProfCoGuia("No tiene");
                if(alumno.getPropuestaList().get(i).getIdRevisora() != null)
                    propuesta.setTieneComRev("Si");
                else
                    propuesta.setTieneComRev("No");
                if(propuesta.getTieneComRev().equals("Si")){
                    if(alumno.getPropuestaList().get(i).getIdRevisora().getIdTema() != null)
                        propuesta.setTieneTema("Si");
                    else
                        propuesta.setTieneTema("No");
                }
                else
                    propuesta.setTieneTema("No");
                propuesta.setRutAlumno(alumno.getRutAlumno());
                propuestas.add(propuesta);
            }
        } catch (Exception e){
            Logger.getLogger(AlumnoViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
    
    public void comisionesRevisorasAlum() throws IOException {
        try {
            comRevisoras = new ArrayList();
            ComisionRevisora comRevisora = new ComisionRevisora();
            List<Alumno> alumno = alumnoFacade.findByRut(alumnoSelected.getRutAlumno());
            String tipoRevision = null;
            //Seteamos las comisiones revisoras que ha tenido el alumno
            for(int i=0; i<alumno.get(0).getPropuestaList().size(); i++){
                if (alumno.get(0).getPropuestaList().get(i).getIdRevisora() != null){
                    comRevisora = alumno.get(0).getPropuestaList().get(i).getIdRevisora();
                    ComisionRevDatos propuesta = new ComisionRevDatos();
                    if (comRevisora.getTipoRevision() == 0){
                        tipoRevision = "Propuesta en Trabajo de titulación (Prof por hora)";
                        mostrarProfRevs = true;
                    }
                    if (comRevisora.getTipoRevision() == 1){
                        tipoRevision = "Ramo de Seminario";
                        mostrarProfRevs = true;
                    }
                    if (comRevisora.getTipoRevision() == 2){
                        tipoRevision = "Acuerdo de Consejo";
                        mostrarProfRevs = false;
                    }
                    propuesta.setFecha(comRevisora.getFechaRevision());
                    propuesta.setIdRevisora(comRevisora.getIdRevisora().toString());
                    propuesta.setIdSemestre(comRevisora.getIdSemestre().getIdSemestre());
                    if(comRevisora.getIdPropuesta().getNombrePropuesta().length()>41)
                        propuesta.setNombrePropuesta(comRevisora.getIdPropuesta().getNombrePropuesta().substring(0,42)+"...");
                    else
                        propuesta.setNombrePropuesta(comRevisora.getIdPropuesta().getNombrePropuesta());
                    //Si es que existe tema de esa propuesta
                    if (comRevisora.getIdTema() != null)
                        propuesta.setIdTema(comRevisora.getIdTema().getIdTema().toString());
                    else
                        propuesta.setIdTema("No ha generado tema");
                    propuesta.setRutAlumno(alumno.get(0).getRutAlumno());
                    propuesta.setTipo(tipoRevision);
                    //Seteamos prof guía, revisores y co-guias
                    for(int j=0; j<alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().size();j++){
                        if(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(j).getRolGuia() == 0)
                            propuesta.setProfGuia(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getNombreProfesor()+" "+alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getApellidoProfesor());
                        else
                            propuesta.setProfCoGuia(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getNombreProfesor()+" "+alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getApellidoProfesor());
                    }
                    for(int j=0; j<comRevisora.getProfeRevisionList().size(); j++)
                        propuesta.addProfRev(comRevisora.getProfeRevisionList().get(j).getProfesor().getNombreProfesor()+" "+comRevisora.getProfeRevisionList().get(j).getProfesor().getApellidoProfesor());
                    propuesta.setTipo(tipoRevision);
                    comRevisoras.add(propuesta);
                }
            }
        } catch (Exception e){
            Logger.getLogger(AlumnoViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
    
    public void temasAlum() throws IOException{
        try{
            List<Alumno> alumno = alumnoFacade.findByRut(alumnoSelected.getRutAlumno());
            temas = new ArrayList();
            TemaDatos tema;
            String estadoTema = null, origenTema = null;
            Tema temaTemp;
            //Seteamos los temas que ha tenido
            for(int i=0; i<alumno.get(0).getPropuestaList().size(); i++){
                if (alumno.get(0).getPropuestaList().get(i).getIdRevisora() != null)
                    if(alumno.get(0).getPropuestaList().get(i).getIdRevisora().getIdTema() != null){
                        tema = new TemaDatos();
                        temaTemp = alumno.get(0).getPropuestaList().get(i).getIdRevisora().getIdTema();
                        //Inicializamos lo valores integer
                        if (temaTemp.getEstadoTema() == 0)
                            estadoTema = "Vigente";
                        if (temaTemp.getEstadoTema() == 1)
                            estadoTema = "Titulado";
                        if (temaTemp.getEstadoTema() == 2)
                            estadoTema = "Reformulado";
                        if (temaTemp.getEstadoTema() == 3)
                            estadoTema = "Caduco";
                        if (temaTemp.getEstadoTema() == 4)
                            estadoTema = "En proceso de Examen";
                        if (temaTemp.getEstadoTema() == 5)
                            estadoTema = "Magíster";
                        if (temaTemp.getEstadoTema() == 6)
                            estadoTema = "Vigente con borrardor final";
                        if (temaTemp.getIdRevisora().getTipoRevision() == 0)
                            origenTema = "Propuesta de profesor por hora";
                        if (temaTemp.getIdRevisora().getTipoRevision()== 1)
                            origenTema = "Propuesta por Ramo Seminario de Titulación";
                        if (temaTemp.getIdRevisora().getTipoRevision() == 2)
                            origenTema = "Propuesta de Acuerdo de Consejo";
                        tema.setEstadoTema(estadoTema);
                        tema.setNombreAlumno(alumnoSelected.getNombreAlumno()+" "+alumnoSelected.getApellidoAlumno());
                        tema.setIngresoTema(origenTema);
                        for (int j=0; j<alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().size(); j++){
                            if (alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(j).getRolGuia() == 0)
                                tema.setNombreProfesor(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getNombreProfesor()+" "+alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getApellidoProfesor());
                            else
                                tema.setNombreProfCoGuia(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getNombreProfesor()+" "+alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(j).getProfesor().getApellidoProfesor());
                        }
                        if(temaTemp.getNombreTema().length()>41)
                            tema.setNombreTema(temaTemp.getNombreTema().substring(0,42)+"...");
                        else
                            tema.setNombreTema(temaTemp.getNombreTema());
                        tema.setSemestreTema(temaTemp.getIdSemestre().getIdSemestre());
                        tema.setFechaTema(temaTemp.getFechaTema());
                        temas.add(tema);   
                    }
            }
        }catch (Exception e){
            Logger.getLogger(AlumnoViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
    
    public void comisionesCorrectorasAlum() throws IOException{
        try{
            List<Alumno> alumno = alumnoFacade.findByRut(alumnoSelected.getRutAlumno());
            comCorrectoras = new ArrayList();
            ComisionCorrecDatos comisionCorrecDatos;
            ComisionCorrectora comCorrec;
            String rutGuia = null;
            //Seteamos las comisiones correctoras que ha tenido
            for(int i=0; i<alumno.get(0).getPropuestaList().size(); i++){
                if(alumno.get(0).getPropuestaList().get(i).getIdRevisora() != null)
                    if(alumno.get(0).getPropuestaList().get(i).getIdRevisora().getIdTema() != null)
                        if (alumno.get(0).getPropuestaList().get(i).getIdRevisora().getIdTema().getIdCorrectora() != null) {
                            comisionCorrecDatos = new ComisionCorrecDatos();
                            comCorrec = alumno.get(0).getPropuestaList().get(i).getIdRevisora().getIdTema().getIdCorrectora();
                            comisionCorrecDatos.setFecha(comCorrec.getFechaCorreccion());
                            comisionCorrecDatos.setIdSemestre(comCorrec.getIdSemestre().getIdSemestre());
                            if(comCorrec.getIdTema().getNombreTema().length()>41)
                                comisionCorrecDatos.setNombreTema(comCorrec.getIdTema().getNombreTema().substring(0,42)+"...");
                            else
                                comisionCorrecDatos.setNombreTema(comCorrec.getIdTema().getNombreTema());
                            for(int j=0; j<comCorrec.getProfeCorreccionList().size(); j++)
                                comisionCorrecDatos.addProfCorrec(comCorrec.getProfeCorreccionList().get(j).getProfesor().getNombreProfesor()+" "+comCorrec.getProfeCorreccionList().get(j).getProfesor().getApellidoProfesor());
                            comisionCorrecDatos.setRutAlumno(alumno.get(0).getRutAlumno());

                            //Seteamos prof guía y sus notas
                            for (int k=0; k<alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().size();k++){
                                if(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getRolGuia() == 0){
                                    comisionCorrecDatos.setProfGuia(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getProfesor().getNombreProfesor()+" "+alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getProfesor().getApellidoProfesor());
                                    //Se asignan las notas, si es que están puestas
                                    if (alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getNotaGuiaDefensa()!= null){
                                        comisionCorrecDatos.setNotaGuiaDef(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getNotaGuiaDefensa());
                                        comisionCorrecDatos.setNotaGuiaInf(alumno.get(0).getPropuestaList().get(i).getProfePropuestaList().get(k).getNotaGuiaInforme());
                                    }
                                }
                            }
                            if(comCorrec.getProfeCorreccionList().get(0).getNotaCorreccionDefensa() != null){
                                comisionCorrecDatos.setNotaCorrec1Def(comCorrec.getProfeCorreccionList().get(0).getNotaCorreccionDefensa());
                                comisionCorrecDatos.setNotaCorrec1Inf(comCorrec.getProfeCorreccionList().get(0).getNotaCorreccionInforme());
                                comisionCorrecDatos.setNotaCorrec2Def(comCorrec.getProfeCorreccionList().get(1).getNotaCorreccionDefensa());
                                comisionCorrecDatos.setNotaCorrec2Inf(comCorrec.getProfeCorreccionList().get(1).getNotaCorreccionInforme());
                            }
                            comCorrectoras.add(comisionCorrecDatos);
                        }
            }
        } catch (Exception e){
            Logger.getLogger(AlumnoViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../../error.xhtml");
        }
    }
    
    public void historial() {
        histAlum = historialFacade.findByIdEntidad(alumnoSelected.getRutAlumno());
    }
}
