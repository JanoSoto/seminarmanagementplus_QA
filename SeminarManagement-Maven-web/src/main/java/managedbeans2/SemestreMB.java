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
import static managedbeans2.propuestas.ComisionRevisora2MB.fechaCorrecta;
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
    private SemestreActual semestreActual;
    private Semestre semestre_1;  
    private String semestre;
    private Date fechacierre;

    private Date fechaprecierre;

    public String getFechaprecierreString() {
        if(semestreFacade.findById(this.semestre).isEmpty()){
            return "";
        }
        return semestreFacade.findById(this.semestre).get(0).getFechaPrecierre();
//        return semestreFacade.findAll().get(0).getFechaPrecierre();
    }

    
    private Integer temasVSemActual = 0, temasCSemActual = 0, propSemActual = 0;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(SemestreMB.class);
    List<Semestre> semestresConPrecierre;

    public List<Semestre> getSemestresConPrecierre() {
        return semestresConPrecierre;
    }

    public void setSemestresConPrecierre(List<Semestre> semestresConPrecierreYCierre) {
        this.semestresConPrecierre = semestresConPrecierreYCierre;
    }

    /**
     * Creates a new instance of semestreMB
     */
    public SemestreMB() {
    }

    @PostConstruct
    public void init() {
        List<SemestreActual> sems = semestreActualFacade.findAll();
        if ( !sems.isEmpty() ){
            semestreActual = sems.get(0);
            semestre_1 = semestreFacade.findOneById(semestreActual.getSemestreActual());
        }
        
        List<Semestre> semestresTodos = semestreFacade.findAll();
        this.semestresConPrecierre = new ArrayList<>();
        for (int i = 0; i < semestresTodos.size(); i++) {
            if(semestresTodos.get(i).getFechaPrecierre() != null){
                this.semestresConPrecierre.add(semestresTodos.get(i));
            }
        }
        
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
    
    public Date getFechacierre() {
        return fechacierre;
    }

    public void setFechacierre(Date fechacierre) {
        this.fechacierre = fechacierre;
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
        if (fechacierre == null || fechacierre.equals("")) {
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
        Semestre cerrado = semestreFacade.findById(semViejo.getSemestreActual()).get(0);
        if (cerrado.getFechaPrecierre()!= null){
            if( fechaCorrecta(cerrado.getFechaPrecierre(),dateToString(fechacierre)) == false){
                return;
            }
        }
        cerrado.setFechaCierre(dateToString(fechacierre));
        semestreFacade.edit(cerrado);

        semestreActualFacade.remove(semViejo);

        //Seteamos el semestre actual
        SemestreActual semActual = new SemestreActual(semestreTemp.getIdSemestre());

        semestreActualFacade.create(semActual);

        //Realizamos los cambios a los temas
        String semestre_actual = semViejo.getSemestreActual();
        String proximo_semestre = semestreTemp.getIdSemestre();
        //List<Tema> temas = temaFacade.findAll();
        
        List<Tema> temas = semestre_1.getTemaList();
        for (int i = 0; i < temas.size(); i++) {
            if (temas.get(i).getEstadoTema() != null) {
                String semestre_tema = temas.get(i).getIdSemestre().getIdSemestre();
                
                if (temas.get(i).getEstadoTema() == 0 ) { // Vigente
                    temas.get(i).setEstadoTema(3);
                    temaFacade.edit(temas.get(i));

             
                } else if (temas.get(i).getEstadoTema() == 2) { // Prorrogado
                    temas.get(i).setEstadoTema(0);
                    temaFacade.edit(temas.get(i));

           
                } 
            }
        }

        context.addMessage(
                null, new FacesMessage("Estados y semestre modificados", "Semestre actual es: " + semActual.getSemestreActual()));

        context.addMessage(
                null, new FacesMessage("Estados y semestre modificados"));
        LOGGER.info("Estados y semestre modificados, el semestre actual es: " + semActual.getSemestreActual());
    }
    
    public void preterminarSemestreActual() {
        FacesContext context = FacesContext.getCurrentInstance();
        //Validamos que haya semestre actual
        SemestreActual semActual = semestreActualFacade.findAll().get(0);
        //List<Tema> temas = temaFacade.findAll();
        //List<Tema> temas = semestre_1.getTemaList();
        Semestre semestrePretermino = semestreFacade.findById(semActual.getSemestreActual()).get(0);
        //semestrePretermino.setIdSemestre(semActual.getSemestreActual());
        semestrePretermino.setFechaPrecierre(dateToString(fechaprecierre));
        semestreFacade.edit(semestrePretermino);

        context.addMessage(
                null, new FacesMessage("Se ha precerrado el semestre", "borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre"));

        context.addMessage(
                null, new FacesMessage("Estados y semestre modificados"));
        LOGGER.info("Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre");
    }

    public static String semestreSiguiente(String semestreActual) {
        String a = semestreActual.substring(0, 1);
        String b = semestreActual.substring(2, 6);
        if ("2".equals(a)) {
            return "1/" + (Integer.parseInt(b) + 1);
        } else {
            return "2/" + b;
        }
    }
    
    public Boolean hizoPrecierre() {
        if(semestreFacade.findById(this.semestre).isEmpty()){
            return false;
        }
        return semestreFacade.findById(this.semestre).get(0).getFechaPrecierre() != null;
    }

}
