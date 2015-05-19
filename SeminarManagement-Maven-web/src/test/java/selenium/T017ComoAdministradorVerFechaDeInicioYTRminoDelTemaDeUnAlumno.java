package selenium;

import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class T017ComoAdministradorVerFechaDeInicioYTRminoDelTemaDeUnAlumno {
  private WebDriver driver;
  private String baseUrl;
  private boolean acceptNextAlert = true;
  private StringBuffer verificationErrors = new StringBuffer();

  @Before
  public void setUp() throws Exception {
    driver = new FirefoxDriver();
    baseUrl = "http://localhost:8080/SeminarManagement-Maven-web/";
    driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
  }

  @Test
  public void testT017ComoAdministradorVerFechaDeInicioYTRminoDelTemaDeUnAlumno() throws Exception {
    driver.get(baseUrl + "/SeminarManagement-Maven-web/2.0/admin/estadisticas/estadisticas.xhtml");
    driver.findElement(By.xpath("//a[@id='j_idt23:j_idt28']/span[2]")).click();
    driver.findElement(By.linkText("SISTEMA DE EVALUACIÓN INTERACTIVO C...")).click();
    driver.findElement(By.xpath("//a[@id='j_idt24:j_idt29']/span[2]")).click();
    driver.findElement(By.linkText("DESARROLLAR JUEGOS PARA CURSO DE EC...")).click();
    driver.findElement(By.xpath("//a[@id='j_idt24:j_idt29']/span[2]")).click();
    new Select(driver.findElement(By.id("j_idt44:propTable:j_idt50:filter"))).selectByVisibleText("TITULADO");
    driver.findElement(By.cssSelector("option[value=\"TITULADO\"]")).click();
    driver.findElement(By.linkText("SOLUCION TECNOLOGICA PARA LA CREACI...")).click();
  }

  @After
  public void tearDown() throws Exception {
    driver.quit();
    String verificationErrorString = verificationErrors.toString();
    if (!"".equals(verificationErrorString)) {
      fail(verificationErrorString);
    }
  }

  private boolean isElementPresent(By by) {
    try {
      driver.findElement(by);
      return true;
    } catch (NoSuchElementException e) {
      return false;
    }
  }

  private boolean isAlertPresent() {
    try {
      driver.switchTo().alert();
      return true;
    } catch (NoAlertPresentException e) {
      return false;
    }
  }

  private String closeAlertAndGetItsText() {
    try {
      Alert alert = driver.switchTo().alert();
      String alertText = alert.getText();
      if (acceptNextAlert) {
        alert.accept();
      } else {
        alert.dismiss();
      }
      return alertText;
    } finally {
      acceptNextAlert = true;
    }
  }
}