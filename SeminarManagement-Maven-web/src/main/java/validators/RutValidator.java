/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package validators;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.component.html.HtmlInputText;
import javax.faces.context.FacesContext;
import javax.faces.validator.FacesValidator;
import javax.faces.validator.Validator;
import javax.faces.validator.ValidatorException;

/**
 *
 * @author Eduardo
 */
@FacesValidator("rutValidator")
public class RutValidator implements Validator{
    
    @Override
    public void validate(FacesContext facesContext, UIComponent uIComponent, Object value) throws ValidatorException {
        Pattern pattern;
        //Reemplazamos "-" y "." por espacios en blanco
        value = value.toString().replace(".", "");
        value = value.toString().replace("-", "");
        if (value.toString().endsWith("k") || value.toString().endsWith("K"))
            pattern = Pattern.compile("\\d{7,8}[Kk]");
        else
            pattern = Pattern.compile("\\d{8,9}");
        Matcher matcher = pattern.matcher((CharSequence) value);
        HtmlInputText htmlInputText = (HtmlInputText) uIComponent;
        String label;
        
        if (htmlInputText.getLabel() == null || htmlInputText.getLabel().trim().equals(""))
            label = htmlInputText.getId();
        else
            label = htmlInputText.getLabel();
        if (!matcher.matches()) {
            FacesMessage facesMessage = new FacesMessage("RUT",label+": ingrese RUT sin puntos ni guión");
            throw new ValidatorException(facesMessage);
        }
        boolean validacion = false;
        try {
            String rut = value.toString();
            rut =  rut.toUpperCase();
            int rutAux = Integer.parseInt(rut.substring(0, rut.length() - 1));
            char dv = rut.charAt(rut.length() - 1);
            int m = 0, s = 1;
            for (; rutAux != 0; rutAux /= 10) {
                s = (s + rutAux % 10 * (9 - m++ % 6)) % 11;
            }
            if (dv == (char) (s != 0 ? s + 47 : 75)) {
                validacion = true;
            }
        } catch (java.lang.NumberFormatException e) {
            FacesMessage facesMessage = new FacesMessage("ERROR:",label+": Hubo un error procesando el RUT. Intente nuevamente");
            throw new ValidatorException(facesMessage);
        }
        if(!validacion) {
            FacesMessage facesMessage = new FacesMessage("RUT",label+": El RUT ingresado no es válido");
            throw new ValidatorException(facesMessage);
        }
    }
}
