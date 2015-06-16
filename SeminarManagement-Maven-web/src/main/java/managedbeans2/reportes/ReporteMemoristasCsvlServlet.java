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
@WebServlet(urlPatterns = {"/ReporteMemoristas"})
public class ReporteMemoristasCsvlServlet extends HttpServlet {
    
    @EJB
    private SemestreActualFacadeLocal semActFacade;
    
    @EJB
    TemaFacadeLocal temasFacade;
    
    @Inject
    ReportesMB reportesMB;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter pw = response.getWriter();
        SemestreActual semestreActual = null;
        try  {
            List<SemestreActual> sems = semActFacade.findAll();
            if ( !sems.isEmpty() ){
                semestreActual = sems.get(0);
            }
            
            reportesMB.findTemasMemoristas();
            
            
            pw.print(" \t");
            for (int i = 0; i < reportesMB.getPlanes().size(); i++) {
                if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                    pw.print(reportesMB.getPlanes().get(i).getCodigo()+"\t");
            }
            pw.print("Grand Total\n");
            
            for (int j= 0; j < reportesMB.getProfesoresJC().size(); j++) {
                
                if ( j == 0 && reportesMB.getCuentaPorPlanJC().get(reportesMB.getCuentaPorPlanJC().size() - 1 )>0)
                    pw.print("JC");
                
                if ( reportesMB.getCuentaTotalPorProfeJC().get(j) == 0 )
                    continue;

                pw.print("\t");

                pw.print(reportesMB.getProfesoresJC().get(j).getNombreProfesor()+" "+reportesMB.getProfesoresJC().get(j).getApellidoProfesor()+"\t");
                for (int i = 0; i < reportesMB.getPlanes().size(); i++) {
                    if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                        pw.print(reportesMB.getCuentaPorProfeJC().get(j).get(i)+"\t");
                }
                pw.print(reportesMB.getCuentaTotalPorProfeJC().get(j)+"\n");
            }
           
            pw.print("JC Total\t");
            for (int i = 0; i < reportesMB.getCuentaPorPlanJC().size()-1; i++) {
                if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                    pw.print(reportesMB.getCuentaPorPlanJC().get(i) + "\t");
            }
            pw.print( reportesMB.getCuentaPorPlanJC().get( reportesMB.getCuentaPorPlanJC().size() - 1) + "\n");
            
            for (int j= 0; j < reportesMB.getProfesoresPH().size(); j++) {
                
                if ( j == 0 && reportesMB.getCuentaPorPlanPH().get(reportesMB.getCuentaPorPlanPH().size() - 1 )>0)
                    pw.print("PPH");
                
                if ( reportesMB.getCuentaTotalPorProfePH().get(j) == 0 )
                    continue;

                pw.print("\t");

                pw.print(reportesMB.getProfesoresPH().get(j).getNombreProfesor()+" "+reportesMB.getProfesoresPH().get(j).getApellidoProfesor()+"\t");
                for (int i = 0; i < reportesMB.getPlanes().size(); i++) {
                    if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                        pw.print(reportesMB.getCuentaPorProfePH().get(j).get(i)+"\t");
                }
                pw.print(reportesMB.getCuentaTotalPorProfePH().get(j)+"\n");
            }
            
            pw.print("PPH Total\t");
            for (int i = 0; i < reportesMB.getCuentaPorPlanPH().size()-1; i++) {
                if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                    pw.print(reportesMB.getCuentaPorPlanPH().get(i) + "\t");
            }
            pw.print( reportesMB.getCuentaPorPlanPH().get( reportesMB.getCuentaPorPlanPH().size() - 1) + "\n");
            
            pw.print("Grand Total\t");
            for (int i = 0; i < reportesMB.getCuentaPorPlanTotal().size()-1; i++) {
                if ( reportesMB.getCuentaPorPlanTotal().get(i) > 0)
                    pw.print(reportesMB.getCuentaPorPlanTotal().get(i) + "\t");
            }
            pw.print( reportesMB.getCuentaPorPlanTotal().get( reportesMB.getCuentaPorPlanTotal().size() - 1) + "\n");

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            Date date = new Date();
            String file_name = "Cantidad de Memoristas por Profesor " + 
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
