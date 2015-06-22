package managedbeans2.propuestas;

import entities.Alumno;
import entities.ComisionRevisora;
import entities.PlanEstudio;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import entities.Versionplan;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.PlanestudioFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.SemestreFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "verPropuestaMB")
@SessionScoped
public class VerPropuestaMB implements Serializable {

    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    @EJB
    private ComisionRevisoraFacadeLocal comisionRevisoraFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private PlanestudioFacadeLocal planFacade;

    private Integer idPropuesta, idPropEdit;
    private String nombreCorto, semestrePropEdit, nombrePropEdit, fechaEntRev;
    private Profesor guia, coguia, revisor1, revisor2;
    private List<ComisionRevisora> comision;
    private Propuesta propuesta;
    private boolean pet;
    private String pet2;
    private Date fechaPropEdit, date, date2;
    private Alumno alumno;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(VerPropuestaMB.class);
    private boolean puedeTenerTema = false;

    /**
     * Creates a new instance of VerPropuestaMB
     */
    public VerPropuestaMB() {
    }

    public void buscarPropuesta() {
        if (idPropuesta != null) {
            List<Propuesta> result = propuestaFacade.findById(idPropuesta);
            if (!result.isEmpty()) {
                propuesta = result.get(0);
                //Inicializamos datos para editar
                idPropEdit = propuesta.getIdPropuesta();
                nombrePropEdit = propuesta.getNombrePropuesta();
                fechaPropEdit = stringToDate(propuesta.getFechaPropuesta());
                semestrePropEdit = propuesta.getIdSemestre().getIdSemestre();

                if (propuesta.getPet() == null) {
                    pet2 = "No hay Pet";
                } else {
                    pet = propuesta.getPet();
                }

                if (pet == true) {
                    pet2 = "Es Pet";
                }

                if (pet == false) {
                    pet2 = "No es Pet";
                }

                if (date != null) {
                    date = stringToDate(propuesta.getIdRevisora().getFechaRevision());
                }

                if (date2 != null) {
                    date2 = stringToDate(propuesta.getIdRevisora().getFechaEntregaRevision());
                }

                if (propuesta.getNombrePropuesta().length() > 68) {
                    nombreCorto = propuesta.getNombrePropuesta().substring(0, 69) + "...";
                } else {
                    nombreCorto = propuesta.getNombrePropuesta();
                }

                for (int i = 0; i < propuesta.getProfePropuestaList().size(); i++) {
                    if (propuesta.getProfePropuestaList().get(i).getRolGuia() == 0) {
                        guia = propuesta.getProfePropuestaList().get(i).getProfesor();
                    }
                    if (propuesta.getProfePropuestaList().get(i).getRolGuia() == 1) {
                        coguia = propuesta.getProfePropuestaList().get(i).getProfesor();
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

                    if (propuesta.getIdRevisora().getTipoRevision() == 2) {
                        //puedeTenerTema = propuesta.getIdRevisora().getFechaPublicacionConsejo() != null 
                        //        && propuesta.getIdRevisora().getFechaTerminoPublicacionConsejo() != null;
                        puedeTenerTema = true;
                    } else {
                        puedeTenerTema = propuesta.getIdRevisora().getFechaRevision() != null
                                && propuesta.getIdRevisora().getFechaRevision2() != null
                                && propuesta.getIdRevisora().getFechaEntregaRevision() != null
                                && propuesta.getIdRevisora().getFechaEntregaRevision2() != null;
                    }
                }

                alumno = propuesta.getRutAlumno();
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

        if (pet != true && pet != false) {
            context.addMessage(null, new FacesMessage("Semestre Propuesta", "Debe ingresar pet propuesta"));
            return;
        }

        //Se valida que no exista otra propuesta con el mismo nombre
        List<Propuesta> propuestas = propuestaFacade.findByName(nombrePropEdit);
        if (!propuestas.isEmpty() && !Objects.equals(propTemp.getIdPropuesta(), propuestas.get(0).getIdPropuesta())) {
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
        propTemp.setPet(pet);
        propuestaFacade.edit(propTemp);

        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Propuesta", "La propuesta ha sido editada exitosamente"));
        LOGGER.info("La el nombre de la propuesta ha sido editada exitosamente por " + nombrePropEdit);

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

    public String funcion(String rut) {
        Profesor propTemp = profesorFacade.findByRut(rut).get(0);
        return propTemp.getNombreProfesor();
    }

    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public String getNombrePropEdit() {
        return nombrePropEdit;
    }

    public void setNombrePropEdit(String nombrePropEdit) {
        this.nombrePropEdit = nombrePropEdit;
    }

    public Integer getIdPropEdit() {
        return idPropEdit;
    }

    public void setIdPropEdit(Integer idPropEdit) {
        this.idPropEdit = idPropEdit;
    }

    public String getSemestrePropEdit() {
        return semestrePropEdit;
    }

    public void setSemestrePropEdit(String semestrePropEdit) {
        this.semestrePropEdit = semestrePropEdit;
    }

    public Date getFechaPropEdit() {
        return fechaPropEdit;
    }

    public void setFechaPropEdit(Date fechaPropEdit) {
        this.fechaPropEdit = fechaPropEdit;
    }

    public Propuesta getPropuesta() {
        return propuesta;
    }

    public void setPropuesta(Propuesta propuesta) {
        this.propuesta = propuesta;
    }

    public Integer getIdPropuesta() {
        return idPropuesta;
    }

    public void setIdPropuesta(Integer idPropuesta) {
        this.idPropuesta = idPropuesta;
    }

    public Profesor getGuia() {
        return guia;
    }

    public String getNombreCorto() {
        return nombreCorto;
    }

    public void setNombreCorto(String nombreCorto) {
        this.nombreCorto = nombreCorto;
    }

    public void setGuia(Profesor guia) {
        this.guia = guia;
    }

    public Profesor getCoguia() {
        return coguia;
    }

    public void setCoguia(Profesor coguia) {
        this.coguia = coguia;
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

    public Alumno getAlumno() {
        return alumno;
    }

    public boolean isPet() {
        return pet;
    }

    public void setPet(boolean pet) {
        this.pet = pet;
    }

    public String getPet2() {
        return pet2;
    }

    public void setPet2(String pet2) {
        this.pet2 = pet2;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public boolean isPuedeTenerTema() {
        return puedeTenerTema;
    }

    public void setPuedeTenerTema(boolean puedeTenerTema) {
        this.puedeTenerTema = puedeTenerTema;
    }

    public String getNombrePlan(Integer id_plan, Integer version_plan) {
        List<PlanEstudio> planes = alumno.getPlanes();
        PlanEstudio plan = null;
        System.out.println("Id: " + id_plan);
        System.out.println("VE: " + version_plan);
        for (int i = 0; i < planes.size(); i++) {
            if (planes.get(i).getId().equals(Long.parseLong(id_plan + ""))) {
                List<Versionplan> versiones = planes.get(i).getVersionplanList();
                for (int j = 0; j < versiones.size(); j++) {
                    Versionplan versionPlan = versiones.get(j);
                    System.out.println("Comparando: " + versionPlan.getVersion() + " con " + Long.parseLong(version_plan + ""));
                    if (versionPlan.getVersion() == Long.parseLong(version_plan + "")) {
                        System.out.println("existeeeee");
                        plan = planes.get(i);
                    }
                }
            }
        }
        System.out.println("Plan: " + plan);
        if (plan == null) {
            return "";
        }
        return plan.getCodigo() + " " + version_plan + " " + plan.getCarreraId().getNombre();
    }

    public Date menorFechaEntregaComisionCorrectora() throws ParseException {
        List<ComisionRevisora> comision_correctora = this.propuesta.getComisionRevisoraList();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        String fecha_menor = "";
        Date date_menor = null;
        for (int i = 0; i < comision_correctora.size(); i++) {
            ComisionRevisora comision = comision_correctora.get(i);
            String fecha_1 = comision.getFechaEntregaRevision();
            String fecha_2 = comision.getFechaEntregaRevision2();

            Date date1 = fecha_1 == null ? null : format.parse(fecha_1);
            Date date2 = fecha_2 == null ? null : format.parse(fecha_2);
            if (date1 == null && date2 == null) {
                continue;
            }
            Date date_min;
            String fecha_min;
            if (date1 == null) {
                date_min = date2;
                fecha_min = fecha_2;
            } else if (date2 == null) {
                date_min = date1;
                fecha_min = fecha_1;
            } else {
                date_min = date1.compareTo(date2) <= 0 ? date1 : date2;
                fecha_min = date1.compareTo(date2) <= 0 ? fecha_1 : fecha_2;
            }
            if (date_menor == null || date_menor.compareTo(date_min) <= 0) {
                date_menor = date_min;
                fecha_menor = fecha_min;
            }
        }
        return date_menor;
    }
}
