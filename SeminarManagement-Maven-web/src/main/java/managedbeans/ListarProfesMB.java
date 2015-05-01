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
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;
import sessionbeans.SemestreActualFacadeLocal;

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
            profeDatosTemp = new ProfeDatos(guiaP,guiaTemp,revisorTemp,profes.get(i).getProfeCorreccionList().size(),profes.get(i).getRutProfesor(),profes.get(i).getNombreProfesor()+" "+profes.get(i).getApellidoProfesor(),profes.get(i).getApellidoProfesor());
            profeDatosTemp.setApellidoProfesor(profes.get(i).getApellidoProfesor());
            //Seteamos algunos valores integer
            if(profes.get(i).getTipoProfesor() == 0)
                profeDatosTemp.setIsGuia("Si");
            if(profes.get(i).getTipoProfesor() == 1)
                profeDatosTemp.setIsGuia("No");
            if(profes.get(i).getContrato() == 0)
                profeDatosTemp.setContratoProfesor("Por Hora");
            if(profes.get(i).getContrato() == 1)
                profeDatosTemp.setContratoProfesor("De Planta");
            if(!profes.get(i).getMailProfesor().isEmpty())
                profeDatosTemp.setMailProfesor(profes.get(i).getMailProfesor());
            else
                profeDatosTemp.setMailProfesor("No tiene mail registrado");
            if(!profes.get(i).getTelefonoProfesor().isEmpty())
                profeDatosTemp.setTelefonoProfesor(profes.get(i).getTelefonoProfesor());
            else
                profeDatosTemp.setTelefonoProfesor("No tiene teléfono registrado");
            profesores.add(profeDatosTemp);
        }
        init();
    }
}
