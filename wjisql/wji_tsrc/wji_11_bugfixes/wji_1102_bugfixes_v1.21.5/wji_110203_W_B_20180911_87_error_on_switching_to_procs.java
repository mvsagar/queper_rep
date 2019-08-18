/**
 * Tests fix for the bug W_B_20180911_87: error on switching to procedures/functions.
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
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
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.TimeoutException;
import org.testng.annotations.Test;
 
public class wji_110203_W_B_20180911_87_error_on_switching_to_procs {
    
    private static void printHtmlTable(WebDriver driver, String htmlTblId)
    {
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement col = null;
        String val = null;
        
        cols = driver.findElements(By.xpath("//*[@id='" + htmlTblId + "']/thead/tr/th"));
        System.out.println("Number of html table columns: " + cols.size());
        rows = driver.findElements(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr"));
        System.out.println("Number of html table rows: " + rows.size());
        // Get columns and check color.
        // Column names
        for (int j = 1; j <= cols.size(); ++j) {
            col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/thead/tr[1]/th[" + j + "]"));
            System.out.print((j == 1 ? "" : ",\t") + col.getText());
        }
        System.out.println();
        // data
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]"));
            System.out.print("(row value color:" 
                + (tr.getAttribute("style").contains("background") ? tr.getAttribute("style") : "None") + ") ");
             
            for (int j = 1; j <= cols.size(); ++j) {
                try {
                    col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]/td[" + j + "]/a/input"));
                    val = col.getAttribute("value");
                } catch (NoSuchElementException nsee) {
                    col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]/td[" + j + "]"));
                    val = col.getText();
                }
                System.out.print((j == 1 ? "" : ",\t") + val); 
            }
            System.out.println();
        }       
    }  
       
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions browserOptions = new ChromeOptions();
        //System.setProperty("webdriver.gecko.driver", "/usr/bin/geckodriver");
        //FirefoxOptions browserOptions = new FirefoxOptions();
        
        browserOptions.addArguments("--headless");
        browserOptions.addArguments("--no-sandbox");
 
        WebDriver driver = null;
        WebElement we = null;
        List<WebElement> weList = null;
        Select jdbcDriverSelect = null;
       
        String frameSource = "";
        WebElement waitForWe = null;
        int waitedTime = 0; // seconds
 
        driver = new ChromeDriver(browserOptions);
        //driver = new FirefoxDriver(browserOptions);
        
        driver.get(args[0]);
 
        Thread.sleep(1000);


        // 1. Click Connect menu link 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Connect"));
        we.click();
        // Login into destdb database as destusr user.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        // select jdbc driver
        we = driver.findElement(By.name("jdriver_name"));
        jdbcDriverSelect = new Select(we);
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
            we.clear();
            we.sendKeys(System.getenv("WJI_USER_ID"));
            // enter password
            we = driver.findElement(By.name("password"));
            we.clear();
            we.sendKeys(System.getenv("WJI_USER_PASSWD"));
        }

        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(5000);
        
        // 2. List tables
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("leftdatafr"));
        System.out.println("List of tables:");
        printHtmlTable(driver, "tbl-tbls");
        
        // 3. Display list of procedures and functions
        System.out.println("\nSwitching to procedures/functions:");     
        we = driver.findElement(By.xpath("//input[contains(@value, 'Procedures')]"));
        we.click();  
        System.out.println("\nList of procedures:");
        printHtmlTable(driver, "tbl-procs");
        System.out.println("Success if procedure test_proc is in the above list.");
        System.out.println("\nList of functions:");
        printHtmlTable(driver, "tbl-funcs");
        System.out.println("Success if function test_func is in the above list.");       
        
        // 4. Logout 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();       
        
        System.out.flush();
        
        driver.quit();
   }
}