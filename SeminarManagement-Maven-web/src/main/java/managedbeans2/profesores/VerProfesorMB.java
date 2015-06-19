package managedbeans2.profesores;

import util.Util;
import clases.PropuestaDatos;
import clases.TemaDatos;
import entities.Alumno;
import entities.Profesor;
import entities.Propuesta;
import entities.SemestreActual;
import entities.Tema;
import entities.Usuario;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "verProfesorMB")
@RequestScoped
public class VerProfesorMB {

    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;

    private int total, totalSemestre;
    private float promPorSemestre;
    private String rutProfesor, rutProfeEdit, semestreActual, semestreAnterior, nombrePropuesta, nombreTemaAlumno;
    private Profesor profesor, profesorEdit = new Profesor();
    private List<Alumno> alumnos;
    private List<Propuesta> propuestas;
    private List<PropuestaDatos> propuestaDatos, propuestasFiltradas,propuestaDatosRevisora,propuestaDatosRevisoraViejo;
    private List<Tema> temas; 
    private List<SemestreActual> semestre;
    private List<TemaDatos> temaDatos, temaDatosProrrogados, temasFiltrados,temaDatosCorrectora,temaDatosCorrectoraSemViejo;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(VerProfesorMB.class);

    /**
     * Creates a new instance of VerProfesorMB
     */
    public VerProfesorMB() {
    }

    public void buscarProfesor() {
        if (rutProfesor != null) {
            profesor = profesorFacade.findByRut(rutProfesor).get(0);
            semestre = semestreActualFacade.findAll();
            semestreActual = semestre.get(0).getSemestreActual();
            semestreAnterior= Util.semestreAnterior(semestreActual);
            
            //Instanciamos para editar al profesor
            profesorEdit = profesor;
            rutProfeEdit = profesor.getRutProfesor();
            temaDatos = new ArrayList();
            temaDatosProrrogados = new ArrayList();
            temaDatosCorrectora = new ArrayList();
            temaDatosCorrectoraSemViejo = new ArrayList();
            propuestaDatosRevisora = new ArrayList();
            propuestaDatosRevisoraViejo = new ArrayList();
            alumnos = alumnoFacade.findAll();

            
            for (Alumno alumno : alumnos) {
                if (!alumno.getPropuestaList().isEmpty()) {
                    for (int k = 0; k < alumno.getPropuestaList().size(); k++) {
                        if (!alumno.getPropuestaList().get(k).getComisionRevisoraList().isEmpty()) {
                            for (int m = 0; m < alumno.getPropuestaList().get(k).getComisionRevisoraList().size(); m++) {
                                if (!alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getProfeRevisionList().isEmpty()) {
                                    for (int n = 0; n < alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getProfeRevisionList().size(); n++) {
                                        Usuario us1 = usuarioFacade.findByRut(profesorEdit.getRutProfesor()).get(0);
                                        Usuario us2 = usuarioFacade.findByRut(alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getProfeRevisionList().get(n).getProfesor().getRutProfesor()).get(0);
                                        if (us1.getNombreUsuario() == null ? us2.getNombreUsuario() == null : us1.getNombreUsuario().equals(us2.getNombreUsuario())) {
                                            if (alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getIdSemestre().getIdSemestre() == null ? semestre.get(0).getSemestreActual() == null : alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getIdSemestre().getIdSemestre().equals(semestreActual)) {
                                                nombrePropuesta = alumno.getPropuestaList().get(k).getNombrePropuesta();
                                                PropuestaDatos propDatos = new PropuestaDatos();
                                                
                                                propDatos.setAlumno(alumno);
                                                propDatos.setIdPropuesta(String.valueOf(alumno.getPropuestaList().get(k).getIdPropuesta()));
                                                if(alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getIdPropuesta().getNombrePropuesta().length() > 64){
                                                    propDatos.setNombreCorto(alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getIdPropuesta().getNombrePropuesta().substring(0, 65) + "...");
                                                }
                                                else{
                                                    propDatos.setNombreCorto(alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getIdPropuesta().getNombrePropuesta());
                                                }
                                                propuestaDatosRevisora.add(propDatos);
                                                
                                            }
                                            
                                            if (alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getIdSemestre().getIdSemestre() == null ? semestre.get(0).getSemestreActual() == null : alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getIdSemestre().getIdSemestre().equals(semestreAnterior)) {
                                                nombrePropuesta = alumno.getPropuestaList().get(k).getNombrePropuesta();
                                                PropuestaDatos propDatos2 = new PropuestaDatos();
                                                
                                                propDatos2.setAlumno(alumno);
                                                propDatos2.setIdPropuesta(String.valueOf(alumno.getPropuestaList().get(k).getIdPropuesta()));
                                                if(alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getIdPropuesta().getNombrePropuesta().length() > 64){
                                                    propDatos2.setNombreCorto(alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getIdPropuesta().getNombrePropuesta().substring(0, 65) + "...");
                                                }
                                                else{
                                                    propDatos2.setNombreCorto(alumno.getPropuestaList().get(k).getComisionRevisoraList().get(m).getIdPropuesta().getNombrePropuesta());
                                                }
                                                propuestaDatosRevisoraViejo.add(propDatos2);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            //alumnos.get(0).getPropuestaList().get(0).getIdRevisora().getIdTema().getIdCorrectora().getProfeCorreccionList().get(0).getProfesor().getNombreProfesor();
            if(!profesor.getProfeCorreccionList().isEmpty()){
                for (int n = 0; n < profesor.getProfeCorreccionList().size(); n++) {
                    if(!profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getTemaList().isEmpty()){
                        for (int o = 0; o < profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getTemaList().size(); o++) {
                            if( profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getTemaList().get(o).getIdSemestre().getIdSemestre() == null ? semestreActual == null : profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getTemaList().get(o).getIdSemestre().getIdSemestre().equals(semestreActual)){
                                nombreTemaAlumno = profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getTemaList().get(o).getNombreTema();
                                TemaDatos temaDTemp2 = new TemaDatos();
                                temaDTemp2.setAlumno(profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getIdTema().getIdRevisora().getIdPropuesta().getRutAlumno());
                                temaDTemp2.setIdTema(profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getTemaList().get(o).getIdTema());

                                if (profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getIdTema().getNombreTema().length() > 64) {
                                    temaDTemp2.setNombreCorto(profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getIdTema().getNombreTema().substring(0, 65) + "...");
                                } else {
                                    temaDTemp2.setNombreCorto(profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getIdTema().getNombreTema());
                                }
                                temaDatosCorrectora.add(temaDTemp2);
                                
                            }
                            
                            if( profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getTemaList().get(o).getIdSemestre().getIdSemestre() == null ? semestreAnterior == null : profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getTemaList().get(o).getIdSemestre().getIdSemestre().equals(semestreAnterior)){
                                
                                nombreTemaAlumno = profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getTemaList().get(o).getNombreTema();
                                TemaDatos temaDTemp3 = new TemaDatos();
                                temaDTemp3.setAlumno(profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getIdTema().getIdRevisora().getIdPropuesta().getRutAlumno());
                                temaDTemp3.setIdTema(profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getTemaList().get(o).getIdTema());

                                if (profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getIdTema().getNombreTema().length() > 64) {
                                    temaDTemp3.setNombreCorto(profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getIdTema().getNombreTema().substring(0, 65) + "...");
                                } else {
                                    temaDTemp3.setNombreCorto(profesor.getProfeCorreccionList().get(n).getComisionCorrectora().getIdTema().getNombreTema());
                                }
                                temaDatosCorrectoraSemViejo.add(temaDTemp3);
                                
                            }
                        }
                    }
                }        
            }
            temas = new ArrayList();
            for (int i = 0; i < profesor.getProfePropuestaList().size(); i++) {
                if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora() != null) {
                    if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema() != null) {
                        if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() != null) {
                            if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 0) {
                                TemaDatos temaDTemp = new TemaDatos();
                                temaDTemp.setIdTema(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getIdTema());
                                temaDTemp.setAlumno(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getIdRevisora().getIdPropuesta().getRutAlumno());
                                if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getNombreTema().length() > 64) {
                                    temaDTemp.setNombreCorto(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getNombreTema().substring(0, 65) + "...");
                                } else {
                                    temaDTemp.setNombreCorto(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getNombreTema());
                                }
                               
                                String semestre = profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getIdSemestre().getIdSemestre();
                                if (semestre.equals(semestreActual)) {
                                    temaDatos.add(temaDTemp);
                                }
                                temas.add(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema());
                            }
                            if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 2) {
                                TemaDatos temaDTemp = new TemaDatos();
                               
                                temaDTemp.setIdTema(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getIdTema());
                                temaDTemp.setAlumno(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getIdRevisora().getIdPropuesta().getRutAlumno());
                                if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getNombreTema().length() > 64) {
                                    temaDTemp.setNombreCorto(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getNombreTema().substring(0, 65) + "...");
                                } else {
                                    temaDTemp.setNombreCorto(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getNombreTema());
                                }
                                temaDatosProrrogados.add(temaDTemp);
                                temas.add(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema());
                            }
                        }
                    }
                }
            }
        } else {
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage("Error", "No se ingresó Profesor"));
        }
    }

    public void verPropuestas() {
        if (rutProfesor != null) {
            profesor = profesorFacade.findByRut(rutProfesor).get(0);

            propuestas = new ArrayList();
            propuestaDatos = new ArrayList();
            for (int i = 0; i < profesor.getProfePropuestaList().size(); i++) {
                PropuestaDatos propDTemp = new PropuestaDatos();
                if (profesor.getProfePropuestaList().get(i).getPropuesta().getNombrePropuesta().length() > 44) {
                    propDTemp.setNombreCorto(profesor.getProfePropuestaList().get(i).getPropuesta().getNombrePropuesta().substring(0, 45) + "...");
                } else {
                    propDTemp.setNombreCorto(profesor.getProfePropuestaList().get(i).getPropuesta().getNombrePropuesta());
                }
                propDTemp.setIdPropuesta(Integer.toString(profesor.getProfePropuestaList().get(i).getPropuesta().getIdPropuesta()));
                propDTemp.setIdSemestre(profesor.getProfePropuestaList().get(i).getPropuesta().getIdSemestre().getIdSemestre());
                propDTemp.setAlumno(profesor.getProfePropuestaList().get(i).getPropuesta().getRutAlumno());
                propuestaDatos.add(propDTemp);
                propuestas.add(profesor.getProfePropuestaList().get(i).getPropuesta());
            }

            String semestreActual = "";
            totalSemestre = 0;
            total = propuestas.size();
            if (!semestreActualFacade.findAll().isEmpty()) {
                semestreActual = semestreActualFacade.findAll().get(0).getSemestreActual();
            }
            for (int i = 0; i < propuestas.size(); i++) {
                if (propuestas.get(i).getIdSemestre().getIdSemestre().equals(semestreActual)) {
                    totalSemestre++;
                }
            }
            float f1Temp = total, f2Temp = semestreFacade.findAll().size();
            promPorSemestre = f1Temp / f2Temp;
        }
    }

    public void verTemas() {
        if (rutProfesor != null) {
            profesor = profesorFacade.findByRut(rutProfesor).get(0);

            temas = new ArrayList();
            temaDatos = new ArrayList();
            for (int i = 0; i < profesor.getProfePropuestaList().size(); i++) {
                if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora() != null) {
                    if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema() != null) {
                        TemaDatos temaDTemp = new TemaDatos();
                        if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getNombreTema().length() > 44) {
                            temaDTemp.setNombreCorto(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getNombreTema().substring(0, 45) + "...");
                        } else {
                            temaDTemp.setNombreCorto(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getNombreTema());
                        }
                        temaDTemp.setIdTema(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getIdTema());
                        temaDTemp.setSemestreTema(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getIdSemestre().getIdSemestre());
                        temaDTemp.setAlumno(profesor.getProfePropuestaList().get(i).getPropuesta().getRutAlumno());
                        if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() != null) {
                            if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 0) {
                                temaDTemp.setEstadoTema("VIGENTE");
                            }
                            if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 1) {
                                temaDTemp.setEstadoTema("TITULADO");
                            }
                            if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 2) {
                                temaDTemp.setEstadoTema("PRORROGADO");
                            }
                            if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 3) {
                                temaDTemp.setEstadoTema("CADUCO");
                            }
                            if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 4) {
                                temaDTemp.setEstadoTema("EN PROCESO EXAMEN");
                            }
                            if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 5) {
                                temaDTemp.setEstadoTema("MAGISTER");
                            }
                            if (profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 6) {
                                temaDTemp.setEstadoTema("VIGENTE");
                            }
                        }
                        temaDatos.add(temaDTemp);
                        temas.add(profesor.getProfePropuestaList().get(i).getPropuesta().getIdRevisora().getIdTema());
                    }
                }
            }

            String semestreActual = "";
            totalSemestre = 0;
            total = temas.size();
            if (!semestreActualFacade.findAll().isEmpty()) {
                semestreActual = semestreActualFacade.findAll().get(0).getSemestreActual();
            }
            for (int i = 0; i < temas.size(); i++) {
                if (temas.get(i).getIdSemestre().getIdSemestre().equals(semestreActual)) {
                    totalSemestre++;
                }
            }
            float f1Temp = total, f2Temp = semestreFacade.findAll().size();
            promPorSemestre = f1Temp / f2Temp;
        }
    }

    public void editProfesor() {
        FacesContext context = FacesContext.getCurrentInstance();
        Profesor profTemp = profesorFacade.findByRut(rutProfeEdit).get(0);
        profTemp.setContrato(profesorEdit.getContrato());
        Integer maxGuiasOld = profTemp.getMaximoGuias();

        if (profesorEdit.getContrato() == 0) {
            if (maxGuiasOld == null) {
                profTemp.setMaximoGuias(7);
            }
        } else {
            profTemp.setTipoProfesor(0);
            profTemp.setMaximoGuias(null);
        }

        profesorEdit = profTemp;
        profesorFacade.edit(profTemp);

        //Añadimos al historial del alumno cuándo lo editaron
        /*
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
         */
        Usuario userLog = usuarioFacade.findByRut(profTemp.getRutProfesor()).get(0);
        context.addMessage(null, new FacesMessage("Editar Profesor", userLog.getNombreUsuario() + " " + userLog.getApellidoUsuarioPaterno() + " editado exitosamente"));
        LOGGER.info("El profesor " + userLog.getNombreUsuario() + " " + userLog.getApellidoUsuarioPaterno()  + " ha sido editado exitosamente");

    }

    public void editProfesorMaxGuias() {
        FacesContext context = FacesContext.getCurrentInstance();
        Profesor profEditGuias = profesorFacade.findByRut(rutProfeEdit).get(0);
        profEditGuias.setTipoProfesor(profesorEdit.getTipoProfesor());
        if (profesorEdit.getTipoProfesor() == 0) {
            profEditGuias.setMaximoGuias(profesorEdit.getMaximoGuias());
            context.addMessage(null, new FacesMessage("Editar Máximo Guías", "El máximo de guías y tipo profesor ha sido editado. El profesor puede ser guía en " + profesorEdit.getMaximoGuias() + " temas."));
        } else {
            profEditGuias.setMaximoGuias(null);
            context.addMessage(null, new FacesMessage("Editar Máximo Guías", "El máximo de guías y tipo profesor ha sido editado. El profesor no puede ser guía."));
        }
        profesorEdit = profEditGuias;
        profesorFacade.edit(profEditGuias);
    }

    public List<PropuestaDatos> getPropuestasFiltradas() {
        return propuestasFiltradas;
    }

    public void setPropuestasFiltradas(List<PropuestaDatos> propuestasFiltradas) {
        this.propuestasFiltradas = propuestasFiltradas;
    }

    public List<TemaDatos> getTemasFiltrados() {
        return temasFiltrados;
    }

    public void setTemasFiltrados(List<TemaDatos> temasFiltrados) {
        this.temasFiltrados = temasFiltrados;
    }

    public String getRutProfeEdit() {
        return rutProfeEdit;
    }

    public void setRutProfeEdit(String rutProfeEdit) {
        this.rutProfeEdit = rutProfeEdit;
    }

    public Profesor getProfesorEdit() {
        return profesorEdit;
    }

    public void setProfesorEdit(Profesor profesorEdit) {
        this.profesorEdit = profesorEdit;
    }

    public String getRutProfesor() {
        return rutProfesor;
    }

    public void setRutProfesor(String rutProfesor) {
        this.rutProfesor = rutProfesor;
    }

    public Profesor getProfesor() {
        return profesor;
    }

    public void setProfesor(Profesor profesor) {
        this.profesor = profesor;
    }

    public List<TemaDatos> getTemaDatos() {
        return temaDatos;
    }

    public void setTemaDatos(List<TemaDatos> temaDatos) {
        this.temaDatos = temaDatos;
    }

    public List<Tema> getTemas() {
        return temas;
    }

    public void setTemas(List<Tema> temas) {
        this.temas = temas;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getTotalSemestre() {
        return totalSemestre;
    }

    public void setTotalSemestre(int totalSemestre) {
        this.totalSemestre = totalSemestre;
    }

    public float getPromPorSemestre() {
        return promPorSemestre;
    }

    public void setPromPorSemestre(float promPorSemestre) {
        this.promPorSemestre = promPorSemestre;
    }

    public List<Propuesta> getPropuestas() {
        return propuestas;
    }

    public void setPropuestas(List<Propuesta> propuestas) {
        this.propuestas = propuestas;
    }

    public List<PropuestaDatos> getPropuestaDatos() {
        return propuestaDatos;
    }

    public void setPropuestaDatos(List<PropuestaDatos> propuestaDatos) {
        this.propuestaDatos = propuestaDatos;
    }

    public List<TemaDatos> getTemaDatosProrrogados() {
        return temaDatosProrrogados;
    }

    public void setTemaDatosProrrogados(List<TemaDatos> temaDatosProrrogados) {
        this.temaDatosProrrogados = temaDatosProrrogados;
    }

    

    public List<TemaDatos> getTemaDatosCorrectoraSemViejo() {
        return temaDatosCorrectoraSemViejo;
    }

    public void setTemaDatosCorrectoraSemViejo(List<TemaDatos> temaDatosCorrectoraSemViejo) {
        this.temaDatosCorrectoraSemViejo = temaDatosCorrectoraSemViejo;
    }
    
    private String semestreSiguiente(String semestreActual) {
        String a = semestreActual.substring(0, 1);
        String b = semestreActual.substring(2, 6);
        if ("2".equals(a)) {
            return "1/" + (Integer.parseInt(b) + 1);
        } else {
            return "2/" + b;
        }
    }
public List<TemaDatos> getTemaDatosCorrectora() {
        return temaDatosCorrectora;
    }

    public void setTemaDatosCorrectora(List<TemaDatos> temaDatosCorrectora) {
        this.temaDatosCorrectora = temaDatosCorrectora;
    }

    public List<PropuestaDatos> getPropuestaDatosRevisora() {
        return propuestaDatosRevisora;
    }

    public void setPropuestaDatosRevisora(List<PropuestaDatos> propuestaDatosRevisora) {
        this.propuestaDatosRevisora = propuestaDatosRevisora;
    }

    public List<PropuestaDatos> getPropuestaDatosRevisoraViejo() {
        return propuestaDatosRevisoraViejo;
    }

    public void setPropuestaDatosRevisoraViejo(List<PropuestaDatos> propuestaDatosRevisoraViejo) {
        this.propuestaDatosRevisoraViejo = propuestaDatosRevisoraViejo;
    }
}
