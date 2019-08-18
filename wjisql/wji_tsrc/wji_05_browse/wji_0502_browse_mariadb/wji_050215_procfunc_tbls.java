/**
 * Tests button 'Tables' in procedure/functions frame.
 */
import java.io.IOException;
import java.util.ArrayList;
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
import org.openqa.selenium.NoSuchElementException;

import org.testng.annotations.Test;
 
public class wji_050215_procfunc_tbls {
 
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
        String he = null; // HTML element.
 
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
        
        // 4. Go to proclist frame and click  Procedures & Functions button,        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        we = driver.findElement(By.xpath("//input[contains(@value, 'Procedures')]"));
        we.click();     
        
                  
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement cell2 = null;
        WebElement cell3 = null;
        
        // 5. Display list of stored procedures.
        System.out.println("List of Stored Procedures:");
        rows = driver.findElements(By.xpath("//*[@id='tbl-procs']/tbody/tr"));
        System.out.println("No of Stored Procedures : " + rows.size());
        
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id='tbl-procs']/tbody/tr[" + i + "]"));
            cell2 = tr.findElement(By.xpath("//*[@id='tbl-procs']/tbody/tr[" + i + "]/td[2]"));
            cell3 = tr.findElement(By.xpath("//*[@id='tbl-procs']/tbody/tr[" + i + "]/td[3]"));
            System.out.println("Name=" + cell2.getText() + ",\tproc/func=" + cell3.getText());
        }
        
        
        // 5. Go table list.      
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        we = driver.findElement(By.xpath("//input[contains(@value, 'Tables')]"));
        we.click();   
        
        // 6. Display table list.
        System.out.println("List of Tables:");
        rows = driver.findElements(By.xpath("//*[@id='tbl-tbls']/tbody/tr"));
        System.out.println("No of Tables: " + rows.size());
        
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id='tbl-tbls']/tbody/tr[" + i + "]"));
            cell2 = tr.findElement(By.xpath("//*[@id='tbl-tbls']/tbody/tr[" + i + "]/td[2]"));
            cell3 = tr.findElement(By.xpath("//*[@id='tbl-tbls']/tbody/tr[" + i + "]/td[3]"));
            System.out.println("Name=" + cell2.getText() + ",\tRows=" + cell3.getText());
        }
                
        System.out.flush();               
        
        // 7. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();     
        
        driver.quit();
        
        System.out.flush();

    }
}
