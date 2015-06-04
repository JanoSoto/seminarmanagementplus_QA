package managedbeans2.propuestas;

import entities.Alumno;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBException;
import org.docx4j.TextUtils;
import org.docx4j.jaxb.XPathBinderAssociationIsPartialException;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
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
public class PlantillaAcuerdoTest {

    private PlantillaAcuerdo servlet;
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;

    public PlantillaAcuerdoTest() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() throws ServletException {
        servlet = new PlantillaAcuerdo();
        servlet.propuestaMB = mock(VerPropuestaMB.class);
        doNothing().when(servlet.propuestaMB).buscarPropuesta(); //evita consultar la BD
        
        servlet.TEMPLATE_LOCATION = "/plantillas/plantilla_acuerdo_consejo.docx";

        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();

        MockServletContext context = new MockServletContext();
        MockServletConfig config = new MockServletConfig(context);

        servlet.init(config);
    }

    @After
    public void tearDown() {
    }

    @Test
    public void testProcessRequestIfNoIdParam() throws Exception {
        System.out.println("ProcessRequestIfNoIdParam");

        servlet.processRequest(request, response);

        assertEquals(response.getContentType(), "text/html");
        assertTrue(response.getContentAsString().contains("Documento no disponible"));
    }

    /**
     * Test of processRequest method, of class PlantillaAcuerdo.
     * @throws java.lang.Exception
     */
    @Ignore
    @Test
    public void testProcessRequestCorrectDocxGeneration() throws Exception {
        System.out.println("testProcessRequestCorrectDocxGeneration");

        Alumno alumno = new Alumno("19");
        alumno.setApellidoAlumno("GARCIA");
        alumno.setNombreAlumno("DIEGO");
        //alumno.setCarreraAlumno(0);
        //alumno.setJornada(0);

        Profesor guia = new Profesor();
        guia.setApellidoProfesor("PEREZ");
        guia.setNombreProfesor("JUAN");

        Propuesta prop = new Propuesta(1);
        prop.setIdSemestre(new Semestre("1/2015"));

        //stubbs de los métodos del MB
        when(this.servlet.propuestaMB.getIdPropuesta()).thenReturn(1);
        when(this.servlet.propuestaMB.getPropuesta()).thenReturn(prop);
        when(this.servlet.propuestaMB.getAlumno()).thenReturn(alumno);
        when(this.servlet.propuestaMB.getGuia()).thenReturn(guia);

        servlet.processRequest(request, response);

        // verifica pdf
        assertEquals("application/vnd.openxmlformats-officedocument.wordprocessingml.document;charset=UTF-8", response.getContentType());
        String docxText = getDocxAsText(response.getContentAsByteArray());
        
        // verfica contenido
        System.out.println(docxText);
        assertTrue(docxText.contains("Diego Garcia"));
        assertTrue(docxText.contains("Juan Perez"));
        //assertTrue(docxText.contains("Ing. Civil Informática, Diurna"));
        //assertTrue(docxText.contains("El documento se encuentra en el casillero de Ingeniería Civil"));
        SimpleDateFormat formateador = new SimpleDateFormat("dd 'de' MMMM 'de' yyyy", new Locale("ES"));
        assertTrue(docxText.contains("Santiago, "+formateador.format(new Date())));

    }

    /**
     * Test of getServletInfo method, of class PlantillaAcuerdo.
     */
    @Test
    public void testGetServletInfo() {
        System.out.println("getServletInfo");
        PlantillaAcuerdo instance = new PlantillaAcuerdo();
        String expResult = "Retorna un docx de Acuerdo de Consejo para una propuesta de acuerdo al id entregado por url";
        String result = instance.getServletInfo();
        assertEquals(expResult, result);
    }

    private String getDocxAsText(byte[] bytes) throws 
            JAXBException, XPathBinderAssociationIsPartialException, Exception {
        
        WordprocessingMLPackage file;
        file = WordprocessingMLPackage.load(new ByteArrayInputStream(bytes) );

        // Request paragraphs
        final String XPATH_TO_SELECT_TEXT_NODES = "//w:t";
        final List<Object> jaxbNodes = file.getMainDocumentPart().getJAXBNodesViaXPath(XPATH_TO_SELECT_TEXT_NODES, true);
        StringBuilder sb = new StringBuilder();
        for (Object jaxbNode : jaxbNodes) {
            final StringWriter stringWriter = new StringWriter();
            TextUtils.extractText(jaxbNode, stringWriter);
            sb.append(stringWriter.toString());
        }
        return sb.toString();
    }
}
