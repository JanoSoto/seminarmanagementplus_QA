/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans;

import clases.UsuarioDatos;
import entities.Tipousuario;
import entities.Usuario;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author Elagos
 */
@Named(value = "listarUsuariosMB")
@SessionScoped
public class ListarUsuariosMB implements Serializable {
    @EJB
    private UsuarioFacadeLocal usuarioFacade;
    
    private List<Tipousuario> tipos;
    
    private List<Usuario> usuarios;
    //private List<UsuarioDatos> usuarios;
    /**
     * Creates a new instance of ListarUsuariosMB
     */
    public ListarUsuariosMB() {
    }
    
    @PostConstruct
    public void init() {
        
    }

    public List<Usuario> getListaUsuarios() {
        return usuarios;
    }

    public void setListaUsuarios(List<Usuario> listaUsuarios) {
        this.usuarios = listaUsuarios;
    }

    
    public void updateUsuarios() {
        usuarios = usuarioFacade.findAll();
        List usuariosList = new ArrayList();
        for (int i = 0; i < usuarios.size(); i++ ) {
            Usuario user = new Usuario();
            if(usuarios.get(i).getActivo())
                user.setActivo(true);
            else
                user.setActivo(false);
            user.setRutUsuario(usuarios.get(i).getUid());
            user.setNombreUsuario(usuarios.get(i).getNombreUsuario());
            user.setApellidoUsuario(usuarios.get(i).getApellidoUsuario());
            user.setTipos(usuarios.get(i).getTipos());
            usuarios.add(user);
            init();
        }
    }
    
}
