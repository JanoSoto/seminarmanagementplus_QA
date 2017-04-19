/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.propuestas;

import entities.Alumno;
import entities.ComisionRevisora;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import managedbeans.AuthMB;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

/**
 *
 * @author matias
 */

@RunWith(MockitoJUnitRunner.class)
public class AgregarPropuestaMBTest {
    @Mock
    private AgregarPropuestaMBTest agregarPropuestaMBTest;
   
    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    public AgregarPropuestaMBTest() {
    }
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        agregarPropuestaMBTest = Mockito.mock(AgregarPropuestaMBTest.class);
        agregarPropuestaMBTest.entityManager = entityManager; 
        
    }

 
    /**
     * Test of addPropuesta method, of class AgregarPropuestaMB.
     */
    @Test
    public void testAddPropuesta() {
        
        Propuesta prop = new Propuesta();
        ComisionRevisora cr = new ComisionRevisora(1);
        ComisionRevisora cr2 = new ComisionRevisora(2);
        List<ComisionRevisora> listcr = new ArrayList<>();
        listcr.add(cr);
        listcr.add(cr2);
        prop.setComisionRevisoraList(listcr);
        prop.setFechaPropuesta("fecha");
        prop.setIdPropuesta(1);
        prop.setIdRevisora(cr);
        Semestre sem = new Semestre("1");
        prop.setIdSemestre(sem);
        prop.setMagister(true);
        prop.setNombrePropuesta("nombre");
        prop.setPet(true);
        prop.setProfePropuestaList(null);
        Alumno al = new Alumno("176767901");
        prop.setRutAlumno(al);
        
        List<Propuesta> propuestaList = new ArrayList<>();
        
        propuestaList.add(prop);
        
        List<Propuesta> propuestaListTest = new ArrayList<>();
        propuestaListTest.add(prop);
        
        when(entityManager.createNamedQuery("SELECT c FROM Propuesta c")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT c FROM Propuesta c");
        
        when(querys.getResultList()).thenReturn(propuestaList);
       
        assertEquals(propuestaListTest, propuestaList);
    }


    
}
