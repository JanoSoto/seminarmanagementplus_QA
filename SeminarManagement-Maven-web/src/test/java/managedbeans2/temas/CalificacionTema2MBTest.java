/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

import entities.ComisionCorrectora;
import entities.Tema;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
public class CalificacionTema2MBTest {
    @Mock
    private CalificacionTema2MBTest calificacionTema2MBTest;
   
    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    public CalificacionTema2MBTest() {
    }
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        calificacionTema2MBTest = Mockito.mock(CalificacionTema2MBTest.class);
        calificacionTema2MBTest.entityManager = entityManager; 
        
    }

    /**
     * Test of calificarTema method, of class CalificacionTema2MB.
     */
    @Test
    public void testCalificarTema() throws ParseException {
        
        CalificacionTema2MB ct = new CalificacionTema2MB();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM-dd-yyyy");
        java.util.Date date;
        date = simpleDateFormat.parse("24-12-12");
        ct.setDate(date);
        ct.setDate2(date);
        ct.setDateCorrecP1(date);
        ct.setDateCorrecP2(date);
        ct.setDateCorrecPG(date);
        ct.setFechaTema("fechatema");
        ct.setIdTema(1);
        ct.setNombreTema("tema");
        ct.setNotaProfe1Def("5.5");
        ct.setNotaProfe1Inf("5.5");
        ct.setNotaProfe2Def("5.5");
        ct.setNotaProfe2Inf("5.5");
        ct.setNotaProfe2Inf("5.5");
        ct.setNotaProfeGuiaDef("5.5");
        ct.setNotaProfeGuiaInf("5.5");
        ct.setRutAlumno("176767881");
        ct.setSemestreTema("1");
        Tema tm = new Tema(1);
        ct.setTema(tm);
        ct.setUser(null);
        
         List<CalificacionTema2MB> ccList = new ArrayList<>();
        ccList.add(ct);
        
        List<CalificacionTema2MB> ccListTest = new ArrayList<>();
        ccListTest.add(ct);
        
        when(entityManager.createNamedQuery("SELECT c FROM CalificacionTema2MB c")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT c FROM CalificacionTema2MB c");
        
        when(querys.getResultList()).thenReturn(ccList);
       
        System.out.println(ccList.get(0).getFechaTema());
        assertEquals(ccListTest, ccList);
    }


   
}
