/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.alumnos;

import clases.PropuestaDatos;
import clases.TemaDatos;
import entities.Alumno;
import entities.ComisionRevisora;
import entities.ProfePropuesta;
import entities.ProfePropuestaPK;
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
public class VerAlumnoMBTest {
    @Mock
    private VerAlumnoMBTest verAlumnoMBTest;
    
    @Mock
    private EntityManager entityManager;
    
    @Mock
    private Query query;
    
    public VerAlumnoMBTest() {
    }
    
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        
        verAlumnoMBTest = Mockito.mock(VerAlumnoMBTest.class);
        verAlumnoMBTest.entityManager = entityManager; 
    }
    
    @Test
    public void testVerDatosMemoristas(){
        Alumno alumno = new Alumno();
        alumno.setApellidoAlumno("apellido");
        alumno.setCarreraAlumno(1);
        alumno.setDireccionAlumno("direccion");
        alumno.setJornada(1);
        alumno.setMailAlumno("mail");
        alumno.setNombreAlumno("nombre");
        alumno.setPet(false);
        alumno.setRutAlumno("rut");
        alumno.setTelefonoAlumno("telefono");
        Propuesta propuesta = new Propuesta();
        ComisionRevisora revisora = new ComisionRevisora();
        revisora.setFechaRevision("fecha");
        revisora.setIdPropuesta(propuesta);
        revisora.setIdRevisora(1);
        Semestre semestre = new Semestre();
        semestre.setComisionCorrectoraList(null);
        semestre.setComisionRevisoraList(null);
        semestre.setIdSemestre("1");
        semestre.setPropuestaList(null);
        semestre.setTemaList(null);
        revisora.setIdSemestre(semestre);
        Tema tema = new Tema();
        tema.setComisionCorrectoraList(null);
        tema.setComisionRevisoraList(null);
        tema.setEstadoTema(0);
        tema.setFechaTema("fecha");
        tema.setIdCorrectora(null);
        tema.setIdRevisora(revisora);
        tema.setIdSemestre(semestre);
        tema.setIdTema(1);
        tema.setNombreTema("nombre");
        revisora.setIdTema(tema);
        revisora.setProfeRevisionList(null);
        revisora.setPropuestaList(null);
        revisora.setTemaList(null);
        revisora.setTipoRevision(1);
        List<ComisionRevisora> listaComisionRevisora = new ArrayList<>();
        listaComisionRevisora.add(revisora);
        propuesta.setComisionRevisoraList(listaComisionRevisora);
        propuesta.setFechaPropuesta("fecha");
        propuesta.setIdPropuesta(1);
        propuesta.setIdRevisora(revisora);
        propuesta.setIdSemestre(semestre);
        propuesta.setMagister(false);
        propuesta.setNombrePropuesta("nombre");
        ProfePropuesta profePropuesta = new ProfePropuesta();
        profePropuesta.setFechaRevision("fecha");
        profePropuesta.setNotaGuiaDefensa((float)7.0);
        profePropuesta.setNotaGuiaInforme((float)7.0);
        ProfePropuestaPK profePropuestaPK = new ProfePropuestaPK();
        profePropuestaPK.setIdPropuesta(1);
        profePropuestaPK.setRutProfesor("rut");
        profePropuesta.setProfePropuestaPK(profePropuestaPK);
        Profesor profesor = new Profesor();
        profesor.setApellidoProfesor("apellido");
        profesor.setContrato(1);
        profesor.setMailProfesor("mail");
        profesor.setMaximoGuias(1);
        profesor.setNombreProfesor("nombre");
        profesor.setProfeCorreccionList(null);
        profesor.setProfePropuestaList(null);
        profesor.setProfeRevisionList(null);
        profesor.setRutProfesor("rut");
        profesor.setTelefonoProfesor("telefono");
        profesor.setTipoProfesor(1);
        profePropuesta.setProfesor(profesor);
        profePropuesta.setPropuesta(propuesta);
        profePropuesta.setRolGuia(1);
        List<ProfePropuesta> listaProfePropuesta = new ArrayList<>();
        listaProfePropuesta.add(profePropuesta);
        propuesta.setProfePropuestaList(listaProfePropuesta);
        propuesta.setRutAlumno(alumno);
        List<Propuesta> listaPropuesta = new ArrayList<>();
        listaPropuesta.add(propuesta);
        alumno.setPropuestaList(listaPropuesta);
        
        
        List<Alumno> listaAlumno = new ArrayList<>();
        listaAlumno.add(alumno);
        
        List<Alumno> listaAlumnoTest = new ArrayList<>();
        listaAlumnoTest.add(alumno);
        
        
        when(entityManager.createNamedQuery("SELECT a FROM Alumno a WHERE a.nombreAlumno LIKE :nombreAlumno OR a.apellidoAlumno LIKE :apellidoAlumno OR a.rutAlumno LIKE :rutAlumno")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT a FROM Alumno a WHERE a.nombreAlumno LIKE :nombreAlumno OR a.apellidoAlumno LIKE :apellidoAlumno OR a.rutAlumno LIKE :rutAlumno");
        
        when(querys.getResultList()).thenReturn(listaAlumno);
        
        //System.out.println(temaList.get(0).getEstadoTema());
       
        assertEquals(listaAlumnoTest, listaAlumno);
        
    }
}
