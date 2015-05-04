/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.usuarios;

import entities.Usuario;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author Elagos
 */
@Named(value = "usuariosIndexMB")
@RequestScoped
public class UsuariosIndexMB {
    @EJB
    private UsuarioFacadeLocal usuarioFacade;
    private static final org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger(UsuariosIndexMB.class);

    /**
     * Creates a new instance of UsuariosIndexMB
     */
    
    private List<Usuario> usuarios;
    
    public UsuariosIndexMB() {
        
    }
    
    @PostConstruct
    public void init() {
       usuarios = usuarioFacade.findAll();
    }

    public List<Usuario> getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(List<Usuario> usuarios) {
        this.usuarios = usuarios;
        LOGGER.info("Se ha modificado a el usuario "+ this.usuarios.get(0));
    }
    
}
