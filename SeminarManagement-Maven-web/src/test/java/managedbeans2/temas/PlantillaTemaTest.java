package managedbeans2.temas;

import entities.Alumno;
import entities.Profesor;
import entities.Semestre;
import entities.Tema;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import javax.servlet.ServletException;
import managedbeans2.SemestreMB;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.util.PDFTextStripper;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockServletConfig;
import org.springframework.mock.web.MockServletContext;

/**
 *
 * @author stateless
 */
public class PlantillaTemaTest {
    
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;
    private PlantillaTema servlet;
    private Profesor guia, coGuia, comision1, comision2;
    private Alumno alumno;
    private Tema tema;
    
    public PlantillaTemaTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() throws ServletException {
        servlet = new PlantillaTema();
        servlet.temaMB = mock(VerTemaMB.class);
        servlet.semestreMB = mock(SemestreMB.class);
        doNothing().when(servlet.temaMB).buscarTema(); //evita consultar la BD

        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();

        MockServletContext context = new MockServletContext();
        MockServletConfig config = new MockServletConfig(context);

        servlet.init(config);
        servlet.TEMPLATE_LOCATION = "/plantillas/plantilla_tema.pdf"; //se debe cambiar ya que el path de ejecución de los test es distinto

        tema = new Tema(1);
        tema.setNombreTema("Nombre de la propuesta");
        tema.setIdSemestre(new Semestre("1/2015"));

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
        when(this.servlet.temaMB.getIdTema()).thenReturn(1);
        when(this.servlet.temaMB.getTema()).thenReturn(tema);
        when(this.servlet.temaMB.getAlumno()).thenReturn(alumno);
        when(this.servlet.temaMB.getGuia()).thenReturn(guia);
        when(this.servlet.temaMB.getCoguia()).thenReturn(coGuia);
        when(this.servlet.temaMB.getAlumno()).thenReturn(alumno);
        when(this.servlet.temaMB.getCorrector1()).thenReturn(comision1);
        when(this.servlet.temaMB.getCorrector2()).thenReturn(comision2);
        when(this.servlet.semestreMB.getSemestre()).thenReturn("1/2015");
        
        request.addParameter("id", "1");

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
        assertTrue(pdfText.contains("INGENIERO"));
        assertTrue(pdfText.contains("CIVIL"));
        assertTrue(pdfText.contains("INFORMATICA"));
        assertTrue(pdfText.contains("89674523"));
        assertTrue(pdfText.contains("diego.garcia@usach.cl"));
        assertTrue(pdfText.contains("Ecuador 1809"));
        
    }

    /**
     * Test of getServletInfo method, of class PlantillaTema.
     */
    @Test
    public void testGetServletInfo() {
        
        PlantillaTema instance = new PlantillaTema();
        String expResult ="Retorna un archivo PDF desplegado en el navegador que contiene la información un tema de trabajo de título";
        String result = instance.getServletInfo();
        assertEquals(expResult, result);
    }

    private static String extractPdfText(byte[] pdfData) throws IOException {
        try (PDDocument pdfDocument = PDDocument.load(new ByteArrayInputStream(pdfData))) {
            return new PDFTextStripper().getText(pdfDocument);
        }
    }
}
