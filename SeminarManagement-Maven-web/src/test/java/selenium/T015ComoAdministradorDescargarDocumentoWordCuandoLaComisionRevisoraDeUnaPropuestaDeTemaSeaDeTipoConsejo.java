package selenium;

import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.openqa.selenium.*;
import org.openqa.selenium.phantomjs.PhantomJSDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.ui.Select;

public class T015ComoAdministradorDescargarDocumentoWordCuandoLaComisionRevisoraDeUnaPropuestaDeTemaSeaDeTipoConsejo {
  private WebDriver driver;
  private String baseUrl;
  private boolean acceptNextAlert = true;
  private StringBuffer verificationErrors = new StringBuffer();

  @Before
  public void setUp() throws Exception {
    DesiredCapabilities capabilities = DesiredCapabilities.phantomjs();
    PhantomJSDriver driver = new PhantomJSDriver(capabilities);
    baseUrl = "http://ruka.diinf.usach.cl:8080/SeminarManagement-Maven-web/";
    driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
  }

  @Test
  public void testT015ComoAdministradorDescargarDocumentoWordCuandoLaComisionRevisoraDeUnaPropuestaDeTemaSeaDeTipoConsejo() throws Exception {
    driver.get(baseUrl + "/SeminarManagement-Maven-web/2.0/admin/propuestas/index.xhtml");
    driver.findElement(By.linkText("RECONSTRUCCIÓN")).click();
    driver.findElement(By.id("j_idt65:j_idt68")).click();
    driver.findElement(By.id("j_idt42:tipo_label")).click();
    driver.findElement(By.xpath("//div[@id='j_idt42:tipo_panel']/div[2]/ul/li[4]")).click();
    driver.findElement(By.id("j_idt42:bt1")).click();
    driver.findElement(By.id("j_idt42:j_idt80")).click();
    driver.findElement(By.id("j_idt65:j_idt77")).click();
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
