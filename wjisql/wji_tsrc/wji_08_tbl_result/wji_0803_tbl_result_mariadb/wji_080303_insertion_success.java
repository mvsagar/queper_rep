/**
 * Tests successful insertion of data.
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
 
public class wji_080303_insertion_success {
 
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
        // Wait for html result set table is displayed.
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-0")));
        
        // 6. Click buttion 'Insert'
        button = driver.findElement(By.xpath("//input[@value='Insert']"));
        button.click();
        // Wait for html result set table is displayed.
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-0")));
        
        // 7. Supply data in the first empty row.
        col = driver.findElement(By.xpath("//input[@name='vr1c1']")); 
        col.sendKeys("1001");
        col = driver.findElement(By.xpath("//input[@name='vr1c2']")); 
        col.sendKeys("1");
        col = driver.findElement(By.xpath("//input[@name='vr1c3']")); 
        col.sendKeys("1");
        col = driver.findElement(By.xpath("//input[@name='vr1c4']")); 
        col.sendKeys("2");
        col = driver.findElement(By.xpath("//input[@name='vr1c5']")); 
        col.sendKeys("1");        
        col = driver.findElement(By.xpath("//input[@name='vr1c6']")); 
        col.sendKeys("Give an example of implementing an interface.");
        col = driver.findElement(By.xpath("//input[@name='vr1c7']")); 
        col.sendKeys("3");         
        col = driver.findElement(By.xpath("//input[@name='vr1c8']")); 
        col.sendKeys("3");    
        
        // 8. Click buttion 'Confirm'
        button = driver.findElement(By.xpath("//input[@value='Confirm']"));
        button.click();
        
        // Wait for html result set table is displayed.
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-0")));        
        
        // 9. Check primary key column color.
        Thread.sleep(1000);
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
                    
        cols = driver.findElements(By.xpath("//*[@id=\"tbl-rs-0\"]/thead/tr/th"));
        System.out.println("No of html tbl columns: " + cols.size());
        rows = driver.findElements(By.xpath("//*[@id=\"tbl-rs-0\"]/tbody/tr/td[1]"));
        System.out.println("No of html table rows: " + rows.size());
        // Column names
        tr = driver.findElement(By.xpath("//*[@id=\"tbl-rs-0\"]/thead/tr[1]"));
        for (int j = 3; j <= cols.size(); ++j) {
            col = tr.findElement(By.xpath("//*[@id=\"tbl-rs-0\"]/thead/tr[1]/th[" + j + "]"));
            System.out.print((j == 3 ? "" : ",\t") + col.getText());
        }
        System.out.println();
        // Column values and color.
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id=\"tbl-rs-0\"]/tbody/tr[" + i + "]"));
            // Get key columns and check color.
            for (int j = 3; j <= cols.size(); ++j) {
                col = tr.findElement(By.xpath("//*[@id=\"tbl-rs-0\"]/tbody/tr[" + i + "]/td[" + j + "]"));
                System.out.print((j == 3 ? "(" : ",\t") + col.getText());
            }
            System.out.println();
        }
        
        System.out.flush();               
        
        // 10. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();     
        
        driver.quit();
        
        System.out.flush();

    }
}
