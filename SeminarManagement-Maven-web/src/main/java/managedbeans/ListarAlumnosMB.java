/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans;

import entities.Alumno;
import sessionbeans.AlumnoFacadeLocal;
import clases.AlumnoDatos;
import entities.Tema;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;

/**
 *
 * @author Eduardo
 */
@Named(value ="listarAlumnosMB")
@SessionScoped
public class ListarAlumnosMB implements Serializable{
    @EJB
    private AlumnoFacadeLocal alumnoFacade;
    private List<AlumnoDatos> alumnos, alumnosFiltrados;
    private String temaAlum,profGuia,rutAlum,nombreAlum,apellidoAlum,matriculaAlum,petAlum,mailAlum,jornadaAlum, telefonoAlum, carreraAlum,profCoGuia;
    private AlumnoDatos alumnoDatoTemp;

    /**
     * Creates a new instance of listarAlumnosMB
     */
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
            alumnoDatoTemp = new AlumnoDatos();
            alumnoDatoTemp.setRutAlumno(alum.get(i).getRutAlumno());
            alumnoDatoTemp.setNombreAlumno(alum.get(i).getNombreAlumno()+" "+alum.get(i).getApellidoAlumno());
            alumnoDatoTemp.setApellidoAlumno(alum.get(i).getApellidoAlumno());
            
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
                                        if(alum.get(i).getPropuestaList().get(k).getProfePropuestaList().get(j).getRolGuia() == 0)
                                            alumnoDatoTemp.setProfesorGuia(alum.get(i).getPropuestaList().get(k).getProfePropuestaList().get(j).getProfesor().getNombreProfesor()+" "+alum.get(i).getPropuestaList().get(k).getProfePropuestaList().get(j).getProfesor().getApellidoProfesor());
                                        if(alum.get(i).getPropuestaList().get(k).getProfePropuestaList().get(j).getRolGuia() == 1)
                                            alumnoDatoTemp.setProfCoGuia(alum.get(i).getPropuestaList().get(k).getProfePropuestaList().get(j).getProfesor().getNombreProfesor()+" "+alum.get(i).getPropuestaList().get(k).getProfePropuestaList().get(j).getProfesor().getApellidoProfesor());
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
            if (alum.get(i).getMailAlumno().equals(""))
                alumnoDatoTemp.setMailAlumno("No tiene mail registrado");
            else
                mailAlum = alum.get(i).getMailAlumno();
            if (alum.get(i).getTelefonoAlumno().equals(""))
                alumnoDatoTemp.setTelefonoAlumno("No tiene teléfono registrado");
            else
                alumnoDatoTemp.setTelefonoAlumno(alum.get(i).getTelefonoAlumno());
            if (alum.get(i).getPet() == true)
                alumnoDatoTemp.setPetAlumno("Es PET");
            else
                alumnoDatoTemp.setPetAlumno("No es PET");
            if (alum.get(i).getJornada() == 0)
                alumnoDatoTemp.setJornadaAlumno("Diurno");
            else
                alumnoDatoTemp.setJornadaAlumno("Vespertino");
            if (alum.get(i).getCarreraAlumno() == 0)
                alumnoDatoTemp.setCarreraAlumno("Civil Informática");
            else
                alumnoDatoTemp.setCarreraAlumno("Ejecución Informática");
            //alumnoDatoTemp=  new AlumnoDatos(rutAlum, nombreAlum, apellidoAlum, temaAlum, profGuia, matriculaAlum, mailAlum, telefonoAlum, petAlum, jornadaAlum, carreraAlum);
            alumnos.add(alumnoDatoTemp);
        }
        init();
    }
}
