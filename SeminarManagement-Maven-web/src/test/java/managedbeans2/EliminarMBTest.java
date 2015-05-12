/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managedbeans2;

import entities.ComisionCorrectora;
import entities.ComisionRevisora;
import entities.ProfeCorreccion;
import entities.Profesor;
import entities.Propuesta;
import entities.Semestre;
import entities.Tema;
import java.util.List;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

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
public class EliminarMBTest {
    @Mock
    private EliminarMBTest eliminarMBTest;
   
    @Mock
    private EntityManager entityManager;
    @Mock
    private Query query;
    public EliminarMBTest() {
    }
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        query = mock(Query.class);
        entityManager = Mockito.mock(EntityManager.class);
        eliminarMBTest = Mockito.mock(EliminarMBTest.class);
        eliminarMBTest.entityManager = entityManager; 
        
    }

    /**
     * Test of removeByPropuesta method, of class EliminarMB.
     */
    @Test
    public void testRemoveByPropuesta() {
        // Creo una propuesta
        Propuesta ppta = new Propuesta();
        ppta.setIdPropuesta(1);
        // Creo comision Revisora
        ComisionRevisora cmr = new ComisionRevisora();
        cmr.setFechaRevision("fecha");
        cmr.setIdPropuesta(ppta);
        cmr.setIdRevisora(1);
        cmr.setIdSemestre(null);
        cmr.setIdTema(null);
        cmr.setProfeRevisionList(null);
        cmr.setPropuestaList(null);
        cmr.setTemaList(null);
        cmr.setTipoRevision(1);
        
        ppta.setComisionRevisoraList(null);
        ppta.setFechaPropuesta("fecha");
        
        ppta.setIdRevisora(null);
        ppta.setMagister(true);
        ppta.setNombrePropuesta("nombre ppta");
        ppta.setProfePropuestaList(null);        
        ppta.setRutAlumno(null);
        

        
        // Creo comision correctora
        ComisionCorrectora cc = new ComisionCorrectora();
        cc.setFechaCorreccion("fecha");
        cc.setIdCorrectora(1);
        
        // creo Semestre
        Semestre sem = new Semestre("1");
        cc.setIdSemestre(sem);
        
        // creo tema
        Tema tm = new Tema();
        
        tm.setComisionRevisoraList(null);
        tm.setEstadoTema(1);
        tm.setFechaTema("fecha");
        tm.setIdCorrectora(cc);
        tm.setIdRevisora(null);
        tm.setIdSemestre(sem);
        tm.setIdTema(1);
        tm.setNombreTema("nombre");
        
        cc.setIdTema(tm);
        
        
        // Creo Profesor para correcion
        ProfeCorreccion pc = new ProfeCorreccion();
        pc.setComisionCorrectora(cc);
        pc.setNotaCorreccionDefensa((float)4.5);
        pc.setNotaCorreccionInforme((float)4.0);
        pc.setProfeCorreccionPK(null);
        
        // Creo Profesor 1
        Profesor p = new Profesor();
        p.setApellidoProfesor("apellido");
        p.setContrato(1);
        p.setMailProfesor("mail");
        p.setMaximoGuias(10);
        p.setNombreProfesor("nombre");
        p.setProfeCorreccionList(null);
        p.setProfePropuestaList(null);
        p.setProfeRevisionList(null);
        p.setRutProfesor("rut");
        p.setTelefonoProfesor("telefono");
        p.setTipoProfesor(1);
        
        // Creo Profesor 2
        
        Profesor p2 = new Profesor();
        p2.setApellidoProfesor("apellido");
        p2.setContrato(2);
        p2.setMailProfesor("mail");
        p2.setMaximoGuias(10);
        p2.setNombreProfesor("nombre");
        p2.setProfeCorreccionList(null);
        p2.setProfePropuestaList(null);
        p2.setProfeRevisionList(null);
        p2.setRutProfesor("rut");
        p2.setTelefonoProfesor("telefono");
        p2.setTipoProfesor(1);
        
        pc.setProfesor(p);
        pc.setRolCorreccion(1);
        
        
        // Creo Profesor2 para correcion
        ProfeCorreccion pc2 = new ProfeCorreccion();
        pc2.setComisionCorrectora(cc);
        pc2.setNotaCorreccionDefensa((float)4.5);
        pc2.setNotaCorreccionInforme((float)4.0);
        pc2.setProfeCorreccionPK(null);
        pc.setProfesor(p2);
        pc.setRolCorreccion(1);
        
        List<ProfeCorreccion> profesores = new ArrayList<>();
        
        profesores.add(pc);
        profesores.add(pc2);
        
        cc.setProfeCorreccionList(profesores);
        cc.setTemaList(null);
        
        List<ComisionCorrectora> ccList = new ArrayList<>();
        ccList.add(cc);
        
        tm.setComisionCorrectoraList(ccList);
        
        List<Propuesta> propTest = new ArrayList<>();
        
        List<ComisionRevisora> ccRev = new ArrayList<>();
        ccRev.add(cmr);
        
        List<Tema> tema = new ArrayList<>();
        tema.add(tm);
        
        List<Propuesta> pta = new ArrayList<>();
        pta.add(ppta);
 
        
        if (cc.getIdCorrectora() == 1){
            ccList.remove(cc);

            if(cmr.getIdRevisora()== 1 && ccList.isEmpty()== true){
                ccRev.remove(cmr);
             
                if(tm.getIdTema()==1 && ccList.isEmpty() && ccRev.isEmpty()){
                    tema.remove(tm);
                    if(pta.get(0).getIdPropuesta()==1 && ccRev.isEmpty() && ccList.isEmpty() && tema.isEmpty() ){

                        when(entityManager.createNamedQuery("SELECT c FROM Propuesta c")).thenReturn(query);
        
                        Query querys = entityManager.createNamedQuery("SELECT c FROM Propuesta c");
        
                        when(querys.getResultList()).thenReturn(pta);
                        
                        if(querys.getResultList().isEmpty()==false){
                            pta.remove(ppta);
                            when(entityManager.createNamedQuery("SELECT c FROM Propuesta c")).thenReturn(query);
                            Query querys2 = entityManager.createNamedQuery("SELECT c FROM Propuesta c");
                            when(querys2.getResultList()).thenReturn(pta);
                            assertEquals(propTest, pta);
                        }
                    }
                }
            }
            
            
        }
        
        // TODO review the generated test code and remove the default call to fail.
      
    }

    
}
