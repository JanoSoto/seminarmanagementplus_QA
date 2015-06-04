/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2;

import entities.Semestre;
import entities.Tema;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;
import java.util.List;
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
 * @author matias
 */

@RunWith(MockitoJUnitRunner.class)
public class SemestreMBTest {
    @Mock
    private SemestreMBTest semestreMBTest;
   
    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    public SemestreMBTest() {
    }
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        semestreMBTest = Mockito.mock(SemestreMBTest.class);
        semestreMBTest.entityManager = entityManager; 
        
    }

    @Test
    public void testTerminarSemestreActual() {
        Semestre sm = new Semestre();
        sm.setComisionCorrectoraList(null);
        sm.setComisionRevisoraList(null);
        sm.setIdSemestre("1");
        sm.setPropuestaList(null);
        
        //Se crea un tema 1
        Tema tm = new Tema();
        tm.setComisionCorrectoraList(null);
        tm.setComisionRevisoraList(null);
        tm.setEstadoTema(0);
        tm.setFechaTema("fecha");
        tm.setIdCorrectora(null);
        tm.setIdRevisora(null);
        tm.setIdSemestre(sm);
        tm.setIdTema(2);
        tm.setNombreTema("nombretema");
        
        //Se crea tema 2
        Tema tm2 = new Tema();
        tm2.setComisionCorrectoraList(null);
        tm2.setComisionRevisoraList(null);
        tm2.setEstadoTema(2);
        tm2.setFechaTema("fecha2");
        tm2.setIdCorrectora(null);
        tm2.setIdSemestre(sm);
        tm2.setIdTema(2);
        tm2.setNombreTema("nombretema2");
        
        //Se crea tema 3
        Tema tm3 = new Tema();
        tm3.setComisionCorrectoraList(null);
        tm3.setComisionRevisoraList(null);
        tm3.setEstadoTema(3);
        tm3.setFechaTema("fecha3");
        tm3.setIdCorrectora(null);
        tm3.setIdSemestre(sm);
        tm3.setIdTema(3);
        tm3.setNombreTema("nombretema3");        
        List<Tema> temas = new ArrayList<>();
        temas.add(tm);
        temas.add(tm2);
        temas.add(tm3);
        
        sm.setTemaList(temas);
        

        
        // terminar semestre
        
        for (int i = 0; i < temas.size(); i++) {
            if (temas.get(i).getEstadoTema() == 0 ){
                temas.get(i).setEstadoTema(3);
            }
            
            else if(temas.get(i).getEstadoTema() == 2 ){
                temas.get(i).setEstadoTema(0);
            }
        }
        
        List<Tema> temaTest = new ArrayList<>();
        tm.setEstadoTema(3);
        tm2.setEstadoTema(3);
        temaTest.add(tm);
        temaTest.add(tm2);
        temaTest.add(tm3);
                
        temaTest.get(0).getEstadoTema();
        
        when(entityManager.createNamedQuery("SELECT c FROM Tema c")).thenReturn(query);
        
        Query querys = entityManager.createNamedQuery("SELECT c FROM Tema c");
        
        when(querys.getResultList()).thenReturn(temaTest);

        assertEquals(temaTest, temas);
    }
    
}
