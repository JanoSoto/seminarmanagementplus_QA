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
import entities.Tipousuario;
import entities.Usuario;
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
import sessionbeans.TipousuarioFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;

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
    private TipousuarioFacadeLocal tipoFacade;
    @EJB
    private UsuarioFacadeLocal usuarioFacade;


    /**
     * Creates a new instance of UsuarioViewMB
     */
    
    private Usuario usuarioSelected, usuarioEdit;
    private String uid;
    private List<Historial> histUser;
    private List<Tipousuario> tipos;
    
    
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
    
    public Usuario getUsuarioEdit() {
        return usuarioEdit;
    }

    public void setUsuarioEdit(Usuario usuarioEdit) {
        this.usuarioEdit = usuarioEdit;
    }

    public Usuario getUsuarioSelected() {
        return usuarioSelected;
    }

    public void setUsuarioSelected(Usuario usuarioSelected) {
        this.usuarioSelected = usuarioSelected;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }
    
    public void handleErrorView() throws IOException{
        try{
            if(usuarioSelected.getNombreUsuario() == null)
                FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
        catch (IOException e){
            Logger.getLogger(ProfesorViewMB.class.getName()).log(Level.SEVERE, null, e);
            FacesContext.getCurrentInstance().getExternalContext().redirect("../error.xhtml");
        }
    }
    
    public void viewSelectUsuario() throws IOException {
        uid = FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap().get("user");
        try{
            if (usuarioFacade.existe(uid)){
                Usuario user = usuarioFacade.findByUid(uid);
                Usuario usuario = new Usuario();
                if(user.getActivo())
                    usuarioSelected.setActivo(true);
                else
                    usuarioSelected.setActivo(false);
                usuarioSelected.setRutUsuario(user.getRutUsuario());
                usuarioSelected.setNombreUsuario(user.getNombreUsuario());
                usuarioSelected.setApellidoUsuario(user.getApellidoUsuario());
                usuarioSelected.setTipos(tipos);
                //usuarioSelected.setTipo(user.getUsuarioTipoList().get(0).getNombreTipo().getNombreTipo());
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
            usuarioEdit = new Usuario();
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
            Usuario user = usuarioFacade.find(usuarioSelected.getUid());
            //Editamos datos usuario
            if (usuarioEdit.getActivo().equals("Si"))
                user.setActivo(true);
            else
                user.setActivo(false);
            user.setApellidoUsuario(usuarioEdit.getApellidoUsuario().toUpperCase());
            user.setNombreUsuario(usuarioEdit.getNombreUsuario().toUpperCase());
            user.setUid(usuarioEdit.getUid());
            
            //Evaluamos si cambio el tipo de usuario, para alterar la tabla tipo_usuario
            //Si no, seteamos el usuario_tipo que ya tenía
            if(!usuarioSelected.getTipos().equals(user.getTipos())) {
                List<Tipousuario> tipo = usuarioEdit.getTipos();
                //UsuarioTipo userTipo = user.getUsuarioTipoList().get(0);
               // userTipo.setNombreTipo(tipo);
                //usuarioTipoFacade.edit(userTipo);
                ///Asignamos el usuario_tipo al usuario
                List<Tipousuario> temp = new ArrayList();
                for(int i=0; i<tipo.size(); i++){
                    temp.add(tipo.get(i));
                }
                
                usuario.setTipos(temp);
            }
            else
                user.setTipos(user.getTipos());
            usuarioFacade.edit(user);
            FacesContext context = FacesContext.getCurrentInstance();
            context.addMessage(null, new FacesMessage("Editar Usuario", "Datos de '"+usuarioEdit.getNombreUsuario()+" "+usuarioEdit.getApellidoUsuario()+"' editados exitosamente"));
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
