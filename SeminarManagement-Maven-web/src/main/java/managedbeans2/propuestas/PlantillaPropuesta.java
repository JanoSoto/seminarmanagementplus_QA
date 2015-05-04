package managedbeans2.propuestas;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import entities.Alumno;
import entities.Profesor;
import entities.Propuesta;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author stateless
 */
@WebServlet(name = "PlantillaPropuesta", urlPatterns = {"/PdfPropuesta"})
public class PlantillaPropuesta extends HttpServlet {

    public String TEMPLATE_LOCATION = "/resources/plantillas/plantilla_propuesta.pdf";
    
    @Inject
    VerPropuestaMB propuestaMB;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ByteArrayOutputStream baosPDF = null;
        
        try {
            if (propuestaMB.getIdPropuesta() == null){
                if (request.getParameter("id") != null){
                    propuestaMB.setIdPropuesta(Integer.parseInt(request.getParameter("id")));
                    propuestaMB.buscarPropuesta();
                } else {
                    throw new NullPointerException("No se especificó una propuesta");
                }
            }

            Propuesta prop = propuestaMB.getPropuesta();
            Alumno alumno = propuestaMB.getAlumno();
            
            InputStream resourceUrl = getServletContext().getResourceAsStream(TEMPLATE_LOCATION);
            System.out.println(resourceUrl);
            baosPDF = new ByteArrayOutputStream();
            PdfReader pdfTemplate = new PdfReader(resourceUrl);
            PdfStamper stamper = new PdfStamper(pdfTemplate, baosPDF);
            stamper.setFormFlattening(true);
            
            StringBuilder str = new StringBuilder();
            str.append("PROPUESTA DE TEMA DE ");
            str.append( alumno.getCarreraAlumno() == 0 ?
                    "INGENIERIA CIVIL EN INFORMATICA - " :
                    "INGENIERIA DE EJECUCION EN COMPUTACION E INFORMATICA - ");
            str.append(prop.getIdSemestre().getIdSemestre().replace("/", "° "));
            
            stamper.getAcroFields().setField("doc_title", str.toString());
            stamper.getAcroFields().setField("title", prop.getNombrePropuesta());
            
            str = new StringBuilder();
            str.append(alumno.getNombreAlumno()).append(" ").append(alumno.getApellidoAlumno());
            stamper.getAcroFields().setField("student_name", str.toString());
            
            Profesor guia = propuestaMB.getGuia();
            str = new StringBuilder("");
            if (guia != null){
                str.append(guia.getNombreProfesor()).append(" ")
                        .append(guia.getApellidoProfesor());
            }
            stamper.getAcroFields().setField("guide_proffesor", str.toString());
            
            Profesor coguia = propuestaMB.getCoguia();
            str = new StringBuilder("");
            if (coguia != null){
                str.append(coguia.getNombreProfesor()).append(" ")
                        .append(coguia.getApellidoProfesor());
            }
            stamper.getAcroFields().setField("co_guide_proffesor", str.toString());

            Profesor profComision1 = propuestaMB.getRevisor1();
            str = new StringBuilder("");
            if (profComision1 != null){
                str.append(profComision1.getNombreProfesor()).append(" ")
                        .append(profComision1.getApellidoProfesor());
            }
            stamper.getAcroFields().setField("commission_proffesor_1", str.toString());
            
            Profesor profComision2 = propuestaMB.getRevisor2();
            str = new StringBuilder();
            if (profComision2 != null){
                str.append(profComision2.getNombreProfesor())
                        .append(" ").append(profComision2.getApellidoProfesor());
            }       
            stamper.getAcroFields().setField("commission_proffesor_2", str.toString());
            
            //formatear el rut
            str = new StringBuilder(alumno.getRutAlumno());
            if (str.length() > 1){
                str.insert(str.length()-1, "-");
                if (str.length() > 5){
                    str.insert(str.length()-5, ".");
                    if (str.length() > 9){
                        str.insert(str.length()-9, ".");
                    }
                }
            }
            
            stamper.getAcroFields().setField("student_rut", str.toString());
            stamper.getAcroFields().setField("student_phone", alumno.getTelefonoAlumno());
            stamper.getAcroFields().setField("student_email", alumno.getMailAlumno());
            stamper.getAcroFields().setField("student_address", alumno.getDireccionAlumno());
            
            SimpleDateFormat formateador = new SimpleDateFormat("dd 'de' MMMM 'de' yyyy", new Locale("ES"));
            str = new StringBuilder("Santiago, ");
            Date date = new Date();
            str.append(formateador.format(date));
            stamper.getAcroFields().setField("date", str.toString());
            
            stamper.close();
            pdfTemplate.close();

            // Read the HTTP 1.1 specification for full details
            // about the Cache-Control header
            response.setHeader("Cache-Control", "max-age=30");
            response.setContentType("application/pdf");
            // The Content-disposition header is explained
            // in RFC 2183
            //    http://www.ietf.org/rfc/rfc2183.txt
            // The Content-disposition value will be in one of 
            // two forms:
            //   1)  inline; filename=foobar.pdf
            //   2)  attachment; filename=foobar.pdf
            // In this servlet, we use "inline"

            StringBuilder sbContentDispValue = new StringBuilder();
            sbContentDispValue.append("inline")
                .append("; filename=")
                .append("Propuesta_")
                .append(alumno.getRutAlumno())
                .append(".pdf");

            response.setHeader("Content-disposition", sbContentDispValue.toString());
            response.setContentLength(baosPDF.size());
            ServletOutputStream sos;
            sos = response.getOutputStream();
            baosPDF.writeTo(sos);
            sos.flush();
            
        } catch (NumberFormatException | NullPointerException | DocumentException | IOException dex) {
            System.out.println(dex);
            //LOGGER.error(dex);
            response.setContentType("text/html");
            PrintWriter writer = response.getWriter();
            writer.println("Documento no disponible<br>");
            writer.println("<pre>");
            writer.println("</pre>");
        } finally {
            if (baosPDF != null) {
                baosPDF.reset();
            }
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
        return "Retorna un archivo PDF desplegado en el navegador que contiene la información una propuesta de trabajo de título";
    }// </editor-fold>

}