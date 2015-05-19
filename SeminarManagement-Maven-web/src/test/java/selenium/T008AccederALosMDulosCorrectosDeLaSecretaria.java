package selenium;

import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class T008AccederALosMDulosCorrectosDeLaSecretaria {
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
  public void testT008AccederALosMDulosCorrectosDeLaSecretaria() throws Exception {
    driver.get(baseUrl + "/SeminarManagement-Maven-web/");
    driver.findElement(By.id("j_idt39:username")).clear();
    driver.findElement(By.id("j_idt39:username")).sendKeys("SECRE");
    driver.findElement(By.id("j_idt39:Password")).clear();
    driver.findElement(By.id("j_idt39:Password")).sendKeys("SECRE");
    driver.findElement(By.id("j_idt19:j_idt29")).click();
    driver.findElement(By.xpath("//a[@id='j_idt20:j_idt31']/span[2]")).click();
    driver.findElement(By.xpath("//a[@id='j_idt20:j_idt32']/span")).click();
    driver.findElement(By.xpath("//a[@id='j_idt20:j_idt33']/span[2]")).click();
    driver.findElement(By.id("j_idt20:j_idt35")).click();
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