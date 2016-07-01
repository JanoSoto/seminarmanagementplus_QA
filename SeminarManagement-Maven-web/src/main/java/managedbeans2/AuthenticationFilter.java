/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2;

import java.io.IOException;
import java.security.Principal;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.MDC;
/**
 *
 * @author miguel
 */
public class AuthenticationFilter implements Filter{
    private static final String USERKEY = "user";
    public void destroy() {
    }
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        boolean successfulRegistration = false;
        HttpServletRequest req = (HttpServletRequest) request;
        Principal principal = req.getUserPrincipal();
        //String user = principal.getName();
        //System.out.println("hola" + user);
        if (principal != null) {
            String username = principal.getName();
            successfulRegistration = registerUsername(username);
        }
        try{           
            chain.doFilter(request, response);
        }finally{
            if (successfulRegistration) {
                MDC.remove(USERKEY);
            }
        }
    }

    public void init(FilterConfig arg0) throws ServletException {
    }
    
    private boolean registerUsername(String username) {
        if (username != null && username.trim().length() > 0) {
            MDC.put(USERKEY, username);
            return true;
        }
        return false;
}

    
}

