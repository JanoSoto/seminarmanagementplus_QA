package managedbeans;

import javax.enterprise.context.RequestScoped;
import javax.faces.bean.ManagedBean;

/**
 *
 * @author David
 */
@ManagedBean(name ="accordionPanelMB")
@RequestScoped
public class AccordionPanelMB {
    
    String  index="-1",
            alumno="enlace",
            profesor="enlace",
            revisora="enlace",
            tema="enlace",
            correctora="enlace",
            avance="enlace",
            renuncia="enlace",
            calificacion="enlace",
            listAlum="enlace",
            listProf="enlace",
            listTem="enlace",
            reglamento="enlace",
            propuesta="enlace",
            borrador="enlace",
            cambiosMasivos="enlace",
            estadProfe="enlace",
            usuario="enlace",
            listUser="enlace",
            eliminar="enlace",
            semestre="enlace";
    
    public AccordionPanelMB() {
    }

    public String getEliminar() {
        return eliminar;
    }

    public void setEliminar(String eliminar) {
        this.eliminar = eliminar;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    public String getPropuesta() {
        return propuesta;
    }

    public void setPropuesta(String propuesta) {
        this.propuesta = propuesta;
    }

    public String getAlumno() {
        return alumno;
    }

    public void setAlumno(String alumno) {
        this.alumno = alumno;
    }

    public String getProfesor() {
        return profesor;
    }

    public void setProfesor(String profesor) {
        this.profesor = profesor;
    }

    public String getRevisora() {
        return revisora;
    }

    public void setRevisora(String revisora) {
        this.revisora = revisora;
    }

    public String getTema() {
        return tema;
    }

    public void setTema(String tema) {
        this.tema = tema;
    }

    public String getCorrectora() {
        return correctora;
    }

    public void setCorrectora(String correctora) {
        this.correctora = correctora;
    }

    public String getAvance() {
        return avance;
    }

    public void setAvance(String avance) {
        this.avance = avance;
    }

    public String getRenuncia() {
        return renuncia;
    }

    public void setRenuncia(String renuncia) {
        this.renuncia = renuncia;
    }

    public String getCalificacion() {
        return calificacion;
    }

    public void setCalificacion(String calificacion) {
        this.calificacion = calificacion;
    }

    public String getListAlum() {
        return listAlum;
    }

    public void setListAlum(String listAlum) {
        this.listAlum = listAlum;
    }

    public String getListProf() {
        return listProf;
    }

    public void setListProf(String listProf) {
        this.listProf = listProf;
    }

    public String getListTem() {
        return listTem;
    }

    public void setListTem(String listTem) {
        this.listTem = listTem;
    }

    public String getReglamento() {
        return reglamento;
    }

    public void setReglamento(String reglamento) {
        this.reglamento = reglamento;
    }

    public String getBorrador() {
        return borrador;
    }

    public void setBorrador(String borrador) {
        this.borrador = borrador;
    }

    public String getCambiosMasivos() {
        return cambiosMasivos;
    }

    public void setCambiosMasivos(String cambiosMasivos) {
        this.cambiosMasivos = cambiosMasivos;
    }

    public String getEstadProfe() {
        return estadProfe;
    }

    public void setEstadProfe(String estadProfe) {
        this.estadProfe = estadProfe;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getListUser() {
        return listUser;
    }

    public void setListUser(String listUser) {
        this.listUser = listUser;
    }

    public String getSemestre() {
        return semestre;
    }

    public void setSemestre(String semestre) {
        this.semestre = semestre;
    }
    
}
