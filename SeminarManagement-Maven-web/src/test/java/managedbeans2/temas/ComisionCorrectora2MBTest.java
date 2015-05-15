/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

import entities.Alumno;
import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.ProfeCorreccion;
import entities.ProfePropuesta;
import entities.ProfePropuestaPK;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import entities.Tema;
import java.util.List;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

import java.util.ArrayList;
import javax.persistence.EntityManager;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;
import javax.persistence.Query;

/**
 *
 * @author luis
 */
@RunWith(MockitoJUnitRunner.class)
public class ComisionCorrectora2MBTest {
    @Mock
    private ComisionCorrectora2MBTest comisionCorrectora2MBTest;
   
    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    public ComisionCorrectora2MBTest() {
    }
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        comisionCorrectora2MBTest = Mockito.mock(ComisionCorrectora2MBTest.class);
        comisionCorrectora2MBTest.entityManager = entityManager; 
        
    }

    @Test
    public void testAddComisionCorrectora() {
        //Alumno 1
        
        Alumno a1 = new Alumno();
        a1.setApellidoAlumno("apellido");
        a1.setCarreraAlumno(1);
        a1.setDireccionAlumno("direccion");
        a1.setJornada(1);
        a1.setMailAlumno("mail");
        a1.setNombreAlumno("nombre");
        a1.setPet(false);
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
        ComisionRevisora cr1 = new ComisionRevisora(1); 
        p1.setIdRevisora(cr1);
        ComisionRevisora cr2 = new ComisionRevisora(2);
        ComisionRevisora cr3 = new ComisionRevisora(3);
        
        //Lista de comisiones
        List<ComisionRevisora> comisionList = new ArrayList<>();
        
        comisionList.add(cr1);
        comisionList.add(cr2);
        comisionList.add(cr3);
        
        //Profesor propuesta 1
        ProfePropuesta pp = new ProfePropuesta();
        pp.setFechaRevision("fecharev");
        pp.setNotaGuiaDefensa((float)4.0);
        pp.setNotaGuiaInforme((float)4.0);
        pp.setRolGuia(2);
        ProfePropuestaPK pppk = new ProfePropuestaPK();
        pppk.setIdPropuesta(1);
        pppk.setRutProfesor("rutprofe");
        pp.setProfePropuestaPK(pppk);
        Profesor profe = new Profesor();
        profe.setApellidoProfesor("apellidoprofe");
        profe.setContrato(1);
        profe.setMailProfesor("mailprofe");
        profe.setMaximoGuias(1);
        profe.setNombreProfesor("nombreprofe");
        profe.setRutProfesor("rutprofe");
        profe.setTelefonoProfesor("telefonoprofe");
        profe.setTipoProfesor(1);
        profe.setProfeCorreccionList(null);
        profe.setProfePropuestaList(null);
        profe.setProfeRevisionList(null);
        pp.setProfesor(profe); 
        pp.setPropuesta(p1);
        p1.setComisionRevisoraList(comisionList);
        
        //Propuesta 2 del alumno 1
        Propuesta p2 = new Propuesta();
        p2.setFechaPropuesta("fecha");
        p2.setIdPropuesta(1);
        p2.setMagister(false);
        p2.setNombrePropuesta("nombreProp");
        p2.setRutAlumno(a1);
        
        ComisionRevisora cr11 = new ComisionRevisora(1); 
        p2.setIdRevisora(cr11);
        ComisionRevisora cr22 = new ComisionRevisora(2);
        ComisionRevisora cr33 = new ComisionRevisora(3);
        
        List<ComisionRevisora> comisionList2 = new ArrayList<>();
        
        comisionList.add(cr11);
        comisionList.add(cr22);
        comisionList.add(cr33);
        
        ProfePropuesta pp2 = new ProfePropuesta();
        pp2.setFechaRevision("fecharev");
        pp2.setNotaGuiaDefensa((float)4.0);
        pp2.setNotaGuiaInforme((float)4.0);
        pp2.setRolGuia(2);
        ProfePropuestaPK pppk2 = new ProfePropuestaPK();
        pppk2.setIdPropuesta(1);
        pppk2.setRutProfesor("rutprofe");
        pp2.setProfePropuestaPK(pppk);
        Profesor profe2 = new Profesor();
        profe2.setApellidoProfesor("apellidoprofe");
        profe2.setContrato(1);
        profe2.setMailProfesor("mailprofe");
        profe2.setMaximoGuias(1);
        profe2.setNombreProfesor("nombreprofe");
        profe2.setRutProfesor("rutprofe");
        profe2.setTelefonoProfesor("telefonoprofe");
        profe2.setTipoProfesor(1);
        profe2.setProfeCorreccionList(null);
        profe2.setProfePropuestaList(null);
        profe2.setProfeRevisionList(null);
        pp2.setProfesor(profe2); 
        pp2.setPropuesta(p2);
        p2.setComisionRevisoraList(comisionList2);
        
        //Propuesta 3
        Propuesta p3 = new Propuesta();
        p3.setFechaPropuesta("fecha");
        p3.setIdPropuesta(1);
        p3.setMagister(false);
        p3.setNombrePropuesta("nombreProp");
        p3.setRutAlumno(a1);
        
        ComisionRevisora cr111 = new ComisionRevisora(1); 
        p3.setIdRevisora(cr111);
        ComisionRevisora cr222 = new ComisionRevisora(2);
        ComisionRevisora cr333 = new ComisionRevisora(3);
        
        List<ComisionRevisora> comisionList3 = new ArrayList<>();
        
        comisionList.add(cr111);
        comisionList.add(cr222);
        comisionList.add(cr333);
        
        ProfePropuesta pp3 = new ProfePropuesta();
        pp3.setFechaRevision("fecharev");
        pp3.setNotaGuiaDefensa((float)4.0);
        pp3.setNotaGuiaInforme((float)4.0);
        pp3.setRolGuia(2);
        ProfePropuestaPK pppk3 = new ProfePropuestaPK();
        pppk3.setIdPropuesta(1);
        pppk3.setRutProfesor("rutprofe");
        pp3.setProfePropuestaPK(pppk);
        Profesor profe3 = new Profesor();
        profe3.setApellidoProfesor("apellidoprofe");
        profe3.setContrato(1);
        profe3.setMailProfesor("mailprofe");
        profe3.setMaximoGuias(1);
        profe3.setNombreProfesor("nombreprofe");
        profe3.setRutProfesor("rutprofe");
        profe3.setTelefonoProfesor("telefonoprofe");
        profe3.setTipoProfesor(1);
        profe3.setProfeCorreccionList(null);
        profe3.setProfePropuestaList(null);
        profe3.setProfeRevisionList(null);
        pp3.setProfesor(profe3); 
        pp3.setPropuesta(p3);
        p3.setComisionRevisoraList(comisionList3);
        
        
        List<Propuesta> proplist = new ArrayList<>();
        
        proplist.add(p1);
        proplist.add(p2);
        proplist.add(p3);
       
        a1.setPropuestaList(proplist);
        
        //Comision correctora
        ComisionCorrectora cc1 = new ComisionCorrectora();
        cc1.setFechaCorreccion("fechacorreccion");
        cc1.setFechaEntCorreccion("fechaEntregaCorrecion");
        cc1.setIdCorrectora(1);
        
        Semestre sm = new Semestre();
        sm.setComisionRevisoraList(comisionList);
        sm.setComisionCorrectoraList(null);
        sm.setIdSemestre("1");
        sm.setPropuestaList(proplist);
        sm.setTemaList(null);
        cc1.setIdSemestre(sm);
        
        Tema tm = new Tema(1);
        cc1.setIdTema(tm);
        
        ProfeCorreccion pc = new ProfeCorreccion();
        pc.setComisionCorrectora(null);
        pc.setNotaCorreccionDefensa((float)4.0);
        pc.setNotaCorreccionInforme((float)4.0);
        pc.setProfeCorreccionPK(null);
        pc.setProfesor(profe3);
        pc.setRolCorreccion(1);
        
        List<ProfeCorreccion> pcl = new ArrayList<>();
        pcl.add(pc);
        cc1.setProfeCorreccionList(pcl);

        List<Tema> temalist = new ArrayList<>();
        temalist.add(tm);
        cc1.setTemaList(temalist);

        List<ComisionCorrectora> ccList = new ArrayList<>();
        ccList.add(cc1);
        
        List<ComisionCorrectora> ccListTest = new ArrayList<>();
        ccListTest.add(cc1);
        
        when(entityManager.createNamedQuery("SELECT c FROM ComisionCorrectora c")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT c FROM ComisionCorrectora c");
        
        when(querys.getResultList()).thenReturn(ccList);
       
        assertEquals(ccListTest, ccList);
        
    }

    
}
