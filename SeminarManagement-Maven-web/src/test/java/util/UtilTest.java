package util;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author giovanni
 */
public class UtilTest {

    public UtilTest() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() {
    }

    @After
    public void tearDown() {
    }

    /**
     * Test of formatearRut method, of class Util.
     */
    @Test
    public void testFormatearRut() {
        
        String rut = "175658173";
        String expResult = "17.565.817-3";
        String result = Util.formatearRut(rut);
        assertEquals(expResult, result);

        rut = "19";
        expResult = "1-9";
        result = Util.formatearRut(rut);
        assertEquals(expResult, result);
        
        rut = "17...565.....817-3";
        expResult = "17.565.817-3";
        result = Util.formatearRut(rut);
        assertEquals(expResult, result);
    }

    @Test
    public void testReducirNombre(){
        String result = Util.reducirNombre("juan carlos", "perez gracia", 2);
        assertEquals("juan perez", result);
        
        result = Util.reducirNombre("juan carlos javier", "perez gracia", 23);
        assertEquals("juan carlos perez gracia", result);
    }
}
