/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import Util.Util;
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
        System.out.println("formatearRut");
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

}
