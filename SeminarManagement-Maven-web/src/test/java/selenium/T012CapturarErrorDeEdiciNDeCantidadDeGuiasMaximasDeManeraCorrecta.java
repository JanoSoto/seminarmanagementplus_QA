package selenium;

import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class T012CapturarErrorDeEdiciNDeCantidadDeGuiasMaximasDeManeraCorrecta {
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
  public void testT012CapturarErrorDeEdiciNDeCantidadDeGuiasMaximasDeManeraCorrecta() throws Exception {
    driver.get(baseUrl + "/SeminarManagement-Maven-web/2.0/admin/index.xhtml");
    driver.findElement(By.cssSelector("span.ui-menuitem-text")).click();
    driver.findElement(By.linkText("ALBERTO CEBALLO")).click();
    driver.findElement(By.id("j_idt64")).click();
    driver.findElement(By.id("editProf:maxGuia")).clear();
    driver.findElement(By.id("editProf:maxGuia")).sendKeys("a");
    driver.findElement(By.id("editProf:bt1")).click();
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
