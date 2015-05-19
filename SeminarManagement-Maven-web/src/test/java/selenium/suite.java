import junit.framework.Test;
import junit.framework.TestSuite;

public class Suite {

  public static Test suite() {
    TestSuite suite = new TestSuite();
    suite.addTestSuite(T-001 - Entrar de forma correcta a la aplicacion como administrador  .class);
    suite.addTestSuite(T-007 - Acceder a los módulos correctos del administrador.class);
    suite.addTestSuite(T-009 - Agregar como administrador fechas de entrega del documento al profesor revisor.class);
    suite.addTestSuite(T-010 - Agregar como administrador fechas de entrega del documento a los profesores correctores.class);
    suite.addTestSuite(T-011 - Editar la cantidad de guias maximas de cada profesor.class);
    suite.addTestSuite(T-012 - Capturar error de edición de cantidad de guias maximas de manera correcta.class);
    suite.addTestSuite(T-013 - Ingresar las fechas de examen de grado.class);
    suite.addTestSuite(T - 014 - Capturar error de ingreso de fechas de manera correcta como administrador.class);
    suite.addTestSuite(T - 015 - "Como administrador descargar documento word cuando la comision revisora de una propuesta de tema sea de tipo consejo ".class);
    suite.addTestSuite(T-016 - Como administrador ver de manera correcta las estadísticas de alumnos titulados.class);
    suite.addTestSuite(T-017 - Como administrador ver fecha de inicio y término del tema de un alumno.class);
    suite.addTestSuite(T-018 - Como usuario quiero editar correctamente los mails de los profesores.class);
    suite.addTestSuite(T-005 - Salir de forma correcta de la aplicación como administrador.class);
    suite.addTestSuite(T-002 - Entrar de forma incorrecta a la aplicación como administrador.class);
    suite.addTestSuite(T-003 - Entrar de forma correcta a la aplicación como secretaria.class);
    suite.addTestSuite(T-008 - Acceder a los módulos correctos de la secretaria.class);
    suite.addTestSuite(T-006 - Salir de forma correcta de la aplicación como secretaria.class);
    suite.addTestSuite(T-004 - Entrar de forma incorrecta a la aplicación como secretaria.class);
    return suite;
  }

  public static void main(String[] args) {
    junit.textui.TestRunner.run(suite());
  }
}
