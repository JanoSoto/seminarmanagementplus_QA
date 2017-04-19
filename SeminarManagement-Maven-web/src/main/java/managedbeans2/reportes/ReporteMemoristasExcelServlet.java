package managedbeans2.reportes;

import entities.SemestreActual;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.TemaFacadeLocal;
import static util.SMUtil.csvTextToExcel;

/**
 *
 * @author stateless
 */
@WebServlet(urlPatterns = {"/ReporteMemoristas"})
public class ReporteMemoristasExcelServlet extends HttpServlet {
    
    @EJB
    private SemestreActualFacadeLocal semActFacade;
    
    @EJB
    TemaFacadeLocal temasFacade;
    
    @Inject
    ReportesMB reportesMB;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StringBuilder sb = new StringBuilder();
        SemestreActual semestreActual = null;
        try  {
            List<SemestreActual> sems = semActFacade.findAll();
            if ( !sems.isEmpty() ){
                semestreActual = sems.get(0);
            }
            
            reportesMB.findTemasMemoristas();
            
            
            sb.append("\t\t");
            for (int i = 0; i < reportesMB.getPlanes().size(); i++) {
                if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                    sb.append(reportesMB.getPlanes().get(i).getCodigo()).append("\t");
            }
            sb.append("Grand Total\n");
            
            for (int j= 0; j < reportesMB.getProfesoresJC().size(); j++) {
                
                if ( j == 0 && reportesMB.getCuentaPorPlanJC().get(reportesMB.getCuentaPorPlanJC().size() - 1 )>0)
                    sb.append("JC");
                
                if ( reportesMB.getCuentaTotalPorProfeJC().get(j) == 0 )
                    continue;

                sb.append("\t");

                sb.append(reportesMB.getProfesoresJC().get(j).getNombreProfesor()).append(" ").append(reportesMB.getProfesoresJC().get(j).getApellidoProfesor()).append("\t");
                for (int i = 0; i < reportesMB.getPlanes().size(); i++) {
                    if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                        sb.append(reportesMB.getCuentaPorProfeJC().get(j).get(i)).append("\t");
                }
                sb.append(reportesMB.getCuentaTotalPorProfeJC().get(j)).append("\n");
            }
           
            sb.append("JC Total\t\t");
            for (int i = 0; i < reportesMB.getCuentaPorPlanJC().size()-1; i++) {
                if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                    sb.append(reportesMB.getCuentaPorPlanJC().get(i)).append("\t");
            }
            sb.append(reportesMB.getCuentaPorPlanJC().get( reportesMB.getCuentaPorPlanJC().size() - 1)).append("\n");
            
            for (int j= 0; j < reportesMB.getProfesoresPH().size(); j++) {
                
                if ( j == 0 && reportesMB.getCuentaPorPlanPH().get(reportesMB.getCuentaPorPlanPH().size() - 1 )>0)
                    sb.append("PPH");
                
                if ( reportesMB.getCuentaTotalPorProfePH().get(j) == 0 )
                    continue;

                sb.append("\t");

                sb.append(reportesMB.getProfesoresPH().get(j).getNombreProfesor()).append(" ").append(reportesMB.getProfesoresPH().get(j).getApellidoProfesor()).append("\t");
                for (int i = 0; i < reportesMB.getPlanes().size(); i++) {
                    if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                        sb.append(reportesMB.getCuentaPorProfePH().get(j).get(i)).append("\t");
                }
                sb.append(reportesMB.getCuentaTotalPorProfePH().get(j)).append("\n");
            }
            
            sb.append("PPH Total\t\t");
            for (int i = 0; i < reportesMB.getCuentaPorPlanPH().size()-1; i++) {
                if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                    sb.append(reportesMB.getCuentaPorPlanPH().get(i)).append("\t");
            }
            sb.append(reportesMB.getCuentaPorPlanPH().get( reportesMB.getCuentaPorPlanPH().size() - 1)).append("\n");
            
            sb.append("Grand Total\t\t");
            for (int i = 0; i < reportesMB.getCuentaPorPlanTotal().size()-1; i++) {
                if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                    sb.append(reportesMB.getCuentaPorPlanTotal().get(i)).append("\t");
            }
            sb.append(reportesMB.getCuentaPorPlanTotal().get( reportesMB.getCuentaPorPlanTotal().size() - 1)).append("\n");

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            Date date = new Date();
            String file_name = "Cantidad de Memoristas por Profesor " + 
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
