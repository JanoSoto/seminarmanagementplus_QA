/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package managedbeans2.temas;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import entities.Alumno;
import entities.Profesor;
import entities.Tema;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.SMUtil;

/**
 *
 * @author xarly
 */
@WebServlet(name = "PlantillaAntecedentes", urlPatterns = {"/PdfAntecedentes"})
public class PlantillaAntecedentes extends HttpServlet {

    public String TEMPLATE_LOCATION = "/resources/plantillas/plantilla_antecedentes.pdf";
    
    @Inject
    VerTemaMB temaMB;
    
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
            throws ServletException, IOException, DocumentException {
        response.setContentType("text/html;charset=UTF-8");
        ByteArrayOutputStream baosPDF = null;
        
        try {
            if (temaMB.getIdTema() == null){
                if (request.getParameter("id") != null){
                    temaMB.setIdTema(Integer.parseInt(request.getParameter("id")));
                    temaMB.buscarTema();
                } else {
                    throw new NullPointerException("No se especificó un tema");
                }
            }

            Tema tema = temaMB.getTema();
            Alumno alumno = temaMB.getAlumno();
            
            InputStream resourceUrl = getServletContext().getResourceAsStream(TEMPLATE_LOCATION);

            baosPDF = new ByteArrayOutputStream();
            PdfReader pdfTemplate = new PdfReader(resourceUrl);
            PdfStamper stamper = new PdfStamper(pdfTemplate, baosPDF);
            stamper.setFormFlattening(true);
            
            stamper.getAcroFields().setField("nombreAlumno", alumno.getNombreAlumno());
            stamper.getAcroFields().setField("apellidoAlumno", alumno.getApellidoAlumno());
            stamper.getAcroFields().setField("rutAlumno", alumno.getRutAlumnoFormateado());
            stamper.getAcroFields().setField("mailAlumno", alumno.getMailAlumno());
            stamper.getAcroFields().setField("direccionAlumno", alumno.getDireccionAlumno());
            stamper.getAcroFields().setField("comunaAlumno", alumno.getUsuario().getComuna().getComunaNombre());
            stamper.getAcroFields().setField("telefonoAlumno", alumno.getTelefonoAlumno());
            
            stamper.getAcroFields().setField("nombreMemoria", tema.getNombreTema());
            
            Profesor guia = temaMB.getGuia();
            StringBuilder str = new StringBuilder("");
            if (guia != null){
                str.append(SMUtil.reducirNombre( guia.getNombreProfesor(), guia.getApellidoProfesor(), 30));
            }
            stamper.getAcroFields().setField("profesorGuia", str.toString());
           
            Profesor corrector1 = temaMB.getCorrector1(), 
                    corrector2 = temaMB.getCorrector2();

            if (corrector1 != null){
                str = new StringBuilder(SMUtil.reducirNombre( corrector1.getNombreProfesor(), corrector1.getApellidoProfesor(), 20));
                stamper.getAcroFields().setField("profesorCorr1", str.toString());
            }
            
            if ( corrector2 != null ){
                str = new StringBuilder(SMUtil.reducirNombre( corrector2.getNombreProfesor(), corrector2.getApellidoProfesor(), 20));
                stamper.getAcroFields().setField("profesorCorr2", str.toString());
            }
            
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
                .append("Antecedentes_")
                .append(alumno.getRutAlumno())
                .append(".pdf");

            response.setHeader("Content-disposition", sbContentDispValue.toString());
            response.setContentLength(baosPDF.size());
            ServletOutputStream sos;
            sos = response.getOutputStream();
            baosPDF.writeTo(sos);
            sos.flush();
            
        } catch (NumberFormatException | NullPointerException | DocumentException | IOException dex) {
            
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
        try {
            processRequest(request, response);
        } catch (DocumentException ex) {
            Logger.getLogger(PlantillaAntecedentes.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (DocumentException ex) {
            Logger.getLogger(PlantillaAntecedentes.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
