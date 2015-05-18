/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

import entities.Alumno;
import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.Profesor;
import entities.Semestre;
import entities.Tema;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
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
public class VerTemaMBTest {
    @Mock
    private VerTemaMBTest verTemaMBTest;
   
    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    public VerTemaMBTest() {
    }
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        verTemaMBTest = Mockito.mock(VerTemaMBTest.class);
        verTemaMBTest.entityManager = entityManager; 
        
    }

    /**
     * Test of editarTema method, of class VerTemaMB.
     */
    @Test
    public void testEditarTema() {
        Tema tm = new Tema();
        tm.setComisionCorrectoraList(null);
        tm.setComisionRevisoraList(null);
        tm.setEstadoTema(0);
        tm.setFechaRealTema("fechareal");
        tm.setFechaSiacTema("fechasiac");
        tm.setFechaTema("fecha");
        
        ComisionCorrectora cm = new ComisionCorrectora(1);
        tm.setIdCorrectora(cm);
        
        ComisionRevisora cr = new ComisionRevisora(1);
        tm.setIdRevisora(cr);
        
        Semestre sm = new Semestre("1");
        tm.setIdSemestre(sm);
        tm.setIdTema(1);
        tm.setNombreTema("nombre");
        tm.setSemestreTermino("semestreTermino");
        
        // tema 2
        Tema tm2 = new Tema();
        tm2.setComisionCorrectoraList(null);
        tm2.setComisionRevisoraList(null);
        tm2.setEstadoTema(0);
        tm2.setFechaRealTema("fechareal2");
        tm2.setFechaSiacTema("fechasiac2");
        tm2.setFechaTema("fecha2");
        
        ComisionCorrectora cm2 = new ComisionCorrectora(1);
        tm2.setIdCorrectora(cm2);
        
        ComisionRevisora cr2 = new ComisionRevisora(1);
        tm2.setIdRevisora(cr2);
        
        Semestre sm2 = new Semestre("1");
        tm2.setIdSemestre(sm2);
        tm2.setIdTema(1);
        tm2.setNombreTema("nombre");
        tm2.setSemestreTermino("semestreTermino");
        
        List<Tema> temaList = new ArrayList<>();
        temaList.add(tm);
        
        List<Tema> temaListTest = new ArrayList<>();
        temaListTest.add(tm2);
        
        
        when(entityManager.createNamedQuery("SELECT c FROM Tema c")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT c FROM Tema c");
        
        when(querys.getResultList()).thenReturn(temaList);
        
        System.out.println(temaList.get(0).getIdTema());
        temaList.get(0).setFechaRealTema("fechareal2");
        temaList.get(0).setFechaSiacTema("fechasiac2");
        temaList.get(0).setFechaTema("fecha2");
        
        when(entityManager.createNamedQuery("SELECT c FROM Tema c")).thenReturn(query);
        
        Query querys2 = entityManager.createNamedQuery("SELECT c FROM Tema c");
        
        when(querys2.getResultList()).thenReturn(temaList);
       
        assertEquals(temaListTest, temaList);
          
    }

}
