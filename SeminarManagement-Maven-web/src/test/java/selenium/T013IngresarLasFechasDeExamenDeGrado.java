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

public class T013IngresarLasFechasDeExamenDeGrado {
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
  public void testT013IngresarLasFechasDeExamenDeGrado() throws Exception {
    driver.get(baseUrl + "/SeminarManagement-Maven-web/2.0/admin/temas/index.xhtml");
    driver.findElement(By.linkText("ASDTEMA")).click();
    driver.findElement(By.id("j_idt87")).click();
    driver.findElement(By.id("j_idt42:calendP_input")).click();
    driver.findElement(By.linkText("27")).click();
    driver.findElement(By.id("j_idt42:bt1")).click();
    driver.findElement(By.xpath("//a[@id='j_idt24:j_idt29']/span[2]")).click();
    new Select(driver.findElement(By.id("j_idt44:propTable:j_idt50:filter"))).selectByVisibleText("VIGENTE, CON BORRADOR FINAL");
    driver.findElement(By.cssSelector("option[value=\"VIGENTE, CON BORRADOR FINAL\"]")).click();
    driver.findElement(By.linkText("ASDTEMA")).click();
    driver.findElement(By.id("j_idt84")).click();
    driver.findElement(By.id("j_idt42:profeR1P_label")).click();
    driver.findElement(By.xpath("//div[@id='j_idt42:profeR1P_panel']/div[2]/ul/li[6]")).click();
    driver.findElement(By.id("j_idt42:calendP_input")).click();
    driver.findElement(By.linkText("20")).click();
    driver.findElement(By.id("j_idt42:profeR2P_label")).click();
    driver.findElement(By.xpath("//div[@id='j_idt42:profeR2P_panel']/div[2]/ul/li[5]")).click();
    driver.findElement(By.id("j_idt42:calendP3_input")).click();
    driver.findElement(By.linkText("22")).click();
    driver.findElement(By.id("j_idt42:bt1")).click();
    driver.findElement(By.id("j_idt42:j_idt77")).click();
    driver.findElement(By.id("j_idt85")).click();
    driver.findElement(By.id("j_idt42:calendP2_input")).click();
    driver.findElement(By.linkText("22")).click();
    driver.findElement(By.id("j_idt42:calendP4_input")).click();
    driver.findElement(By.linkText("28")).click();
    driver.findElement(By.id("j_idt42:bt1")).click();
    driver.findElement(By.id("j_idt42:j_idt73")).click();
    driver.findElement(By.id("j_idt88")).click();
    driver.findElement(By.id("j_idt42:calendP_input")).click();
    driver.findElement(By.linkText("20")).click();
    driver.findElement(By.id("j_idt42:calendP2_input")).click();
    driver.findElement(By.linkText("5")).click();
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
