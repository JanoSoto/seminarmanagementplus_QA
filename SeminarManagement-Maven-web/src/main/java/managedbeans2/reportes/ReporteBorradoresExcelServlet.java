package managedbeans2.reportes;

import entities.SemestreActual;
import entities.Tema;
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

/**
 *
 * @author stateless
 */
@WebServlet(urlPatterns = {"/ReporteBorradores"})
public class ReporteBorradoresExcelServlet extends HttpServlet {
    
    @EJB
    private SemestreActualFacadeLocal semActFacade;
    
    @EJB
    TemaFacadeLocal temasFacade;

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
                    + "Fecha Entrega Propuesta\tSemestre\tProfesor Revisor 1\tEntrega\t"
                    + "Devolución\tProfesor Revisor 2\tEntrega\tDevolución");
            for (Tema  tema : temasFacade.findByEstado(4)) {

                String salida =
                        tema.getIdRevisora().getIdPropuesta().getRutAlumno().getNombreAlumno() + " "
                        + tema.getIdRevisora().getIdPropuesta().getRutAlumno().getApellidoAlumno();
                
                if ( tema.getIdRevisora().getIdPropuesta().getRutAlumno().getPlanActivo() == null)
                    salida += "\t" ;
                else 
                    salida += "\t" + tema.getIdRevisora().getIdPropuesta().getRutAlumno().getPlanActivo().getCodigo();
                
                salida += "\t" + tema.getNombreTema();
                salida += "\t" + tema.getIdRevisora().getGuia().getNombreProfesor() + " "
                        + tema.getIdRevisora().getGuia().getApellidoProfesor();
                salida += "\t" + tema.getFechaTema();
                
                if (tema.getSemestreTermino() != null)
                    salida += "\t" + tema.getSemestreTermino();
                else
                    salida += "\t";
                
                if ( tema.getIdCorrectora() != null){
                    if ( tema.getIdCorrectora().getCorrector1() != null){
                        salida += "\t" + tema.getIdCorrectora().getCorrector1().getNombreProfesor() + " "
                            + tema.getIdCorrectora().getCorrector1().getApellidoProfesor();

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
                        salida += "\t" + tema.getIdCorrectora().getCorrector2().getNombreProfesor() + " "
                            + tema.getIdCorrectora().getCorrector2().getApellidoProfesor();

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
                    " "+ dateFormat.format(date) + ".xlsx";
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
