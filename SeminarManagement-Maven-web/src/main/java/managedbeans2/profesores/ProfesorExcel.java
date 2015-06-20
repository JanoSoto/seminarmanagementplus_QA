package managedbeans2.profesores;

import clases.PropuestaDatos;
import clases.TemaDatos;
import entities.Profesor;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(urlPatterns = {"/Profesor"})
public class ProfesorExcel extends HttpServlet {
    
    @EJB
    private SemestreActualFacadeLocal semActFacade;
    
    @EJB
    TemaFacadeLocal temasFacade;
    
    @Inject
    VerProfesorMB profesorMB;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StringBuilder sb = new StringBuilder();
        try  {
            if (profesorMB.getProfesor() == null) {
                if (request.getParameter("id") != null) {   
                    profesorMB.setRutProfesor(request.getParameter("id"));
                    profesorMB.buscarProfesor();
                } else {
                    throw new NullPointerException("No se especificó una propuesta");
                }
            }
            
            Profesor profe = profesorMB.getProfesor();
            
            sb.append("Datos Profesor\n");
            
            sb.append("Nombre\t");
            if ( profe.getNombreProfesor() != null)
                sb.append(profe.getNombreProfesor()).append(" ");
            if ( profe.getApellidoProfesor() != null)
                sb.append(profe.getApellidoProfesor());
            sb.append("\n");
            
            sb.append("Rut\t");
            if ( profe.getRutFormateadoProfesor() != null )
                sb.append(profe.getRutFormateadoProfesor());
            sb.append("\n");
            
            sb.append("E-mail\t");
            if  ( profe.getMailProfesor() != null )
                sb.append(profe.getMailProfesor());
            sb.append("\n");
            
            sb.append("Fono\t");
            if ( profe.getTelefonoProfesor() != null )
                sb.append(profe.getTelefonoProfesor());
            sb.append("\n");
            
            sb.append("Contrato\t");
            if ( profe.getContrato() != null ){
                if (profe.getContrato() == 1) {
                    sb.append("Jornada Completa");
                } else if (profe.getContrato() == 0) {
                    sb.append("Profesor Externo");
                } else {
                    //pw.print();
                }
            }
            sb.append("\n");
            
            sb.append("Jerarquía o categoría\t");
            if ( profe.getJerarquiaCategoria() != null ){
                sb.append( profe.getJerarquiaCategoria() );
            }
            sb.append("\n\n");
            
            sb.append("\t\tTemas Vigentes ").append(profesorMB.getSemestreActual()).append("\n");
            if ( profesorMB.getTemaDatos().isEmpty() ){
                sb.append("\t\tNo se encontraron temas\n");
            } else {
                sb.append("\t\tTítulo\tAlumno\n");
                for (TemaDatos temaDato : profesorMB.getTemaDatos()) {
                    sb.append("\t\t").append(temaDato.getNombreTema()).append("\t")
                            .append(temaDato.getAlumno().getNombreAlumno()).append(" ")
                            .append(temaDato.getAlumno().getApellidoAlumno()).append("\n");
                }
            }
            sb.append("\n");
            
            sb.append("\t\tTemas Prorrogados ").append(profesorMB.getSemestreActual()).append("\n");
            if ( profesorMB.getTemaDatosProrrogados().isEmpty() ){
                sb.append("\t\tNo se encontraron temas\n");
            } else {
                sb.append("\t\tTítulo\tAlumno\n");
                for (TemaDatos temaDato : profesorMB.getTemaDatosProrrogados()) {
                    sb.append("\t\t").append(temaDato.getNombreTema()).append("\t")
                            .append(temaDato.getAlumno().getNombreAlumno()).append(" ")
                            .append(temaDato.getAlumno().getApellidoAlumno()).append("\n");
                }
            }
            sb.append("\n");
            
            sb.append("\t\tParticipación Comisión Correctora ").append(profesorMB.getSemestreActual()).append("\n");
            if ( profesorMB.getTemaDatosCorrectora().isEmpty() ){
                sb.append("\t\tNo se encontraron temas\n");
            } else {
                sb.append("\t\tTítulo\tAlumno\n");
                for (TemaDatos temaDato : profesorMB.getTemaDatosCorrectora()) {
                    sb.append("\t\t").append(temaDato.getNombreTema()).append("\t")
                            .append(temaDato.getAlumno().getNombreAlumno()).append(" ")
                            .append(temaDato.getAlumno().getApellidoAlumno());
                }
            }
            sb.append("\n");
            
            sb.append("\t\tParticipación Comisión Correctora ").append(profesorMB.getSemestreAnterior()).append("\n");
            if ( profesorMB.getTemaDatosCorrectoraSemViejo().isEmpty() ){
                sb.append("\t\tNo se encontraron temas\n");
            } else {
                sb.append("\t\tTítulo\tAlumno\n");
                for (TemaDatos temaDato : profesorMB.getTemaDatosCorrectoraSemViejo()) {
                    sb.append("\t\t").append(temaDato.getNombreTema())
                            .append("\t").append(temaDato.getAlumno().getNombreAlumno()).append(" ")
                            .append(temaDato.getAlumno().getApellidoAlumno()).append("\n");
                }
            }
            sb.append("\n");
            
            sb.append("\t\tParticipación Comisión Revisora ").append(profesorMB.getSemestreActual()).append("\n");
            if ( profesorMB.getPropuestaDatosRevisora().isEmpty() ){
                sb.append("\t\tNo se encontraron propuestas\n");
            } else {
                sb.append("\t\tTítulo\tAlumno\n");
                for (PropuestaDatos propDato : profesorMB.getPropuestaDatosRevisora()) {
                    sb.append("\t\t").append(propDato.getNombrePropuesta()).append("\t")
                            .append(propDato.getAlumno().getNombreAlumno()).append(" ")
                            .append(propDato.getAlumno().getApellidoAlumno()).append("\n");
                }
            }
            sb.append("\n");
            
            sb.append("\t\tParticipación Comisión Revisora ").append(profesorMB.getSemestreAnterior()).append("\n");
            if ( profesorMB.getPropuestaDatosRevisoraViejo().isEmpty() ){
                sb.append("\t\tNo se encontraron propuestas\n");
            } else {
                sb.append("\t\tTítulo\tAlumno\n");
                for (PropuestaDatos temaDato : profesorMB.getPropuestaDatosRevisoraViejo()) {
                    sb.append("\t\t").append(temaDato.getNombrePropuesta()).append("\t")
                            .append(temaDato.getAlumno().getNombreAlumno()).append(" ")
                            .append(temaDato.getAlumno().getApellidoAlumno()).append("\n");
                }
            }
            sb.append("\n");
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            Date date = new Date();
            String fileName = "Informe Profesor - " + profe.getNombreProfesor() + " " + profe.getApellidoProfesor() + " - " + dateFormat.format(date) + ".xlsx";
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            response.setContentType("application/vnd.ms-excel");
            
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
            //pw.close();
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
