package managedbeans2.reportes;

import entities.SemestreActual;
import entities.Tema;
import entities.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.TemaFacadeLocal;
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author stateless
 */
@WebServlet(urlPatterns = {"/ReporteBorradores"})
public class ReporteBorradoresCsvServlet extends HttpServlet {
    
    @EJB
    private SemestreActualFacadeLocal semActFacade;
    
    @EJB
    private TemaFacadeLocal temasFacade;
    
    @EJB
    private UsuarioFacadeLocal usuarioFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter pw = response.getWriter();
        SemestreActual semestreActual = null;
        try  {
            List<SemestreActual> sems = semActFacade.findAll();
            if ( !sems.isEmpty() ){
                semestreActual = sems.get(0);
            }
            pw.println("Alumno\tCarrera\tTítulo Tema\tProfesor Guía\t"
                    + "Fecha Entrega Borrador\tSemestre\tProfesor Revisor 1\tEntrega\t"
                    + "Devolución\tProfesor Revisor 2\tEntrega\tDevolución");
            for (Tema  tema : temasFacade.findByEstado(4)) {
                Usuario us1 = usuarioFacade.findByRut(tema.getIdRevisora().getIdPropuesta().getRutAlumno().getRutAlumno()).get(0);
                String salida =
                        us1.getNombreUsuario() + " "
                        + us1.getApellidoUsuarioPaterno();
                
                if ( tema.getIdRevisora().getIdPropuesta().getRutAlumno().getPlanActivo() == null)
                    salida += "\t" ;
                else 
                    salida += "\t" + tema.getIdRevisora().getIdPropuesta().getRutAlumno().getPlanActivo().getCodigo();
                Usuario us2 = usuarioFacade.findByRut(tema.getIdRevisora().getGuia().getRutProfesor()).get(0);
                salida += "\t" + tema.getNombreTema();
                salida += "\t" + us2.getNombreUsuario() + " "
                        + us2.getNombreUsuario();
                salida += "\t" + tema.getFechaTema();
                
                if (tema.getIdSemestre().getIdSemestre() != null)
                    salida += "\t" + tema.getIdSemestre().getIdSemestre();
                else
                    salida += "\t";
                
                if ( tema.getIdCorrectora() != null){
                    if ( tema.getIdCorrectora().getCorrector1() != null){
                        Usuario us3 = usuarioFacade.findByRut(tema.getIdCorrectora().getCorrector1().getRutProfesor()).get(0);
                        salida += "\t" + us3.getNombreUsuario() + " "
                            + us3.getApellidoUsuarioPaterno();

                        if ( tema.getIdCorrectora().getFechaCorreccion() != null )
                            salida += "\t" + tema.getIdCorrectora().getFechaCorreccion();
                        else
                            salida += "\t";

                        if ( tema.getIdCorrectora().getFechaEntCorreccion()!= null )
                            salida += "\t" + tema.getIdCorrectora().getFechaEntCorreccion();
                        else
                            salida += "\t";

                    } else
                        salida += "\t\t\t";

                    if ( tema.getIdCorrectora().getCorrector2() != null){
                        Usuario us4 = usuarioFacade.findByRut(tema.getIdCorrectora().getCorrector2().getRutProfesor()).get(0);
                        salida += "\t" + us4.getNombreUsuario() + " "
                            + us4.getApellidoUsuarioPaterno();

                        if ( tema.getIdCorrectora().getFechaCorreccion2() != null )
                            salida += "\t" + tema.getIdCorrectora().getFechaCorreccion2();
                        else
                            salida += "\t";

                        if ( tema.getIdCorrectora().getFechaEntCorreccion2()!= null )
                            salida += "\t" + tema.getIdCorrectora().getFechaEntCorreccion2();
                        else
                            salida += "\t";

                    } else
                        salida += "\t\t\t";
                
                } else {
                    salida += "\t\t\t\t\t\t";
                }
                
                pw.println(salida);
            }

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            Date date = new Date();
            String file_name = "Seguimiento Revision Borradores " + 
                    semestreActual.getSemestreActual().replace("/", "-") +
                    " "+ dateFormat.format(date) + ".csv";
            response.setHeader("Content-Disposition", "attachment; filename=\"" + file_name + "\"");
            
        } catch(Exception ex){
            ex.printStackTrace();
            response.setContentType("text/html");
            PrintWriter writer = response.getWriter();
            writer.println("No disponible<br>");
            writer.println("<pre>");
            writer.println("</pre>");
        } finally {
            pw.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Retorna un archivo csv con la información de los temas vigentes para un profesor";
    }// </editor-fold>

}
