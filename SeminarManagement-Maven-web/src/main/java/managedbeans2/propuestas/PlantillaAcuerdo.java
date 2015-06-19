package managedbeans2.propuestas;

import entities.Alumno;
import entities.PlanEstudio;
import entities.Profesor;
import entities.Usuario;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.ejb.EJB;
import javax.inject.Inject;
import javax.servlet.ServletException;
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
import sessionbeans.UsuarioFacadeLocal;

/**
 *
 * @author stateless
 */
@WebServlet(name = "PlantillaAcuerdo", urlPatterns = {"/PlantillaAcuerdo"})
public class PlantillaAcuerdo extends HttpServlet {

    public String TEMPLATE_LOCATION = "/resources/plantillas/plantilla_acuerdo_consejo.docx";
    
    @EJB
    private UsuarioFacadeLocal usuarioFacade;
            
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
     * @throws org.docx4j.openpackaging.exceptions.Docx4JException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Docx4JException, Exception {

        try {
            if (propuestaMB.getIdPropuesta() == null) {
                if (request.getParameter("id") != null) {
                    propuestaMB.setIdPropuesta(Integer.parseInt(request.getParameter("id")));
                    propuestaMB.buscarPropuesta();
                    if (propuestaMB.getPropuesta() == null) {
                        throw new NullPointerException("No se encontró la propuesta");
                    }
                } else {
                    throw new NullPointerException("No se especificó una propuesta");
                }
            }

            Alumno alumno = propuestaMB.getAlumno();
            Usuario us1 = usuarioFacade.findByRut(alumno.getRutAlumno()).get(0);
            Profesor guia = propuestaMB.getGuia();
            Usuario guia1 = usuarioFacade.findByRut(guia.getRutProfesor()).get(0);
            
            String fileName = ""+"AcuerdoConsejo_"+
                    us1.getApellidoUsuarioPaterno().replace(" ", "-")+"_"+
                    alumno.getRutAlumno()+".docx";
            
            response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document;charset=UTF-8");
            response.setHeader("Content-disposition", "filename="+fileName);

            StringBuilder str = new StringBuilder();

            str.append(us1.getNombreUsuario()).append(us1.getNombreUsuario());
            String nombreAlumno = WordUtils.capitalizeFully(
                    "" + us1.getNombreUsuario() + " " + us1.getApellidoUsuarioPaterno());
            String profeGuia = WordUtils.capitalizeFully(
                    "" + guia1.getNombreUsuario() + " " + guia1.getApellidoUsuarioPaterno());
            String carrera = "";
            String ubicacion = "El documento se encuentra en el casillero de Ingeniería ";
            List <PlanEstudio> planes = alumno.getPlanes();
            if ( !planes.isEmpty() ){
                if ( planes.get(0).getCarreraId() != null) {
                    if ( planes.get(0).getCarreraId().getNombre().contains("CIVIL") ) {
                        carrera += "Ing. Civil Informática, ";
                        ubicacion += "Civil";
                    } else if ( planes.get(0).getCarreraId().getNombre().contains("EJECUCIÓN") ) {
                        carrera += "Ing. De Ejecución en Computación e Informática, ";
                        ubicacion += "de Ejecución";
                    }
                }
                if ( planes.get(0).getJornada() == 0) {
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
            replaceText(dsa, nombreAlumno, carrera, profeGuia, fecha, ubicacion);

            Save saver = new Save(template);

            saver.save(response.getOutputStream());

        } catch (Exception e) {
            response.setContentType("text/html");
            PrintWriter writer = response.getWriter();
            writer.println("Documento no disponible<br>");
            writer.println("<pre>");
            writer.println("</pre>");
        }
    }
    
    /**
     * Busca y reemplaza el texto en contenido de un docx
     * @param c
     * @param alumno
     * @param carrera
     * @param guia
     * @param fecha
     * @param ubicacion
     * @throws Exception 
     */
    private void replaceText(ContentAccessor c, String alumno, String carrera, 
            String guia, String fecha, String ubicacion)
            throws Exception {
        for (Object p : c.getContent()) {
            if (p instanceof ContentAccessor) {
                replaceText((ContentAccessor) p, alumno, carrera, guia, fecha, ubicacion);
            } else if (p instanceof JAXBElement) {
                Object v = ((JAXBElement) p).getValue();

                if (v instanceof ContentAccessor) {
                    replaceText((ContentAccessor) v, alumno, carrera, guia, fecha, ubicacion);
                } else if (v instanceof org.docx4j.wml.Text) {
                    org.docx4j.wml.Text t = (org.docx4j.wml.Text) v;
                    String text = t.getValue();
                    if (text.startsWith("SM_")) {
                        if ( text.compareTo("SM_NOMBRE_ALUMNO") == 0) {
                            t.setValue(alumno);
                        } else if ( text.compareTo("SM_CARRERA") == 0) {
                            t.setValue(carrera);
                        } else if ( text.compareTo("SM_GUIA") == 0) {
                            t.setValue(guia);
                        } else if ( text.compareTo("SM_FECHA") == 0) {
                            t.setValue(fecha);
                        } else if ( text.compareTo("SM_UBICACION") == 0) {
                            t.setValue(ubicacion);
                        }
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
        } catch (Docx4JException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
            //Logger.getLogger(PlantillaAcuerdo.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Docx4JException ex) {
            //Logger.getLogger(PlantillaAcuerdo.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex);
        } catch (Exception ex) {
            //Logger.getLogger(PlantillaAcuerdo.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Retorna un docx de Acuerdo de Consejo para una propuesta de acuerdo al id entregado por url";
    }// </editor-fold>

}
