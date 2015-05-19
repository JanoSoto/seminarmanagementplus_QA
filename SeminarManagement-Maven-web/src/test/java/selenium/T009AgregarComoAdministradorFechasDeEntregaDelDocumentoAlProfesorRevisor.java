package selenium;

import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class T009AgregarComoAdministradorFechasDeEntregaDelDocumentoAlProfesorRevisor {
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
  public void testT009AgregarComoAdministradorFechasDeEntregaDelDocumentoAlProfesorRevisor() throws Exception {
    driver.get(baseUrl + "/SeminarManagement-Maven-web/2.0/admin/alumnos/index.xhtml");
    driver.findElement(By.xpath("//a[@id='j_idt23:j_idt27']/span[2]")).click();
    driver.findElement(By.linkText("PROPUESTA PROP1")).click();
    driver.findElement(By.id("j_idt65:j_idt69")).click();
    driver.findElement(By.id("j_idt42:calendP_input")).click();
    driver.findElement(By.linkText("20")).click();
    driver.findElement(By.id("j_idt42:calendP2_input")).click();
    driver.findElement(By.linkText("21")).click();
    driver.findElement(By.id("j_idt42:calendP3_input")).click();
    driver.findElement(By.linkText("30")).click();
    driver.findElement(By.id("j_idt42:calendP4_input")).click();
    driver.findElement(By.cssSelector("span.ui-icon.ui-icon-circle-triangle-e")).click();
    driver.findElement(By.linkText("23")).click();
    driver.findElement(By.id("j_idt42:bt1")).click();
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
