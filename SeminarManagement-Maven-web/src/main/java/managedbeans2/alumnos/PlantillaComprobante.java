/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.alumnos;

import managedbeans2.temas.*;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import entities.Alumno;
import entities.PlanEstudio;
import entities.Profesor;
import entities.Tema;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBElement;
import org.apache.commons.lang.WordUtils;
import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.io3.Save;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import org.docx4j.wml.ContentAccessor;
import util.SMUtil;

/**
 *
 * @author xarly
 */
@WebServlet(name = "PlantillaComprobante", urlPatterns = {"/DocComprobante"})
public class PlantillaComprobante extends HttpServlet {

    public String TEMPLATE_LOCATION = "/resources/plantillas/plantilla_pago.docx";

    @Inject
    VerAlumnoMB alumnoMB;

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
            throws ServletException, IOException, Docx4JException, Exception {

        try {
            if (alumnoMB.getAlumno()== null) {
                if (request.getParameter("id") != null) {
                    alumnoMB.setRutAlumno(request.getParameter("id"));
                    alumnoMB.buscarAlumno();
                    if (alumnoMB.getAlumno()== null) {
                        throw new NullPointerException("No se encontró el alumno");
                    }
                } else {
                    throw new NullPointerException("No se especificó un alumno");
                }
            }

            Alumno alumno = alumnoMB.getAlumno();
            String fileName = "" + "ComprobantePago_"
                    + alumno.getApellidoAlumno().replace(" ", "-") + "_"
                    + alumno.getRutAlumno() + ".docx";

            response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document;charset=UTF-8");
            response.setHeader("Content-disposition", "filename=" + fileName);

            String nombreAlumno = WordUtils.capitalizeFully("" + alumno.getNombreAlumno());
            String apellidoAlumno = alumno.getApellidoAlumno();
            String apellidoPAlumno, apellidoMAlumno = "";
            if(apellidoAlumno.contains(" ")){
                apellidoPAlumno = WordUtils.capitalizeFully("" + alumno.getApellidoAlumno().split(" ")[0]);
                apellidoMAlumno = WordUtils.capitalizeFully("" + alumno.getApellidoAlumno().split(" ")[1]);
            } else {
                apellidoPAlumno = WordUtils.capitalizeFully("" + alumno.getApellidoAlumno());
            }
           
            String rutAlumno = alumno.getRutAlumnoFormateado();
            WordprocessingMLPackage template;
            try (InputStream resourceUrl = getServletContext().getResourceAsStream(TEMPLATE_LOCATION)) {
                template = WordprocessingMLPackage.load(resourceUrl);
                resourceUrl.close();
            }

            MainDocumentPart dsa = template.getMainDocumentPart();
            replaceText(dsa,
                    nombreAlumno,
                    apellidoPAlumno,
                    apellidoMAlumno,
                    rutAlumno);

            Save saver = new Save(template);

            saver.save(response.getOutputStream());

        } catch (Exception e) {
            System.out.println(e);
            response.setContentType("text/html");
            PrintWriter writer = response.getWriter();
            writer.println("Documento no disponible<br>");
            writer.println("<pre>");
            writer.println("</pre>");
        }
    }

    /**
     * Busca y reemplaza el texto en contenido de un docx
     *
     * @param c
     * @param alumno
     * @param carrera
     * @param guia
     * @param fecha
     * @param ubicacion
     * @throws Exception
     */
    private void replaceText(ContentAccessor c, String nombre, String apellidoP,
            String apellidoM, String rut)
            throws Exception {
        for (Object p : c.getContent()) {
            if (p instanceof ContentAccessor) {
                replaceText((ContentAccessor) p, nombre, apellidoP, apellidoM,
                        rut);
            } else if (p instanceof JAXBElement) {
                Object v = ((JAXBElement) p).getValue();

                if (v instanceof ContentAccessor) {
                    replaceText((ContentAccessor) v, nombre, apellidoP, apellidoM,
                            rut);
                } else if (v instanceof org.docx4j.wml.Text) {
                    org.docx4j.wml.Text t = (org.docx4j.wml.Text) v;
                    String text = t.getValue();

                    if (text.compareTo("nombreAlumno") == 0) {
                        t.setValue(nombre);
                    } else if (text.compareTo("apellidoPAlumno") == 0) {
                        t.setValue(apellidoP);
                    } else if (text.compareTo("apellidoMAlumno") == 0) {
                        t.setValue(apellidoM);
                    } else if (text.compareTo("rutAlumno") == 0) {
                        t.setValue(rut);
                    } 
                }
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
            Logger.getLogger(PlantillaComprobante.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(PlantillaComprobante.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(PlantillaComprobante.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(PlantillaComprobante.class.getName()).log(Level.SEVERE, null, ex);
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
