package managedbeans2.profesores;

import clases.TemaDatos;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import managedbeans2.SemestreMB;

/**
 *
 * @author giovanni
 */
// ya no se usa
@WebServlet(urlPatterns = {"/excel"})
public class Excel extends HttpServlet {

    @Inject
    VerProfesorMB profesorMB;
    @Inject
    SemestreMB semestreMB;

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
        PrintWriter out = response.getWriter();
        try {

            String rut = request.getParameter("prof");
            if (rut == null) {
                throw new NullPointerException("No se especificó un profesor");
            }

            profesorMB.setRutProfesor(rut);
            profesorMB.buscarProfesor();
            profesorMB.verPropuestas();
            profesorMB.verTemas();
            List<TemaDatos> a = profesorMB.getTemaDatos();
            out.println("Nombre\tAlumno\tEstado\tSemestre Inicio");
            for (TemaDatos b : a) {
                String salida = "";
                if (b.getNombreTema() != null){
                    salida += b.getNombreTema();
                }
                salida += "\t";
                if ( b.getAlumno() != null)
                     salida += b.getAlumno().getNombreAlumno() + " " + b.getAlumno().getApellidoAlumno();
                salida += "\t";
                /*if ( b.getEstadoTema() != null){
                    if ( b.getEstadoTema() == ) {
                    } else if ( b.getEstadoTema() == ) {
                    } else if ( b.getEstadoTema() == ) {
                    } else if ( b.getEstadoTema() == ) {
                    } else if ( b.getEstadoTema() == ) {
                    }
                }*/
                salida += "\t" + b.getAlumno().getNombreAlumno() + " " + b.getAlumno().getApellidoAlumno();
                salida += "\t" + b.getEstadoTema();
                salida += "\t" + b.getSemestreTema();
                out.println(salida);
            }

            response.setContentType("application/vnd.ms-excel");
            String file_name = profesorMB.getProfesor().getApellidoProfesor() +" vigentes "+ semestreMB.getSemestre().replace("/", "-") +".csv";
            response.setHeader("Content-Disposition", "attachment; filename=\"" + file_name + "\"");

        } catch(Exception ex){
            response.setContentType("text/html");
            PrintWriter writer = response.getWriter();
            writer.println("No disponible<br>");
            writer.println("<pre>");
            writer.println("</pre>");
        }finally {
            out.close();
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
