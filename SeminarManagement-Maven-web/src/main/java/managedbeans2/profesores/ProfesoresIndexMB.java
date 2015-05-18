/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.profesores;

import clases.ProfeDatos2;
import entities.ProfeCorreccion;
import entities.ProfeRevision;
import entities.Profesor;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.ProfesorFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import Util.Util;
import entities.Alumno;
import sessionbeans.AlumnoFacadeLocal;

/**
 *
 * @author David
 */
@Named(value = "profesoresIndexMB")
@RequestScoped
public class ProfesoresIndexMB {

    @EJB
    private SemestreActualFacadeLocal semestreActualFacade;
    @EJB
    private ProfesorFacadeLocal profesorFacade;

    @EJB
    private AlumnoFacadeLocal alumnoFacade;

    private List<Profesor> profesores;
    private List<ProfeDatos2> profeDatos, profesoresFiltrados, profeDatosJornadaCompleta, profeDatosPorHoras;

    private Integer totalTemasVigentesJornadaCompleta, totalTemasVigentesJornadaCompletaDiurno, totalTemasVigentesJornadaCompletaVespertino, totalTemasVigentesPorHora, totalTemasVigentesPorHoraDiurno, totalTemasVigentesPorHoraVespertino;

    /**
     * Creates a new instance of ProfesoresIndexMB
     */
    public ProfesoresIndexMB() {
    }

    @PostConstruct
    public void init() {
        totalTemasVigentesJornadaCompleta = 0;
        totalTemasVigentesJornadaCompletaDiurno = 0;
        totalTemasVigentesJornadaCompletaVespertino = 0;
        totalTemasVigentesPorHora = 0;
        totalTemasVigentesPorHoraDiurno = 0;
        totalTemasVigentesPorHoraVespertino = 0;
        String semestreActual;
        FacesContext context = FacesContext.getCurrentInstance();
        //Seteamos el semestre a semestre actual
        if (semestreActualFacade.findAll().isEmpty()) {
            semestreActual = "";
            context.addMessage(null, new FacesMessage("Aviso", "No se ha ingresado semestre actual en el sistema"));
        } else {
            semestreActual = semestreActualFacade.findAll().get(0).getSemestreActual();
        }

        profesores = profesorFacade.findAll();
        int guiaTemp, revisorTemp, guiaP, revProp, revSem, guiaTempDiurno, guiaTempVespertino;
        ProfeDatos2 profeDatosTemp;
        profeDatos = new ArrayList();
        profeDatosJornadaCompleta = new ArrayList();
        profeDatosPorHoras = new ArrayList();
        List<ProfeRevision> profRev;
        for (int i = 0; i < profesores.size(); i++) {
            profeDatosTemp = new ProfeDatos2();
            profRev = profesores.get(i).getProfeRevisionList();
            guiaTemp = 0;
            guiaTempDiurno = 0;
            guiaTempVespertino = 0;
            guiaP = 0;
            //Seteamos revisiones
            revisorTemp = 0;
            revProp = 0;
            revSem = 0;
            for (int j = 0; j < profRev.size(); j++) {
                if (profRev.get(j).getComisionRevisora().getIdSemestre().getIdSemestre().equals(semestreActual)) {
                    revisorTemp++;
                    if (profRev.get(j).getComisionRevisora().getTipoRevision() == 0) {
                        revProp++;
                    }
                    if (profRev.get(j).getComisionRevisora().getTipoRevision() == 1) {
                        revSem++;
                    }
                }
            }
            //Seteamos la cantidad de temas vigentes en que es guía
            for (int j = 0; j < profesores.get(i).getProfePropuestaList().size(); j++) {
                if (profesores.get(i).getProfePropuestaList().get(j).getRolGuia() == 0) {
                    guiaP++;
                    if (profesores.get(i).getProfePropuestaList().get(j).getPropuesta() != null) {
                        if (profesores.get(i).getProfePropuestaList().get(j).getPropuesta().getIdRevisora() != null) {
                            if (profesores.get(i).getProfePropuestaList().get(j).getPropuesta().getIdRevisora().getIdTema() != null) {
                                if (profesores.get(i).getProfePropuestaList().get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema() != null) {
                                    int tipoTemaTemp = profesores.get(i).getProfePropuestaList().get(j).getPropuesta().getIdRevisora().getIdTema().getEstadoTema();
                                    if (tipoTemaTemp == 0 || tipoTemaTemp == 2) {
                                        guiaTemp++;

                                        List<Alumno> alumno = alumnoFacade.findByRut(profesores.get(i).getProfePropuestaList().get(j).getPropuesta().getRutAlumno().getRutAlumno());
                                        if (alumno.get(0).getJornada() == 1) {
                                            guiaTempDiurno++;
                                            if (profesores.get(i).getContrato() == 0) {// Por Hora
                                                totalTemasVigentesPorHora++;
                                                totalTemasVigentesPorHoraDiurno++;
                                            } else { // Jornada Completa
                                                totalTemasVigentesJornadaCompleta++;
                                                totalTemasVigentesJornadaCompletaDiurno++;
                                            }
                                        } else {
                                            guiaTempVespertino++;
                                            if (profesores.get(i).getContrato() == 0) {// Por Hora
                                                totalTemasVigentesPorHora++;
                                                totalTemasVigentesPorHoraVespertino++;
                                            } else { // Jornada Completa
                                                totalTemasVigentesJornadaCompleta++;
                                                totalTemasVigentesJornadaCompletaVespertino++;
                                            }
                                        }
                                    }

                                }
                            }
                        }
                    }
                }
            }
            //Seteamos correcciones
            int corrTemp;
            List<Profesor> profes = profesorFacade.findAll();
            List<ProfeCorreccion> profCorr;
            profCorr = profes.get(i).getProfeCorreccionList();
            corrTemp = 0;
            for (int j = 0; j < profCorr.size(); j++) {
                if (profCorr.get(j).getComisionCorrectora().getIdSemestre().getIdSemestre().equals(semestreActual)) {
                    corrTemp++;
                }
            }
            profeDatosTemp.setCorrSemActual(corrTemp);
            profeDatosTemp.setProfesor(profesores.get(i));
            String rutP = profesores.get(i).getRutProfesor();
            profeDatosTemp.setRutFormateado(Util.formatearRut(rutP));
            profeDatosTemp.setRutProfConGuion(rutP.substring(0, rutP.length() - 1) + "-" + rutP.substring(rutP.length() - 1));
            if (profesores.get(i).getContrato() == 0) {
                profeDatosTemp.setContrato("Por Hora");
            } else {
                profeDatosTemp.setContrato("Jornada Completa");
            }
            profeDatosTemp.setRevSemActual(revProp);
            profeDatosTemp.setTemasVigentes(guiaTemp);
            profeDatosTemp.setTemasVigentesDiurno(guiaTempDiurno);
            profeDatosTemp.setTemasVigentesVespertino(guiaTempVespertino);
            profeDatosTemp.setPropSemActual(guiaP);
            profeDatos.add(profeDatosTemp);
            // Por horas
            if (profesores.get(i).getContrato() == 0) {
                profeDatosPorHoras.add(profeDatosTemp);
            } else { // Jornada Completa
                profeDatosJornadaCompleta.add(profeDatosTemp);
            }
        }
    }

    public List<ProfeDatos2> getProfeDatos() {
        return profeDatos;
    }

    public void setProfeDatos(List<ProfeDatos2> profeDatos) {
        this.profeDatos = profeDatos;
    }

    public List<ProfeDatos2> getProfesoresFiltrados() {
        return profesoresFiltrados;
    }

    public void setProfesoresFiltrados(List<ProfeDatos2> profesoresFiltrados) {
        this.profesoresFiltrados = profesoresFiltrados;
    }

    public List<Profesor> getProfesores() {
        return profesores;
    }

    public void setProfesores(List<Profesor> profesores) {
        this.profesores = profesores;
    }

    public List<ProfeDatos2> getProfeDatosJornadaCompleta() {
        return profeDatosJornadaCompleta;
    }

    public List<ProfeDatos2> getProfeDatosPorHoras() {
        return profeDatosPorHoras;
    }

    public Integer getTotalTemasVigentesJornadaCompleta() {
        return totalTemasVigentesJornadaCompleta;
    }

    public Integer getTotalTemasVigentesJornadaCompletaDiurno() {
        return totalTemasVigentesJornadaCompletaDiurno;
    }

    public Integer getTotalTemasVigentesJornadaCompletaVespertino() {
        return totalTemasVigentesJornadaCompletaVespertino;
    }

    public Integer getTotalTemasVigentesPorHora() {
        return totalTemasVigentesPorHora;
    }

    public Integer getTotalTemasVigentesPorHoraDiurno() {
        return totalTemasVigentesPorHoraDiurno;
    }

    public Integer getTotalTemasVigentesPorHoraVespertino() {
        return totalTemasVigentesPorHoraVespertino;
    }
}
