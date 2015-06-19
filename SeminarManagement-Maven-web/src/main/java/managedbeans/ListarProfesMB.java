/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans;

import entities.ProfeRevision;
import entities.Profesor;
import sessionbeans.ProfesorFacadeLocal;
import clases.ProfeDatos;
import entities.SemestreActual;
import entities.Usuario;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author Eduardo
 */
@Named(value ="listarProfesMB")
@SessionScoped
public class ListarProfesMB implements Serializable {
    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;
    private List<ProfeDatos> profesores;

    /**
     * Creates a new instance of listarProfesMB
     */
    public ListarProfesMB() {
    }
    
    @PostConstruct
    public void init() {

    }
    
    public List<ProfeDatos> getProfesores() {
        return profesores;
    }

    public void setProfesores(List<ProfeDatos> profesores) {
        this.profesores = profesores;
    }
    
    public void updateProfes() {
        int guiaTemp,revisorTemp,guiaP;
        ProfeDatos profeDatosTemp;
        profesores = new ArrayList();
        List<Profesor> profes = profesorFacade.findAll();
        List<ProfeRevision> profRev;
        for(int i=0;i<profes.size();i++){
            profRev=profes.get(i).getProfeRevisionList();
            guiaTemp=0;
            guiaP=0;
            revisorTemp=profes.get(i).getProfeRevisionList().size();
            for(int j=0; j<profes.get(i).getProfePropuestaList().size(); j++){
                //Si el profesor es prof guía, y además, de la propuesta en que es guía, sale un tema, se aumenta guiaTemp
                //Sólo se consideran guías de temas vigentes
                if(profes.get(i).getProfePropuestaList().get(j).getRolGuia() == 0){
                    guiaP++;
                    if(profes.get(i).getProfePropuestaList().get(j).getPropuesta() != null)
                        if(profes.get(i).getProfePropuestaList().get(j).getPropuesta().getIdRevisora() != null)
                            if(profes.get(i).getProfePropuestaList().get(j).getPropuesta().getIdRevisora().getIdTema() != null)
                                if(profes.get(i).getProfePropuestaList().get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() == 0)
                                    guiaTemp++;
                }
            }
            Usuario prof = usuarioFacade.findByRut(profes.get(i).getRutProfesor()).get(0);
            profeDatosTemp = new ProfeDatos(guiaP,guiaTemp,revisorTemp,profes.get(i).getProfeCorreccionList().size(),profes.get(i).getRutProfesor(),prof.getNombreUsuario()+" "+prof.getApellidoUsuarioPaterno(),prof.getApellidoUsuarioPaterno());
            profeDatosTemp.setApellidoProfesor(prof.getApellidoUsuarioPaterno());
            //Seteamos algunos valores integer
            if(profes.get(i).getTipoProfesor() == 0)
                profeDatosTemp.setIsGuia("Si");
            if(profes.get(i).getTipoProfesor() == 1)
                profeDatosTemp.setIsGuia("No");
            if(profes.get(i).getContrato() == 0)
                profeDatosTemp.setContratoProfesor("Por Hora");
            if(profes.get(i).getContrato() == 1)
                profeDatosTemp.setContratoProfesor("De Planta");
            if(!prof.getMailUsuario().isEmpty())
                profeDatosTemp.setMailProfesor(prof.getMailUsuario());
            else
                profeDatosTemp.setMailProfesor("No tiene mail registrado");
            if(!prof.getTelefonoUsuario().isEmpty())
                profeDatosTemp.setTelefonoProfesor(prof.getTelefonoUsuario());
            else
                profeDatosTemp.setTelefonoProfesor("No tiene teléfono registrado");
            profesores.add(profeDatosTemp);
        }
        init();
    }
}
