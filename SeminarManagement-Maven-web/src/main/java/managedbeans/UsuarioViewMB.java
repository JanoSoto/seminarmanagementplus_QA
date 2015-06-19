/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans;

import clases.ProfeDatos;
import clases.UsuarioDatos;
import entities.Historial;
import entities.Profesor;
import entities.Tipo;
import entities.Usuario;
import entities.UsuarioTipo;
import entities.UsuarioTipoPK;
import java.io.IOException;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.TipoFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;
import sessionbeans.UsuarioTipoFacadeLocal;

/**
 *
 * @author Elagos
 */
@Named(value = "usuarioViewMB")
@SessionScoped
public class UsuarioViewMB implements Serializable {
    @EJB
    private HistorialFacadeLocal historialFacade;
    @EJB
    private TipoFacadeLocal tipoFacade;
    @EJB
    private UsuarioTipoFacadeLocal usuarioTipoFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;

    

    /**
     * Creates a new instance of UsuarioViewMB
     */
    
    private UsuarioDatos usuarioSelected, usuarioEdit;
    private Tipo tipoSelected;
    private String rutUsuario;
    private List<Historial> histUser;
    
    @PostConstruct
    public void init() {  
    }
    
    public UsuarioViewMB() {
    }

    public List<Historial> getHistUser() {
        return histUser;
    }

    public void setHistUser(List<Historial> histUser) {
        this.histUser = histUser;
    }
    
    public UsuarioDatos getUsuarioEdit() {
        return usuarioEdit;
    }

    public void setUsuarioEdit(UsuarioDatos usuarioEdit) {
        this.usuarioEdit = usuarioEdit;
    }

    public UsuarioDatos getUsuarioSelected() {
        return usuarioSelected;
    }

    public void setUsuarioSelected(UsuarioDatos usuarioSelected) {
        this.usuarioSelected = usuarioSelected;
    }

    public String getRutUsuario() {
        return rutUsuario;
    }

    public void setRutUsuario(String rutUsuario) {
        this.rutUsuario = rutUsuario;
    }
    
    public void handleErrorView() throws IOException{
        try{
            if(usuarioSelected.getNombre() == null)
                FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
        catch (IOException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void viewSelectUsuario() throws IOException {
        rutUsuario = FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap().get("user");
        try{
            if (usuarioFacade.existe(rutUsuario)){
                Usuario user = usuarioFacade.findByUsername(rutUsuario).get(0);
                usuarioSelected = new UsuarioDatos();
                if(user.getActivo())
                    usuarioSelected.setActivo("Si");
                else
                    usuarioSelected.setActivo("No");
                usuarioSelected.setRut(user.getUid());
                usuarioSelected.setNombre(user.getNombreUsuario());
                usuarioSelected.setApellido(user.getApellidoUsuarioPaterno());
                UsuarioTipoPK ut = new UsuarioTipoPK(tipoSelected.getIdTipo(),usuarioSelected.getRut());
                //usuarioSelected.setTipo(user.getUsuarioTipoList().get(0).setUsuarioTipoPK(ut));
                //init();
            }
            else
                FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        } catch (NumberFormatException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void loadEditPage() throws IOException {
        try {
            usuarioEdit = new UsuarioDatos();
            usuarioEdit = usuarioSelected;
            FacesContext.getCurrentInstance().getExternalContext().redirect("../editar/usuario.xhtml");
        } catch (IOException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void editUsuario() throws IOException{
        try {
            Usuario usuario = new Usuario();
            Usuario user = usuarioFacade.find(usuarioSelected.getRut());
            //Editamos datos usuario
            if (usuarioEdit.getActivo().equals("Si"))
                user.setActivo(true);
            else
                user.setActivo(false);
            user.setApellidoUsuarioPaterno(usuarioEdit.getApellido().toUpperCase());
            user.setNombreUsuario(usuarioEdit.getNombre().toUpperCase());
            user.setRutUsuario(usuarioEdit.getRut());
            
            //Evaluamos si cambio el tipo de usuario, para alterar la tabla tipo_usuario
            //Si no, seteamos el usuario_tipo que ya tenía
            
            if(!usuarioSelected.getTipo().equals(tipoFacade.find(user.getUsuarioTipoList().get(0).getUsuarioTipoPK().getIdTipo()).getNombreTipo())) {
                Tipo tipo = tipoFacade.find(usuarioEdit.getTipo());
                UsuarioTipo userTipo = user.getUsuarioTipoList().get(0);
                //userTipo.setNombreTipo(tipo);
                usuarioTipoFacade.edit(userTipo);
                //Asignamos el usuario_tipo al usuario
                List<UsuarioTipo> temp = new ArrayList();
                temp.add(userTipo);
                //usuario.setUsuarioTipoList(temp);
            }
            else
                //user.setUsuarioTipoList(user.getUsuarioTipoList());
            usuarioFacade.edit(user);
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage("Editar Usuario", "Datos de '"+usuarioEdit.getNombre()+" "+usuarioEdit.getApellido()+"' editados exitosamente"));
        } catch (NumberFormatException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void historialUsuario(String rut) throws IOException{
        try{
            histUser = new ArrayList();
            histUser = historialFacade.findByIdEntidad(rut);
        } catch (Exception e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void destroyHist() throws IOException {
        try{
            histUser = new ArrayList<Historial>();
        } catch (Exception e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
}
