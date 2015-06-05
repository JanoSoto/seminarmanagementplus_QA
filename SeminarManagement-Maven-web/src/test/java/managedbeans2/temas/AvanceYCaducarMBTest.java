/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2.temas;

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
 * @author miguel
 */
@RunWith(MockitoJUnitRunner.class)
public class AvanceYCaducarMBTest {
    @Mock
    private AvanceYCaducarMBTest avanceYCaducarMBTest;
    
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
        avanceYCaducarMBTest = Mockito.mock(AvanceYCaducarMBTest.class);
        avanceYCaducarMBTest.entityManager = entityManager; 
        
    }
    
    @Test
    public void testCaducarTema() throws ParseException {
        
        AvanceYCaducarMB ct = new AvanceYCaducarMB();
        ct.caducarRenunciaTema();
        
        
    }
}
