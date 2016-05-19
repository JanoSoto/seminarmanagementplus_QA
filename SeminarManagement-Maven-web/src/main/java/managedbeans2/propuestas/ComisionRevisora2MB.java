package managedbeans2.propuestas;

import clases.ProfeDatos2;
import entities.Alumno;
import entities.ComisionRevisora;
import entities.ProfePropuesta;
import entities.ProfeRevision;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import javax.inject.Named;
import managedbeans.AuthMB;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.ProfeRevisionFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;

/**
 *
 * @author Eduardo
 */
@RequestScoped
@Named("comisionRevisora2MB")
public class ComisionRevisora2MB implements Serializable {

    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private ProfeRevisionFacadeLocal profeRevisionFacade;
    @EJB
    private ComisionRevisoraFacadeLocal comisionRevisoraFacade;
    private Integer idProp, tipoRevision, idPropEdit, contratoGuia, tipoRevision2;
    private String nombrePropuesta, rutAlumno, fechaProp, semestreProp, nombreProp, rutProfeRev1, rutProfeRev2, fechaRev, fechaEntRev, fechaRev2,
            fechaEntRev2, semestreRev, nombrePropEdit, semestrePropEdit, rutProfeRev1Sem, rutProfeRev2Sem;
    private Propuesta propuesta;
    private List<ComisionRevisora> comision;
    private List<Profesor> profesores;
    private Alumno alumno;
    private Profesor profGuia, profcoGuia, revisor1, revisor2;
    private Date date, date2, date3, date4, fechaPropEdit, publicacionConsejo, terminoPublicacionConsejo, fechaSeminario;
    private List<ProfeDatos2> profeDatos;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(ComisionRevisora2MB.class);
    private HashMap<Object, Object> tiposRevision;

    public ComisionRevisora2MB() {
    }

    @PostConstruct
    public void init() {
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        FacesContext context = FacesContext.getCurrentInstance();

        //Seteamos el semestre a semestre actual
        if (semestreActualFacade.findAll().isEmpty()) {
            semestreRev = "";
            context.addMessage(null, new FacesMessage("Aviso", "No se ha ingresado semestre actual en el sistema"));
        } else {
            semestreRev = semestreActualFacade.findAll().get(0).getSemestreActual();
        }

        profesores = profesorFacade.findAll();

        //Seteamos el semestre a semestre actual
        if (semestreActualFacade.findAll().isEmpty()) {
            semestreRev = "";
            context.addMessage(null, new FacesMessage("Aviso", "No se ha ingresado semestre actual en el sistema"));
        } else {
            semestreRev = semestreActualFacade.findAll().get(0).getSemestreActual();
        }

        //Generamos las listas de posibles Profesores Revisores y Guías
        int guiaProp, revisorTemp, revProp, revSem, guiaTem;
        ProfeDatos2 profeDatosTemp;
        profeDatos = new ArrayList();
        List<Profesor> profes = profesorFacade.findAll();
        List<ProfeRevision> profRev;
        List<ProfePropuesta> profProp;
        for (int i = 0; i < profes.size(); i++) {
            profeDatosTemp = new ProfeDatos2();
            profRev = profes.get(i).getProfeRevisionList();
            revisorTemp = 0;
            revProp = 0;
            revSem = 0;
            //Extraemos la cantidad de propuestas revisadas este semestre por el profesor
            for (int j = 0; j < profRev.size(); j++) {
                if (profRev.get(j).getComisionRevisora() != null){
                    if(profRev.get(j).getComisionRevisora().getIdSemestre()!= null){
                        if(profRev.get(j).getComisionRevisora().getIdSemestre().getIdSemestre()!= null){
                            if (profRev.get(j).getComisionRevisora().getIdSemestre().getIdSemestre().equals(semestreRev)) {
                                revisorTemp++;
                                if (profRev.get(j).getComisionRevisora().getTipoRevision() == 0) {
                                    revProp++;
                                }
                                if (profRev.get(j).getComisionRevisora().getTipoRevision() == 1) {
                                    revSem++;
                                }
                            }
                        }
                    }
                }
            }
            guiaTem = 0;
            guiaProp = 0;
            profProp = profes.get(i).getProfePropuestaList();
            //Extraemos la cantidad de Temas vigentes y las Propuestas del semestre actual guiadas por el profesor
            for (int j = 0; j < profProp.size(); j++) {
                if (profProp.get(j).getRolGuia() == 0) {
                    if (profProp.get(j).getPropuesta().getIdSemestre().getIdSemestre().equals(semestreRev)) {
                        guiaProp++;
                    }
                    if (profProp.get(j).getPropuesta().getIdRevisora() != null) {
                        if (profProp.get(j).getPropuesta().getIdRevisora().getIdTema() != null) {
                            if (profProp.get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() != null) {
                                if (profProp.get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 0) {
                                    guiaTem++;
                                }
                            }
                        }
                    }
                }
            }

            profeDatosTemp.setRevSemActual(revProp);
            profeDatosTemp.setProfesor(profes.get(i));
            profeDatosTemp.setCorrSemActual(0);
            profeDatosTemp.setPropSemActual(guiaProp);
            profeDatosTemp.setTemasVigentes(guiaTem);
            profeDatos.add(profeDatosTemp);
        }

        tiposRevision = new HashMap<>();
        tiposRevision.put("Seminario", 1);

        Map<String, String> params = context.getExternalContext().getRequestParameterMap();
        String propuestaId = params.get("prop");
        if (propuestaId != null) {
            propuesta = propuestaFacade.findOneById(Integer.parseInt(propuestaId));
            if (propuesta != null) {
                profGuia = propuesta.getProfesorGuia();
                contratoGuia = profGuia.getContrato();
            }
        }

    }

    public List<ProfeDatos2> getProfeDatos() {
        return profeDatos;
    }

    public void setProfeDatos(List<ProfeDatos2> profeDatos) {
        this.profeDatos = profeDatos;
    }

    public void buscarPropuesta() {
        if (idProp != null) {
            List<Propuesta> result = propuestaFacade.findById(idProp);
            if (!result.isEmpty()) {
                propuesta = result.get(0);
                //Inicializamos datos para editar
                idPropEdit = propuesta.getIdPropuesta();
                nombrePropEdit = propuesta.getNombrePropuesta();
                fechaPropEdit = stringToDate(propuesta.getFechaPropuesta());
                semestrePropEdit = propuesta.getIdSemestre().getIdSemestre();

                if (propuesta.getNombrePropuesta().length() > 68) {
                    nombreProp = propuesta.getNombrePropuesta().substring(0, 69) + "...";
                } else {
                    nombreProp = propuesta.getNombrePropuesta();
                }

                for (int i = 0; i < propuesta.getProfePropuestaList().size(); i++) {
                    if (propuesta.getProfePropuestaList().get(i).getRolGuia() == 0) {
                        profGuia = propuesta.getProfePropuestaList().get(i).getProfesor();
                    }
                    if (propuesta.getProfePropuestaList().get(i).getRolGuia() == 1) {
                        profcoGuia = propuesta.getProfePropuestaList().get(i).getProfesor();
                    }
                }

                if (propuesta.getIdRevisora() != null) {
                    for (int i = 0; i < propuesta.getIdRevisora().getProfeRevisionList().size(); i++) {

                        if (propuesta.getIdRevisora().getProfeRevisionList().get(i).getRolRevision() == 0) {
                            revisor1 = propuesta.getIdRevisora().getProfeRevisionList().get(i).getProfesor();
                        }
                        if (propuesta.getIdRevisora().getProfeRevisionList().get(i).getRolRevision() == 1) {
                            revisor2 = propuesta.getIdRevisora().getProfeRevisionList().get(i).getProfesor();
                        }
                    }
                }

                alumno = propuesta.getRutAlumno();

                comision = comisionRevisoraFacade.findById(propuesta.getIdRevisora().getIdRevisora());
                if (comision.get(0).getFechaRevision() != null) {
                    date = stringToDate(comision.get(0).getFechaRevision());
                }
                if (comision.get(0).getFechaEntregaRevision() != null) {
                    date2 = stringToDate(comision.get(0).getFechaEntregaRevision());
                }
                if (comision.get(0).getFechaRevision2() != null) {
                    date3 = stringToDate(comision.get(0).getFechaRevision2());
                }
                if (comision.get(0).getFechaEntregaRevision2() != null) {
                    date4 = stringToDate(comision.get(0).getFechaEntregaRevision2());
                }
                if (comision.get(0).getFechaPublicacionConsejo() != null) {
                    publicacionConsejo = stringToDate(comision.get(0).getFechaPublicacionConsejo());
                }
                if (comision.get(0).getFechaTerminoPublicacionConsejo() != null) {
                    terminoPublicacionConsejo = stringToDate(comision.get(0).getFechaTerminoPublicacionConsejo());
                }
            }

        } else {
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage("Error", "No se ingresó Propuesta"));
        }
    }

    public void editarPropuesta() {
        FacesContext context = FacesContext.getCurrentInstance();
        Propuesta propTemp = propuestaFacade.findById(idPropEdit).get(0);

        if (nombrePropEdit == null) {
            context.addMessage(null, new FacesMessage("Nombre Propuesta", "Debe ingresar nombre propuesta"));
            return;
        }

        if (semestrePropEdit == null || semestrePropEdit.equals("")) {
            context.addMessage(null, new FacesMessage("Semestre Propuesta", "Debe ingresar semestre propuesta"));
            return;
        }

        //Se valida que no exista otra propuesta con el mismo nombre
        List<Propuesta> propuestas = propuestaFacade.findByName(nombrePropEdit);
        if (!propuestas.isEmpty() && !propTemp.equals(nombrePropEdit)) {
            context.addMessage(null, new FacesMessage("Nombre Propuesta", "Ya existe una propuesta con ese nombre"));
            return;
        }

        //Validamos errores de semestre
        if (Integer.valueOf(semestrePropEdit.substring(2, 6)) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre", "Año del semestre debe ser después de 1972"));
            return;
        }

        if ((Integer.valueOf(semestrePropEdit.substring(0, 1)) != 1) && (Integer.valueOf(semestrePropEdit.substring(0, 1)) != 2)) {
            context.addMessage(null, new FacesMessage("Semestre Revisión", "Semestre ingresado debe ser '1' o '2'"));
            return;
        }

        //Accedemos a la tabla semestre, e ingresamos semestre si no ha sido ingresado
        Semestre semTemp = new Semestre(semestrePropEdit);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semTemp)) {
            semestreFacade.create(semTemp);
        }

        nombrePropEdit = nombrePropEdit.toUpperCase();
        propTemp.setNombrePropuesta(nombrePropEdit);
        propTemp.setFechaPropuesta(dateToString(fechaPropEdit));
        propTemp.setIdSemestre(semTemp);
        propuestaFacade.edit(propTemp);

        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Propuesta", "La propuesta ha sido editada exitosamente"));
        LOGGER.info("La propuesta ha sido editada exitosamente por '" + nombrePropEdit + "'");

    }

    public void EditarComisionRevisora() {
        FacesContext context = FacesContext.getCurrentInstance();

        if (idProp == null) {
            context.addMessage(null, new FacesMessage("Error", "No se ingresó Propuesta"));
            return;
        }

        propuesta = propuestaFacade.findById(idProp).get(0);

        comision = comisionRevisoraFacade.findById(propuesta.getIdRevisora().getIdRevisora());

        ComisionRevisora nuevaComision;

        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestreRevision = new Semestre(semestreRev);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semestreRevision)) {
            semestreFacade.create(semestreRevision);
        }

        if (date != null) {
            fechaRev = dateToString(date);
        } else {
            fechaRev = null;
        }

        if (date2 != null) {
            fechaEntRev = dateToString(date2);
        } else {
            fechaEntRev = null;
        }

        if (date != null && date2 != null) {

            if (fechaCorrecta(fechaRev, fechaEntRev) == false) {
                return;
            }
        }

        if (date3 != null) {
            fechaRev2 = dateToString(date3);
        } else {
            fechaRev2 = null;
        }

        if (date4 != null) {
            fechaEntRev2 = dateToString(date4);
        } else {
            fechaEntRev2 = null;
        }

        if (date3 != null && date4 != null) {

            if (fechaCorrecta(fechaRev2, fechaEntRev2) == false) {
                return;
            }
        }

        if (fechaRev != null) {
            if (fechaCorrecta(propuesta.getFechaPropuesta(), fechaRev) == false) {
                return;
            }
        }

        if (fechaRev2 != null) {
            if (fechaCorrecta(propuesta.getFechaPropuesta(), fechaRev2) == false) {
                return;
            }
        }
        
        String fechaConsejoPub, fechaConsejoPubTermino;
        if (publicacionConsejo != null) {
            fechaConsejoPub = dateToString(publicacionConsejo);
        } else {
            fechaConsejoPub = null;
        }

        if (terminoPublicacionConsejo != null) {
            fechaConsejoPubTermino = dateToString(terminoPublicacionConsejo);
        } else {
            fechaConsejoPubTermino = null;
        }
        
        if (terminoPublicacionConsejo != null){
            if(!fechaCorrecta(propuesta.getFechaPropuesta(), fechaConsejoPubTermino) ){
            return;
            }
        }
        
         if (publicacionConsejo != null){
            if(!fechaCorrecta(propuesta.getFechaPropuesta(), fechaConsejoPub) ){
            return;
            }
        }
         

        if (date3 != null && date4 != null) {

            if (fechaCorrecta(fechaRev2, fechaEntRev2) == false) {
                return;
            }
        }

        //Seteamos la nueva comision y la creamos
        comision.get(0).setIdPropuesta(comision.get(0).getIdPropuesta());
        comision.get(0).setFechaRevision(fechaRev);
        comision.get(0).setFechaEntregaRevision(fechaEntRev);
        comision.get(0).setFechaRevision2(fechaRev2);
        comision.get(0).setFechaEntregaRevision2(fechaEntRev2);
        comision.get(0).setIdSemestre(comision.get(0).getIdSemestre());
        comision.get(0).setTipoRevision(comision.get(0).getTipoRevision());
        comision.get(0).setFechaPublicacionConsejo(fechaConsejoPub);
        comision.get(0).setFechaTerminoPublicacionConsejo(fechaConsejoPubTermino);
        comisionRevisoraFacade.edit(comision.get(0));

        //Mensaje de confirmación 
        context.addMessage(null, new FacesMessage("Comisión Revisora editada en el sistema"));
        LOGGER.info("La comision revisora de la propuesta " + propuesta.getNombrePropuesta() + " ha sido modificada en el sistema");
    }

    public void editarFechasComisionRevisoraAcuerdoConsejo() {
        FacesContext context = FacesContext.getCurrentInstance();
        String fechaPublicacion = null, fechaTerminoPublicacion = null;
        if (idProp == null) {
            context.addMessage(null, new FacesMessage("Error", "No se ingresó Propuesta"));
            return;
        }

        propuesta = propuestaFacade.findById(idProp).get(0);
        comision = comisionRevisoraFacade.findById(propuesta.getIdRevisora().getIdRevisora());
        ComisionRevisora com = comision.get(0);

        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestreRevision = new Semestre(semestreRev);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semestreRevision)) {
            semestreFacade.create(semestreRevision);
        }

        if (publicacionConsejo != null) {
            fechaPublicacion = dateToString(publicacionConsejo);
        }

        if (terminoPublicacionConsejo != null) {
            fechaTerminoPublicacion = dateToString(terminoPublicacionConsejo);
        }

        if (publicacionConsejo != null && terminoPublicacionConsejo != null) {
            if (!fechaCorrecta(fechaPublicacion, fechaTerminoPublicacion)) {
                return;
            }
        }
        if (fechaTerminoPublicacion != null){
            if(!fechaCorrecta(propuesta.getFechaPropuesta(), fechaTerminoPublicacion) ){
            return;
            }
        }
        
         if (fechaPublicacion != null){
            if(!fechaCorrecta(propuesta.getFechaPropuesta(), fechaPublicacion) ){
            return;
            }
        }
         

        //Seteamos la nueva comision y la creamos
        com.setIdPropuesta(com.getIdPropuesta());
        com.setFechaPublicacionConsejo(fechaPublicacion);
        com.setFechaTerminoPublicacionConsejo(fechaTerminoPublicacion);
        com.setIdSemestre(com.getIdSemestre());
        comisionRevisoraFacade.edit(com);

        //Mensaje de confirmación 
        context.addMessage(null, new FacesMessage("Acuerdo de consejo editado en el sistema"));
        LOGGER.info("La comision revisora de la propuesta " + propuesta.getNombrePropuesta() + " ha sido modificada en el sistema");
    }

    public void addComisionRevisora() {
        FacesContext context = FacesContext.getCurrentInstance();
        Map<String, String> params = context.getExternalContext().getRequestParameterMap();
        String propuestaId = params.get("prop");
        if (date != null && date2 != null) {
            if (date.compareTo(date2) > 0) {
                context.addMessage(null, new FacesMessage("Error", "Fecha de entrega al profesor revisor 1 no puede ser menor a su fecha de devolución con correcciones"));
                return;
            }
        }

        if (date3 != null && date4 != null) {
            if (date3.compareTo(date4) > 0) {
                context.addMessage(null, new FacesMessage("Error", "Fecha de entrega al profesor revisor 2 no puede ser menor a su fecha de devolución con correcciones"));
                return;
            }
        }

        if (idProp == null && propuestaId == null) {
            context.addMessage(null, new FacesMessage("Error", "No se ingresó Propuesta"));
            return;
        }

        propuesta = propuestaFacade.findById(idProp).get(0);
        //Se valida que la propuesta no tenga Comisión Revisora
        if (propuesta.getIdRevisora() != null) {
            context.addMessage(null, new FacesMessage("Propuesta", "La propuesta seleccionada ya tiene una Comisión Revisora asignada"));
            return;
        }

        if (tipoRevision == null && tipoRevision2 != null) {
            tipoRevision = tipoRevision2;
        }

        //Se valida el tipo de revisión seleccionada y los profesores
        if (tipoRevision == null) {
            context.addMessage(null, new FacesMessage("Tipo Revisión", "Debe seleccionar un tipo de Revisión"));
            return;
        }
        if (tipoRevision == 2) { //acuerdo consejo
            for (int i = 0; i < propuesta.getProfePropuestaList().size(); i++) {
                if (propuesta.getProfePropuestaList().get(i).getRolGuia() == 0) {
                    if (propuesta.getProfePropuestaList().get(i).getProfesor().getContrato() != 1) {
                        context.addMessage(null, new FacesMessage("Tipo Revisión", "El Profesor Guía de la propuesta seleccionada no es de Jornada Completa"));
                        return;
                    }
                }
            }
            //if (!rutProfeRev1.equals("-") || !rutProfeRev2.equals("-")) {
            //    context.addMessage(null, new FacesMessage("Tipo Revisión", "Una Comisión por Acuerdo de Consejo no tiene profesores, deje estos espacios en blanco o cambie el Tipo de Revisión"));
            //    return;
            //}
        } else if (tipoRevision == 0) { //secretaría
            //Se valida que se halla seleccionado profesor1
            System.out.println("RUT1:"+rutProfeRev1);
            System.out.println("RUT2:"+rutProfeRev1Sem);
            System.out.println("D1:"+date);
            System.out.println("D2:"+date2);
            //if (rutProfeRev1.equals("-")) {
            //    context.addMessage(null, new FacesMessage("Profesor Revisor 1", "Debe seleccionar Profesor"));
            //    return;
            //}

            //Se valida que se halla seleccionado Profesor2
            /*if (rutProfeRev2.equals("-")) {
                context.addMessage(null, new FacesMessage("Profesor Revisor 2", "Debe seleccionar Profesor"));
                return;
            }*/
            //Se valida que se hallan seleccionado profesores revisores distintos al guia
            for (int i = 0; i < propuesta.getProfePropuestaList().size(); i++) {
                if (propuesta.getProfePropuestaList().get(i).getRolGuia() == 0) {
                    profGuia = propuesta.getProfePropuestaList().get(i).getProfesor();
                }
            }
            if (profGuia.getRutProfesor().equals(rutProfeRev1) || profGuia.getRutProfesor().equals(rutProfeRev2)) {
                context.addMessage(null, new FacesMessage("Profesor Revisor", "El Profesor guía no puede ser seleccionado como Profesor Revisor"));
                return;
            }
            //Se valida que se hallan seleccionado profesores revisores distintos entre si
            if (rutProfeRev1.equals(rutProfeRev2)) {
                context.addMessage(null, new FacesMessage("Profesor Revisor", "Los Profesores revisores deben ser distintos"));
                return;
            }
        } else if ( tipoRevision == 1 ){ // seminario
        //Se valida que se halla seleccionado profesor1
            if (rutProfeRev1Sem.equals("-")) {
                context.addMessage(null, new FacesMessage("Profesor Revisor 1", "Debe seleccionar Profesor"));
                return;
            }

            //Se valida que se halla seleccionado Profesor2
            if (rutProfeRev2Sem.equals("-")) {
                context.addMessage(null, new FacesMessage("Profesor Revisor 2", "Debe seleccionar Profesor"));
                return;
            }
            //Se valida que se hallan seleccionado profesores revisores distintos al guia
            for (int i = 0; i < propuesta.getProfePropuestaList().size(); i++) {
                if (propuesta.getProfePropuestaList().get(i).getRolGuia() == 0) {
                    profGuia = propuesta.getProfePropuestaList().get(i).getProfesor();
                }
            }
            if (profGuia.getRutProfesor().equals(rutProfeRev1Sem) || profGuia.getRutProfesor().equals(rutProfeRev2Sem)) {
                context.addMessage(null, new FacesMessage("Profesor Revisor", "El Profesor guía no puede ser seleccionado como Profesor Revisor"));
                return;
            }
            //Se valida que se hallan seleccionado profesores revisores distintos entre si
            if (rutProfeRev1Sem.equals(rutProfeRev2Sem)) {
                context.addMessage(null, new FacesMessage("Profesor Revisor", "Los Profesores revisores deben ser distintos"));
                return;
            }
            
            publicacionConsejo = fechaSeminario;
        }
        else if ( tipoRevision == 3 ){ // magister
        //Se valida que se halla seleccionado profesor1
            if (rutProfeRev1.equals("-")) {
                context.addMessage(null, new FacesMessage("Profesor Revisor 1", "Debe seleccionar Profesor"));
                return;
            }

            //Se valida que se halla seleccionado Profesor2
            if (rutProfeRev2.equals("-")) {
                context.addMessage(null, new FacesMessage("Profesor Revisor 2", "Debe seleccionar Profesor"));
                return;
            }
            //Se valida que se hallan seleccionado profesores revisores distintos al guia
            for (int i = 0; i < propuesta.getProfePropuestaList().size(); i++) {
                if (propuesta.getProfePropuestaList().get(i).getRolGuia() == 0) {
                    profGuia = propuesta.getProfePropuestaList().get(i).getProfesor();
                }
            }
            if (profGuia.getRutProfesor().equals(rutProfeRev1) || profGuia.getRutProfesor().equals(rutProfeRev2)) {
                context.addMessage(null, new FacesMessage("Profesor Revisor", "El Profesor guía no puede ser seleccionado como Profesor Revisor"));
                return;
            }
            //Se valida que se hallan seleccionado profesores revisores distintos entre si
            if (rutProfeRev1.equals(rutProfeRev2)) {
                context.addMessage(null, new FacesMessage("Profesor Revisor", "Los Profesores revisores deben ser distintos"));
                return;
            }
            
            publicacionConsejo = fechaSeminario;
        }
        //fecha

        //Validamos errores de semestre
        if (Integer.valueOf(semestreRev.substring(2, 6)) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre", "Año del semestre debe ser después de 1972"));
            return;
        }

        if ((Integer.valueOf(semestreRev.substring(0, 1)) != 1) && (Integer.valueOf(semestreRev.substring(0, 1)) != 2)) {
            context.addMessage(null, new FacesMessage("Semestre Revisión", "Semestre ingresado debe ser '1' o '2'"));
            return;
        }

        String fechaPublicacion = null, fechaTerminoPublicacion = null;
        
        if (publicacionConsejo != null) {
            fechaPublicacion = dateToString(publicacionConsejo);
        }
        if (terminoPublicacionConsejo != null) {
            fechaTerminoPublicacion = dateToString(terminoPublicacionConsejo);
        }

        if ((fechaPublicacion != null) && (fechaTerminoPublicacion != null)
                && !fechaCorrecta(fechaPublicacion, fechaTerminoPublicacion)) {
            return;
        }
        
        if (fechaTerminoPublicacion != null){
            if(!fechaCorrecta(propuesta.getFechaPropuesta(), fechaTerminoPublicacion) ){
            return;
            }
        }
        
         if (fechaPublicacion != null){
            if(!fechaCorrecta(propuesta.getFechaPropuesta(), fechaPublicacion) ){
            return;
            }
        }
         
            
  
        
        
        

        ComisionRevisora nuevaComision = new ComisionRevisora();

        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestreRevision = new Semestre(semestreRev);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semestreRevision)) {
            semestreFacade.create(semestreRevision);
        }
        if (date != null) {
            fechaRev = dateToString(date);
        } else {
            fechaRev = null;
        }

        if (date2 != null) {
            fechaEntRev = dateToString(date2);
        } else {
            fechaEntRev = null;
        }

        if (date != null && date2 != null) {

            if (fechaCorrecta(fechaRev, fechaEntRev) == false) {
                return;
            }
        }

        if (date3 != null) {
            fechaRev2 = dateToString(date3);
        } else {
            fechaRev2 = null;
        }

        if (date4 != null) {
            fechaEntRev2 = dateToString(date4);
        } else {
            fechaEntRev2 = null;
        }

        if (date3 != null && date4 != null) {

            if (fechaCorrecta(fechaRev2, fechaEntRev2) == false) {
                return;
            }
        }

        if (fechaRev != null) {
            if (fechaCorrecta(propuesta.getFechaPropuesta(), fechaRev) == false) {
                return;
            }
        }

        if (fechaRev2 != null) {
            if (fechaCorrecta(propuesta.getFechaPropuesta(), fechaRev2) == false) {
                return;
            }
        }

        //Seteamos la nueva comision y la creamos
        nuevaComision.setIdPropuesta(propuesta);
        nuevaComision.setFechaRevision(fechaRev);
        nuevaComision.setFechaEntregaRevision(fechaEntRev);
        nuevaComision.setFechaRevision2(fechaRev2);
        nuevaComision.setFechaEntregaRevision2(fechaEntRev2);
        nuevaComision.setIdSemestre(semestreRevision);
        nuevaComision.setTipoRevision(tipoRevision);
        nuevaComision.setFechaPublicacionConsejo(fechaPublicacion);
        nuevaComision.setFechaTerminoPublicacionConsejo(fechaTerminoPublicacion);
        comisionRevisoraFacade.create(nuevaComision);

        //Agregamos la comision a la lista de comisiones del semestre
        semestreRevision.add(nuevaComision);
        semestreFacade.edit(semestreRevision);

        if ( tipoRevision == 0 ) {
            //Profes
            Profesor profRev1 = profesorFacade.findByRut(rutProfeRev1).get(0);
            Profesor profRev2 = profesorFacade.findByRut(rutProfeRev2).get(0);

            //Inicializamos las revisiones de los profesores
            ProfeRevision nuevoProfeRevision1 = new ProfeRevision(nuevaComision.getIdRevisora(), rutProfeRev1);
            ProfeRevision nuevoProfeRevision2 = new ProfeRevision(nuevaComision.getIdRevisora(), rutProfeRev2);

            //Creamos las relaciones entre los profes y la comisión
            //Profe 1
            nuevoProfeRevision1.setRolRevision(0);
            nuevoProfeRevision1.setProfesor(profRev1);
            nuevoProfeRevision1.setComisionRevisora(nuevaComision);
            profeRevisionFacade.create(nuevoProfeRevision1);
            //Profe 2
            nuevoProfeRevision2.setRolRevision(1);
            nuevoProfeRevision2.setProfesor(profRev2);
            nuevoProfeRevision2.setComisionRevisora(nuevaComision);
            profeRevisionFacade.create(nuevoProfeRevision2);

            //Asignamos revisiones a la comision
            nuevaComision.add(nuevoProfeRevision1);
            nuevaComision.add(nuevoProfeRevision2);
            comisionRevisoraFacade.edit(nuevaComision);

            //Asignamos las revisiones a los profesores
            profRev1.add(nuevoProfeRevision1);
            profesorFacade.edit(profRev1);
            profRev2.add(nuevoProfeRevision2);
            profesorFacade.edit(profRev2);
        } else if ( tipoRevision == 1){
            //Profes
            Profesor profRev1 = profesorFacade.findByRut(rutProfeRev1Sem).get(0);
            Profesor profRev2 = profesorFacade.findByRut(rutProfeRev2Sem).get(0);

            //Inicializamos las revisiones de los profesores
            ProfeRevision nuevoProfeRevision1 = new ProfeRevision(nuevaComision.getIdRevisora(), rutProfeRev1Sem);
            ProfeRevision nuevoProfeRevision2 = new ProfeRevision(nuevaComision.getIdRevisora(), rutProfeRev2Sem);

            //Creamos las relaciones entre los profes y la comisión
            //Profe 1
            nuevoProfeRevision1.setRolRevision(0);
            nuevoProfeRevision1.setProfesor(profRev1);
            nuevoProfeRevision1.setComisionRevisora(nuevaComision);
            profeRevisionFacade.create(nuevoProfeRevision1);
            //Profe 2
            nuevoProfeRevision2.setRolRevision(1);
            nuevoProfeRevision2.setProfesor(profRev2);
            nuevoProfeRevision2.setComisionRevisora(nuevaComision);
            profeRevisionFacade.create(nuevoProfeRevision2);

            //Asignamos revisiones a la comision
            nuevaComision.add(nuevoProfeRevision1);
            nuevaComision.add(nuevoProfeRevision2);
            comisionRevisoraFacade.edit(nuevaComision);

            //Asignamos las revisiones a los profesores
            profRev1.add(nuevoProfeRevision1);
            profesorFacade.edit(profRev1);
            profRev2.add(nuevoProfeRevision2);
            profesorFacade.edit(profRev2);
        } else if ( tipoRevision == 3 ){
            //Profes
            Profesor profRev1 = profesorFacade.findByRut(rutProfeRev1).get(0);
            Profesor profRev2 = profesorFacade.findByRut(rutProfeRev2).get(0);

            //Inicializamos las revisiones de los profesores
            ProfeRevision nuevoProfeRevision1 = new ProfeRevision(nuevaComision.getIdRevisora(), rutProfeRev1);
            ProfeRevision nuevoProfeRevision2 = new ProfeRevision(nuevaComision.getIdRevisora(), rutProfeRev2);

            //Creamos las relaciones entre los profes y la comisión
            //Profe 1
            nuevoProfeRevision1.setRolRevision(0);
            nuevoProfeRevision1.setProfesor(profRev1);
            nuevoProfeRevision1.setComisionRevisora(nuevaComision);
            profeRevisionFacade.create(nuevoProfeRevision1);
            //Profe 2
            nuevoProfeRevision2.setRolRevision(1);
            nuevoProfeRevision2.setProfesor(profRev2);
            nuevoProfeRevision2.setComisionRevisora(nuevaComision);
            profeRevisionFacade.create(nuevoProfeRevision2);

            //Asignamos revisiones a la comision
            nuevaComision.add(nuevoProfeRevision1);
            nuevaComision.add(nuevoProfeRevision2);
            comisionRevisoraFacade.edit(nuevaComision);

            //Asignamos las revisiones a los profesores
            profRev1.add(nuevoProfeRevision1);
            profesorFacade.edit(profRev1);
            profRev2.add(nuevoProfeRevision2);
            profesorFacade.edit(profRev2);
        }

        //Asignamos la Comision a la Propuesta
        propuesta.setIdRevisora(nuevaComision);
        propuestaFacade.edit(propuesta);

        //Mensaje de confirmación 
        context.addMessage(null, new FacesMessage("Comisión Revisora", propuesta.getNombrePropuesta() + ", ingresada al sistema"));
        //LOGGER.info("La propuesta " + propuesta.getNombrePropuesta() + " ha sido ingresada al sistema");
    }

    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value = "#{authMB}")
    private AuthMB user;

    
    public AuthMB getUser() {
        return user;
    }

    public void setUser(AuthMB user) {
        this.user = user;
    }

    public List<Profesor> getProfesores() {
        return profesores;
    }

    public void setProfesores(List<Profesor> profesores) {
        this.profesores = profesores;
    }

    public String getSemestreRev() {
        return semestreRev;
    }

    public void setSemestreRev(String semestreRev) {
        this.semestreRev = semestreRev;
    }

    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public Integer getIdProp() {
        return idProp;
    }

    public void setIdProp(Integer idProp) {
        this.idProp = idProp;
    }

    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public String getFechaProp() {
        return fechaProp;
    }

    public void setFechaProp(String fechaProp) {
        this.fechaProp = fechaProp;
    }

    public Date getDate3() {
        return date3;
    }

    public void setDate3(Date date3) {
        this.date3 = date3;
    }

    public Date getDate4() {
        return date4;
    }

    public void setDate4(Date date4) {
        this.date4 = date4;
    }

    public String getSemestreProp() {
        return semestreProp;
    }

    public void setSemestreProp(String semestreProp) {
        this.semestreProp = semestreProp;
    }

    public String getNombreProp() {
        return nombreProp;
    }

    public void setNombreProp(String nombreProp) {
        this.nombreProp = nombreProp;
    }

    public Propuesta getPropuesta() {
        return propuesta;
    }

    public void setPropuesta(Propuesta propuesta) {
        this.propuesta = propuesta;
    }

    public Profesor getProfGuia() {
        return profGuia;
    }

    public void setProfGuia(Profesor profGuia) {
        this.profGuia = profGuia;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getDate2() {
        return date2;
    }

    public void setDate2(Date date2) {
        this.date2 = date2;
    }

    public String getNombrePropuesta() {
        return nombrePropuesta;
    }

    public void setNombrePropuesta(String nombrePropuesta) {
        this.nombrePropuesta = nombrePropuesta;
    }

    public String getRutProfeRev1() {
        return rutProfeRev1;
    }

    public void setRutProfeRev1(String rutProfeRev1) {
        this.rutProfeRev1 = rutProfeRev1;
    }

    public String getRutProfeRev2() {
        return rutProfeRev2;
    }

    public void setRutProfeRev2(String rutProfeRev2) {
        this.rutProfeRev2 = rutProfeRev2;
    }

    public String getFechaRev() {
        return fechaRev;
    }

    public void setFechaRev(String fechaRev) {
        this.fechaRev = fechaRev;
    }

    public Date stringToDate(String dateChoosen) {
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        try {
            Date date = formatter.parse(dateChoosen);
            return date;
        } catch (ParseException e) {
            return null;
        }
    }

    public String getFechaEntRev() {
        return fechaEntRev;
    }

    public void setFechaEntRev(String fechaEntRev) {
        this.fechaEntRev = fechaEntRev;
    }

    public String getFechaRev2() {
        return fechaRev2;
    }

    public void setFechaRev2(String fechaRev2) {
        this.fechaRev2 = fechaRev2;
    }

    public String getFechaEntRev2() {
        return fechaEntRev2;
    }

    public void setFechaEntRev2(String fechaEntRev2) {
        this.fechaEntRev2 = fechaEntRev2;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public Profesor getRevisor1() {
        return revisor1;
    }

    public void setRevisor1(Profesor revisor1) {
        this.revisor1 = revisor1;
    }

    public Profesor getRevisor2() {
        return revisor2;
    }

    public void setRevisor2(Profesor revisor2) {
        this.revisor2 = revisor2;
    }

    public static boolean fechaCorrecta(String fecha, String fecha2) {
        FacesContext context = FacesContext.getCurrentInstance();
        
        int a, b, c, d, e, f;
        String fechas[] = fecha.split("/");
        String fechas2[] = fecha2.split("/");
        a = Integer.parseInt(fechas[2]);
        b = Integer.parseInt(fechas2[2]);
        c = Integer.parseInt(fechas[1]);
        d = Integer.parseInt(fechas2[1]);
        e = Integer.parseInt(fechas[0]);
        f = Integer.parseInt(fechas2[0]);

        if (a > b) {
            context.addMessage(null, new FacesMessage("Año de la fecha", "La fecha debe ser mayor o igual a " + fecha));
            return false;

        } else {
            if (c > d && a==b) {
                context.addMessage(null, new FacesMessage("Mes de la fecha", "La fecha debe ser mayor o igual a " + fecha));
                return false;
            } else {
                if (e > f && c >= d && a==b) {
                    context.addMessage(null, new FacesMessage("Dia de la fecha", "La fecha debe ser mayor o igual a " + fecha));
                    return false;
                }
            }

        }
        return true;

    }

    public Integer getTipoRevision() {
        return tipoRevision;
    }

    public void setTipoRevision(Integer tipoRevision) {
        this.tipoRevision = tipoRevision;
    }

    public HashMap<Object, Object> getTiposRevision() {
        return tiposRevision;
    }

    public void setTiposRevision(HashMap<Object, Object> tiposRevision) {
        this.tiposRevision = tiposRevision;
    }

    public Date getPublicacionConsejo() {
        return publicacionConsejo;
    }

    public void setPublicacionConsejo(Date publicacionConsejo) {
        this.publicacionConsejo = publicacionConsejo;
    }

    public Date getTerminoPublicacionConsejo() {
        return terminoPublicacionConsejo;
    }

    public void setTerminoPublicacionConsejo(Date terminoPublicacionConsejo) {
        this.terminoPublicacionConsejo = terminoPublicacionConsejo;
    }

    public Integer getContratoGuia() {
        return contratoGuia;
    }

    public void setContratoGuia(Integer contratoGuia) {
        this.contratoGuia = contratoGuia;
    }

    public Integer getTipoRevision2() {
        return tipoRevision2;
    }

    public void setTipoRevision2(Integer tipoRevision2) {
        this.tipoRevision2 = tipoRevision2;
    }

    public String getRutProfeRev1Sem() {
        return rutProfeRev1Sem;
    }

    public void setRutProfeRev1Sem(String rutProfeRev1Sem) {
        this.rutProfeRev1Sem = rutProfeRev1Sem;
    }

    public String getRutProfeRev2Sem() {
        return rutProfeRev2Sem;
    }

    public void setRutProfeRev2Sem(String rutProfeRev2Sem) {
        this.rutProfeRev2Sem = rutProfeRev2Sem;
    }

    public Date getFechaSeminario() {
        return fechaSeminario;
    }

    public void setFechaSeminario(Date secretaria) {
        this.fechaSeminario = secretaria;
    }

}
