/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans.estadotemas;

import clases.TemaDatos;
import entities.Historial;
import entities.Tema;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import managedbeans.AuthMB;
import org.primefaces.model.DualListModel;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author Eduardo
 */
@ManagedBean(name ="cambiosMasivosMB")
@RequestScoped
public class CambiosMasivosMB {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    
    private Integer opcionCaducar, opcionActivar;
    private String rutAlumno,nombreTema,fechaCaduco, fechaActivo, semestre;
    private List<Historial> historiales;
    private DualListModel<TemaDatos> pickListTemasCaducos,pickListTemasVigentes;
    private int temasVigentes;
    private Date date;
    private boolean cargarEvent;
    List<TemaDatos> temasCaducosSource, temasCaducosTarget;
    public CambiosMasivosMB() {
    }
    
    @PostConstruct
    public void init(){
        //Para inicializar el managed property, si no no se puede acceder a esos datos
        System.out.println(user.toString());
        
        date = null;
        semestre = null;
        cargarEvent = true;
        List<Tema> temasTemp = new ArrayList(), temasCaducosPorInforme = new ArrayList(), temasCaducosPorBorrador = new ArrayList();
        List<TemaDatos> temasVigentesSource = new ArrayList<TemaDatos>();
        List<TemaDatos> temasVigentesTarget = new ArrayList<TemaDatos>();
        temasCaducosSource = new ArrayList<TemaDatos>();
        temasCaducosTarget = new ArrayList<TemaDatos>();
        temasTemp = temaFacade.findAll();
        
        //Cargamos lista de temas vigentes
        for(int i=0; i<temasTemp.size(); i++)
            if(temasTemp.get(i).getEstadoTema() == 0){
                TemaDatos temaTemp = new TemaDatos();
                temaTemp.setNombreAlumno(temasTemp.get(i).getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno());
                temaTemp.setRutAlumno(temasTemp.get(i).getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno());
                temaTemp.setApellidoAlumno(temasTemp.get(i).getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno());
                temaTemp.setIdTema(temasTemp.get(i).getIdTema());
                temaTemp.setSemestreTema(temasTemp.get(i).getIdSemestre().getIdSemestre());
                temasVigentesSource.add(temaTemp);
            }
        
        
        //Cargamos lista de temas caducados por informe de avance
        for (int i = 0; i < temasTemp.size(); i++)
            if(temasTemp.get(i).getEstadoTema() == 3){
                TemaDatos temaTemp = new TemaDatos();
                temaTemp.setNombreAlumno(temasTemp.get(i).getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno());
                temaTemp.setApellidoAlumno(temasTemp.get(i).getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno());
                temaTemp.setRutAlumno(temasTemp.get(i).getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno());
                temaTemp.setIdTema(temasTemp.get(i).getIdTema());
                temaTemp.setSemestreTema(temasTemp.get(i).getIdSemestre().getIdSemestre());
                temasCaducosSource.add(temaTemp);
            }
        
        pickListTemasCaducos = new DualListModel<TemaDatos>(temasCaducosSource, temasCaducosTarget);
        pickListTemasVigentes = new DualListModel<TemaDatos>(temasVigentesSource, temasVigentesTarget);
    }
    
    //Declaramos esto para poder acceder al managed bean de autenticación (para almecenar el usuario en el historial)
    @ManagedProperty(value="#{authMB}")
    private AuthMB user;
    
    
    public AuthMB getUser() {
        return user;
    }

    public void setUser(AuthMB user) {
        this.user = user;
    }

    public boolean isCargarEvent() {
        return cargarEvent;
    }

    public void setCargarEvent(boolean cargarEvent) {
        this.cargarEvent = cargarEvent;
    }

    public String getSemestre() {
        return semestre;
    }

    public void setSemestre(String semestre) {
        this.semestre = semestre;
    }

    public DualListModel<TemaDatos> getPickListTemasVigentes() {
        return pickListTemasVigentes;
    }

    public void setPickListTemasVigentes(DualListModel<TemaDatos> pickListTemasVigentes) {
        this.pickListTemasVigentes = pickListTemasVigentes;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getTemasVigentes() {
        return temasVigentes;
    }

    public void setTemasVigentes(int temasVigentes) {
        this.temasVigentes = temasVigentes;
    }

    public String getFechaActivo() {
        return fechaActivo;
    }

    public void setFechaActivo(String fechaActivo) {
        this.fechaActivo = fechaActivo;
    }

    public Integer getOpcionCaducar() {
        return opcionCaducar;
    }

    public void setOpcionCaducar(Integer opcionCaducar) {
        this.opcionCaducar = opcionCaducar;
    }

    public Integer getOpcionActivar() {
        return opcionActivar;
    }

    public void setOpcionActivar(Integer opcionActivar) {
        this.opcionActivar = opcionActivar;
    }
    
    public String getRutAlumno() {
        return rutAlumno;
    }

    public void setRutAlumno(String rutAlumno) {
        this.rutAlumno = rutAlumno;
    }

    public String getNombreTema() {
        return nombreTema;
    }

    public void setNombreTema(String nombreTema) {
        this.nombreTema = nombreTema;
    }

    public String getFechaCaduco() {
        return fechaCaduco;
    }

    public void setFechaCaduco(String fechaCaduco) {
        this.fechaCaduco = fechaCaduco;
    }

    public List<Historial> getHistoriales() {
        return historiales;
    }

    public void setHistoriales(List<Historial> historiales) {
        this.historiales = historiales;
    }

    public DualListModel<TemaDatos> getPickListTemasCaducos() {
        return pickListTemasCaducos;
    }

    public void setPickListTemasCaducos(DualListModel<TemaDatos> pickListTemasCaducos) {
        this.pickListTemasCaducos = pickListTemasCaducos;
    }
    
    
    
    public String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }
    /*
    public void cargarTemasCaducos(){
        List<TemaDatos> temasCaducosSource = new ArrayList<TemaDatos>();
        List<TemaDatos> temasCaducosTarget = new ArrayList<TemaDatos>();
        List<Tema> temasTemp = temaFacade.findAll();
        
        //Cargamos lista de temas caducados por informe de avance
        for (int i = 0; i < temasTemp.size(); i++)
            if(temasTemp.get(i).getEstadoTema() == 3){
                TemaDatos temaTemp = new TemaDatos();
                temaTemp.setNombreAlumno(temasTemp.get(i).getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno());
                temaTemp.setApellidoAlumno(temasTemp.get(i).getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno());
                temaTemp.setRutAlumno(temasTemp.get(i).getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno());
                temaTemp.setIdTema(temasTemp.get(i).getIdTema());
                temaTemp.setSemestreTema(temasTemp.get(i).getIdSemestre().getIdSemestre());
                temasCaducosSource.add(temaTemp);
            }
        pickListTemasCaducos = new DualListModel<TemaDatos>(temasCaducosSource, temasCaducosTarget);
    }*/
    
    public void filtrarTemasCaducos(){
        FacesContext context = FacesContext.getCurrentInstance();
        List<TemaDatos> temasFiltradosSource = new ArrayList<TemaDatos>();
        List<TemaDatos> temasFiltradosTarget = new ArrayList<TemaDatos>();
        //Validamos errores de semestre
        if(semestre.isEmpty()){
            context.addMessage(null, new FacesMessage("Semestre","Debe escoger semestre"));
            return;
        }
        
        if (Integer.valueOf(semestre.substring(2, 6).toString()) <= 1972) {
            context.addMessage(null, new FacesMessage("Semestre","Año del semestre debe ser después de 1972"));
            return;
        }
        
        if ((Integer.valueOf(semestre.substring(0, 1)) != 1) && (Integer.valueOf(semestre.substring(0, 1)) != 2)){
            context.addMessage(null, new FacesMessage("Semestre","Semestre ingresado debe ser '1' o '2'"));
            return;
        }
        cargarEvent = false;
        int semTemp,anoTemp;
        String semAnterior;
        semTemp= Integer.parseInt(semestre.substring(0,1));
        anoTemp= Integer.parseInt(semestre.substring(2));
        
        if(semTemp==2)
            semTemp=1;
        else{
            semTemp=2;
            anoTemp--;
        }
        
        semAnterior = Integer.toString(semTemp)+"/"+Integer.toString(anoTemp);
        pickListTemasCaducos = new DualListModel<TemaDatos>(temasCaducosSource, temasCaducosTarget);
        //Seleccionamos los temas ingresados el semestre escogido y del anterior
        if(!pickListTemasCaducos.getSource().isEmpty())
            for(int i=0; i<pickListTemasCaducos.getSource().size(); i++){
                if(pickListTemasCaducos.getSource().get(i).getSemestreTema().equals(semestre) || pickListTemasCaducos.getSource().get(i).getSemestreTema().equals(semAnterior)){
                    temasFiltradosSource.add(pickListTemasCaducos.getSource().get(i));
                }
           }
        else{
            context.addMessage(null, new FacesMessage("Cargar Temas", "No hay temas caducados por este motivo en el semestre escogido")); 
            return;
        }
        pickListTemasCaducos = new DualListModel<TemaDatos>(temasFiltradosSource, temasFiltradosTarget);
    }
    
    public void caducarTemas(){
        FacesContext context = FacesContext.getCurrentInstance();    
        
        //VALIDACIONES
        //Se valida ingreso de fecha
        if(date == null){
            context.addMessage(null, new FacesMessage("Fecha de Caducación","Debe seleccionar una fecha"));
            return;
        }
        
        //Validamos que se escogan temas para caducar
        if(pickListTemasVigentes.getTarget().isEmpty()){
            context.addMessage(null, new FacesMessage("Caducar Temas Masivamente","No hay temas escogidos"));
            return;
        }
        
        Historial historial;
        Tema temaTemp;
        fechaCaduco = dateToString(date);
        
        //Caducamos temas escogidos, y agregamos la acción al historial
        for(int i=0; i<pickListTemasVigentes.getTarget().size(); i++){
            temaTemp = new Tema();
            temaTemp = temaFacade.findById(pickListTemasVigentes.getTarget().get(i).getIdTema()).get(0);
            temaTemp.setEstadoTema(3);
            temaFacade.edit(temaTemp);
            
            
            //Seteamos historial
            historial = new Historial();
            historial.setIdEntidad(String.valueOf(temaTemp.getIdTema()));
            historial.setTipoHistorial(1);
            historial.setFechaHistorial(fechaCaduco);
            String descHist = null;
            if(opcionCaducar == -1){
                descHist = "Motivo: No fue señalado";
                historial.setDescripcion("Caducar tema: El estado del tema cambió de 'Vigente' a 'Caduco'. "+descHist);
            }
            if(opcionCaducar == 1){
                descHist = "Motivo: Alumno no entrega borrador final";
                historial.setDescripcion("Caducar tema: El estado del tema cambió de 'Vigente' a 'Caduco'. "+descHist);
            }
            if(opcionCaducar == 2){
                descHist = "Motivo: Alumno no presenta informe de avance";
                historial.setDescripcion("Caducar tema: El estado del tema cambió de 'Vigente' a 'Caduco'. "+descHist);
            }
            if(opcionCaducar == 3){
                descHist = "Motivo: Otro";
                historial.setDescripcion("Caducar tema: El estado del tema cambió de 'Vigente' a 'Caduco'. "+descHist);
            }
            historialFacade.create(historial);
            
            //Añadimos al historial del alumno
            Date temp = new Date();
            String dateHist = dateToString(temp);
            Historial histCambioMasivoAlum = new Historial();
            histCambioMasivoAlum.setDescripcion("Se cambió masivamente el estado de su tema de 'Vigente' a 'Caduco'. Lo realizó el usuario "+user.getFullNameUser()+". "+descHist);
            histCambioMasivoAlum.setFechaHistorial(dateHist);
            histCambioMasivoAlum.setTipoHistorial(2);
            histCambioMasivoAlum.setIdEntidad(temaTemp.getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno());
            historialFacade.create(histCambioMasivoAlum);


            //Añadimos al historial del usuario que generó el cambio masivo
            Historial histCambioMasivoUser = new Historial();
            histCambioMasivoUser.setDescripcion("Cambió masivamente el Tema de 'Vigente' a 'Caduco' del alumno "+temaTemp.getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno()+" "+temaTemp.getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno()+". "+descHist);
            histCambioMasivoUser.setFechaHistorial(dateHist);
            histCambioMasivoUser.setTipoHistorial(3);
            histCambioMasivoUser.setIdEntidad(user.getUsername());
            historialFacade.create(histCambioMasivoUser);
        }
        init();
        context.addMessage(null, new FacesMessage("Caducar Temas", "Temas escogidos han pasado a estado 'Caduco'")); 
    }
    
    public void activarTemas(){
        FacesContext context = FacesContext.getCurrentInstance();
        
        //VALIDACIONES
        //Validamos que se hayan escogido temas para activar
        if(pickListTemasCaducos.getTarget().isEmpty()){
            context.addMessage(null, new FacesMessage("Activar Temas Masivamente","No hay temas escogidos"));
            return;
        }
        
        //Se valida ingreso de fecha
        if(date == null){
            context.addMessage(null, new FacesMessage("Fecha de Activación","Debe seleccionar una fecha"));
            return;
        }
        
        Tema temaTemp;
        Historial historial;
        fechaActivo = dateToString(date);
        //Activamos temas escogidos, y agregamos la acción al historial
        for(int i=0; i<pickListTemasCaducos.getTarget().size(); i++){
            temaTemp = new Tema();
            temaTemp = temaFacade.findById(pickListTemasCaducos.getTarget().get(i).getIdTema()).get(0);
            temaTemp.setEstadoTema(0);
            temaFacade.edit(temaTemp);
            
            //Seteamos historial
            historial = new Historial();
            historial.setIdEntidad(String.valueOf(temaTemp.getIdTema()));
            historial.setTipoHistorial(1);
            historial.setFechaHistorial(fechaActivo);
            String descHist = null;
            if(opcionActivar == -1){
                descHist = "Motivo: No fue señalado";
                historial.setDescripcion("Activar tema: El estado del tema cambió de 'Caduco' a 'Vigente'. "+descHist);
            }
            if(opcionActivar == 1){
                descHist = "Motivo: Alumno presentará informe de avance";
                historial.setDescripcion("Activar tema: El estado del tema cambió de 'Caduco' a 'Vigente'. "+descHist);
            }
            if(opcionActivar == 2){
                descHist = "Motivo: Alumno entregará borrador final";
                historial.setDescripcion("Activar tema: El estado del tema cambió de 'Caduco' a 'Vigente'. "+descHist);
            }
            if(opcionActivar == 3){
                descHist = "Motivo: Otro";
                historial.setDescripcion("Activar tema: El estado del tema cambió de 'Caduco' a 'Vigente'. "+descHist);
            }
            historialFacade.create(historial);
            
            //Añadimos al historial del alumno
            Date temp = new Date();
            String dateHist = dateToString(temp);
            Historial histCambioMasivoAlum = new Historial();
            histCambioMasivoAlum.setDescripcion("Se cambió masivamente el estado de su tema de 'Caduco' a 'Vigente'. Lo realizó el usuario "+user.getFullNameUser()+". "+descHist);
            histCambioMasivoAlum.setFechaHistorial(dateHist);
            histCambioMasivoAlum.setTipoHistorial(2);
            histCambioMasivoAlum.setIdEntidad(temaTemp.getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno());
            historialFacade.create(histCambioMasivoAlum);


            //Añadimos al historial del usuario que generó el cambio masivo
            Historial histCambioMasivoUser = new Historial();
            histCambioMasivoUser.setDescripcion("Cambió masivamente el Tema de 'Caduco' a 'Vigente' del alumno "+temaTemp.getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno()+" "+temaTemp.getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno()+". "+descHist);
            histCambioMasivoUser.setFechaHistorial(dateHist);
            histCambioMasivoUser.setTipoHistorial(3);
            histCambioMasivoUser.setIdEntidad(user.getUsername());
            historialFacade.create(histCambioMasivoUser);
        }
        opcionActivar = -1;
        date = null;
        init();
        context.addMessage(null, new FacesMessage("Activar Temas Masivamente", "Temas escogidos han pasado a estado 'Vigente'")); 
    }
}
