/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2;

import clases.TemaDatos;
import entities.Historial;
import entities.ProfePropuesta;
import entities.Propuesta;
import entities.Semestre;
import entities.SemestreActual;
import entities.Tema;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.Dependent;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author Elagos
 */
@Named(value = "semestreMB")
@RequestScoped
public class SemestreMB {

    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;

    private String semestre;
    private Date date;
    private Date fechaprecierre;

    
    private Integer temasVSemActual = 0, temasCSemActual = 0, propSemActual = 0;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(SemestreMB.class);

    /**
     * Creates a new instance of semestreMB
     */
    public SemestreMB() {
    }

    @PostConstruct
    public void init() {
        //Seteamos el semestre a semestre actual
        if (semestreActualFacade.findAll().isEmpty()) {
            semestre = "";
        } else {
            semestre = semestreActualFacade.findAll().get(0).getSemestreActual();
        }

        //Propuestas ingresadas semestre actual
        List<Propuesta> prop = propuestaFacade.findBySemestre(semestreFacade.find(semestre));
        propSemActual = prop.size();

        //Cantidad temas vigentes en el semestre actual
        List<Propuesta> prop2 = propuestaFacade.findAll();
        for (int i = 0; i < prop2.size(); i++) {
            if (prop2.get(i).getIdRevisora() != null) {
                if (prop2.get(i).getIdRevisora().getIdTema() != null) {
                    if (prop2.get(i).getIdRevisora().getIdTema().getEstadoTema() != null) {
                        if (prop2.get(i).getIdRevisora().getIdTema().getEstadoTema() == 0) {
                            temasVSemActual++;
                        }
                    }
                }
            }
        }
    }

    public Integer getTemasVSemActual() {
        return temasVSemActual;
    }

    public void setTemasVSemActual(Integer temasVSemActual) {
        this.temasVSemActual = temasVSemActual;
    }
    
    public Date getFechaprecierre() {
        return fechaprecierre;
    }

    public void setFechaprecierre(Date fechaprecierre) {
        this.fechaprecierre = fechaprecierre;
    }

    public Integer getTemasCSemActual() {
        return temasCSemActual;
    }

    public void setTemasCSemActual(Integer temasCSemActual) {
        this.temasCSemActual = temasCSemActual;
    }

    public Integer getPropSemActual() {
        return propSemActual;
    }

    public void setPropSemActual(Integer propSemActual) {
        this.propSemActual = propSemActual;
    }

    public String getSemestre() {
        return semestre;
    }

    public void setSemestre(String semestre) {
        this.semestre = semestre;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public void addSemestreActual() {
        FacesContext context = FacesContext.getCurrentInstance();

        //validamos semestre ingresado
        if (Integer.valueOf(semestre.substring(2, 6).toString()) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre", "Año del semestre debe ser después de 1972"));
            return;
        }

        //Validamos el semestre
        if ((Integer.valueOf(semestre.substring(0, 1)) != 1) && (Integer.valueOf(semestre.substring(0, 1)) != 2)) {
            context.addMessage(null, new FacesMessage("Semestre Actual", "Semestre ingresado debe ser '1' o '2'"));
            return;
        }

        //Asignamos el semestre
        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semTemp = new Semestre(semestre);
        List<Semestre> semestres = semestreFacade.findAll();
        if (!semestres.contains(semTemp)) {
            semestreFacade.create(semTemp);
        }

        //Seteamos el semestre actual
        SemestreActual semActual = new SemestreActual(semTemp.getIdSemestre());
        if (!semestreActualFacade.findAll().isEmpty()) {
            SemestreActual semViejo = semestreActualFacade.findAll().get(0);
            semestreActualFacade.remove(semViejo);
        }
        semestreActualFacade.create(semActual);

        //Mensaje de confirmación 
        context.addMessage(null, new FacesMessage("Semestre Actual Modificado", "Semestre actual es: " + semActual.getSemestreActual()));
        LOGGER.info("Semestre Actual Modificado el Semestre actual es: " + semActual.getSemestreActual());
    }

    public void terminarSemestreActual() {
        FacesContext context = FacesContext.getCurrentInstance();

        //Validamos que haya semestre actual
        if (semestreActualFacade.findAll()
                .isEmpty()) {
            context.addMessage(null, new FacesMessage("No hay Semestre Actual ingresado en el sistema", ""));
            return;
        } else {
            semestre = semestreActualFacade.findAll().get(0).getSemestreActual();
        }

        //Validamos el semestre
        if ((Integer.valueOf(semestre.substring(0, 1)) != 1) && (Integer.valueOf(semestre.substring(0, 1)) != 2)) {
            
            context.addMessage(null, new FacesMessage("Terminar Semestre", "Semestre ingresado debe ser '1' o '2'"));
            return;
        }

        //Validamos la fecha
        if (date
                == null || date.equals(
                        "")) {
            context.addMessage(null, new FacesMessage("Fecha", "Debe seleccionar la fecha de término del Semestre"));
            return;
        }

        int semTemp, anoTemp;
        semTemp = Integer.parseInt(semestre.substring(0, 1));
        anoTemp = Integer.parseInt(semestre.substring(2));

        if (semTemp
                == 1) {
            semTemp = 2;
        } else {
            semTemp = 1;
            anoTemp++;
        }

        semestre = Integer.toString(semTemp) + "/" + Integer.toString(anoTemp);

        //Asignamos el semestre
        //Accedemos a la tabla semestre, e ingresamos semestre actual si no ha sido ingresado
        Semestre semestreTemp = new Semestre(semestre);
        List<Semestre> semestres = semestreFacade.findAll();

        if (!semestres.contains(semestreTemp)) {
            semestreFacade.create(semestreTemp);
        }

        //Eliminamos el semestre viejo
        SemestreActual semViejo = semestreActualFacade.findAll().get(0);

        semestreActualFacade.remove(semViejo);

        //Seteamos el semestre actual
        SemestreActual semActual = new SemestreActual(semestreTemp.getIdSemestre());

        semestreActualFacade.create(semActual);

        //Realizamos los cambios a los temas
        String semestre_actual = semViejo.getSemestreActual();
        String proximo_semestre = semestreTemp.getIdSemestre();
        List<Tema> temas = temaFacade.findAll();
        for (int i = 0; i < temas.size(); i++) {
            if (temas.get(i).getEstadoTema() != null) {
                String semestre_tema = temas.get(i).getIdSemestre().getIdSemestre();
                
                if (temas.get(i).getEstadoTema() == 0 && !(proximo_semestre.equals(semestre_tema))) { // Vigente
                    temas.get(i).setEstadoTema(3);
                    temas.get(i).setSemestreTermino(semActual.getSemestreActual());
                    temaFacade.edit(temas.get(i));

                    /*
                     //Agregamos el historial de cambio de estado
                     Historial historial = new Historial();
                     String fecha = dateToString(date);
                     historial.setDescripcion("Fin de Semestre: El estado del tema cambió de 'Vigente' a 'Caduco'");
                     historial.setFechaHistorial(fecha);
                     historial.setIdEntidad(String.valueOf(temas.get(i).getIdTema()));
                     historial.setTipoHistorial(1);
                     historialFacade.create(historial);
                     */
                } else if (temas.get(i).getEstadoTema() == 2) { // Prorrogado
                    temas.get(i).setEstadoTema(0);
                    temaFacade.edit(temas.get(i));

                    /*
                     //Agregamos el historial de cambio de estado
                     Historial historial = new Historial();
                     String fecha = dateToString(date);
                     historial.setDescripcion("Fin de Semestre: El estado del tema cambió de 'Prorrogado' a 'Vigente'");
                     historial.setFechaHistorial(fecha);
                     historial.setIdEntidad(String.valueOf(temas.get(i).getIdTema()));
                     historial.setTipoHistorial(1);
                     historialFacade.create(historial);
                     */
                } else if (temas.get(i).getEstadoTema() == 6){
                    Tema temaCerrado = temas.get(i);
                    if(temaCerrado.getPrecerrado()==false){
                        temaCerrado.setIdSemestre(semestreTemp);
                        temaFacade.edit(temaCerrado);
                    }
                }
            }
        }

        context.addMessage(
                null, new FacesMessage("Estados y semestre modificados", "Semestre actual es: " + semActual.getSemestreActual()));

        context.addMessage(
                null, new FacesMessage("Estados y semestre modificados"));
        LOGGER.info(
                "Estados y semestre modificados, el semestre actual es: " + semActual.getSemestreActual());
    }
    
    public void preterminarSemestreActual() {
        FacesContext context = FacesContext.getCurrentInstance();
        //Validamos que haya semestre actual
        SemestreActual semActual = semestreActualFacade.findAll().get(0);
        List<Tema> temas = temaFacade.findAll();
        Semestre semestrePretermino = semestreFacade.findById(semActual.getSemestreActual()).get(0);
        semestrePretermino.setFechaPrecierre(dateToString(fechaprecierre));
        for (int i = 0; i < temas.size(); i++) {
            if (temas.get(i).getEstadoTema() != null) {
                if (temas.get(i).getEstadoTema() == 6){
                    temas.get(i).setPrecerrado(true);
                    
                    //temas.get(i).setPrecierre(dateToString(fechaprecierre));
                    temaFacade.edit(temas.get(i));
                }
            }
        }

        context.addMessage(
                null, new FacesMessage("Se ha precerrado el semestre", "borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre"));

        context.addMessage(
                null, new FacesMessage("Estados y semestre modificados"));
        LOGGER.info("Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre");
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

}
