/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

import clases.TemaDatos;
import entities.ProfePropuesta;
import entities.Tema;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import javax.faces.model.SelectItem;
import sessionbeans.TemaFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "temasIndexMB")
@RequestScoped
public class TemasIndexMB {

    @EJB
    private TemaFacadeLocal temaFacade;

    private List<Tema> temas;
    private List<TemaDatos> temaDatos, temaDatosFiltrados;
    private SelectItem[] estados;
    private List<String> estadosTemas;
    private ArrayList<SelectItem> semestres;

    /**
     * Creates a new instance of TemasIndexMB
     */
    public TemasIndexMB() {
    }

    @PostConstruct
    public void init() {
        semestres = new ArrayList<>();
        temaDatos = new ArrayList();
        temas = temaFacade.findAll();
        TemaDatos temaDTemp;
        for (int i = 0; i < temas.size(); i++) {
            temaDTemp = new TemaDatos();
            temaDTemp.setAlumno(temas.get(i).getIdRevisora().getIdPropuesta().getRutAlumno());
            List<ProfePropuesta> listaProfes = temas.get(i).getIdRevisora().getIdPropuesta().getProfePropuestaList();
            for (int j = 0; j < listaProfes.size(); j++) {
                if (listaProfes.get(j).getRolGuia() == 0) {
                    temaDTemp.setGuia(listaProfes.get(j).getProfesor());
                }
            }
            temaDTemp.setIdTema(temas.get(i).getIdTema());
            temaDTemp.setNombreTema(temas.get(i).getNombreTema());
            if (temas.get(i).getNombreTema().length() > 44) {
                temaDTemp.setNombreCorto(temas.get(i).getNombreTema().substring(0, 35) + "...");
            } else {
                temaDTemp.setNombreCorto(temas.get(i).getNombreTema());
            }
            temaDTemp.setSemestreTema(temas.get(i).getIdSemestre().getIdSemestre());
            String semestre_id = temas.get(i).getIdSemestre().getIdSemestre();
            Boolean exists = false;
            for (SelectItem semestre : semestres) {
                if (semestre.getLabel().equals(semestre_id)) {
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                semestres.add(0, new SelectItem(semestre_id, semestre_id));
            }
            if (temas.get(i).getEstadoTema() != null) {
                Integer estadoTema = temas.get(i).getEstadoTema();
                if (estadoTema == 0) {
                    temaDTemp.setEstadoTema("VIGENTE");
                }
                if (estadoTema == 1) {
                    temaDTemp.setEstadoTema("TITULADO");
                }
                if (estadoTema == 2) {
                    temaDTemp.setEstadoTema("PRORROGADO");
                }
                if (estadoTema == 3) {
                    temaDTemp.setEstadoTema("CADUCO");
                }
                if (estadoTema == 4) {
                    temaDTemp.setEstadoTema("EN PROCESO DE EXAMEN");
                }
                if (estadoTema == 6) {
                    temaDTemp.setEstadoTema("VIGENTE, CON BORRADOR FINAL");
                }
            }
            temaDatos.add(temaDTemp);
        }

        //Inicializamos filtros de estados
        estados = new SelectItem[7];
        estados[0] = new SelectItem("");
        estados[1] = new SelectItem("VIGENTE");
        estados[2] = new SelectItem("TITULADO");
        estados[3] = new SelectItem("PRORROGADO");
        estados[4] = new SelectItem("CADUCO");
        estados[5] = new SelectItem("EN PROCESO DE EXAMEN");
        estados[6] = new SelectItem("VIGENTE, CON BORRADOR FINAL");
        semestres.add(0, new SelectItem("","Todos"));
    }

    public SelectItem[] getEstadosOptions() {
        SelectItem[] r = new SelectItem[estadosTemas.size() + 1];
        r[0] = new SelectItem("", "Seleccione");
        for (int t = 0; t < estadosTemas.size(); t++) {
            r[t + 1] = new SelectItem(estadosTemas.get(t), estadosTemas.get(t));
        }
        return r;
    }

    public List<String> getEstadosTemas() {
        return estadosTemas;
    }

    public void setEstadosTemas(List<String> estadosTemas) {
        this.estadosTemas = estadosTemas;
    }

    public SelectItem[] getEstados() {
        return estados;
    }

    public ArrayList<SelectItem> getSemestres() {
//        semestres.add(new SelectItem("1/2015"));
//        semestres.add(new SelectItem("2/2014"));
//        semestres.add(new SelectItem("1/2014"));
        return semestres;
    }

    public void setEstados(SelectItem[] estados) {
        this.estados = estados;
    }

    public List<TemaDatos> getTemaDatosFiltrados() {
        return temaDatosFiltrados;
    }

    public void setTemaDatosFiltrados(List<TemaDatos> temaDatosFiltrados) {
        this.temaDatosFiltrados = temaDatosFiltrados;
    }

    public List<TemaDatos> getTemaDatos() {
        return temaDatos;
    }

    public void setTemaDatos(List<TemaDatos> temaDatos) {
        this.temaDatos = temaDatos;
    }

}
