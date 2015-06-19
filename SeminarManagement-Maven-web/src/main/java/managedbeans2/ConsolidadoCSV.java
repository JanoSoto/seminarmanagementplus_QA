package managedbeans2;

import entities.Alumno;
import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.ProfePropuesta;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import entities.Tema;
import entities.Usuario;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.AlumnoFacadeLocal;
import sessionbeans.ComisionCorrectoraFacadeLocal;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.ProfePropuestaFacadeLocal;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.SemestreFacadeLocal;
import sessionbeans.TemaFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "consolidadoCVS")
@RequestScoped
public class ConsolidadoCSV {
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private ComisionCorrectoraFacadeLocal comisionCorrectoraFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    @EJB
    private ComisionRevisoraFacadeLocal comisionRevisoraFacade;
    @EJB
    private ProfePropuestaFacadeLocal profePropuestaFacade;
    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;
    
    private String path;

    /**
     * Creates a new instance of ConsolidadoCVS
     */
    public ConsolidadoCSV() {
    }
    
    public void leer(){
        
        String csvFile = path;
        System.out.println(path);
    	BufferedReader br = null;
    	String line;
        
        List<String> lines = new ArrayList();
        
	   //Lee el CSV y almacena cada linea en la variable lines
        try {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(csvFile), "UTF-8"));
            int count=0;
            while ((line = br.readLine()) != null) {
                if(count>0)
                    lines.add(line);
                count++;
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        
        List<String> fila;
        ConsolidadoCSV cCSV = new ConsolidadoCSV();
        List<Profesor> profes = new ArrayList();
        List<Alumno> alumnos = new ArrayList();
        
        /*for(int i=0;i<5;i++){
            fila = cCSV.splitCSVLine(lines.get(i));
            cCSV.printList(fila);
        }
        
        fila = cCSV.splitCSVLine(lines.get(25));
        cCSV.printList(fila);*/
        
        //Transforma cada linea en un arreglo y lo recorre
        for(int i=0;i<lines.size();i++){
            fila = cCSV.splitCSVLine(lines.get(i));
            
            //Agregamos Profesor
            Profesor profeTemp;
            profeTemp = new Profesor(cCSV.rutProfe(fila.get(2)));//Debería ser el RUT
            Usuario cs1 = usuarioFacade.findByRut(profeTemp.getRutProfesor()).get(0);
            cs1.setNombreUsuario(cCSV.getNombreProfesor(fila.get(2)).toUpperCase());
            cs1.setApellidoUsuarioPaterno(cCSV.getApellidoProfesor(fila.get(2)).toUpperCase());
            profeTemp.setContrato(1);
            profeTemp.setTipoProfesor(0);
            
            if(profesorFacade.findByRut(cCSV.rutProfe(fila.get(2))).isEmpty()){
                System.out.println(i+": Profesor: "+cs1.getNombreUsuario()+" "+cs1.getNombreUsuario()+" Agregado");
                profesorFacade.create(profeTemp);
                int aprofeTemp = profesorFacade.count();
            }
            
            profeTemp = profesorFacade.findByRut(cCSV.rutProfe(fila.get(2))).get(0);
            
            //Agregamos Alumno
            Alumno alumTemp;
            alumTemp = new Alumno(cCSV.cleanRut(fila.get(6)));
            Usuario cs2 = usuarioFacade.findByRut(alumTemp.getRutAlumno()).get(0);
            cs2.setNombreUsuario(cCSV.getNombreAlumno(fila.get(4)).toUpperCase());
            cs2.setNombreUsuario(cCSV.getApellidoAlumno(fila.get(4)).toUpperCase());

            //if(fila.get(21).length()>7)
            //alumTemp.setMailAlumno(fila.get(21).substring(0, 7));
            //else
            cs2.setMailUsuario(fila.get(21).toUpperCase());
            
            //Reemplazamos signos y sacamos los '0' que hayan al comienzo del teléfono
            //Algunos telefono estan así 09-82161813 / 02-7916425 o con (02)
            if ((!fila.get(22).isEmpty() && !fila.get(22).equals("-"))) {
                Boolean temp = true;
                String telefono = fila.get(22);
                telefono = telefono.replace(".", "");
                telefono = telefono.replace("-", "");
                telefono = telefono.replace("+", "");
                telefono = telefono.replace("/", "");
                telefono = telefono.replace("(", "");
                telefono = telefono.replace(")", "");
                telefono = telefono.replace(" ", "");
                while(temp){
                    if(telefono.charAt(0) == '0')
                        telefono = telefono.substring(1);
                    else
                        temp=false;
                }
            }
            else
                cs2.setTelefonoUsuario("");
            
//            if(fila.get(5).equals("DIURNO"))
//                alumTemp.setJornada(0);
//            if(fila.get(5).equals("VESPERTINO"))
//                alumTemp.setJornada(1);
//            if(fila.get(5).equals("PET"))
//                alumTemp.setJornada(2);

            if(!alumnos.contains(alumTemp)){
                alumnos.add(alumTemp);
                if(!alumnoFacade.findAll().contains(alumTemp)){
                    System.out.println(i+": Alumno: "+cs2.getNombreUsuario()+" "+cs2.getApellidoUsuarioPaterno()+" Agregado");
                    alumnoFacade.create(alumTemp);
                }
            }
            
            //Semestre
            Semestre semestre = new Semestre("default");
            List<Semestre> semestres = semestreFacade.findAll();
            if (!semestres.contains(semestre)) {
                semestreFacade.create(semestre);
            }
            
            
            //Agregamos Propuesta
            Alumno alumnoPropuesta = alumnoFacade.findByRut(alumTemp.getRutAlumno()).get(0);
            Propuesta nuevaPropuesta;
            nuevaPropuesta = new Propuesta();
            nuevaPropuesta.setNombrePropuesta(fila.get(10).toUpperCase());
            nuevaPropuesta.setFechaPropuesta(fila.get(11));
            nuevaPropuesta.setIdSemestre(semestre);
            nuevaPropuesta.setRutAlumno(alumnoPropuesta);
            if(!propuestaFacade.findAll().contains(nuevaPropuesta)){
                propuestaFacade.create(nuevaPropuesta);
                //Inicializamos la guia del profesor
                Profesor profGuia;
                profGuia = profesorFacade.findByRut(cCSV.rutProfe(fila.get(2))).get(0);
                ProfePropuesta profePropGuia = new ProfePropuesta(nuevaPropuesta.getIdPropuesta(), profGuia.getRutProfesor());//Debería ser el RUT
                //Seteamos roles
                //Asignamos los roles y profesores a las guias
                profePropGuia.setRolGuia(0);
                profePropGuia.setProfesor(profGuia);
                profePropGuia.setPropuesta(nuevaPropuesta);
                profePropuestaFacade.create(profePropGuia);
                //Asignamos los profes a la propuesta
                nuevaPropuesta.add(profePropGuia);
                propuestaFacade.edit(nuevaPropuesta);
                //Asignamos las revisiones a los profesores
                profGuia.add(profePropGuia);
                profesorFacade.edit(profGuia);
                //Asignamos la propuesta al alumno
                alumnoPropuesta.add(nuevaPropuesta);
                alumnoFacade.edit(alumnoPropuesta);
            }
            if(!fila.get(1).equals("RP")){
                //Agregamos la Comisión Revisora
                Propuesta propuesta = propuestaFacade.findById(nuevaPropuesta.getIdPropuesta()).get(0);
                ComisionRevisora nuevaComision;
                //Seteamos la nueva comision y la creamos
                nuevaComision = new ComisionRevisora();
                nuevaComision.setIdPropuesta(propuesta);
                nuevaComision.setFechaRevision("");
                if(fila.get(12).equals("NO"))
                    nuevaComision.setTipoRevision(0);
                if(fila.get(12).equals("SI"))
                    nuevaComision.setTipoRevision(1);
                nuevaComision.setIdSemestre(semestre);
                if(!comisionRevisoraFacade.findAll().contains(nuevaComision)){
                    comisionRevisoraFacade.create(nuevaComision);
                    //Asignamos la Comision a la Propuesta
                    propuesta.setIdRevisora(nuevaComision);
                    propuestaFacade.edit(propuesta);
                }

                //Agregamos El Tema
                ComisionRevisora comRev = comisionRevisoraFacade.findById(nuevaComision.getIdRevisora()).get(0);
                Tema tema = new Tema();
                tema.setNombreTema(fila.get(10).toUpperCase());
                if(fila.get(13).length()>15){
                    System.out.println("----------------------------------------------------------------------------");
                    System.out.println("La fecha grande es: "+fila.get(13));
                    System.out.println("----------------------------------------------------------------------------");
                    //String fecha = fila.get(13).substring(0, 10);
                    //fecha = fecha.replace("-","/");
                    tema.setFechaTema("");
                }
                else {
                    tema.setFechaTema(fila.get(13));
                }
                if(fila.get(1).length()>0){
                    if(fila.get(1).charAt(0)=='V')
                        tema.setEstadoTema(0);
                    if(fila.get(1).equals("T"))
                        tema.setEstadoTema(1);
                    if(fila.get(1).charAt(0)=='R')
                        tema.setEstadoTema(2);
                    if(fila.get(1).charAt(0)=='C')
                        tema.setEstadoTema(3);
                    if(fila.get(1).charAt(0)=='P')
                        tema.setEstadoTema(4);
                }
                else
                    tema.setEstadoTema(7);
                tema.setIdSemestre(semestre);
                tema.setIdRevisora(comRev);
                if(!temaFacade.findAll().contains(tema)){
                    temaFacade.create(tema);
                    //Le asignamos el tema a la comisión revisora
                    comRev.setIdTema(tema);
                    comisionRevisoraFacade.edit(comRev);
                }
                
                if(tema.getEstadoTema()!=null)
                if(tema.getEstadoTema()==1){
                    //Agregamos la Comisión Correctora
                    tema = temaFacade.findById(tema.getIdTema()).get(0);
                    ComisionCorrectora comisionC = new ComisionCorrectora();
                    comisionC.setIdTema(tema);
                    comisionC.setIdSemestre(semestre);
                    if(!comisionCorrectoraFacade.findAll().contains(comisionC)){
                        comisionCorrectoraFacade.create(comisionC);
                        //Agregamos comision al tema
                        tema.setIdCorrectora(comisionC);
                        temaFacade.edit(tema);
                    }
                }
            }
            
            System.out.println(i+": Tema: "+fila.get(10)+" Agregado");
        }
        
        /*for(int i=0;i<profes.size();i++){
            System.out.println(i+": "+profes.get(i).getNombreProfesor()+" "+profes.get(i).getApellidoProfesor());
        }
        
        for(int i=0;i<alumnos.size();i++){
            System.out.println(alumnos.get(i).getRutAlumno()+": "+alumnos.get(i).getNombreAlumno()+" "+alumnos.get(i).getApellidoAlumno());
        }*/
        //Mensaje de confirmación
        System.out.println("Done");
        FacesContext context = FacesContext.getCurrentInstance();
        context.addMessage(null, new FacesMessage("Migrado", "Se Agregaron "+profes.size()+" Profesores, "+alumnos.size()+" Alumnos y "+lines.size()+" Temas"));
    }
    
    public String rutProfe(String s){
        if(s.equals("LUIS RÍOS"))
                return "59653024";
        if(s.equals("MARIA CAROLINA CHAMORRO"))
                return "138328449";
        if(s.equals("NÉSTOR GONZÁLEZ"))
                return "58872830";
        if(s.equals("JOSÉ ÁLVAREZ"))
                return "63567833";
        if(s.equals("EDMUNDO LEIVA"))
                return "78132884";
        if(s.equals("VÍCTOR PARADA"))
                return "82230971";
        if(s.equals("FERNANDO RANNOU"))
                return "95794912";
        if(s.equals("NICOLÁS HIDALGO"))
                return "155898712";
        if(s.equals("CAROLINA BONACIC"))
                return "120188615";
        if(s.equals("ROSA MUÑOZ"))
                return "77657495";
        if(s.equals("MARIO INOSTROZA"))
                return "130438164";
        if(s.equals("ARTURO ALVAREZ"))
                return "136934384";
        if(s.equals("MÓNICA VILLANUEVA"))
                return "51668316";
        if(s.equals("ANDRÉS RICE"))
                return "70549123";
        if(s.equals("EMIR MUÑOZ"))
                return "162690302";
        if(s.equals("EDGARDO SEPÚLVEDA"))
                return "68635926";
        if(s.equals("BRUNO JERARDINO"))
                return "70658828";
        if(s.equals("JOSÉ LUIS JARA"))
                return "96742975";
        if(s.equals("MAURICIO MARÍN"))
                return "71531589";
        if(s.equals("HÉCTOR ANTILLANCA"))
                return "65776545";
        if(s.equals("FERNANDO CONTRERAS"))
                return "56369325";
        if(s.equals("JUAN COCKBAINE"))
                return "73172713";
        if(s.equals("PAULO QUINSACARA"))
                return "128416374";
        if(s.equals("MAX CHACON"))
                return "80796609";
        if(s.equals("JUAN ITURBE"))
                return "156232890";
        if(s.equals("HÉCTOR PONCE"))
                return "00";
        if(s.equals("GONZALO ACUÑA"))
                return "69476376";
        if(s.equals("ROBERTO GONZÁLEZ"))
                return "141475789";
        if(s.equals("ROGERS ATERO"))
                return "66348903";
        if(s.equals("JACQUELINE KOHLER"))
                return "136725092";
        if(s.equals("ERIKA ROSAS"))
                return "155560002";
        if(s.equals("ALBERTO CEBALLOS"))
                return "136711261";
        if(s.equals("IRENE ZUCCAR"))
                return "130461786";
        if(s.equals("RICARDO CONTRERAS"))
                return "90070819";
        if(s.equals("LUIS BERRÍOS"))
                return "141622404";
        if(s.equals("CRISTIÁN BADILLA"))
                return "145010330";
        if(s.equals("SERGIO VELASTIN"))
                return "70629054";
        if(s.equals("CRISTÓBAL ACOSTA"))
                return "163601311";
        if(s.equals("FERNANDA KRI"))
                return "109857017";
        if(s.equals("JUAN PABLO RUZ"))
                return "157762311";
        return null;
    }
    
    public void leerProfes(){
        List<Profesor> profesores = profesorFacade.findAll();
        
        try{
            BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path),"UTF-8"));
 
	    writer.append("RUT");
	    writer.append(',');
	    writer.append("NOMBRE");
	    writer.append(',');
            writer.append("APELLIDO");
	    writer.append(',');
            writer.append("CONTRATO");
	    writer.append(',');
            writer.append("TIPO");
	    writer.append(',');
            writer.append("MÁXIMO GUÍAS");
	    writer.append(',');
            writer.append("MAIL");
	    writer.append(',');
            writer.append("TELÉFONO");
	    writer.append('\n');
 
	    for(int i=0;i<profesores.size();i++){
                Usuario cs3 = usuarioFacade.findByRut(profesores.get(i).getRutProfesor()).get(0);
                writer.append(profesores.get(i).getRutProfesor());
                writer.append(',');
                writer.append(cs3.getNombreUsuario());
                writer.append(',');
                writer.append(cs3.getApellidoUsuarioPaterno());
                writer.append(',');
                writer.append(Integer.toString(profesores.get(i).getContrato()));
                writer.append(',');
                writer.append(Integer.toString(profesores.get(i).getTipoProfesor()));
                writer.append(',');
                if(profesores.get(i).getMaximoGuias()==null)
                    writer.append("");
                else
                    writer.append(Integer.toString(profesores.get(i).getMaximoGuias()));
                writer.append(',');
                writer.append(cs3.getMailUsuario());
                writer.append(',');
                writer.append(cs3.getTelefonoUsuario());
                writer.append('\n');
            }
	    writer.flush();
	    writer.close();
	}
	catch(IOException e)
	{
            e.printStackTrace();
        }
        FacesContext context = FacesContext.getCurrentInstance();
        context.addMessage(null, new FacesMessage("Listo", "Se Agregaron "+profesores.size()+" Profesores al archivo ingresado"));
    }
    
    public void crearProfes(){
        String csvFile = path;
    	BufferedReader br = null;
    	String line;
        
        List<String> lines = new ArrayList();
 
	   //Lee el CSV y almacena cada linea en la variable lines
        try {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(csvFile), "UTF-8"));
            int count=0;
            while ((line = br.readLine()) != null) {
                if(count>0)
                    lines.add(line);
                count++;
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        
        List<String> fila;
        ConsolidadoCSV cCSV = new ConsolidadoCSV();
        for(int i=0;i<lines.size();i++){
            fila = cCSV.splitCSVLine(lines.get(i));
            
            Profesor profeTemp = new Profesor(fila.get(0)+Integer.toString(i));
            Usuario cs4 = usuarioFacade.findByRut(profeTemp.getRutProfesor()).get(0);
            cs4.setNombreUsuario(fila.get(1));
            cs4.setApellidoUsuarioPaterno(fila.get(2));
            profeTemp.setContrato(Integer.parseInt(fila.get(3)));
            profeTemp.setTipoProfesor(Integer.parseInt(fila.get(4)));
            if(!fila.get(5).equals(""))
                profeTemp.setMaximoGuias(Integer.parseInt(fila.get(5)));
            cs4.setMailUsuario(fila.get(6));
            cs4.setDireccionUsuario(fila.get(7));
            
            profesorFacade.create(profeTemp);
        }
        FacesContext context = FacesContext.getCurrentInstance();
        context.addMessage(null, new FacesMessage("Listo", "Se Agregaron los Profesores del archivo ingresado"));
    }
    
    public void crearProfes2(){
        String csvFile = path;
    	BufferedReader br = null;
    	String line;
        
        List<String> lines = new ArrayList();
 
	   //Lee el CSV y almacena cada linea en la variable lines
        try {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(csvFile), "UTF-8"));
            int count=0;
            while ((line = br.readLine()) != null) {
                if(count>0)
                    lines.add(line);
                count++;
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        
        List<String> fila;
        ConsolidadoCSV cCSV = new ConsolidadoCSV();
        for(int i=0;i<lines.size();i++){
            fila = cCSV.splitCSVLine(lines.get(i));
            
            Profesor profeTemp = new Profesor(fila.get(7));
            Usuario cs5 = usuarioFacade.findByRut(profeTemp.getRutProfesor()).get(0);
            cs5.setNombreUsuario(fila.get(1));
            cs5.setApellidoUsuarioPaterno(fila.get(2));
            profeTemp.setContrato(Integer.parseInt(fila.get(0)));
            profeTemp.setTipoProfesor(Integer.parseInt(fila.get(5)));
            if(!fila.get(6).equals(""))
                profeTemp.setMaximoGuias(Integer.parseInt(fila.get(6)));
            cs5.setMailUsuario(fila.get(3));
            cs5.setDireccionUsuario(fila.get(4));
            
            profesorFacade.create(profeTemp);
        }
        FacesContext context = FacesContext.getCurrentInstance();
        context.addMessage(null, new FacesMessage("Listo", "Se Agregaron los Profesores del archivo ingresado"));
    }
    
    //Recibe una linea en formato CSV y retorna una arreglo de Strings con los valores encontrados
    private List<String> splitCSVLine(String line){
        List<String> splitTemp = new ArrayList();
        ConsolidadoCSV cCSV = new ConsolidadoCSV();
        int firstComa;
        while(!line.equals("")){
            if(line.startsWith("\"\"\"")||(line.startsWith("\"") && !line.startsWith("\"\""))){
                if(line.indexOf("\",",2)==-1){
                    splitTemp.add(cCSV.removeDQuot(line.substring(1,line.length()-1)));
                    line = "";
                }else{
                    firstComa = line.indexOf("\",",2);
                    splitTemp.add(cCSV.removeDQuot(line.substring(1, firstComa)));
                    line = line.substring(firstComa+2);
                    if(line.equals(""))
                        splitTemp.add(line);
                }
            }else{
                if(!line.contains(",")){
                    splitTemp.add(cCSV.removeDQuot(line.substring(0)));
                    line = "";
                }else{
                    firstComa = line.indexOf(",");
                    splitTemp.add(cCSV.removeDQuot(line.substring(0, firstComa)));
                    line = line.substring(firstComa+1);
                    if(line.equals(""))
                        splitTemp.add(line);
                }
            }
        }
        return splitTemp;
    }
    
    //Reemplaza las dobles comillas ("") generadas por el CSV por una sola comilla (")
    private String removeDQuot(String s){
        String temp="";
        int firstDQuot;
        while(!s.equals("")){
            if(!s.contains("\"\"")){
                temp += s;
                s = "";
            }else{
                firstDQuot = s.indexOf("\"\"");
                temp += s.substring(0, firstDQuot);
                s = s.substring(firstDQuot+1);
            }
        }
        return temp;
    }
    
    //Imprime por consola los valores de un arreglo (para probar funciones)
    private void printList(List<String> lS){
        String temp ="";
        temp += "Size: "+lS.size()+";";
        for(int i=0;i<lS.size();i++){
            temp += lS.get(i) + ";";
        }
        System.out.println(temp);
    }
    
    private String getNombreProfesor(String s){
        int lastSpace;
        lastSpace = s.lastIndexOf(" ");
        return s.substring(0,lastSpace);
    }
    
    private String getApellidoProfesor(String s){
        int lastSpace;
        lastSpace = s.lastIndexOf(" ");
        return s.substring(lastSpace+1);
    }
    
    private String cleanRut(String s){
        s = s.replace(".", "");
        s = s.replace("-", "");
        s = s.replace(" ", "");
        s = s.replace(",", "");
        return s;
    }
    
    private String getNombreAlumno(String s){
        int coma;
        coma = s.indexOf(",");
        if(s.substring(coma).length()<3)
            return s;
        if(s.charAt(coma+1)!=' ')
            return s.substring(coma+1);
        return s.substring(coma+2);
    }
    
    private String getApellidoAlumno(String s){
        int coma;
        coma = s.indexOf(",");
        return s.substring(0, coma);
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
    
}
