/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Logs;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.persistence.EntityManager;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;
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
public class LogsFacadeTest {
    @Mock
    private LogsFacade logsFacade;
    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;

    public LogsFacadeTest() {
    }

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);

        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        logsFacade = Mockito.mock(LogsFacade.class);
        logsFacade.em = entityManager;
        
    }

    @Test
    public void testLogsFacadeFindAll() throws ParseException {
        Logs a1 = new Logs();
        Logs a2 = new Logs();
        Logs a3 = new Logs();
        
        // a1
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM-dd-yyyy");
        java.util.Date date;
        date = simpleDateFormat.parse("24-12-12");
        a1.setDated(date);
        a1.setLevel("1");
        a1.setLogger("1");
        a1.setLogsId(1);
        a1.setMessage("mensaje");
        a1.setUserId("userid");

        // a2
        java.util.Date date2;
        date2 = simpleDateFormat.parse("24-12-12");
        a2.setDated(date2);
        a2.setLevel("1");
        a2.setLogger("1");
        a2.setLogsId(2);
        a2.setMessage("mensaje");
        a2.setUserId("userid");
        
        // a3
        java.util.Date date3;
        date3 = simpleDateFormat.parse("24-12-12");
        a3.setDated(date3);
        a3.setLevel("1");
        a3.setLogger("1");
        a3.setLogsId(3);
        a3.setMessage("mensaje");
        a3.setUserId("userid");
        
        List<Logs> systemlogs = new ArrayList<>();
        systemlogs.add(a1);
        systemlogs.add(a2);
        systemlogs.add(a3);

        List<Logs> systemlogsTest = new ArrayList<>();
        systemlogsTest.add(a1);
        systemlogsTest.add(a2);
        systemlogsTest.add(a3);

        when(entityManager.createNamedQuery("SELECT a FROM Logs a")).thenReturn(query);

        Query querys = entityManager.createNamedQuery("SELECT a FROM Logs a");

        when(querys.getResultList()).thenReturn(systemlogs);

        when(logsFacade.findAll()).thenReturn(systemlogsTest);

        assertEquals(systemlogsTest, systemlogs);

        }
    
}