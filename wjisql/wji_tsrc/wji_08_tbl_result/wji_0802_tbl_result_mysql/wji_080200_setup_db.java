/**
 * Tests successful connection and disconnection.
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
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.Alert;
import org.openqa.selenium.UnhandledAlertException;
import org.openqa.selenium.NoAlertPresentException;

import org.testng.annotations.Test;
 
public class wji_080200_setup_db {
 
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
        int waitedTime = 0; // seconds

 
        //driver = new ChromeDriver(browserOptions);
        driver = new FirefoxDriver(browserOptions);
        
        driver.get(args[0]);
 
        Thread.sleep(1000);
 

        // 1. Click Connect menu link 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Connect"));
        we.click();
        

        // 2. Login into a database and check results
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

        // 3. Click SQL menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("SQL"));
        we.click();
                  
        // 4. Execute script to create tables emp and dept.
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear stmt window
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        // Create tables emp and dept.
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_16_sql_scripts/tst_16_002_sql_script_deptemp.sql");
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }
        System.out.println("sqlstmt=" + we.getAttribute("value"));
        
        // Execute the script stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();
        
        Thread.sleep(2000);

        
        /*
        // Check for errors in execution
        try {
            WebDriverWait wait = new WebDriverWait(driver, 30);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            // Ignore errors
            //System.out.println("Alert error message:");
            //System.out.println(errMsg);
            //System.out.println();
            
            alert.accept();
        } catch (Exception e) {
            //System.out.println("Error:Alert:" + e.getMessage());
            //System.out.println("Execution of statements failed.");
        }
        */

        // Check results.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-13")));  
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-14")));   
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement col = null; 
        
        for (int k=13; k <= 14; ++k) {
            we = driver.findElement(By.id("text-stmt-" + k));
            System.out.println("SQL stmt:" + we.getText());
            cols = driver.findElements(By.xpath("//*[@id='tbl-rs-" + k + "']/thead/tr[1]/th"));
            //if (cols.size() == 0) {
            //    continue;
            //}
            System.out.println("No of html table columns: " + cols.size());
            rows = driver.findElements(By.xpath("//*[@id='tbl-rs-" + k + "']/tbody/tr/td[1]"));
            System.out.println("No of html table rows: " + rows.size());
            // heading
            for (int j = 2; j <= cols.size(); ++j) {
                col = driver.findElement(By.xpath("//*[@id='tbl-rs-" + k + "']/thead/tr[1]/th[" + j + "]"));
                System.out.print((j == 2 ? "" : ",\t") + col.getText()); 
            }
            System.out.println();
            // data
            for (int i = 1; i <= rows.size(); ++i) {
                tr = driver.findElement(By.xpath("//*[@id='tbl-rs-" + k + "']/tbody/tr[" + i + "]"));
                for (int j = 2; j <= cols.size(); ++j) {
                    col = tr.findElement(By.xpath("//*[@id='tbl-rs-" + k + "']/tbody/tr[" + i + "]/td[" + j + "]"));
                    System.out.print((j == 2 ? "" : ",\t") + col.getText()); 
                }
                System.out.println();
            }
        }        
        
        
        // 5. Execute script to create table questions and indexes.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear stmt window
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
       
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_16_sql_scripts/tst_16_004_sql_script_keysindexes.sql");
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }
        System.out.println("sqlstmt=" + we.getAttribute("value"));
        
        // Execute the script stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();
        
        Thread.sleep(2000);
        
        // Check results.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-6")));   
        for (int k=6; k <= 6; ++k) {
            (new WebDriverWait(driver, 10)).until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-" + k))); 
            we = driver.findElement(By.id("text-stmt-" + k));
            System.out.println("SQL stmt:" + we.getText());
            cols = driver.findElements(By.xpath("//*[@id='tbl-rs-" + k + "']/thead/tr[1]/th"));
            //if (cols.size() == 0) {
            //    continue;
            //}
            System.out.println("No of html table columns: " + cols.size());
            rows = driver.findElements(By.xpath("//*[@id='tbl-rs-" + k + "']/tbody/tr/td[1]"));
            System.out.println("No of html table rows: " + rows.size());
            // heading
            for (int j = 2; j <= cols.size(); ++j) {
                col = driver.findElement(By.xpath("//*[@id='tbl-rs-" + k + "']/thead/tr[1]/th[" + j + "]"));
                System.out.print((j == 2 ? "" : ",\t") + col.getText()); 
            }
            System.out.println();
            // data
            for (int i = 1; i <= rows.size(); ++i) {
                tr = driver.findElement(By.xpath("//*[@id='tbl-rs-" + k + "']/tbody/tr[" + i + "]"));
                for (int j = 2; j <= cols.size(); ++j) {
                    col = tr.findElement(By.xpath("//*[@id='tbl-rs-" + k + "']/tbody/tr[" + i + "]/td[" + j + "]"));
                    System.out.print((j == 2 ? "" : ",\t") + col.getText()); 
                }
                System.out.println();
            }
        }         
        
        System.out.flush();
                
        
        // 6. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();
        
        
        driver.quit();
        
        System.out.flush();

    }
}
