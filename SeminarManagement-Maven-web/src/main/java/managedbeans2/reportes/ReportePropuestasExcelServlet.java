package managedbeans2.reportes;

import entities.ComisionRevisora;
import entities.Propuesta;
import entities.Semestre;
import entities.SemestreActual;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;
import static util.SMUtil.csvTextToExcel;

/**
 *
 * @author stateless
 */
@WebServlet(urlPatterns = {"/ReportePropuestas"})
public class ReportePropuestasExcelServlet extends HttpServlet {
    
    @EJB
    private SemestreActualFacadeLocal semActFacade;
    
    @EJB
    private ComisionRevisoraFacadeLocal revisoraFacade;
    
    @EJB
    private SemestreFacadeLocal semFacade;
    
    @EJB
    private PropuestaFacadeLocal propFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StringBuilder sb = new StringBuilder();
        SemestreActual semestreActual = null;
        try  {
            List<SemestreActual> sems = semActFacade.findAll();
            if ( !sems.isEmpty() ){
                semestreActual = sems.get(0);
            }
            sb.append("Alumno\tCarrera\tTítulo Propuesta\tProfesor Guía\t")
                    .append("Fecha Entrega Propuesta\tProfesor Revisor 1\tEntrega\t")
                    .append("Devolución\tProfesor Revisor 2\tEntrega\tDevolución\n");
            /*
            if (semestreActual.getSemestreActual() != null) {
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
                    
                    sb.append(salida).append("\n");
                }
            } else {
            }*/
            Semestre sem = semFacade.findOneById(semestreActual.getSemestreActual());
            List<Propuesta> propuestas = sem.getPropuestaList();
            List<Propuesta> propASacar = new ArrayList<>();

            for (Propuesta propuesta : propuestas) {
                if ( propuesta.getIdRevisora() != null ){
                    if ( propuesta.getIdRevisora().getTipoRevision() == 2 || // consejo
                            propuesta.getIdRevisora().getTipoRevision() == 1 ){ // seminario
                        propASacar.add(propuesta);
                    }
                }
            }
            
            propuestas.removeAll(propASacar);
            
            for (Propuesta prop : propuestas) {
                
                String salida =
                            prop.getRutAlumno().getNombreAlumno() + " "
                            + prop.getRutAlumno().getApellidoAlumno();
                    
                    if ( prop.getPlanActivo() == null)
                        salida += "\t" ;
                    else
                        salida += "\t" + prop.getPlanActivo().getCodigo();
                    
                    salida += "\t" + prop.getNombrePropuesta();
                    salida += "\t" + prop.getProfesorGuia().getNombreProfesor() + " "
                            + prop.getProfesorGuia().getApellidoProfesor();
                    salida += "\t" + prop.getFechaPropuesta();
                    
                    if ( prop.getProfesorRevisor1() != null){
                        salida += "\t" + prop.getProfesorRevisor1().getNombreProfesor() + " "
                                + prop.getProfesorRevisor1().getApellidoProfesor();
                        
                        if ( prop.getIdRevisora().getFechaRevision() != null )
                            salida += "\t" + prop.getIdRevisora().getFechaRevision();
                        else
                            salida += "\t";
                        
                        if ( prop.getIdRevisora().getFechaEntregaRevision() != null )
                            salida += "\t" + prop.getIdRevisora().getFechaEntregaRevision();
                        else
                            salida += "\t";
                        
                    } else
                        salida += "\t\t\t";
                    
                    if ( prop.getProfesorRevisor2() != null){
                        salida += "\t" + prop.getProfesorRevisor2().getNombreProfesor() + " "
                                + prop.getProfesorRevisor2().getApellidoProfesor();
                        
                        if ( prop.getIdRevisora().getFechaRevision2() != null )
                            salida += "\t" + prop.getIdRevisora().getFechaRevision2();
                        else
                            salida += "\t";
                        
                        if ( prop.getIdRevisora().getFechaEntregaRevision2() != null )
                            salida += "\t" + prop.getIdRevisora().getFechaEntregaRevision2();
                        else
                            salida += "\t";
                        
                    } else
                        salida += "\t\t\t";
                    
                    sb.append(salida).append("\n");
            }

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            Date date = new Date();
            String file_name = "Seguimiento Revision Propuestas " + 
                    semestreActual.getSemestreActual().replace("/", "-") +
                    " "+ dateFormat.format(date) + ".xlsx";
            response.setHeader("Content-Disposition", "attachment; filename=\"" + file_name + "\"");
            
            ServletOutputStream sos;
            sos = response.getOutputStream();
            XSSFWorkbook wb = csvTextToExcel(sb.toString());
            wb.write(sos);
            
        } catch(Exception ex){
            ex.printStackTrace();
            response.setContentType("text/html");
            PrintWriter writer = response.getWriter();
            writer.println("No disponible<br>");
            writer.println("<pre>");
            writer.println("</pre>");
        } finally {
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
