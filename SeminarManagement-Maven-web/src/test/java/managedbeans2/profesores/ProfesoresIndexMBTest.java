/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.profesores;

import clases.ProfeDatos2;
import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.Profesor;
import entities.Semestre;
import entities.SemestreActual;
import entities.Tema;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.mockito.Mock;
import org.mockito.Mockito;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;

/**
 *
 * @author matias
 */

    
public class ProfesoresIndexMBTest {
    @Mock
    private ProfesoresIndexMBTest profesoresIndexMBTest;
    
    @Mock
    private EntityManager entityManager;
    
    @Mock
    private Query query;
    
    public ProfesoresIndexMBTest() {
    }

    
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        
        profesoresIndexMBTest = Mockito.mock(ProfesoresIndexMBTest.class);
        profesoresIndexMBTest.entityManager = entityManager; 
    }
    
    @Test
    public void testInit() {
        SemestreActual sma = new SemestreActual();
        sma.setSemestreActual("1/2016");
        // tema 1
        Tema tema = new Tema();
        ComisionRevisora cr= new ComisionRevisora(1);
        ComisionRevisora cr2= new ComisionRevisora(2);
        
        List<ComisionRevisora> lcr = new ArrayList<>();
        lcr.add(cr);
        lcr.add(cr2);
        
        ComisionCorrectora cc= new ComisionCorrectora(1);
        ComisionCorrectora cc2= new ComisionCorrectora(2);
        
        List<ComisionCorrectora> lcc = new ArrayList<>();
        lcc.add(cc);
        lcc.add(cc2);
        tema.setComisionCorrectoraList(lcc);
        tema.setComisionRevisoraList(lcr);
        tema.setEstadoTema(0);
        tema.setFechaRealTema("fecha");
        tema.setFechaSiacTema("fecha2");
        tema.setFechaTema("fecha3");
        tema.setIdCorrectora(cc2);
        tema.setIdRevisora(cr2);
        
        Semestre sm = new Semestre();
        sm.setIdSemestre("2/2016");
        tema.setIdSemestre(sm);
        tema.setIdTema(1);
        tema.setNombreTema("Nombre Tema");
        tema.setSemestreTermino("1/2016");
        
        // tema 2
        Tema tema2 = new Tema();
        tema2.setComisionCorrectoraList(lcc);
        tema2.setComisionRevisoraList(lcr);
        tema2.setEstadoTema(0);
        tema2.setFechaRealTema("fecha");
        tema2.setFechaSiacTema("fecha2");
        tema2.setFechaTema("fecha3");
        tema2.setIdCorrectora(cc2);
        tema2.setIdRevisora(cr2);
        Semestre sm2 = new Semestre();
        sm2.setIdSemestre("2/2016");
        tema2.setIdSemestre(sm2);
        tema2.setIdTema(1);
        tema2.setNombreTema("Nombre Tema");
        tema2.setSemestreTermino("1/2016");
        
         // tema 3
        Tema tema3 = new Tema();
        tema3.setComisionCorrectoraList(lcc);
        tema3.setComisionRevisoraList(lcr);
        tema3.setEstadoTema(0);
        tema3.setFechaRealTema("fecha");
        tema3.setFechaSiacTema("fecha2");
        tema3.setFechaTema("fecha3");
        tema3.setIdCorrectora(cc2);
        tema3.setIdRevisora(cr2);
        Semestre sm3 = new Semestre();
        sm3.setIdSemestre("1/2016");
        tema3.setIdSemestre(sm3);
        tema3.setIdTema(2);
        tema3.setNombreTema("Nombre Tema");
        tema3.setSemestreTermino("1/2016");
        
         // tema 4
        Tema tema4 = new Tema();
        tema4.setComisionCorrectoraList(lcc);
        tema4.setComisionRevisoraList(lcr);
        tema4.setEstadoTema(0);
        tema4.setFechaRealTema("fecha");
        tema4.setFechaSiacTema("fecha2");
        tema4.setFechaTema("fecha3");
        tema4.setIdCorrectora(cc2);
        tema4.setIdRevisora(cr2);
        Semestre sm4 = new Semestre();
        sm4.setIdSemestre("1/2016");
        tema4.setIdSemestre(sm4);
        tema4.setIdTema(2);
        tema4.setNombreTema("Nombre Tema");
        tema4.setSemestreTermino("1/2016");
        
        List<Tema> temaList = new ArrayList<>();
        temaList.add(tema);
        temaList.add(tema3);
        List<Tema> temaListTest = new ArrayList<>();
        temaListTest.add(tema2);
        temaListTest.add(tema4);
        
        for (Tema temaList1 : temaList) {
            if (!(temaList1.getIdSemestre().getIdSemestre() == null ? sma.getSemestreActual() == null : temaList1.getIdSemestre().getIdSemestre().equals(sma.getSemestreActual()))) {
                for (Tema temaListTest1 : temaListTest) {
                    if (temaList1.getNombreTema() == null ? temaListTest1.getNombreTema() == null : temaList1.getNombreTema().equals(temaListTest1.getNombreTema())) {
                        temaListTest1.setIdSemestre(sm2);
                    }
                }
            }
        }
        when(entityManager.createNamedQuery("SELECT t FROM Tema t")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT t FROM Tema t");
        
        when(querys.getResultList()).thenReturn(temaList);
    
        assertEquals(temaListTest, temaList);
    }

}
