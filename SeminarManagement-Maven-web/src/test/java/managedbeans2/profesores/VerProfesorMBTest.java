package managedbeans2.profesores;

import clases.PropuestaDatos;
import clases.TemaDatos;
import entities.Alumno;
import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import entities.Tema;
import java.util.List;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.Collection;
import javax.persistence.EntityManager;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;
import javax.persistence.Query;
import sessionbeans.ComisionCorrectoraFacade;


/**
 *
 * @author luis
 */
public class VerProfesorMBTest {
    @Mock
    private VerProfesorMBTest verProfesorMBTest;
    
    @Mock
    private EntityManager entityManager;
    
    @Mock
    private Query query;
    
    public VerProfesorMBTest() {
    }

    
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        
        verProfesorMBTest = Mockito.mock(VerProfesorMBTest.class);
        verProfesorMBTest.entityManager = entityManager; 
    }
    
    
    @Test
    public void testVerTemasVigentesProfesor(){
        
        //Profesor
        Profesor profesor = new Profesor();
        profesor.setApellidoProfesor("apellido");
        profesor.setContrato(1);
        profesor.setMailProfesor("mail");
        profesor.setMaximoGuias(1);
        profesor.setNombreProfesor("nombre");
        profesor.setProfeCorreccionList(null);
        profesor.setProfePropuestaList(null);
        profesor.setRutProfesor("rut");
        profesor.setTelefonoProfesor("telefono");
        profesor.setTipoProfesor(1);
       
        //Creamos un tema vigente
       Tema tema = new Tema();
       tema.setComisionCorrectoraList(null);
       tema.setComisionRevisoraList(null);
       tema.setFechaTema("fecha");
       ComisionCorrectora correctora = new ComisionCorrectora();
       correctora.setFechaCorreccion("fecha");
       correctora.setIdCorrectora(1);
       Semestre semestre = new Semestre();
       semestre.setComisionCorrectoraList(null);
       semestre.setComisionRevisoraList(null);
       semestre.setIdSemestre("1");
       semestre.setPropuestaList(null);
       semestre.setTemaList(null);
       correctora.setIdSemestre(semestre);
       correctora.setIdTema(tema);
       correctora.setProfeCorreccionList(null);
       correctora.setTemaList(null);
       tema.setIdCorrectora(correctora);
       ComisionRevisora revisora = new ComisionRevisora();
       revisora.setFechaRevision("fecha");
       Propuesta propuesta = new Propuesta();
       propuesta.setComisionRevisoraList(null);
       propuesta.setFechaPropuesta("fecha");
       propuesta.setIdPropuesta(1);
       propuesta.setIdRevisora(revisora);
       propuesta.setIdSemestre(semestre);
       propuesta.setMagister(false);
       propuesta.setNombrePropuesta("nombre");
       propuesta.setProfePropuestaList(null);
       Alumno alumno = new Alumno();
       alumno.setApellidoAlumno("apellido");
       //alumno.setCarreraAlumno(1);
       alumno.setDireccionAlumno("direccion");
       //alumno.setJornada(1);
       alumno.setMailAlumno("mail");
       alumno.setNombreAlumno("nombre");
       alumno.setPropuestaList(null);
       alumno.setRutAlumno("rut");
       alumno.setTelefonoAlumno("telefono");
       propuesta.setRutAlumno(alumno);
       revisora.setIdPropuesta(propuesta);
       revisora.setIdRevisora(1);
       revisora.setIdSemestre(semestre);
       revisora.setIdTema(tema);
       revisora.setProfeRevisionList(null);
       revisora.setPropuestaList(null);
       revisora.setTemaList(null);
       revisora.setTipoRevision(1);
       tema.setIdRevisora(revisora);
       tema.setIdSemestre(semestre);
       tema.setIdTema(1);
       tema.setNombreTema("nombre");
       tema.setEstadoTema(0); // 0 es vigente
       
       List<Tema> temaList = new ArrayList<>();
       temaList.add(tema);
       
       List<Tema> temaListTest = new ArrayList<>();
       temaListTest.add(tema);
       
        when(entityManager.createNamedQuery("SELECT t FROM Tema t WHERE t.estadoTema = :estadoTema")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT t FROM Tema t WHERE t.estadoTema = :estadoTema");
        
        when(querys.getResultList()).thenReturn(temaList);
        
        
       
        assertEquals(temaListTest, temaList);
       
       
       
       
        
    }
    
    
    @Test
    public void testEditarGuias(){
    
               //Profesor
        Profesor profesor = new Profesor();
        profesor.setApellidoProfesor("apellido");
        profesor.setContrato(1);
        profesor.setMailProfesor("mail");
        profesor.setMaximoGuias(10);
        profesor.setNombreProfesor("nombre");
        profesor.setProfeCorreccionList(null);
        profesor.setProfePropuestaList(null);
        profesor.setRutProfesor("rut");
        profesor.setTelefonoProfesor("telefono");
        profesor.setTipoProfesor(1);
        
               //Profesor2
        Profesor profesor2 = new Profesor();
        profesor2.setApellidoProfesor("apellido");
        profesor2.setContrato(1);
        profesor2.setMailProfesor("mail");
        profesor2.setMaximoGuias(7);
        profesor2.setNombreProfesor("nombre");
        profesor2.setProfeCorreccionList(null);
        profesor2.setProfePropuestaList(null);
        profesor2.setRutProfesor("rut");
        profesor2.setTelefonoProfesor("telefono");
        profesor2.setTipoProfesor(1);
        
        
        
        List<Profesor> profeList = new ArrayList<>();
        profeList.add(profesor);
       
        List<Profesor> profeListTest = new ArrayList<>();
        profeListTest.add(profesor);
        

       
        when(entityManager.createNamedQuery("SELECT t FROM Profesor t WHERE t.maxGuias = :maxGuias")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT t FROM Profesor t WHERE t.maxGuias = :maxGuias");
        
        when(querys.getResultList()).thenReturn(profeList);

        
        profeList.get(0).setMaximoGuias(7);
       
        when(entityManager.createNamedQuery("SELECT t FROM Profesor t WHERE t.maxGuias = :maxGuias")).thenReturn(query);
        
        Query querys2 = entityManager.createNamedQuery("SELECT t FROM Profesor t WHERE t.maxGuias = :maxGuias");
        
        when(querys2.getResultList()).thenReturn(profeList);
        
       
        assertEquals(profeListTest, profeList);
       
    }
    
}
