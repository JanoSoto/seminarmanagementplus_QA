package managedbeans;

import entities.Logs;
import util.JsfUtil;
import util.JsfUtil.PersistAction;
import sessionbeans.LogsFacadeLocal;

import java.io.Serializable;
import java.util.List;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;

@Named("logsMB")
@SessionScoped
public class LogsMB implements Serializable {

    @EJB
    private LogsFacadeLocal ejbFacade;
    private List<Logs> items = null;
    private Logs selected;

    public LogsMB() {
    }

    public Logs getSelected() {
        return selected;
    }

    public void setSelected(Logs selected) {
        this.selected = selected;
    }

    protected void setEmbeddableKeys() {
        //no embeddable keys
    }

    protected void initializeEmbeddableKey() {
        //no embeddable keys so no initialize needed
    }

    private LogsFacadeLocal getFacade() {
        return ejbFacade;
    }

    public Logs prepareCreate() {
        selected = new Logs();
        initializeEmbeddableKey();
        return selected;
    }

    public void create() {
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/Bundle").getString("LogsCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    
            // Invalidate list of items to trigger re-query.
        }
    }

    public void update() {
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/Bundle").getString("LogsUpdated"));
    }

    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/Bundle").getString("LogsDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; 
            // Remove selection
            items = null;    
            // Invalidate list of items to trigger re-query.
        }
    }

    public List<Logs> getItems() {
        if (items == null) {
            items = getFacade().findAll();
        }
        return items;
    }

    private void persist(PersistAction persistAction, String successMessage) {
        if (selected != null) {
            setEmbeddableKeys();
            try {
                if (persistAction != PersistAction.DELETE) {
                    getFacade().edit(selected);
                } else {
                    getFacade().remove(selected);
                }
                JsfUtil.addSuccessMessage(successMessage);
            } catch (EJBException ex) {
                String msg = "";
                Throwable cause = ex.getCause();
                if (cause != null) {
                    msg = cause.getLocalizedMessage();
                }
                if (msg.length() > 0) {
                    JsfUtil.addErrorMessage(msg);
                } else {
                    JsfUtil.addErrorMessage(ex, ResourceBundle.getBundle("/Bundle").getString("PersistenceErrorOccured"));
                }
            } catch (Exception ex) {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, null, ex);
                JsfUtil.addErrorMessage(ex, ResourceBundle.getBundle("/Bundle").getString("PersistenceErrorOccured"));
            }
        }
    }

    public Logs getLogs(java.lang.Integer id) {
        return getFacade().find(id);
    }

    public List<Logs> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }

    public List<Logs> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    @FacesConverter(forClass = Logs.class)
    public static class LogsMBConverter implements Converter {

        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            LogsMB controller = (LogsMB) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "LogsMB");
            return controller.getLogs(getKey(value));
        }

        java.lang.Integer getKey(String value) {
            java.lang.Integer key;
            key = Integer.valueOf(value);
            return key;
        }

        String getStringKey(java.lang.Integer value) {
            StringBuilder sb = new StringBuilder();
            sb.append(value);
            return sb.toString();
        }

        @Override
        public String getAsString(FacesContext facesContext, UIComponent component, Object object) {
            if (object == null) {
                return null;
            }
            if (object instanceof Logs) {
                Logs o = (Logs) object;
                return getStringKey(o.getLogsId());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), Logs.class.getName()});
                return null;
            }
        }

    }

}