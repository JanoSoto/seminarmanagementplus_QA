package managedbeans;

import entities.Alumno;
import sessionbeans.AlumnoFacadeLocal;
import clases.AlumnoDatos;
import entities.Tema;
import entities.Usuario;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author Eduardo
 */
@Named(value ="listarAlumnosMB")
@SessionScoped
public class ListarAlumnosMB implements Serializable{
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;
    private List<AlumnoDatos> alumnos, alumnosFiltrados;
    private String temaAlum,profGuia,rutAlum,nombreAlum,apellidoAlum,matriculaAlum,petAlum,mailAlum,jornadaAlum, telefonoAlum, carreraAlum,profCoGuia;
    private AlumnoDatos alumnoDatoTemp;

    public ListarAlumnosMB() {
    }
    
    @PostConstruct
    public void init() {
        
    }

    public List<AlumnoDatos> getAlumnosFiltrados() {
        return alumnosFiltrados;
    }

    public void setAlumnosFiltrados(List<AlumnoDatos> alumnosFiltrados) {
        this.alumnosFiltrados = alumnosFiltrados;
    }

    public AlumnoDatos getAlumnoDatoTemp() {
        return alumnoDatoTemp;
    }

    public void setAlumnoDatoTemp(AlumnoDatos alumnoDatoTemp) {
        this.alumnoDatoTemp = alumnoDatoTemp;
    }

    public List<AlumnoDatos> getAlumnos() {
        return alumnos;
    }

    public void setAlumnos(List<AlumnoDatos> alumnos) {
        this.alumnos = alumnos;
    }
    
    public void updateAlumnos() {
        //Seteamos todos los valores para alumnoDatos
        List<Alumno> alum = alumnoFacade.findAll();
        alumnos = new ArrayList();
        Tema temaActivo = new Tema();
        for(int i = 0; i < alum.size(); i++) {
            Usuario al = usuarioFacade.findByRut(alum.get(i).getRutAlumno()).get(0);
            alumnoDatoTemp = new AlumnoDatos();
            alumnoDatoTemp.setRutAlumno(alum.get(i).getRutAlumno());
            alumnoDatoTemp.setNombreAlumno(al.getNombreUsuario()+" "+al.getApellidoUsuarioPaterno());
            alumnoDatoTemp.setApellidoAlumno(al.getApellidoUsuarioPaterno());
            
            //Recorremos los temas que ha tenido el alumno, y seleccionamos el activo, para mostralo
            alumnoDatoTemp.setMatriculaAlumno("No existe Registro");
            if(!alum.get(i).getPropuestaList().isEmpty()){
                for(int k=0; k<alum.get(i).getPropuestaList().size();k++){
                    if(alum.get(i).getPropuestaList().get(k).getIdRevisora() != null){
                            if(alum.get(i).getPropuestaList().get(k).getIdRevisora().getIdTema() != null){
                                if(alum.get(i).getPropuestaList().get(k).getIdRevisora().getIdTema().getEstadoTema()!=3){
                                    //Recortamos los nombres de los temas para mostrarlos en la vista
                                    if(alum.get(i).getPropuestaList().get(k).getIdRevisora().getIdTema().getNombreTema().length()>70)
                                        alumnoDatoTemp.setNombreTema(alum.get(i).getPropuestaList().get(k).getIdRevisora().getIdTema().getNombreTema().substring(0,71)+"...");
                                    else
                                        alumnoDatoTemp.setNombreTema(alum.get(i).getPropuestaList().get(k).getIdRevisora().getIdTema().getNombreTema());
                                    //Recorremos la lista de profesores para asignar prof guía y co-guía
                                    for(int j=0; j<alum.get(i).getPropuestaList().get(k).getProfePropuestaList().size(); j++){
                                        if(alum.get(i).getPropuestaList().get(k).getProfePropuestaList().get(j).getRolGuia() == 0){
                                            Usuario prof = usuarioFacade.findByRut(alum.get(i).getPropuestaList().get(k).getProfePropuestaList().get(j).getProfesor().getRutProfesor()).get(0);
                                            alumnoDatoTemp.setProfesorGuia(prof.getNombreUsuario()+" "+prof.getApellidoUsuarioPaterno());
                                        }
                                        if(alum.get(i).getPropuestaList().get(k).getProfePropuestaList().get(j).getRolGuia() == 1){
                                            Usuario prof2 = usuarioFacade.findByRut(alum.get(i).getPropuestaList().get(k).getProfePropuestaList().get(j).getProfesor().getRutProfesor()).get(0);
                                            alumnoDatoTemp.setProfCoGuia(prof2.getNombreUsuario()+" "+prof2.getApellidoUsuarioPaterno());
                                        }
                                    }
                                }    
                        }
                    }
                }
            }
            //Si no se ha seteado el tema, es porque no tiene tema activo
            //Por lo que se se añade que no tiene tema ni prof guía.
            if(alumnoDatoTemp.getNombreTema() == null){
                alumnoDatoTemp.setNombreTema("No tiene tema activo");
                alumnoDatoTemp.setProfesorGuia("No tiene tema activo");
                alumnoDatoTemp.setProfCoGuia("No tiene tema activo");
            }
            if (al.getMailUsuario().equals(""))
                alumnoDatoTemp.setMailAlumno("No tiene mail registrado");
            else
                mailAlum = al.getMailUsuario();
            if (al.getTelefonoUsuario().equals(""))
                alumnoDatoTemp.setTelefonoAlumno("No tiene teléfono registrado");
            else
                alumnoDatoTemp.setTelefonoAlumno(al.getTelefonoUsuario());
            if(!alum.get(i).getPlanes().isEmpty()){
                if(alum.get(i).getPlanes().get(0).getJornada() == 0){
                    alumnoDatoTemp.setJornadaAlumno("Diurno");
                }
                else{
                    alumnoDatoTemp.setJornadaAlumno("Vespertino");
                }
            }
            if(!alum.get(i).getPlanes().isEmpty()){
                if(alum.get(i).getPlanes().get(0).getCarreraId().getNombre().contains("CIVIL")){
                    alumnoDatoTemp.setCarreraAlumno("Civil Informática");                
                }
                else{
                    alumnoDatoTemp.setCarreraAlumno("Ejecución Informática");
                }
            
            }
            //alumnoDatoTemp=  new AlumnoDatos(rutAlum, nombreAlum, apellidoAlum, temaAlum, profGuia, matriculaAlum, mailAlum, telefonoAlum, petAlum, jornadaAlum, carreraAlum);
            alumnos.add(alumnoDatoTemp);
        }
        init();
    }
}
