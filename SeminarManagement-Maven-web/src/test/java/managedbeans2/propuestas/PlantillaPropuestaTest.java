package managedbeans2.propuestas;

import entities.Alumno;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import javax.servlet.ServletException;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.util.PDFTextStripper;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import static org.mockito.Mockito.*;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockServletConfig;
import org.springframework.mock.web.MockServletContext;

/**
 *
 * @author stateless
 */
@RunWith(MockitoJUnitRunner.class)
public class PlantillaPropuestaTest {

    private MockHttpServletRequest request;
    private MockHttpServletResponse response;
    private PlantillaPropuesta servlet;
    private Profesor guia, coGuia, comision1, comision2;
    private Alumno alumno;
    private Propuesta prop;

    public PlantillaPropuestaTest() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() throws ServletException {

        servlet = new PlantillaPropuesta();
        servlet.propuestaMB = mock(VerPropuestaMB.class);
        doNothing().when(servlet.propuestaMB).buscarPropuesta(); //evita consultar la BD

        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();

        MockServletContext context = new MockServletContext();
        MockServletConfig config = new MockServletConfig(context);

        servlet.init(config);
        servlet.TEMPLATE_LOCATION = "/plantillas/plantilla_propuesta.pdf"; //se debe cambiar ya que el path de ejecución de los test es distinto

        prop = new Propuesta(1);
        prop.setNombrePropuesta("Nombre de la propuesta");
        prop.setIdSemestre(new Semestre("1/2015"));

        guia = new Profesor();
        guia.setApellidoProfesor("PEREZ");
        guia.setNombreProfesor("JUAN");

        coGuia = new Profesor();
        coGuia.setApellidoProfesor("APELLIDO");
        coGuia.setNombreProfesor("NOMBRE");

        comision1 = new Profesor();
        comision1.setApellidoProfesor("GONZALEZ");
        comision1.setNombreProfesor("PEDRO");

        comision2 = new Profesor();
        comision2.setApellidoProfesor("GUTIERREZ");
        comision2.setNombreProfesor("DAVID");

        alumno = new Alumno("19");
        alumno.setApellidoAlumno("GARCIA");
        alumno.setNombreAlumno("DIEGO");
        //alumno.setCarreraAlumno(0);
        alumno.setTelefonoAlumno("89674523");
        alumno.setMailAlumno("diego.garcia@usach.cl");
        alumno.setDireccionAlumno("Ecuador 1809");
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of processRequest method, of class PlantillaPropuesta.
     *
     * @throws java.lang.Exception
     */
    @Test
    public void testProcessRequestIfNoIdParam() throws Exception {
        

        servlet.processRequest(request, response);

        assertEquals(response.getContentType(), "text/html");
        assertTrue(response.getContentAsString().contains("Documento no disponible"));
    }

    @Test
    @Ignore
    public void testProcessRequestCorrectPDFGeneration() throws ServletException, IOException, URISyntaxException {
        

        //stubbs de los métodos del MB
        when(this.servlet.propuestaMB.getIdPropuesta()).thenReturn(1);
        when(this.servlet.propuestaMB.getPropuesta()).thenReturn(prop);
        when(this.servlet.propuestaMB.getAlumno()).thenReturn(alumno);
        when(this.servlet.propuestaMB.getGuia()).thenReturn(guia);
        when(this.servlet.propuestaMB.getCoguia()).thenReturn(coGuia);
        when(this.servlet.propuestaMB.getAlumno()).thenReturn(alumno);
        when(this.servlet.propuestaMB.getRevisor1()).thenReturn(comision1);
        when(this.servlet.propuestaMB.getRevisor2()).thenReturn(comision2);

        servlet.processRequest(request, response);

        // verifica pdf
        assertEquals("application/pdf", response.getContentType());
        String pdfText = extractPdfText(response.getContentAsByteArray());
        // verfica contenido
        assertTrue(pdfText.contains("Nombre de la propuesta"));
        assertTrue(pdfText.contains("1° 2015"));
        assertTrue(pdfText.contains("JUAN PEREZ"));
        assertTrue(pdfText.contains("NOMBRE APELLIDO"));
        assertTrue(pdfText.contains("PEDRO GONZALEZ"));
        assertTrue(pdfText.contains("DAVID GUTIERREZ"));
        assertTrue(pdfText.contains("1-9"));
        assertTrue(pdfText.contains("DIEGO GARCIA"));
        assertTrue(pdfText.contains("INGENIERIA CIVIL EN INFORMATICA"));
        assertTrue(pdfText.contains("89674523"));
        assertTrue(pdfText.contains("diego.garcia@usach.cl"));
        assertTrue(pdfText.contains("Ecuador 1809"));
        
    }

    /**
     * Test of getServletInfo method, of class PlantillaPropuesta.
     */
    @Test
    public void testGetServletInfo() {
        
        PlantillaPropuesta instance = new PlantillaPropuesta();
        String expResult = "Retorna un archivo PDF desplegado en el navegador que contiene la información una propuesta de trabajo de título";
        String result = instance.getServletInfo();
        assertEquals(expResult, result);
    }

    private static String extractPdfText(byte[] pdfData) throws IOException {
        try (PDDocument pdfDocument = PDDocument.load(new ByteArrayInputStream(pdfData))) {
            return new PDFTextStripper().getText(pdfDocument);
        }
    }

}
