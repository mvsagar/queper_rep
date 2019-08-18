/**
 * Tests table data feature.
 */
import java.io.IOException;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.Alert;
import org.openqa.selenium.UnhandledAlertException;
import org.openqa.selenium.NoAlertPresentException;

import org.testng.annotations.Test;
 
public class wji_050206_tbl_data {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = null;
        WebElement we = null;
        List<WebElement> weList = null;
        String currVersion = "";
        String frameSource = "";
 
        driver = new ChromeDriver(chromeOptions);
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
        // enter user id
        we = driver.findElement(By.name("userid"));
        we.sendKeys(System.getenv("WJI_USER_ID"));
        // enter password
        we = driver.findElement(By.name("password"));
        we.sendKeys(System.getenv("WJI_USER_PASSWD"));
        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(1000);

        // 3. Click Browse menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Browse"));
        we.click();
                  
        
        // 4. Table data tests.
        
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement tblNameEle = null; 
        WebElement col = null; 
        WebElement button = null;
        
        // 4.1 Test data button for the first 3 tables - TC 1, 2 and 3
        
        for (int k = 1; k <= 3; ++k) {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("leftdatafr");
                    
            // Click first table to get the table properties.
            tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[" + k + "]"));
            tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[" + k + "]/td[2]"));
            System.out.println("Table=" + tblNameEle.getText());
            we = driver.findElement(By.linkText(tblNameEle.getText()));
            we.click();
            
            // Click Data button.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("rightdatafr");
            button = driver.findElement(By.xpath("//input[@value='Data']"));
            button.click();
            
            // Display table data.
            Thread.sleep(1000);
            driver.switchTo().defaultContent();
            driver.switchTo().frame("rightdatafr");
                    
            cols = driver.findElements(By.xpath("//*[@id=\"tbl-rs-0\"]/thead/tr/th"));
            System.out.println("No of html tbl columns: " + cols.size());
            rows = driver.findElements(By.xpath("//*[@id=\"tbl-rs-0\"]/tbody/tr/td[1]"));
            System.out.println("No of html table rows: " + rows.size());
            for (int i = 1; i <= rows.size(); ++i) {
                tr = driver.findElement(By.xpath("//*[@id=\"tbl-rs-0\"]/tbody/tr[" + i + "]"));
                for (int j = 2; j <= cols.size(); ++j) {
                    col = tr.findElement(By.xpath("//*[@id=\"tbl-rs-0\"]/tbody/tr[" + i + "]/td[" + j + "]"));
                    System.out.print((j == 2 ? "" : ",\t") + col.getText()); 
                }
                System.out.println();
                System.out.println();
            }
        } // k
                
        
        System.out.flush();               
        
        // 5. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();     
        
        driver.quit();
        
        System.out.flush();

    }
}
