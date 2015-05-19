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

public class T018ComoUsuarioQuieroEditarCorrectamenteLosMailsDeLosProfesores {
  private WebDriver driver;
  private String baseUrl;
  private boolean acceptNextAlert = true;
  private StringBuffer verificationErrors = new StringBuffer();

  @Before
  public void setUp() throws Exception {
    DesiredCapabilities capabilities = DesiredCapabilities.phantomjs();
    PhantomJSDriver driver = new PhantomJSDriver(capabilities);
    baseUrl = "http://localhost:8080/SeminarManagement-Maven-web/";
    driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
  }

  @Test
  public void testT018ComoUsuarioQuieroEditarCorrectamenteLosMailsDeLosProfesores() throws Exception {
    driver.get(baseUrl + "/SeminarManagement-Maven-web/2.0/admin/profesores/index.xhtml");
    driver.findElement(By.linkText("CRISTÓBAL ACOSTA")).click();
    driver.findElement(By.id("j_idt63")).click();
    driver.findElement(By.id("j_idt46:celular")).clear();
    driver.findElement(By.id("j_idt46:celular")).sendKeys("74315582");
    driver.findElement(By.id("j_idt46:mail")).clear();
    driver.findElement(By.id("j_idt46:mail")).sendKeys("a@a.cl");
    driver.findElement(By.id("j_idt46:bt1")).click();
    driver.findElement(By.id("j_idt44")).click();
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
