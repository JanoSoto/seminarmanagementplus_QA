/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.usuarios;

import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;
import sessionbeans.HistorialFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author Elagos
 */
@Named(value = "verUsuarioMB")
@RequestScoped
public class VerUsuarioMB {
    @EJB
    private UsuarioFacadeLocal usuarioFacade;
    @EJB
    private HistorialFacadeLocal historialFacade;

    /**
     * Creates a new instance of VerUsuarioMB
     */
    
    private String username;
    
    public VerUsuarioMB() {
    }
    
}
