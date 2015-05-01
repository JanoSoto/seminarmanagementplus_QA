/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans;

import clases.UsuarioDatos;
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
    
    private List<Usuario> listaUsuarios;
    private List<UsuarioDatos> usuarios;
    /**
     * Creates a new instance of ListarUsuariosMB
     */
    public ListarUsuariosMB() {
    }
    
    @PostConstruct
    public void init() {
        
    }

    public List<Usuario> getListaUsuarios() {
        return listaUsuarios;
    }

    public void setListaUsuarios(List<Usuario> listaUsuarios) {
        this.listaUsuarios = listaUsuarios;
    }

    public List<UsuarioDatos> getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(List<UsuarioDatos> usuarios) {
        this.usuarios = usuarios;
    }
    
    public void updateUsuarios() {
        listaUsuarios = usuarioFacade.findAll();
        usuarios = new ArrayList();
        for (int i = 0; i < listaUsuarios.size(); i++ ) {
            UsuarioDatos user = new UsuarioDatos();
            if(listaUsuarios.get(i).getActivo())
                user.setActivo("Si");
            else
                user.setActivo("No");
            user.setRut(listaUsuarios.get(i).getUsername());
            user.setNombre(listaUsuarios.get(i).getNombreUsuario());
            user.setApellido(listaUsuarios.get(i).getApellidoUsuario());
            user.setTipo(listaUsuarios.get(i).getUsuarioTipoList().get(0).getNombreTipo().getNombreTipo());
            usuarios.add(user);
            init();
        }
    }
    
}
