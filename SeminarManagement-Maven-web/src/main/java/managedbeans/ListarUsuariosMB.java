/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans;

import clases.UsuarioDatos;
import entities.Tipo;
import entities.Usuario;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import sessionbeans.TipoFacadeLocal;
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
    @EJB
    private TipoFacadeLocal tipoFacade;
    
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
            user.setRut(listaUsuarios.get(i).getUid());
            user.setNombre(listaUsuarios.get(i).getNombreUsuario());
            user.setApellido(listaUsuarios.get(i).getApellidoUsuarioPaterno());
            user.setApellido(listaUsuarios.get(i).getApellidoUsuarioMaterno());
            Tipo buscado = tipoFacade.find(listaUsuarios.get(i).getUsuarioTipoList().get(0).getUsuarioTipoPK().getIdTipo());
            user.setTipo(buscado.getNombreTipo());
            usuarios.add(user);
            init();
        }
    }
    
}
