
import entities.AsociacionPlanEstudioAlumno;
import otros.Asignatura;
import entities.ParamSemestreAno;
import entities.PlanEstudio;
import entities.Versionplan;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.inject.Named;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.NotOLE2FileException;
import org.apache.poi.ss.usermodel.Cell;
import org.primefaces.context.RequestContext;
import org.primefaces.model.DualListModel;
import otros.AsignaturasLocal;
import otros.CarrerasLocal;
import otros.PlanesEstudioLocal;
import otros.VersionesPlanLocal;
import sessionbeans.AsignaturaFacadeLocal;
import sessionbeans.CarreraFacadeLocal;
import sessionbeans.*;
import util.JsfUtil;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author giovanni
 */
@Named(value = "cargarPlanDeEstudios")
//@Dependent
@SessionScoped
public class CargarPlanDeEstudios implements Serializable {

    @EJB
    private AsignaturaFacadeLocal ejbFacade;
    
    @EJB
    private AsignaturasLocal asignaturas;
    
    @EJB
    private CarreraFacadeLocal carreraFacade;
    
    @EJB
    private CarrerasLocal carreraBusiness;
    
    @EJB
    private PlanestudioFacadeLocal plan;
    
    @EJB
    private VersionplanFacadeLocal version;
    
    @EJB
    private PlanesEstudioLocal planesBusiness;
    
    @EJB
    private VersionesPlanLocal versionesBusiness;
    
    @EJB
    private ParamSemestreAnioFacadeLocal paramFacade;
    
    @EJB
    asociacionFacadeLocal asociacionFacade;
    
    private int codigoPlan;
    private int versionPlan;
    private int anioPlan  = Calendar.getInstance().get(Calendar.YEAR);
    private long carreraSelected = 0;
    private String ruta;
    private HSSFWorkbook workbook;
    private String nombrePlan;
    private long idPlan = 0;
    private long idVersion = 0;
    private String aux;
    private boolean cargados = false;
    private List<Asignatura> asignaturasAñadidas = new ArrayList();    
    private DualListModel<Versionplan> versionPickList;
    private long nuevoPlan = 0L;
    private String jornada;
    private int codigo;
    private int resolucion = 1;
    private int anio_resolucion = Calendar.getInstance().get(Calendar.YEAR);
    private boolean iniciado = false;
    private boolean opcion = false;

    public boolean isOpcion() {
        return opcion;
    }

    public void setOpcion(boolean opcion) {
        this.opcion = opcion;
    }

    public boolean isIniciado() {
        return iniciado;
    }

    public void setIniciado(boolean iniciado) {
        this.iniciado = iniciado;
    }

    public int getResolucion() {
        return resolucion;
    }

    public void setResolucion(int resolucion) {
        this.resolucion = resolucion;
    }

    public int getAnio_resolucion() {
        return anio_resolucion;
    }

    public void setAnio_resolucion(int anio_resolucion) {
        this.anio_resolucion = anio_resolucion;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getJornada() {
        return jornada;
    }

    public void setJornada(String jornada) {
        this.jornada = jornada;
    }

    public long getNuevoPlan() {
        return nuevoPlan;
    }

    public void setNuevoPlan(long nuevoPlan) {
        this.nuevoPlan = nuevoPlan;
    }

    public CargarPlanDeEstudios() {
    }

    public ParamSemestreAnioFacadeLocal getParamFacade() {
        return paramFacade;
    }

    public void setParamFacade(ParamSemestreAnioFacadeLocal paramFacade) {
        this.paramFacade = paramFacade;
    }
    
    public DualListModel<Versionplan> getVersionPickList() {
        setVersionPickList();
        return versionPickList;
    }

    public void setVersionPickList(DualListModel<Versionplan> versionPickList) {
        this.versionPickList = versionPickList;
    }
    
    public void setVersionPickList(){
        List<Versionplan> versionesSource = getVersiones();
        List<Versionplan> versionesTarget = new ArrayList();
        this.versionPickList = new DualListModel<>(versionesSource, versionesTarget);
    }
    
    public String getNombrePlan() {
        return nombrePlan;
    }
    
    public List<PlanEstudio> getAllPlanEstudio() {
        return plan.findAll();
    }
    
    public List<AsociacionPlanEstudioAlumno> getAllAsociacionPlanEstudio() {
        List<AsociacionPlanEstudioAlumno> asociaciones = asociacionFacade.findAll();
        List<AsociacionPlanEstudioAlumno> salida = new ArrayList<>();
        for (AsociacionPlanEstudioAlumno asociacion : asociaciones) {
            salida.add(asociacion);
        }
        return salida;
    }

    public boolean isCargados() {
        return cargados;
    }

    public long getIdPlan() {
        return idPlan;
    }

    public void setIdPlan(long idPlan) {
        this.idPlan = idPlan;
    }

    public long getIdVersion() {
        return idVersion;
    }

    public void setIdVersion(long idVersion) {
        this.idVersion = idVersion;
    }
    
    public AsignaturasLocal getAsignaturas() {
        return asignaturas;
    }

    public void setAsignaturas(AsignaturasLocal asignaturas) {
        this.asignaturas = asignaturas;
    }

    public int getCodigoPlan() {
        return codigoPlan;
    }

    public void setCodigoPlan(int codigoPlan) {
        this.codigoPlan = codigoPlan;
    }

    public int getVersionplan() {
        return versionPlan;
    }

    public int getAnioPlan() {
        return anioPlan;
    }

    public void setAnioPlan(int anioPlan) {
        this.anioPlan = anioPlan;
    }

    public void setVersionplan(int versionPlan) {
        this.versionPlan = versionPlan;
    }

    public long getCarreraSelected() {
        return carreraSelected;
    }

    public void setCarreraSelected(long carreraSelected) {
        this.carreraSelected = carreraSelected;
    }
    
    public CarreraFacadeLocal getCarreraFacade() {
        return carreraFacade;
    }

    public void setCarreraFacade(CarreraFacadeLocal carreraFacade) {
        this.carreraFacade = carreraFacade;
    }
    
    public void setCargados(boolean cargados) {
        this.cargados = cargados;
    }

    public void setNombrePlan(String nombrePlan) {
        this.nombrePlan = nombrePlan;
    }
    
    
    private AsignaturaFacadeLocal getFacade(){
        return ejbFacade;
    }

    public String getAux() {
        return aux;
    }

    public void setAux(String aux) {
        this.aux = aux;
    }

    public String getRuta() {
        return ruta;
    }
    
    public void setRuta(String Ruta) {
        this.ruta = Ruta;
    }

    public CarrerasLocal getCarreraBusiness() {
        return carreraBusiness;
    }

    public void setCarreraBusiness(CarrerasLocal carreraBusiness) {
        this.carreraBusiness = carreraBusiness;
    }
    
    public List<Versionplan> getVersionesList(){
        return versionesBusiness.findByIdPlan(idPlan);
    }
    
    public List<PlanEstudio> getPlanesList(){
        return planesBusiness.findPlanByIdCarrera(carreraSelected);
    }
    
    public List<Versionplan> getVersiones(){
        System.out.println("Buscando versiones...");
        return version.findAll();
    }
    
    public List<Versionplan> getVersionesPlanificadas(){
        return versionesBusiness.findByPlanificado(true);
    }
    
    public String getJornada(int jornada){
        if (jornada == 0)
            return "Diurno";
        return "Vespertino";
    }
    
    public List<Integer> getAllJornada(){
        List<Integer> jornadas = new ArrayList<>();
        jornadas.add(0);
        jornadas.add(1);        
        return jornadas;    
    }
    
    public boolean posibleCarga(List<Asignatura> asigns, long idVersion){
        for(Asignatura a : asigns){
            if( a.getVersionplan().getId() == idVersion)
                return false;
        }
        return true;
    }
    
    public void seleccionarComando(){
        if (getTargetList().isEmpty()){
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"No se ha seleccionado ningún plan de estudio para la inicialización",null));
        }
        else{
            RequestContext.getCurrentInstance().execute("PF('dialogo').show();");
        }
        
    }
    
    public void cargarArchivo() throws FileNotFoundException, IOException{
        Versionplan versionSeleccionada = version.find(idVersion);
        List<Asignatura> asigns = ejbFacade.findAll();
        
        if(posibleCarga(asigns,idVersion)){
            List sheetData = new ArrayList();

            String[] aux2 = ruta.split("=", 5);
            boolean flag = false;


            try{
                FileInputStream file = new FileInputStream(aux2[2].split(", size")[0]);
                workbook = new HSSFWorkbook(file);
                HSSFSheet sheet = workbook.getSheetAt(0);

                Iterator rows = sheet.rowIterator();
                while (rows.hasNext()) {
                    HSSFRow row = (HSSFRow) rows.next();
                    Iterator cells = row.cellIterator();
                    List data = new ArrayList();
                    while (cells.hasNext()) {
                    HSSFCell cell = (HSSFCell) cells.next();
                    data.add(cell);
                    }
                    sheetData.add(data);
                }

                for (Object sheetData1 : sheetData) {
                    Asignatura asignatura = new Asignatura();
                    List list = (List) sheetData1;
                    Cell cell = (Cell) list.get(0);
                    try{
                        int num = (int) cell.getNumericCellValue();
                        asignatura.setCodigo(num+"");
                        cell = (Cell) list.get(1);
                        asignatura.setNombre(cell.getStringCellValue());
                        cell = (Cell) list.get(2);
                        asignatura.setTeoria((int) cell.getNumericCellValue());
                        cell = (Cell) list.get(3);
                        asignatura.setEjercicios((int) cell.getNumericCellValue());
                        cell = (Cell) list.get(4);
                        asignatura.setLaboratorio((int) cell.getNumericCellValue());
                        cell = (Cell) list.get(5);
                        asignatura.setNivel((int) cell.getNumericCellValue());

                        cell = (Cell) list.get(6);
                        asignatura.setVersionplan(versionSeleccionada);
                    }
                    catch(IllegalStateException ex5){
                        aux = "El archivo no contiene los campos requeridos o estos no se encuentran en el orden correcto. Los campos requeridos son código asignatura, nombre asignatura, teoría, ejercicio, laboratorio, nivel y requisitos, en ese mismo orden.";
                        flag = true;
                        break;
                    }

                    try{
                        switch(cell.getCellType()){
                            case Cell.CELL_TYPE_STRING:{
                                if(cell.getStringCellValue().equals("Ingreso") || cell.getStringCellValue().equals("")){
                                    asignatura.setPrerequisitos(new ArrayList());
                                }
                                else {
                                    String[] prerequisitos = cell.getStringCellValue().split(", "); 
                                    List lista = new ArrayList();
                                    for (int i=0; i<prerequisitos.length; i++){
                                        Asignatura aux = getBusiness().findByCodigoAsgAndIdVersion(prerequisitos[i], versionSeleccionada.getId());
                                        //Asignatura aux = getBusiness().findByCarreraAndCodigoAndPlan(carreraSelected,prerequisitos[i], nombrePlan);
                                        if(aux != null){
                                            System.out.println(aux.toString());
                                            lista.add(aux);
                                        }
                                    }
                                    asignatura.setPrerequisitos(lista);
                                }
                                break;
                            }
                            case Cell.CELL_TYPE_NUMERIC:{
                                List lista = new ArrayList();
                                asignatura.setPrerequisitos(lista);
                                Asignatura aux = getBusiness().findByCodigoAsgAndIdVersion((int) cell.getNumericCellValue() +"", versionSeleccionada.getId());
                                //Asignatura aux = getBusiness().findByCarreraAndCodigoAndPlan(carreraSelected,(int) cell.getNumericCellValue() +"", nombrePlan);
                                if(aux != null){
                                    lista.add(aux);
                                }
                            }
                        }
                    }
                    catch(EJBException ex){
                        Throwable cause = ex.getCause();
                        if (cause != null) {
                            aux = cause.getLocalizedMessage();
                        }
                    }
                    if(!flag){
                        asignaturasAñadidas.add(asignatura);
                        persist(asignatura);
                    }
                }
                if(!flag){
                    aux = "Archivo cargado con éxito";
                    cargados = true;                
                }
            }
            catch(NotOLE2FileException ex){
                String linea;
                BufferedReader buffer = new BufferedReader(new FileReader(aux2[2].split(", size")[0]));
                try{
                    while((linea = buffer.readLine()) != null){
                        String[] elementos = linea.split(",");
                        Asignatura asignatura = new Asignatura();
                        asignatura.setCodigo(elementos[0]);                    
                        try{
                            asignatura.setNombre(elementos[1]);
                            asignatura.setTeoria(Integer.parseInt(elementos[2]));
                            asignatura.setEjercicios(Integer.parseInt(elementos[3]));
                            asignatura.setLaboratorio(Integer.parseInt(elementos[4]));
                            asignatura.setNivel(Integer.parseInt(elementos[5]));
                            asignatura.setVersionplan(versionSeleccionada);
                            if(elementos[6].equals("") || elementos[6].equals("Ingreso")){
                                asignatura.setPrerequisitos(new ArrayList());
                            }
                            else{
                                List lista = new ArrayList();
                                if(elementos.length == 8){
                                    Asignatura aux = getBusiness().findByCodigoAsgAndIdVersion(elementos[6], versionSeleccionada.getId());
                                    //Asignatura aux = getBusiness().findByCarreraAndCodigoAndPlan(carreraSelected,elementos[6], nombrePlan);
                                    if (aux != null)
                                        lista.add(aux);
                                }
                                else if(elementos.length == 9){
                                    Asignatura aux = getBusiness().findByCodigoAsgAndIdVersion(elementos[6], versionSeleccionada.getId());
                                    //Asignatura aux = getBusiness().findByCarreraAndCodigoAndPlan(carreraSelected,elementos[6].substring(1), nombrePlan);

                                    if(aux != null)
                                        lista.add(aux);
                                    Asignatura aux3 = getBusiness().findByCodigoAsgAndIdVersion(elementos[7].substring(1, elementos[7].length()-1), versionSeleccionada.getId());
                                    //Asignatura aux3 = getBusiness().findByCarreraAndCodigoAndPlan(carreraSelected,elementos[7].substring(1, elementos[7].length()-1), nombrePlan);
                                    if(aux3 != null)
                                        lista.add(aux3);
                                }
                                else if(elementos.length > 9){
                                    Asignatura aux = getBusiness().findByCodigoAsgAndIdVersion(elementos[6].substring(1), versionSeleccionada.getId());
                                    //Asignatura aux = getBusiness().findByCarreraAndCodigoAndPlan(carreraSelected,elementos[6].substring(1), nombrePlan);
                                    if (aux != null)
                                        lista.add(aux);
                                    int i = 7;
                                    while(i<elementos.length-2){
                                        Asignatura aux3 = getBusiness().findByCodigoAsgAndIdVersion(elementos[i].substring(1), versionSeleccionada.getId());
                                        //Asignatura aux3 = getBusiness().findByCarreraAndCodigoAndPlan(carreraSelected,elementos[i].substring(1), nombrePlan);
                                        if (aux3 != null)
                                            lista.add(aux3);
                                        i++;
                                    }
                                    Asignatura aux3 = getBusiness().findByCodigoAsgAndIdVersion(elementos[i].substring(1,elementos[i].length()-1), versionSeleccionada.getId());
                                    //Asignatura aux3 = getBusiness().findByCarreraAndCodigoAndPlan(carreraSelected,elementos[i].substring(1, elementos[i].length()-1), nombrePlan);
                                    if (aux3 != null)
                                        lista.add(aux3);                            
                                }

                                asignatura.setPrerequisitos(lista);
                            }
                        }
                        catch(ArrayIndexOutOfBoundsException ex3){
                            aux = "El archivo tiene problemas internos de codificación o no corresponde con los formatos adecuados (CSV o XLS). Si el formato del archivo es el adecuado, por favor, ábralo con su editor de texto, guárdelo como un archivo csv o xls y vuelva a intentarlo.";
                            flag = true;
                            break;
                        }
                        catch(IllegalStateException | NumberFormatException ex5){
                            aux = "El archivo no contiene los campos requeridos o estos no se encuentran en el orden correcto. Los campos requeridos son código asignatura, nombre asignatura, teoría, ejercicio, laboratorio, nivel y requisitos, en ese mismo orden.";
                            flag = true;
                            break;
                        }
                        if(!flag){
                            asignaturasAñadidas.add(asignatura);
                            persist(asignatura);
                        }

                    }
                    if(!flag){
                        aux = "Archivo cargado con éxito";
                        cargados = true;
                    }
                }            
                catch(EJBException ex2){
                    aux = "Ya existe un Plan de Estudios con el nombre '"+nombrePlan+"'";
                }
                catch(Exception ex3){
                    aux = "El archivo no es válido";
                }

            } 
        }else{
            aux = "El plan ya contiene asignaturas cargadas.";
            JsfUtil.addErrorMessage("El plan ya contiene asignaturas cargadas.");
        }
    }
    
    public void persist(Asignatura asignatura){
        try{
            getFacade().create(asignatura);
        }
        catch(EJBException ex){
            Throwable cause = ex.getCause();
            if (cause != null) {
                aux = cause.getLocalizedMessage();
            }
        }
    }
    
    public List<Asignatura> getAsignaturasAñadidas(){
        return asignaturasAñadidas;
    }
    
    public AsignaturasLocal getBusiness(){
        return asignaturas;
    }
    
    public List<Versionplan> getTargetList(){
        try{
            List<Versionplan> tgt = this.versionPickList.getTarget();
            return tgt;
        }catch(NullPointerException e){
            return new ArrayList<>();
        }
    }
    
    public void iniciarPlanificacion() throws IOException{
        if(this.versionPickList.getTarget().isEmpty()){
            System.out.println("versionesTarget está vacío");
            JsfUtil.addErrorMessage("No ha seleccionado ninguna carrera");
        }
        else{
            System.out.println("VersionesTarget tiene contenido");
            for(Versionplan vp : this.versionPickList.getTarget()){
                vp.setPlanificado(true);
                this.version.edit(vp);
            }
            for(Versionplan vp : this.versionPickList.getSource()){
                vp.setPlanificado(false);
                this.version.edit(vp);
            }
            avanzarSemestre();
            iniciado = true;
            JsfUtil.addSuccessMessage("Planificación iniciada correctamente para las carreras seleccionadas");
            FacesContext.getCurrentInstance().getExternalContext().redirect("/easy-planning-web/faces/coordinador_docente/plan_de_estudios/inicializar_secciones.xhtml");
            
        }
    }
    
    public List<Versionplan> getTarget(){
        return this.versionPickList.getTarget();
    }
    
    public void avanzarSemestre(){
        ParamSemestreAno paramSemAno = this.paramFacade.find(1L);
        int sem = paramSemAno.getSemestreActual();
        int ano = paramSemAno.getAnoActual();
        if(sem == 1){
            paramSemAno.setSemestreActual(2);
            this.paramFacade.edit(paramSemAno);
        }
        else{
            paramSemAno.setSemestreActual(1);
            paramSemAno.setAnoActual(ano+1);
            this.paramFacade.edit(paramSemAno);
        }
    }
    
    public boolean agregaPlan(){
        if(idPlan != 0L){
            opcion = false;
            return true;
        }
        else{
            return false;
        }
    }
    
    public void agregarPlanDeEstudios() throws IOException{
        if(!opcion){
            if(idPlan != 0L){
                Versionplan vp = version.find(idPlan);
                PlanEstudio planAntiguo = vp.getPlanestudio();
                Versionplan newVp = new Versionplan();
                newVp.setAnio(vp.getAnio());
                newVp.setPlanestudio(planAntiguo);
                newVp.setPlanificado(false);
                newVp.setVersion(vp.getVersion()+1);
                newVp.setCorrelativo(versionesBusiness.findMaxCorrelativo()+1);
                newVp.setAnio_resolucion(anio_resolucion);
                newVp.setResolucion(resolucion);
                System.out.println(newVp);
//                version.create(newVp);
                planAntiguo.addVersion(newVp);
                plan.edit(planAntiguo);
                
                carreraSelected = 0;
                idPlan = 0L;
                codigo = 0;
                anioPlan = Calendar.getInstance().get(Calendar.YEAR);
                resolucion = 1;
                anio_resolucion = Calendar.getInstance().get(Calendar.YEAR);
                jornada = null;
                JsfUtil.addSuccessMessage("Nueva versión del plan "+vp.getPlanestudio().getCodigo()+" creada con éxito");
//                FacesContext.getCurrentInstance().getExternalContext().redirect("/SeminarManagement-Maven-web/2.0/admin/planes.xhtml");
            }
            else{
                JsfUtil.addErrorMessage("Debe seleccionar un Plan de Estudios");
            }
        }
        else{
            if(!(codigo == 0 || anioPlan < 1900  || resolucion == 0 || anio_resolucion < 1900) ){
                PlanEstudio newPlan = new PlanEstudio();
                newPlan.setCarrera(carreraFacade.find(carreraSelected));
                newPlan.setCodigo(codigo);
                if(jornada.equals("Diurno")){
                    newPlan.setJornada(0);
                }
                else{
                    newPlan.setJornada(1);
                }
                Versionplan vp = new Versionplan();
                vp.setAnio(anioPlan);
                vp.setPlanestudio(newPlan);
                vp.setPlanificado(false);
                vp.setVersion(1);
                vp.setResolucion(resolucion);
                vp.setAnio_resolucion(anio_resolucion);
                vp.setCorrelativo(versionesBusiness.findMaxCorrelativo()+1);
                newPlan.addVersion(vp);
                plan.create(newPlan);
//                version.create(vp);
                carreraSelected = 0;
                idPlan = 0L;
                codigo = 0;
                anioPlan = Calendar.getInstance().get(Calendar.YEAR);
                resolucion=1;
                anio_resolucion = Calendar.getInstance().get(Calendar.YEAR);
                jornada = null;
                JsfUtil.addSuccessMessage("Nuevo plan agregado correctamente");
//                recargaPagina();
            }
            else{
                JsfUtil.addErrorMessage("Alguno de los parámetros indicados no es correcto");
            }
        }
    }
    
    public int obtenerNivelMayor(List<Asignatura> asignaturas){
        int mayor = 0;
        for (Asignatura a : asignaturas){
            if (mayor < a.getNivel())
                mayor = a.getNivel();
        }
        return mayor;
    }
    
    public void eliminarMalla(){
        if (idVersion == 0)
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "No se ha seleccionado ningún plan de estudios.", null));
        else{
            System.out.println("idVersion: "+idVersion);
            List<Asignatura> asignaturasMalla = new ArrayList<>();
            for(Asignatura a : ejbFacade.findAll()){
                if (a.getVersionplan().getId() == idVersion)
                    asignaturasMalla.add(a);
            }
            if(!asignaturasMalla.isEmpty()){
                int contador = 0;
                for(Asignatura a : asignaturasMalla){
                    if (!a.getCoordinaciones().isEmpty()){
                        contador++;
                    }
                }
                if (contador == 0){
                    int nivel = obtenerNivelMayor(asignaturasMalla);
                    while(nivel > 0){
                        for (Asignatura a : asignaturasMalla){
                            if (a.getNivel() == nivel){
                                ejbFacade.remove(a);
                            }
                            nivel--;
                        }
                    }
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "La malla del plan de estudios seleccionado ha sido eliminada con éxito.", null));
                }
                else{
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "La malla del plan de estudios seleccionado ya tiene datos cargados y no se puede borrar.", null));
                }
            }
            else
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "La malla seleccionada no contiene ninguna asignatura", null));
        }
    }
    
    public void recargaPagina() throws IOException{
        FacesContext.getCurrentInstance().getExternalContext().redirect("/SeminarManagement-Maven-web/2.0/admin/agregar_plan.xhtml");
    }
}
