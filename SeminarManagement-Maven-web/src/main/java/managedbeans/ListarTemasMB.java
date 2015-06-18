/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans;

import entities.Tema;
import sessionbeans.TemaFacadeLocal;
import clases.TemaDatos;
import entities.Semestre;
import entities.Usuario;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.faces.model.SelectItem;
import javax.inject.Named;
import sessionbeans.SemestreFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author Eduardo
 */
@Named(value ="listarTemasMB")
@SessionScoped
public class ListarTemasMB implements Serializable {
    @EJB
    private SemestreFacadeLocal semestreFacade;
    @EJB
    private TemaFacadeLocal temaFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;
    private List<TemaDatos> listTemas, temasFiltrados;
    private List<String> estadosTemas;
    String nombreTema, alumTema,profTema,semestreTema,estadoTemaString, origenTema;
    int estadoTema;
    private SelectItem[] estados, semestres, origen;

    /**
     * Creates a new instance of listarTemasMB
     */
    public ListarTemasMB() {
    }
    
    @PostConstruct
    public void init() {
    }

    public SelectItem[] getSemestres() {
        return semestres;
    }

    public void setSemestres(SelectItem[] semestres) {
        this.semestres = semestres;
    }

    public SelectItem[] getOrigen() {
        return origen;
    }

    public void setOrigen(SelectItem[] origen) {
        this.origen = origen;
    }

    public SelectItem[] getEstados() {
        return estados;
    }

    public void setEstados(SelectItem[] estados) {
        this.estados = estados;
    }

    public List<String> getEstadosTemas() {
        return estadosTemas;
    }

    public void setEstadosTemas(List<String> estadosTemas) {
        this.estadosTemas = estadosTemas;
    }

    public List<TemaDatos> getTemasFiltrados() {
        return temasFiltrados;
    }

    public void setTemasFiltrados(List<TemaDatos> temasFiltrados) {
        this.temasFiltrados = temasFiltrados;
    }

    public String getOrigenTema() {
        return origenTema;
    }

    public void setOrigenTema(String origenTema) {
        this.origenTema = origenTema;
    }

    public String getEstadoTemaString() {
        return estadoTemaString;
    }

    public void setEstadoTemaString(String estadoTemaString) {
        this.estadoTemaString = estadoTemaString;
    }

    public int getEstadoTema() {
        return estadoTema;
    }

    public void setEstadoTema(int estadoTema) {
        this.estadoTema = estadoTema;
    }

    public String getNombreTema() {
        return nombreTema;
    }

    public void setNombreTema(String nombreTema) {
        this.nombreTema = nombreTema;
    }

    public String getAlumTema() {
        return alumTema;
    }

    public void setAlumTema(String alumTema) {
        this.alumTema = alumTema;
    }

    public String getProfTema() {
        return profTema;
    }

    public void setProfTema(String profTema) {
        this.profTema = profTema;
    }

    public String getSemestreTema() {
        return semestreTema;
    }

    public void setSemestreTema(String semestreTema) {
        this.semestreTema = semestreTema;
    }

    public List<TemaDatos> getListTemas() {
        return listTemas;
    }

    public void setListTemas(List<TemaDatos> listTemas) {
        this.listTemas = listTemas;
    }
    
    public SelectItem[] getEstadosOptions() {
       SelectItem[] r = new SelectItem[estadosTemas.size() + 1];
       r[0] = new SelectItem("", "Seleccione");
       for (int t = 0; t < estadosTemas.size(); t++)
         r[t + 1] = new SelectItem(estadosTemas.get(t), estadosTemas.get(t));
       return r;
     }

    
    public void updateTemas() {
        List<Semestre> allSemestres = semestreFacade.findAll();
        String sem;
        //Seteamos valores para los filtros de estado tema, semestre y oringe tema
        estados = new SelectItem[8];
        estados[0] = new SelectItem("");
        estados[1] = new SelectItem("Vigente");
        estados[2] = new SelectItem("Titulado");
        estados[3] = new SelectItem("Prolongado");
        estados[4] = new SelectItem("Caduco");
        estados[5] = new SelectItem("En Proceso de Examen");
        estados[6] = new SelectItem("Magíster");
        estados[7] = new SelectItem("Vigente con borrador final");
        semestres = new SelectItem[allSemestres.size()+1];
        semestres[0] = new SelectItem("");
        for (int k=0;k<allSemestres.size();k++)
            semestres[k+1] = new SelectItem(allSemestres.get(k).getIdSemestre()); 
        origen = new SelectItem[4];
        origen[0] = new SelectItem("");
        origen[1] = new SelectItem("Comision Revisora");
        origen[2] = new SelectItem("Acuerdo Consejo");
        origen[3] = new SelectItem("Ramo 'Seminario de Titulación'");
        List<Tema> temasReal = temaFacade.findAll();
        TemaDatos temaDatosTemp;
        listTemas = new ArrayList();
        for(int i=0;i<temasReal.size();i++){
            nombreTema = temasReal.get(i).getNombreTema();
            estadoTema = temasReal.get(i).getEstadoTema();
            if(estadoTema == 0)
                estadoTemaString = "Vigente";
            if(estadoTema == 1)
                estadoTemaString = "Titulado";
            if(estadoTema == 2)
                estadoTemaString = "Prolongado";
            if(estadoTema == 3)
                estadoTemaString = "Caduco";
            if(estadoTema == 4)
                estadoTemaString = "En Proceso de Examen";
            if(estadoTema == 5)
                estadoTemaString = "Magíster";
            if(estadoTema == 6)
                estadoTemaString = "Vigente con borrador final";
            semestreTema = temasReal.get(i).getIdSemestre().getIdSemestre();
            Usuario deTema = usuarioFacade.findByRut(temasReal.get(i).getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno()).get(0);
            alumTema = deTema.getNombreUsuario()+" "+deTema.getApellidoUsuarioPaterno();
            for(int j=0; j<temasReal.get(i).getIdRevisora().getIdPropuesta().getProfePropuestaList().size(); j++)
                if(temasReal.get(i).getIdRevisora().getIdPropuesta().getProfePropuestaList().get(j).getRolGuia() == 0){
                    Usuario temaReal = usuarioFacade.findByRut(temasReal.get(i).getIdRevisora().getIdPropuesta().getProfePropuestaList().get(j).getProfesor().getRutProfesor()).get(0);
                    profTema = temaReal.getNombreUsuario()+" "+temaReal.getApellidoUsuarioPaterno();
                }
            if (temasReal.get(i).getIdRevisora().getTipoRevision() == 0)
                origenTema = "Propuesta por Trabajo de titulación (Prof por hora)";
            if (temasReal.get(i).getIdRevisora().getTipoRevision() == 1)
                origenTema = "Ramo de Seminario";
            if (temasReal.get(i).getIdRevisora().getTipoRevision() == 2)
                origenTema = "Acuerdo Consejo";
            temaDatosTemp = new TemaDatos(estadoTemaString, semestreTema, nombreTema, alumTema, profTema, origenTema);
            temaDatosTemp.setIdTema(temasReal.get(i).getIdTema());
            listTemas.add(temaDatosTemp);
        }
        //Recortamos los nombres de los temas para mostrarlos en la vista
        for(int i=0;i<temasReal.size();i++)
            if(temasReal.get(i).getNombreTema().length()>41)
                temasReal.get(i).setNombreTema(listTemas.get(i).getNombreTema().substring(0, 42)+"...");
        init();
    }
}
