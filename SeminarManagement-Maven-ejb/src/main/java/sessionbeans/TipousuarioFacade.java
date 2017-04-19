/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Tipousuario;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author miguel
 */
@Stateless
public class TipousuarioFacade extends AbstractFacade<Tipousuario> implements TipousuarioFacadeLocal {

    @PersistenceContext(unitName = "com.mycompany_SeminarManagement-Maven-ejb_ejb_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TipousuarioFacade() {
        super(Tipousuario.class);
    }

    public Tipousuario findByNombreTipo(String nombre_tipo) {
        Query query;
        query = em.createNamedQuery("Tipousuario.findByNombreTipo")
                .setParameter("nombreTipo", nombre_tipo);
        return (Tipousuario) query.getSingleResult();
    }

//    @Override
//    public List<Tipousuario> findAll() {
//        Query query;
//        query = em.createNamedQuery("Tipousuario.findAll");
//        List<Tipousuario> resultados = (List<Tipousuario>) query.getResultList();
//        List<String> tipos = new ArrayList<>();
//        tipos.add("ADMINISTRADOR");
//        tipos.add("PROFESOR");
//        tipos.add("SECRETARIA");
//        List<Tipousuario> resultados_finales = new ArrayList<>();
//        for (int i = 0; i < resultados.size(); i++) {
//            if(tipos.contains(resultados.get(i).getNombreTipo())){
//                resultados_finales.add(resultados.get(i));
//            }
//        }
//        return resultados_finales;
//    }
}
