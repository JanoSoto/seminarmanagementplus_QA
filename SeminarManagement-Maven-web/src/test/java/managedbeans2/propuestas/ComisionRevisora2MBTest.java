package managedbeans2.propuestas;

import entities.Alumno;
import entities.ComisionRevisora;
import entities.Propuesta;
import entities.Semestre;
import entities.Tema;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;
import sessionbeans.ComisionRevisoraFacadeLocal;
import sessionbeans.PropuestaFacade;
import sessionbeans.PropuestaFacadeLocal;
import sessionbeans.SemestreActualFacadeLocal;
import sessionbeans.SemestreFacadeLocal;

/**
 *
 * @author matias
 */
@RunWith(MockitoJUnitRunner.class)
public class ComisionRevisora2MBTest {
    @Mock
    private ComisionRevisora2MBTest comisionRevisora2MBTest;
    
    @Mock
    private EntityManager entityManager;
    
    @Mock
    private Query query;
    
    private ComisionRevisora2MB managedBean;
    
    @EJB
    private PropuestaFacadeLocal propuestaFacade;
    
    @EJB
    private ComisionRevisoraFacadeLocal comisionFacade;
    
    @EJB
    private SemestreFacadeLocal semestreFacade;
    
    public ComisionRevisora2MBTest() {
    }
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        comisionRevisora2MBTest = Mockito.mock(ComisionRevisora2MBTest.class);
        comisionRevisora2MBTest.entityManager = entityManager; 
        
        managedBean = Mockito.mock(ComisionRevisora2MB.class);
        
        propuestaFacade = Mockito.mock(PropuestaFacadeLocal.class);
        comisionFacade = Mockito.mock(ComisionRevisoraFacadeLocal.class);
        semestreFacade = Mockito.mock(SemestreFacadeLocal.class);
        
        
    }


    /**
     * Test of addComisionRevisora method, of class ComisionRevisora2MB.
     */
    @Test
    public void testAddComisionRevisora() {
        //Alumno 1
        
        Alumno a1 = new Alumno();
        a1.setApellidoAlumno("apellido");
        //a1.setCarreraAlumno(1);
        a1.setDireccionAlumno("direccion");
        //a1.setJornada(1);
        a1.setMailAlumno("mail");
        a1.setNombreAlumno("nombre");
        a1.setRutAlumno("rut");
        a1.setTelefonoAlumno("telefono");
        
        //Propuesta 1 del alumno 1
        Propuesta p1 = new Propuesta();
        p1.setFechaPropuesta("fecha");
        p1.setIdPropuesta(1);
        p1.setMagister(false);
        p1.setNombrePropuesta("nombreProp");
        p1.setRutAlumno(a1);
        
        //Comision de la propuesta 1
        ComisionRevisora cr1 = new ComisionRevisora(); 
        cr1.setFechaEntregaRevision("fechaentregarevision");
        cr1.setFechaRevision("fecharevision");
        cr1.setIdPropuesta(p1);
        cr1.setIdRevisora(1);
        
        Semestre sm = new Semestre("1");
        
        cr1.setIdSemestre(sm);
        
        Tema tm2 = new Tema();
        tm2.setComisionCorrectoraList(null);
        tm2.setComisionRevisoraList(null);
        tm2.setEstadoTema(1);
        tm2.setFechaTema("fecha");
        tm2.setIdCorrectora(null);
        tm2.setIdSemestre(sm);
        tm2.setIdTema(1);
        tm2.setNombreTema("nombre");
        tm2.setIdRevisora(cr1);
        
       
        cr1.setIdTema(tm2);
        cr1.setProfeRevisionList(null);
        cr1.setPropuestaList(null);
        cr1.setTemaList(null);
        cr1.setTipoRevision(1);
        
        
        
        p1.setIdRevisora(cr1);
 
        //Lista de comisiones
        List<ComisionRevisora> comisionList = new ArrayList<>();
        
        comisionList.add(cr1);
        
        List<ComisionRevisora> comisionListTest = new ArrayList<>();
        comisionListTest.add(cr1);
        
        
        
        when(entityManager.createNamedQuery("SELECT c FROM ComisionRevisora c")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT c FROM ComisionRevisora c");
        
        when(querys.getResultList()).thenReturn(comisionList);
       
        assertEquals(comisionListTest, comisionList);
    }

    @Test
    public void testEditarFechasComisionRevisoraAcuerdoConsejo() throws ParseException{
        Propuesta propuesta = new Propuesta(1);
        ComisionRevisora comision = new ComisionRevisora(2);
        Semestre semestre = new Semestre("1/2015");
        
        List<Propuesta> propuestas = new ArrayList<>();
        propuestas.add(propuesta);
        
        List<ComisionRevisora> comisiones = new ArrayList<>();
        comisiones.add(comision);
        
        List<Semestre> semestres = new ArrayList<>();
        semestres.add(semestre);
        
        when(this.propuestaFacade.findById(1)).thenReturn(propuestas);
        when(this.comisionFacade.findById(2)).thenReturn(comisiones);
        when(this.semestreFacade.findAll()).thenReturn(semestres);
        doNothing().when(this.comisionFacade).edit(comision);
        
        managedBean.setIdProp(1);
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date publicacion = sdf.parse("10/03/2015");
        Date termino = sdf.parse("16/03/2015");
        managedBean.setPublicacionConsejo(publicacion);
        managedBean.setTerminoPublicacionConsejo(termino);
        managedBean.setSemestreRev("1/2015");
        comision.setFechaPublicacionConsejo("10/03/2015");
        comision.setFechaTerminoPublicacionConsejo("16/03/2015");
        
        managedBean.EditarComisionRevisora();

    }
}
