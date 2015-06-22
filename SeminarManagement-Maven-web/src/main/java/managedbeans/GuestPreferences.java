/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans;

/**
 *
 * @author miguel
 */
import java.io.Serializable;
import java.util.Map;
import javax.enterprise.context.SessionScoped;
import javax.faces.bean.ManagedBean;

import javax.faces.context.FacesContext;
import javax.inject.Named;

@ManagedBean(name="guestPreferences")
@SessionScoped
public class GuestPreferences implements Serializable {

	private String theme = "usachborde"; //default

	public String getTheme() {
		Map<String, String> params = FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap();
		if(params.containsKey("theme")) {
                        System.out.println("Entro ji");
			this.theme = params.get("theme");
		}
		System.out.println("Preferencias: "+ this.theme);
		return this.theme;
	}

	public void setTheme(String theme) {
                this.theme = theme;
                System.out.println("Cambio de tema usuario: " + this.theme);
		
	}
}