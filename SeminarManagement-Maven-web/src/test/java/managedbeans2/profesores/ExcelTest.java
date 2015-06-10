package managedbeans2.profesores;

import clases.TemaDatos;
import entities.Alumno;
import entities.Profesor;
import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import managedbeans2.SemestreMB;
import managedbeans2.propuestas.PlantillaPropuesta;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;
import org.mockito.Mockito;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

/**
 *
 * @author stateless
 */
public class ExcelTest {
    
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;
    private Excel excelServlet;
    
    public ExcelTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of processRequest method, of class Excel.
     */
    @Test(expected = NullPointerException.class)
    public void testProcessRequestNullParam() throws Exception {
        
        HttpServletRequest request = null;
        HttpServletResponse response = null;
        Excel instance = new Excel();
        instance.processRequest(request, response);
    }

    @Test
    public void testProcessRequestCorrectCsvGeneration() throws Exception {
        
        
        excelServlet = new Excel();
        excelServlet.profesorMB = mock(VerProfesorMB.class);
        excelServlet.semestreMB = mock(SemestreMB.class);
        
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();
        
        doNothing().when( excelServlet.profesorMB ).buscarProfesor();
        doNothing().when( excelServlet.profesorMB ).verPropuestas();
        doNothing().when( excelServlet.profesorMB ).verTemas();
        
        TemaDatos t1 = new TemaDatos();
        t1.setNombreCorto("Tema muy interesante");
        t1.setEstadoTema("VIGENTE");
        t1.setSemestreTema("1/2015");
        
        Alumno a1 = new Alumno();
        a1.setNombreAlumno("Juan");
        a1.setApellidoAlumno("Perez");
        
        t1.setAlumno(a1);
        
        TemaDatos t2 = new TemaDatos();
        t2.setNombreCorto("Tema no interesante");
        t2.setEstadoTema("NOVIGENTE");
        t2.setSemestreTema("2/2016");
        
        Alumno a2 = new Alumno();
        a2.setNombreAlumno("Jorge");
        a2.setApellidoAlumno("Parra");
        
        t2.setAlumno(a2);
        
        ArrayList <TemaDatos> temas = new ArrayList<>();
        temas.add(t1);
        temas.add(t2);
        
        Profesor p = new Profesor();
        p.setApellidoProfesor("Aguirre");
        
        when(excelServlet.profesorMB.getTemaDatos()).thenReturn(temas);
        when(excelServlet.semestreMB.getSemestre()).thenReturn("1-2015");
        when(excelServlet.profesorMB.getProfesor()).thenReturn(p);
        excelServlet.profesorMB.setRutProfeEdit("19");
        
        request.addParameter("prof", "19");
        
        excelServlet.processRequest(request, response);
        
        // verifica csv
        assertEquals("application/vnd.ms-excel", response.getContentType());
        assertTrue(
                response.getHeader("Content-Disposition")
                        .contains("filename=\"Aguirre vigentes 1-2015.csv\""));

        String str = response.getContentAsString();
        assertTrue( str.contains("Nombre\tAlumno\tEstado\tSemestre"));
        assertTrue( str.contains("Tema muy interesante\tJuan Perez\tVIGENTE\t1/2015"));
        assertTrue( !str.contains("Tema no interesante\tJorge Parra\tNOVIGENTE\t2/2016"));

    }

    /**
     * Test of getServletInfo method, of class Excel.
     */
    @Test
    public void testGetServletInfo() {
      
        Excel instance = new Excel();
        String expResult = "Retorna un archivo csv con la información de los temas vigentes para un profesor";
        String result = instance.getServletInfo();
        assertEquals(expResult, result);
    }
    
}
