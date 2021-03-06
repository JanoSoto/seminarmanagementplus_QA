package managedbeans2.temas;

import entities.Alumno;
import entities.Profesor;
import entities.Semestre;
import entities.Tema;
import entities.ComisionRevisora;
import entities.Propuesta;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import static managedbeans2.propuestas.ComisionRevisora2MB.fechaCorrecta;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.SemestreFacadeLocal;
import sessionbeans.TemaFacadeLocal;
import sessionbeans.PropuestaFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "verTemaMB")
@RequestScoped
public class VerTemaMB {

    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    @EJB
    private ComisionRevisoraFacadeLocal revisoraFacade;
    @EJB
    private PropuestaFacadeLocal propuestaFacade;

    private Integer idTema, idTemaEdit, idProp;

    private Profesor guia, coguia, corrector1, corrector2;
    private Tema tema;
    private Date fechaEdit, fechaEdit2, fechaEdit3;

    private String semestreEdit, nombreTemaEdit, semestreTerminoEdit, nombreProp;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(VerTemaMB.class);
    private Alumno alumno;

    /**
     * Creates a new instance of VerTemaMB
     */
    public VerTemaMB() {
    }

    public Integer buscarIdPropuestaDelTema(Integer idtema) {
        int retorno = 0;
        List<Tema> result = temaFacade.findById(idtema);
        if (result != null) {
            //System.out.println("Entro aca porque el resultado no es nulo");
            tema = result.get(0);
            List<ComisionRevisora> result1 = revisoraFacade.findByTema(tema);
            int idpropuesta = result1.get(0).getIdPropuesta().getIdPropuesta();
            List<Propuesta> resultProp = propuestaFacade.findById(idpropuesta);
            //setIdProp(resultProp.get(0).getIdPropuesta());
            //setNombreProp(resultProp.get(0).getNombrePropuesta());
            //System.out.println(nombreProp);
            retorno = resultProp.get(0).getIdPropuesta();
            //System.out.println(retorno);
            return retorno;
        }
        //System.out.println("Entro aca porque el resultado es nulo");
        FacesContext context = FacesContext.getCurrentInstance();
        context.addMessage(null, new FacesMessage("Error", "No se ingresó Propuesta"));
        return retorno;

    }

    public String buscarPropuestaDelTema(Integer idtema) {
        String retorno = "";
        List<Tema> result = temaFacade.findById(idtema);
        if (result != null) {
            //System.out.println("Entro aca porque el resultado no es nulo");
            tema = result.get(0);
            List<ComisionRevisora> result1 = revisoraFacade.findByTema(tema);
            int idpropuesta = result1.get(0).getIdPropuesta().getIdPropuesta();
            List<Propuesta> resultProp = propuestaFacade.findById(idpropuesta);
            //setIdProp(resultProp.get(0).getIdPropuesta());
            //setNombreProp(resultProp.get(0).getNombrePropuesta());
            //System.out.println(nombreProp);
            retorno = resultProp.get(0).getNombrePropuesta();
            //System.out.println(retorno);
            return retorno;
        }
        //System.out.println("Entro aca porque el resultado es nulo");
        FacesContext context = FacesContext.getCurrentInstance();
        context.addMessage(null, new FacesMessage("Error", "No se ingresó Propuesta"));
        return retorno;

    }
    
    public Propuesta buscarObjetoPropuestaDelTema(Integer idtema) {
        Propuesta retorno = null;
        List<Tema> result = temaFacade.findById(idtema);
        if (result != null) {
            //System.out.println("Entro aca porque el resultado no es nulo");
            tema = result.get(0);
            List<ComisionRevisora> result1 = revisoraFacade.findByTema(tema);
            int idpropuesta = result1.get(0).getIdPropuesta().getIdPropuesta();
            List<Propuesta> resultProp = propuestaFacade.findById(idpropuesta);
            //setIdProp(resultProp.get(0).getIdPropuesta());
            //setNombreProp(resultProp.get(0).getNombrePropuesta());
            //System.out.println(nombreProp);
            retorno = resultProp.get(0);
            //System.out.println(retorno);
            return retorno;
        }
        //System.out.println("Entro aca porque el resultado es nulo");
        FacesContext context = FacesContext.getCurrentInstance();
        context.addMessage(null, new FacesMessage("Error", "No se ingresó Propuesta"));
        return retorno;

    }

    public void buscarTema() {
        List<Tema> result = temaFacade.findById(idTema);
        if (result != null) {
            tema = result.get(0);
            //Inicializamos info para editar
            idTemaEdit = tema.getIdTema();
            nombreTemaEdit = tema.getNombreTema();
            semestreEdit = tema.getIdSemestre().getIdSemestre();
            fechaEdit = stringToDate(tema.getFechaTema());
            semestreTerminoEdit = tema.getSemestreTermino();
            if (tema.getFechaRealTema() != null) {
                fechaEdit2 = stringToDate(tema.getFechaRealTema());
            }
            if (tema.getFechaSiacTema() != null) {
                fechaEdit3 = stringToDate(tema.getFechaSiacTema());
            }

            for (int i = 0; i < tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().size(); i++) {
                if (tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia() == 0) {
                    guia = tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor();
                }
                if (tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getRolGuia() == 1) {
                    coguia = tema.getIdRevisora().getIdPropuesta().getProfePropuestaList().get(i).getProfesor();
                }
            }

            if (tema.getIdCorrectora() != null) {
                for (int i = 0; i < tema.getIdCorrectora().getProfeCorreccionList().size(); i++) {
                    if (tema.getIdCorrectora().getProfeCorreccionList().get(i).getRolCorreccion() == 0) {
                        corrector1 = tema.getIdCorrectora().getProfeCorreccionList().get(i).getProfesor();
                    }
                    if (tema.getIdCorrectora().getProfeCorreccionList().get(i).getRolCorreccion() == 1) {
                        corrector2 = tema.getIdCorrectora().getProfeCorreccionList().get(i).getProfesor();
                    }
                }
            }
            alumno = tema.getIdRevisora().getIdPropuesta().getRutAlumno();
        } else {
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage("Error", "No se ingresó Propuesta"));
        }
    }

    public void descaducarTema(Integer id) throws IOException {
        FacesContext context = FacesContext.getCurrentInstance();

        if (id == null) {
            context.addMessage(null, new FacesMessage("Error", "No se ingresó Id"));
            return;
        }
        Tema temaTemp = temaFacade.findById(id).get(0);
        temaTemp.setEstadoTema(0);
        temaTemp.setSemestreTermino("");
        temaFacade.edit(temaTemp);

        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Tema", temaTemp.getNombreTema() + ", editado en el sistema"));
        LOGGER.info("Tema " + temaTemp.getNombreTema() + " editado en el sistema");

        //externalContext.getFlash().setKeepMessages(true); //Para mantener los mensaje aunque se pase de página
        FacesContext.getCurrentInstance().getExternalContext().redirect("tema.xhtml?tema=" + id);
    }

    //Manejos de fechas
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
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

    public void editarTema() {
        FacesContext context = FacesContext.getCurrentInstance();

        Tema temaTemp = temaFacade.findById(idTemaEdit).get(0);

        if ((nombreTemaEdit == null) || (nombreTemaEdit.equals(""))) {
            context.addMessage(null, new FacesMessage("Nombre Tema", "Debe asignar nombre al Tema"));
            return;
        }

        if (fechaEdit == null || fechaEdit.equals("")) {
            context.addMessage(null, new FacesMessage("Fecha", "Debe seleccionar la fecha del Tema"));
            return;
        }

        if (fechaEdit2 == null || fechaEdit2.equals("")) {
            if (temaTemp.getEstadoTema() == 1) {
                context.addMessage(null, new FacesMessage("Fecha", "Debe seleccionar la fecha real del Tema"));
                return;
            }

        }

        if ((fechaEdit3 == null || fechaEdit3.equals(""))) {
            if (temaTemp.getEstadoTema() == 1) {
                context.addMessage(null, new FacesMessage("Fecha", "Debe seleccionar la fecha SIAC del Tema"));
                return;
            }

        }

        if (fechaCorrecta(temaTemp.getIdRevisora().getIdPropuesta().getFechaPropuesta(), dateToString(fechaEdit)) == false) {
            return;
        }

        if (temaTemp.getIdRevisora().getTipoRevision() == 0) {
            if (fechaCorrecta(temaTemp.getIdRevisora().getFechaEntregaRevision(), dateToString(fechaEdit)) == false) {
                return;
            }

            if (fechaCorrecta(temaTemp.getIdRevisora().getFechaEntregaRevision2(), dateToString(fechaEdit)) == false) {
                return;
            }
        }

        if (temaTemp.getIdRevisora().getTipoRevision() == 1) {
            if (fechaCorrecta(temaTemp.getIdRevisora().getFechaPublicacionConsejo(), dateToString(fechaEdit)) == false) {
                return;
            }
        }

        if (temaTemp.getIdRevisora().getTipoRevision() == 2) {
            if (fechaCorrecta(temaTemp.getIdRevisora().getFechaTerminoPublicacionConsejo(), dateToString(fechaEdit)) == false) {
                return;
            }
        }

        //Validamos que no haya otro tema con el mismo nombre
        if (!temaFacade.findByName(nombreTemaEdit).isEmpty() && !temaTemp.getNombreTema().equals(nombreTemaEdit)) {
            context.addMessage(null, new FacesMessage("Nombre Tema", "Ya existe un tema con ese nombre, por favor escoja otro."));
            return;
        }

        //Validaciones del Semestre
        if (semestreEdit == null || semestreEdit.equals("")) {
            context.addMessage(null, new FacesMessage("Semestre Tema", "Debe ingresar semestre"));
            return;
        }

        if (Integer.valueOf(semestreEdit.substring(2, 6)) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre Tema", "Año del semestre debe ser después de 1972"));
            return;
        }

        if ((Integer.valueOf(semestreEdit.substring(0, 1)) != 1) && (Integer.valueOf(semestreEdit.substring(0, 1)) != 2)) {
            context.addMessage(null, new FacesMessage("Semestre Tema", "Semestre ingresado debe ser '1' o '2'"));
            return;
        }

        //Validaciones del Semestre
        if ((semestreTerminoEdit == null || semestreTerminoEdit.equals(""))) {
            if (temaTemp.getEstadoTema() == 1) {
                context.addMessage(null, new FacesMessage("Semestre Tema", "Debe ingresar semestre"));
                return;
            }

        }
        if (temaTemp.getEstadoTema() == 1) {
            if (Integer.valueOf(semestreTerminoEdit.substring(2, 6)) <= 1972) {
                context.addMessage(null, new FacesMessage("Semestre Tema", "Año del semestre debe ser después de 1972"));
                return;
            }
            if ((Integer.valueOf(semestreTerminoEdit.substring(0, 1)) != 1) && (Integer.valueOf(semestreTerminoEdit.substring(0, 1)) != 2)) {
                context.addMessage(null, new FacesMessage("Semestre Tema", "Semestre ingresado debe ser '1' o '2'"));
                return;
            }

            temaTemp.setFechaRealTema(dateToString(fechaEdit2));
            temaTemp.setFechaSiacTema(dateToString(fechaEdit3));
            temaTemp.setSemestreTermino(semestreTerminoEdit);
        }

        //Editamos el tema
        nombreTemaEdit = nombreTemaEdit.toUpperCase();
        temaTemp.setNombreTema(nombreTemaEdit);
        temaTemp.setFechaTema(dateToString(fechaEdit));

        //Accedemos a la tabla semestre, e ingresamos semestre si no ha sido ingresado
        Semestre semTemp = new Semestre(semestreEdit);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semTemp)) {
            semestreFacade.create(semTemp);
        }
        temaTemp.setIdSemestre(semTemp);

        temaFacade.edit(temaTemp);

        //Mensaje de confirmación
        context.addMessage(null, new FacesMessage("Tema", "El tema ha sido editado exitosamente"));
        LOGGER.info("Tema " + nombreTemaEdit + " editado exitosamente");

    }

    public Integer getIdTemaEdit() {
        return idTemaEdit;
    }

    public void setIdTemaEdit(Integer idTemaEdit) {
        this.idTemaEdit = idTemaEdit;
    }

    public String getSemestreEdit() {
        return semestreEdit;
    }

    public void setSemestreEdit(String semestreEdit) {
        this.semestreEdit = semestreEdit;
    }

    public String getNombreTemaEdit() {
        return nombreTemaEdit;
    }

    public void setNombreTemaEdit(String nombreTemaEdit) {
        this.nombreTemaEdit = nombreTemaEdit;
    }

    public Date getFechaEdit() {
        return fechaEdit;
    }

    public void setFechaEdit(Date fechaEdit) {
        this.fechaEdit = fechaEdit;
    }

    public Date getFechaEdit2() {
        return fechaEdit2;
    }

    public void setFechaEdit2(Date fechaEdit2) {
        this.fechaEdit2 = fechaEdit2;
    }

    public Date getFechaEdit3() {
        return fechaEdit3;
    }

    public void setFechaEdit3(Date fechaEdit3) {
        this.fechaEdit3 = fechaEdit3;
    }

    public Integer getIdTema() {
        return idTema;
    }

    public void setIdTema(Integer idTema) {
        this.idTema = idTema;
    }

    public Profesor getGuia() {
        return guia;
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

    public Profesor getCorrector1() {
        return corrector1;
    }

    public void setCorrector1(Profesor corrector1) {
        this.corrector1 = corrector1;
    }

    public Profesor getCorrector2() {
        return corrector2;
    }

    public void setCorrector2(Profesor corrector2) {
        this.corrector2 = corrector2;
    }

    public Tema getTema() {
        return tema;
    }

    public void setTema(Tema tema) {
        this.tema = tema;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public String getSemestreTerminoEdit() {
        return semestreTerminoEdit;
    }

    public void setSemestreTerminoEdit(String semestreTerminoEdit) {
        this.semestreTerminoEdit = semestreTerminoEdit;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public Integer getIdProp() {
        return idProp;
    }

    public void setIdProp(Integer idProp) {
        this.idProp = idProp;
    }

    public String getNombreProp() {
        return nombreProp;
    }

    public void setNombreProp(String nombreProp) {
        this.nombreProp = nombreProp;
    }

}
