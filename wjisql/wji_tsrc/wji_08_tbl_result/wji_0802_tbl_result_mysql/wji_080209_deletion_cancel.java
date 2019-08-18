/**
 * Tests cancelation of deletion of data.
 */
import java.io.IOException;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.Color;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.Alert;
import org.openqa.selenium.UnhandledAlertException;
import org.openqa.selenium.NoAlertPresentException;

import org.testng.annotations.Test;
 
class wji_080209_deletion_cancel {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        //System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        //ChromeOptions browserOptions = new ChromeOptions();
        System.setProperty("webdriver.gecko.driver", "/usr/bin/geckodriver");
        FirefoxOptions browserOptions = new FirefoxOptions();
        
        browserOptions.addArguments("--headless");
        browserOptions.addArguments("--no-sandbox");
 
        WebDriver driver = null;
        WebElement we = null;
        List<WebElement> weList = null;
        String currVersion = "";
        String frameSource = "";
        WebElement waitForWe = null;

 
        //driver = new ChromeDriver(browserOptions);
        driver = new FirefoxDriver(browserOptions);

        driver.get(args[0]);
 
        Thread.sleep(1000);
 

        // 1. Click Connect menu link 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Connect"));
        we.click();
        

        // 2. Login into a database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        // select jdbc driver
        we = driver.findElement(By.name("jdriver_name"));
        Select jdbcDriverSelect = new Select(we);
        jdbcDriverSelect.selectByVisibleText(System.getenv("WJI_JDBC_DRIVER_NAME"));
        // enter url
        we = driver.findElement(By.name("dburl"));
        we.clear();
        we.sendKeys(System.getenv("WJI_JDBC_URL"));
        if (System.getenv("WJI_JDBC_URL").contains("sqlite")) {
            // Do not need userid and passwords.
        } else {
            // enter user id
            we = driver.findElement(By.name("userid"));
            we.sendKeys(System.getenv("WJI_USER_ID"));
            // enter password
            we = driver.findElement(By.name("password"));
            we.sendKeys(System.getenv("WJI_USER_PASSWD"));
        }

        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(1000);

        // 3. Click Browse menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Browse"));
        we.click();
                  
        
        // 4. Click on table emp.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-tbls")));
        we = driver.findElement(By.linkText("questions"));
        we.click();
        
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement tblNameEle = null; 
        WebElement col = null; 
        WebElement button = null;
        
        // 5. Click on 'Data'  button
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.xpath("//input[@value='Data']")));
        button = driver.findElement(By.xpath("//input[@value='Data']"));
        button.click();
        // Wait for html result set table is displayed 
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-0")));
        
        // 6. Check rows before delete button is clicked.
        rows = driver.findElements(By.xpath("//*[@id=\"tbl-rs-0\"]/tbody/tr/td[1]"));
        System.out.println("No rows before deletion: " + rows.size());

        // 7. Select row 2 for deleting
        button = driver.findElement(By.xpath("//input[@name='vr2c0']"));
        button.click();       
        
        // 8. Click buttion 'Delete' to delete without selecting any row to delete.
        button = driver.findElement(By.xpath("//input[@value='Delete']"));
        button.click();
        
        // 9. Click Cancel on pop up.
        try {
            WebDriverWait wait = new WebDriverWait(driver, 30);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert message:" + errMsg);
            alert.dismiss();
        } catch (Exception e) {
            //System.out.println("Error:Alert:" + e.getMessage());
            //System.out.println("Execution of statements failed.");
        }        
        
        // Wait for html result set table is displayed.
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-0")));   
        
        // 10. Check rows after deletion failure
        rows = driver.findElements(By.xpath("//*[@id=\"tbl-rs-0\"]/tbody/tr/td[1]"));
        System.out.println("No rows after deletion failure: " + rows.size());
       
        
        
        System.out.flush();               
        
        // 11. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();     
        
        driver.quit();
        
        System.out.flush();

    }
}
