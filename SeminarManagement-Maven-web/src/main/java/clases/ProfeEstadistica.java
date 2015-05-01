/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import entities.ProfeCorreccion;
import entities.ProfePropuesta;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author David
 */
public class ProfeEstadistica {
    private String rut,nombre,apellido;
    private float propuestas,propRevisadas,propAceptadas,temasCaducos,
            temasTitulados,temasConCorrectora,temasConNota,semestresEnCorregir,
            promedioGuias,promedioEnGuia,promedioEnCorreccion;
    
    public ProfeEstadistica(Profesor p, int semestres){
        rut = p.getRutProfesor();
        nombre = p.getNombreProfesor();
        apellido = p.getApellidoProfesor();
        
        List<Propuesta> props = new ArrayList();
        for(int i=0;i<p.getProfePropuestaList().size();i++)
            if(p.getProfePropuestaList().get(i).getRolGuia()==0)
                props.add(p.getProfePropuestaList().get(i).getPropuesta());
        
        propuestas = props.size();
        propRevisadas = 0;
        propAceptadas = 0;
        temasCaducos = 0;
        temasTitulados = 0;
        temasConCorrectora = 0;
        semestresEnCorregir = 0;
        temasConNota = 0;
        promedioGuias = 0;
        promedioEnGuia = 0;
        Semestre semTemp;
        for(int i=0;i<props.size();i++){
            semTemp = props.get(i).getIdSemestre();
            
            if(props.get(i).getIdRevisora()!=null){
                propRevisadas++;
                if(props.get(i).getIdRevisora().getIdTema()!=null){
                    propAceptadas++;
                    
                    if(props.get(i).getIdRevisora().getIdTema().getEstadoTema()==1)
                        temasTitulados++;
                    if(props.get(i).getIdRevisora().getIdTema().getEstadoTema()==3)
                        temasCaducos++;
                    
                    if(props.get(i).getIdRevisora().getIdTema().getIdCorrectora()!=null){
                        temasConCorrectora++;
                        semestresEnCorregir += substract(props.get(i).getIdRevisora().getIdTema().getIdCorrectora().getIdSemestre(),semTemp);
                        
                        if(props.get(i).getIdRevisora().getIdTema().getIdCorrectora().getProfeCorreccionList().get(0).getNotaCorreccionDefensa()!=null){
                            List<ProfeCorreccion> profeCorreccionTemp = props.get(i).getIdRevisora().getIdTema().getIdCorrectora().getProfeCorreccionList();
                            ProfePropuesta profePropuestaTemp = new ProfePropuesta();
                            for(int j=0;j<props.get(i).getProfePropuestaList().size();j++)
                                if(props.get(i).getProfePropuestaList().get(j).getRolGuia()==0)
                                    profePropuestaTemp = props.get(i).getProfePropuestaList().get(j);
                            
                            temasConNota++;
                            promedioGuias += (profeCorreccionTemp.get(0).getNotaCorreccionInforme()+
                                    profeCorreccionTemp.get(0).getNotaCorreccionDefensa()+
                                    profeCorreccionTemp.get(1).getNotaCorreccionInforme()+
                                    profeCorreccionTemp.get(1).getNotaCorreccionDefensa()+
                                    profePropuestaTemp.getNotaGuiaInforme()+
                                    profePropuestaTemp.getNotaGuiaDefensa())/6;
                            
                            promedioEnGuia += (profePropuestaTemp.getNotaGuiaInforme()+
                                    profePropuestaTemp.getNotaGuiaDefensa())/2;
                        }
                    }
                }
            }
        }
        semestresEnCorregir = semestresEnCorregir/temasConCorrectora;
        promedioGuias = promedioGuias/temasConNota;
        promedioEnGuia = promedioEnGuia/temasConNota;
        propuestas = propuestas/semestres;
        propRevisadas = propRevisadas/semestres;
        propAceptadas = propAceptadas/semestres;
        temasCaducos = temasCaducos/semestres;
        temasTitulados = temasTitulados/semestres;
        temasConCorrectora = temasConCorrectora/semestres;
        temasConNota = temasConNota/semestres;
        
        
        promedioEnCorreccion = 0;
        int correccionesConNota = 0;
        List<ProfeCorreccion> profeCorrecciones = p.getProfeCorreccionList();
        for(int i=0;i<profeCorrecciones.size();i++)
            if(profeCorrecciones.get(i).getNotaCorreccionInforme()!=null){
                correccionesConNota++;
                promedioEnCorreccion += (profeCorrecciones.get(i).getNotaCorreccionInforme()+
                        profeCorrecciones.get(i).getNotaCorreccionDefensa())/2;
            }
        promedioEnCorreccion = promedioEnCorreccion/correccionesConNota;
    }
    
    private int substract(Semestre s1, Semestre s2){
        int sem1,ano1,sem2,ano2;
        
        sem1= Integer.parseInt(s1.getIdSemestre().substring(0,1));
        ano1= Integer.parseInt(s1.getIdSemestre().substring(2));
        
        sem2= Integer.parseInt(s2.getIdSemestre().substring(0,1));
        ano2= Integer.parseInt(s2.getIdSemestre().substring(2));
        
        return (ano1-ano2)*2 + sem1-sem2 + 1;
    }

    public String getRut() {
        return rut;
    }

    public void setRut(String rut) {
        this.rut = rut;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public float getPropuestas() {
        return propuestas;
    }

    public void setPropuestas(float propuestas) {
        this.propuestas = propuestas;
    }

    public float getPropRevisadas() {
        return propRevisadas;
    }

    public void setPropRevisadas(float propRevisadas) {
        this.propRevisadas = propRevisadas;
    }

    public float getPropAceptadas() {
        return propAceptadas;
    }

    public void setPropAceptadas(float propAceptadas) {
        this.propAceptadas = propAceptadas;
    }

    public float getTemasCaducos() {
        return temasCaducos;
    }

    public void setTemasCaducos(float temasCaducos) {
        this.temasCaducos = temasCaducos;
    }

    public float getTemasTitulados() {
        return temasTitulados;
    }

    public void setTemasTitulados(float temasTitulados) {
        this.temasTitulados = temasTitulados;
    }

    public float getTemasConCorrectora() {
        return temasConCorrectora;
    }

    public void setTemasConCorrectora(float temasConCorrectora) {
        this.temasConCorrectora = temasConCorrectora;
    }

    public float getTemasConNota() {
        return temasConNota;
    }

    public void setTemasConNota(float temasConNota) {
        this.temasConNota = temasConNota;
    }

    public float getSemestresEnCorregir() {
        return semestresEnCorregir;
    }

    public void setSemestresEnCorregir(float semestresEnCorregir) {
        this.semestresEnCorregir = semestresEnCorregir;
    }

    public float getPromedioGuias() {
        return promedioGuias;
    }

    public void setPromedioGuias(float promedioGuias) {
        this.promedioGuias = promedioGuias;
    }

    public float getPromedioEnGuia() {
        return promedioEnGuia;
    }

    public void setPromedioEnGuia(float promedioEnGuia) {
        this.promedioEnGuia = promedioEnGuia;
    }

    public float getPromedioEnCorreccion() {
        return promedioEnCorreccion;
    }

    public void setPromedioEnCorreccion(float promedioEnCorreccion) {
        this.promedioEnCorreccion = promedioEnCorreccion;
    }
}
