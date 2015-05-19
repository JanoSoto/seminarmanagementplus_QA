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

public class T007AccederALosMDulosCorrectosDelAdministrador {
  private WebDriver driver;
  private String baseUrl;
  private boolean acceptNextAlert = true;
  private StringBuffer verificationErrors = new StringBuffer();

  @Before
  public void setUp() throws Exception {
    dDesiredCapabilities capabilities = DesiredCapabilities.phantomjs();
    PhantomJSDriver driver = new PhantomJSDriver(capabilities);
    baseUrl = "http://ruka.diinf.usach.cl:8080/SeminarManagement-Maven-web/";
    driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
  }

  @Test
  public void testT007AccederALosMDulosCorrectosDelAdministrador() throws Exception {
    driver.get(baseUrl + "/SeminarManagement-Maven-web/2.0/admin/index.xhtml");
    driver.findElement(By.xpath("//a[@id='j_idt22:j_idt31']/span[2]")).click();
    driver.findElement(By.xpath("//a[@id='j_idt23:j_idt31']/span[2]")).click();
    driver.findElement(By.id("j_idt23:j_idt30")).click();
    driver.findElement(By.xpath("//a[@id='j_idt23:j_idt29']/span[2]")).click();
    driver.findElement(By.xpath("//a[@id='j_idt23:j_idt28']/span[2]")).click();
    driver.findElement(By.xpath("//a[@id='j_idt23:j_idt27']/span[2]")).click();
    driver.findElement(By.xpath("//a[@id='j_idt23:j_idt26']/span[2]")).click();
    driver.findElement(By.cssSelector("span.ui-menuitem-text")).click();
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
