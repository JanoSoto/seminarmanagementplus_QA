/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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
import managedbeans2.profesores.VerProfesorMB;

/**
 *
 * @author giovanni
 */
@WebServlet(urlPatterns = {"/excel"})
public class Excel extends HttpServlet {

    @Inject
    VerProfesorMB profesorMB;

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
        response.setContentType("text/html;charset=UTF-8");
        response.setContentType("application/vnd.ms-excel");
        String file_name = "salida.csv";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + file_name + "\"");

        PrintWriter out = response.getWriter();

        String rut = request.getParameter("prof");
        profesorMB.setRutProfesor(rut);
        profesorMB.buscarProfesor();
        profesorMB.verPropuestas();
        profesorMB.verTemas();
        List<TemaDatos> a = profesorMB.getTemaDatos();
        out.println("Nombre\tAlumno\tEstado\tSemestre");
        for (int i = 0; i < a.size(); i++) {
            TemaDatos b = a.get(i);
            if (b.getEstadoTema() == "VIGENTE") {
                String salida = b.getNombreCorto();
                salida += "\t" + b.getAlumno().getNombreAlumno() + " " + b.getAlumno().getApellidoAlumno();
                salida += "\t" + b.getEstadoTema();
                salida += "\t" + b.getSemestreTema();
                out.println(salida);
            }
        }

        try {
        } finally {
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
        return "Short description";
    }// </editor-fold>

}
