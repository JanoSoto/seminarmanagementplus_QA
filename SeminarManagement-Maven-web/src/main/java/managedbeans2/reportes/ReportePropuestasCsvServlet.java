package managedbeans2.reportes;

import entities.ComisionRevisora;
import entities.SemestreActual;
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
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;

/**
 *
 * @author stateless
 */
@WebServlet(urlPatterns = {"/ReportePropuestas"})
public class ReportePropuestasCsvServlet extends HttpServlet {
    
    @EJB
    private SemestreActualFacadeLocal semActFacade;
    
    @EJB
    private ComisionRevisoraFacadeLocal revisoraFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter pw = response.getWriter();
        SemestreActual semestreActual = null;
        try  {
            List<SemestreActual> sems = semActFacade.findAll();
            if ( !sems.isEmpty() ){
                semestreActual = sems.get(0);
            }
            pw.println("Alumno\tCarrera\tTítulo Propuesta\tProfesor Guía\t"
                    + "Fecha Entrega Propuesta\tProfesor Revisor 1\tEntrega\t"
                    + "Devolución\tProfesor Revisor 2\tEntrega\tDevolución");
            for (ComisionRevisora  com : revisoraFacade.findBySemestre(semestreActual.getSemestreActual())) {
                if ( com.getTipoRevision() == 2)
                    continue;

                String salida =
                        com.getIdPropuesta().getRutAlumno().getNombreAlumno() + " "
                        + com.getIdPropuesta().getRutAlumno().getApellidoAlumno();
                
                if ( com.getIdPropuesta().getRutAlumno().getPlanActivo() == null)
                    salida += "\t" ;
                else 
                    salida += "\t" + com.getIdPropuesta().getRutAlumno().getPlanActivo().getCodigo();
                
                salida += "\t" + com.getIdPropuesta().getNombrePropuesta();
                salida += "\t" + com.getGuia().getNombreProfesor() + " "
                        + com.getGuia().getApellidoProfesor();
                salida += "\t" + com.getIdPropuesta().getFechaPropuesta();
                
                if ( com.getRevisor1() != null){
                    salida += "\t" + com.getRevisor1().getNombreProfesor() + " "
                        + com.getRevisor1().getApellidoProfesor();
                    
                    if ( com.getFechaRevision() != null )
                        salida += "\t" + com.getFechaRevision();
                    else
                        salida += "\t";
                    
                    if ( com.getFechaEntregaRevision() != null )
                        salida += "\t" + com.getFechaEntregaRevision();
                    else
                        salida += "\t";
                    
                } else
                    salida += "\t\t\t";
                
                if ( com.getRevisor2() != null){
                    salida += "\t" + com.getRevisor2().getNombreProfesor() + " "
                        + com.getRevisor2().getApellidoProfesor();
                    
                    if ( com.getFechaRevision2() != null )
                        salida += "\t" + com.getFechaRevision2();
                    else
                        salida += "\t";
                    
                    if ( com.getFechaEntregaRevision2() != null )
                        salida += "\t" + com.getFechaEntregaRevision2();
                    else
                        salida += "\t";
                    
                } else
                    salida += "\t\t\t";
                
                pw.println(salida);
            }

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            Date date = new Date();
            String file_name = "Seguimiento Revision Propuestas " + 
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
