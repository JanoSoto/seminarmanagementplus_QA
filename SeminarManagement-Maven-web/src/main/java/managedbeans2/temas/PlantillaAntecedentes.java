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
@WebServlet(name = "PlantillaAntecedentes", urlPatterns = {"/DocAntecedentes"})
public class PlantillaAntecedentes extends HttpServlet {

    public String TEMPLATE_LOCATION = "/resources/plantillas/plantilla_antecedentes.docx";

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
            throws ServletException, IOException, Docx4JException, Exception {

        try {
            if (temaMB.getIdTema() == null) {
                if (request.getParameter("id") != null) {
                    temaMB.setIdTema(Integer.parseInt(request.getParameter("id")));
                    temaMB.buscarTema();
                    if (temaMB.getTema() == null) {
                        throw new NullPointerException("No se encontró el tema");
                    }
                } else {
                    throw new NullPointerException("No se especificó un tema");
                }
            }

            Alumno alumno = temaMB.getAlumno();
            Profesor guia = temaMB.getGuia();
            Profesor corr1 = temaMB.getCorrector1();
            Profesor corr2 = temaMB.getCorrector2();
            String fileName = "" + "AntecedentesFormularioTitulacion_"
                    + alumno.getApellidoAlumno().replace(" ", "-") + "_"
                    + alumno.getRutAlumno() + ".docx";

            response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document;charset=UTF-8");
            response.setHeader("Content-disposition", "filename=" + fileName);

            StringBuilder str = new StringBuilder();

            str.append(alumno.getNombreAlumno()).append(alumno.getApellidoAlumno());
            String nombreAlumno = WordUtils.capitalizeFully("" + alumno.getNombreAlumno());
            String apellidoAlumno = WordUtils.capitalizeFully("" + alumno.getApellidoAlumno());
            String comunaAlumno = WordUtils.capitalizeFully("" + alumno.getUsuario().getComuna().getComunaNombre());
            String mailAlumno = WordUtils.capitalizeFully("" + alumno.getMailAlumno());
            String direccionAlumno = WordUtils.capitalizeFully("" + alumno.getDireccionAlumno());
            String telefonoAlumno = WordUtils.capitalizeFully("" + alumno.getTelefonoAlumno());
            String tituloMemoria = WordUtils.capitalizeFully("" + temaMB.getTema().getNombreTema());
            String profeGuia = WordUtils.capitalizeFully(
                    "" + guia.getNombreProfesor() + " " + guia.getApellidoProfesor());
            String profeCorr1;
            try{
                profeCorr1 = WordUtils.capitalizeFully(
                    "" + corr1.getNombreProfesor() + " " + corr1.getApellidoProfesor());
            } catch(NullPointerException e){
                profeCorr1 = "";
            }
            String profeCorr2;
            try{
                profeCorr2 = WordUtils.capitalizeFully(
                    "" + corr2.getNombreProfesor() + " " + corr2.getApellidoProfesor());
            } catch(NullPointerException e){
                profeCorr2 = "";
            }
            String rutAlumno = alumno.getRutAlumnoFormateado();
            String carrera = "";
            String ubicacion = "El documento se encuentra en el casillero de Ingeniería ";
            List<PlanEstudio> planes = alumno.getPlanes();
            if (!planes.isEmpty()) {
                if (planes.get(0).getCarreraId() != null) {
                    if (planes.get(0).getCarreraId().getNombre().contains("CIVIL")) {
                        carrera += "Ing. Civil Informática, ";
                        ubicacion += "Civil";
                    } else if (planes.get(0).getCarreraId().getNombre().contains("EJECUCIÓN")) {
                        carrera += "Ing. De Ejecución en Computación e Informática, ";
                        ubicacion += "de Ejecución";
                    }
                }
                if (planes.get(0).getJornada() == 0) {
                    carrera += "Diurna";
                } else if (planes.get(0).getJornada() == 1) {
                    carrera += "Vespertina";
                } else if (planes.get(0).getJornada() == 2) {
                }
            }

            SimpleDateFormat formateador = new SimpleDateFormat("dd 'de' MMMM 'de' yyyy", new Locale("ES"));
            String fecha = "Santiago, " + formateador.format(new Date());

            WordprocessingMLPackage template;
            try (InputStream resourceUrl = getServletContext().getResourceAsStream(TEMPLATE_LOCATION)) {
                template = WordprocessingMLPackage.load(resourceUrl);
                resourceUrl.close();
            }

            MainDocumentPart dsa = template.getMainDocumentPart();
            replaceText(dsa,
                    nombreAlumno,
                    apellidoAlumno,
                    rutAlumno,
                    direccionAlumno,
                    comunaAlumno,
                    mailAlumno,
                    telefonoAlumno,
                    tituloMemoria,
                    profeGuia,
                    profeCorr1,
                    profeCorr2);

            Save saver = new Save(template);

            saver.save(response.getOutputStream());

        } catch (Exception e) {
            System.out.println("holi "+e);
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
    private void replaceText(ContentAccessor c, String nombre, String apellido,
            String rut, String direccion, String comuna, String mail,
            String telefono, String titulo, String guia, String corr1,
            String corr2)
            throws Exception {
        for (Object p : c.getContent()) {
            if (p instanceof ContentAccessor) {
                replaceText((ContentAccessor) p, nombre, apellido, rut,
                        direccion, comuna, mail, telefono, titulo, guia, corr1,
                        corr2);
            } else if (p instanceof JAXBElement) {
                Object v = ((JAXBElement) p).getValue();

                if (v instanceof ContentAccessor) {
                    replaceText((ContentAccessor) v, nombre, apellido, rut,
                            direccion, comuna, mail, telefono, titulo, guia, corr1,
                            corr2);
                } else if (v instanceof org.docx4j.wml.Text) {
                    org.docx4j.wml.Text t = (org.docx4j.wml.Text) v;
                    String text = t.getValue();

                    if (text.compareTo("nombreAlumno") == 0) {
                        t.setValue(nombre);
                    } else if (text.compareTo("apellidoAlumno") == 0) {
                        t.setValue(apellido);
                    } else if (text.compareTo("rutAlumno") == 0) {
                        t.setValue(rut);
                    } else if (text.compareTo("mailAlumno") == 0) {
                        t.setValue(mail);
                    } else if (text.compareTo("direccionAlumno") == 0) {
                        t.setValue(direccion);
                    } else if (text.compareTo("comunaAlumno") == 0) {
                        t.setValue(comuna);
                    } else if (text.compareTo("telefonoAlumno") == 0) {
                        t.setValue(telefono);
                    } else if (text.compareTo("tituloTema") == 0) {
                        t.setValue(titulo);
                    } else if (text.compareTo("profesorGuia") == 0) {
                        t.setValue(guia);
                    } else if (text.compareTo("profesorCorr1") == 0) {
                        t.setValue(corr1);
                    } else if (text.compareTo("profesorCorr2") == 0) {
                        t.setValue(corr2);
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
            Logger.getLogger(PlantillaAntecedentes.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
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
        } catch (Exception ex) {
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
