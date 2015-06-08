/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

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
import org.primefaces.model.UploadedFile;

/**
 *
 * @author matias
 */
@RunWith(MockitoJUnitRunner.class)
public class AvanceYCaducarMBTest {
    @Mock
    private AvanceYCaducarMBTest avanceycaducarMBTest;
   
    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    public AvanceYCaducarMBTest() {
    }
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        avanceycaducarMBTest = Mockito.mock(AvanceYCaducarMBTest.class);
        avanceycaducarMBTest.entityManager = entityManager; 
        
    }
    
    /**
     * Test of caducarRenunciaTema method, of class AvanceYCaducarMB.
     */
    @Test
    public void testCaducarRenunciaTema() {
        
        Tema tm = new Tema();
        
        ComisionCorrectora cc = new ComisionCorrectora(1);
        ComisionCorrectora cc2 = new ComisionCorrectora(2);
        List<ComisionCorrectora> Listcc = new ArrayList<>();
        Listcc.add(cc);
        Listcc.add(cc2);
        
        ComisionRevisora cr = new ComisionRevisora(1);
        ComisionRevisora cr2 = new ComisionRevisora(2);
        List<ComisionRevisora> Listcr = new ArrayList<>();
        Listcr.add(cr);
        Listcr.add(cr2);
        
        tm.setComisionCorrectoraList(Listcc);
        tm.setComisionRevisoraList(Listcr);
        tm.setEstadoTema(0);
        tm.setFechaRealTema("fecha");
        tm.setFechaSiacTema("fecha");
        tm.setFechaTema("fecha");
        tm.setIdCorrectora(cc);
        tm.setIdRevisora(cr);
        tm.setIdTema(1);
        
        Semestre sm = new Semestre("1");
        tm.setIdSemestre(sm);
        tm.setNombreTema("tema"); 
        tm.setSemestreTermino("2012");
        
        List<Tema> temaList = new ArrayList<>();
        temaList.add(tm);
        
        List<Tema> temaListTest = new ArrayList<>();
        temaListTest.add(tm);
        
        when(entityManager.createNamedQuery("SELECT c FROM AvanceyCaducarMB c")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT c FROM AvanceyCaducarMB c");
        
        when(querys.getResultList()).thenReturn(temaList);
        temaList.get(0).setEstadoTema(8);
        temaListTest.get(0).setEstadoTema(8);
        
        when(entityManager.createNamedQuery("SELECT c FROM AvanceyCaducarMB c")).thenReturn(query);
        
        Query querys2 = entityManager.createNamedQuery("SELECT c FROM AvanceyCaducarMB c");
        
        when(querys2.getResultList()).thenReturn(temaList);
        
        assertEquals(temaListTest, temaList);
        
    }
    
}
