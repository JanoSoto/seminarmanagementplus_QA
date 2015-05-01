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
@FacesValidator("celularValidator")
public class CelularValidator implements Validator {
     
    @Override
    public void validate(FacesContext facesContext, UIComponent uIComponent, Object value) throws ValidatorException {
        Pattern pattern = Pattern.compile("\\d{8}");
        Matcher matcher = pattern.matcher((CharSequence) value);
        HtmlInputText htmlInputText = (HtmlInputText) uIComponent;
        String label;
        
        if (htmlInputText.getLabel() == null || htmlInputText.getLabel().trim().equals(""))
            label = htmlInputText.getId();
        else
            label = htmlInputText.getLabel();
        
        //Si se ingreso celular, se valida, de lo contrario no, pues no es obligatorio
        if (value != "") {
            if (!matcher.matches()) {
                FacesMessage facesMessage = new FacesMessage("Error",label+": Debe ser un número y debe ser de 8 dígitos");
                throw new ValidatorException(facesMessage);
            }
        }
    }
}
