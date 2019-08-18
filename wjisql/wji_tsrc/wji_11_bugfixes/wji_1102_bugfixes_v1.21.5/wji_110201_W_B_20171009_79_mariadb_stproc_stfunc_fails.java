/**
 * Tests fix for the bug W_B_20171009_79: Stored procedure and function creation fails in MariaDB..
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
 
public class wji_110201_W_B_20171009_79_mariadb_stproc_stfunc_fails {
    
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
        
        // wait till SQL statement window is displayed
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("navifr"));
        we = driver.findElement(By.linkText("SQL"));
        we.click();
        
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));        
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("user_sqlstmt")));
                
        // 2. Execute statement to create procedure.
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));
        // Clear sqlstmt area first.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();    
        // Then execute.
        we = driver.findElement(By.id("user_sqlstmt"));
        we.sendKeys(" DROP PROCEDURE IF EXISTS test_proc; "
                + " CREATE PROCEDURE test_proc( "
                + "       IN in_int_arg INTEGER,"
                + "        OUT out_char_arg CHAR(50) "
                + "   ) "
                + "    BEGIN "
                + "       SELECT  CASE in_int_arg  "
                + "                    WHEN 1 THEN  'one'  "
                + "                    WHEN 2 THEN  'two'  "
                + "                    WHEN 3 THEN  'three'  "
                + "                    ELSE   'invalid'  "
                + "                    END "
                + "                INTO out_char_arg; "                       
                + "    END;   "               
                );               
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }
        // Execute stmt
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click(); 
        // Wait till stmts are executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        (new WebDriverWait(driver, 10)).until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-1")));

        
        // 3. Execute statement to create function.
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));
        // Clear sqlstmt area first.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();    
        // Then execute.
        we = driver.findElement(By.id("user_sqlstmt"));
        we.sendKeys(" DROP FUNCTION IF EXISTS test_func; "  
                + " CREATE FUNCTION test_func(in_int_arg INTEGER) "
                + "       RETURNS CHAR(50) "
                + "    BEGIN "
                + "       DECLARE char_val CHAR(50);"
                + "       SELECT  CASE in_int_arg  "
                + "                    WHEN 1 THEN  'one'  "
                + "                    WHEN 2 THEN  'two'  "
                + "                    WHEN 3 THEN  'three'  "
                + "                    ELSE   'invalid'  "
                + "                    END "
                + "                INTO char_val; "    
                + "       RETURN char_val; "
                + "    END;   "             
                );               
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }
        // Execute stmt
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click(); 
        // Wait till stmts are executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        (new WebDriverWait(driver, 10)).until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-1")));
        
        
        // 4. Display list procedures and functions
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("navifr"));
        we = driver.findElement(By.linkText("SQL"));
        we.click();  
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("leftdatafr"));        
        we = driver.findElement(By.xpath("//input[contains(@value, 'Procedures')]"));
        we.click();  
        System.out.println("\nList of procedures:");
        printHtmlTable(driver, "tbl-procs");
        System.out.println("Success if procedure test_proc is in the above list.");
        System.out.println("\nList of procedures:");
        printHtmlTable(driver, "tbl-funcs");
        System.out.println("Success if function test_func is in the above list.");       
        
        // 5. Drop the procedure and functions.
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));        
        we = driver.findElement(By.id("user_sqlstmt"));
        we.clear();
        we.sendKeys("DROP PROCEDURE IF EXISTS test_proc;"
                + "DROP FUNCTION IF EXISTS test_func;"
                );               
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }
        // Execute stmt
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();           
        
        // 6. Logout 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();
        
        
        System.out.flush();
        
        driver.quit();
   }
}
