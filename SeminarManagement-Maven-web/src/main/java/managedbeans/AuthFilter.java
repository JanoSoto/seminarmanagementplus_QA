package managedbeans;


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

public class AuthFilter implements Filter {

  private static final String USERKEY = "user";
  
  @Override
  public void destroy() {
      //Nothing to destroy
  }

  @Override
  public void doFilter(ServletRequest request, ServletResponse response,
    FilterChain chain) throws IOException, ServletException {

    boolean successfulRegistration = false;

    HttpServletRequest req = (HttpServletRequest) request;    
    Principal principal = req.getUserPrincipal();
    // Please note that we could have also used a cookie to 
    // retrieve the user name

    if (principal != null) {
      String username = principal.getName();
      successfulRegistration = registerUsername(username);
    } 

    try {
      chain.doFilter(request, response);
    } finally {
      if (successfulRegistration) {
        MDC.remove(USERKEY);
      }
    }
  }

  @Override
  public void init(FilterConfig arg0) throws ServletException {
      //Empty 'cause the work is done in the other methods
  }
  

  /**
   * Register the user in the MDC under USER_KEY.
   * 
   * @param username
   * @return true id the user can be successfully registered
   */
  private boolean registerUsername(String username) {
    if (username != null && username.trim().length() > 0) {
      MDC.put(USERKEY, username);
      return true;
    }
    return false;
  }
}