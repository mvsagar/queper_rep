/**
 * Creates tables with data.
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
 
public class wji_050601_db_setup_tables {
 
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
        WebElement waitForWe = null; 
        int waitedTime = 0;
 
        driver = new ChromeDriver(chromeOptions);
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

        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(1000);

        // 3. Click SQL menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("SQL"));
        we.click();
                  
        // 4. Execute table drop script
        
        // 4.1 Supply table drop script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear stmt window
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_13_basic_sqlite_tables/tst_13_001_tables_drop_uc.sql");
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }      
        System.out.println("sqlstmt=" + we.getAttribute("value"));
        
        // 4.2. Execute the script stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();

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
        // Wait till last stmt of the script is executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-6")));        
        
        // 5. Execute table create script
        
        // 5.1 Supply table create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear stmt window
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_13_basic_sqlite_tables/tst_13_002_tables_create_uc.sql");
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }        
        System.out.println("sqlstmt=" + we.getAttribute("value"));
        
        // 5.2. Execute the script stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();
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
            System.out.println("Error:Alert:" + e.getMessage());
            System.out.println("Execution of statements failed.");
        } 
        */
        // Wait till last stmt of the script is executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-3")));        
        // 6. Execute table insert script
        
        // 6.1 Supply table insert script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_13_basic_sqlite_tables/tst_13_003_tables_insert_uc.sql");
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }      
        System.out.println("sqlstmt=" + we.getAttribute("value"));
        
        // 6.2. Execute the script stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();
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
            System.out.println("Error:Alert:" + e.getMessage());
            System.out.println("Execution of statements failed.");
        }            
        */
        // Wait till last stmt of the script is executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-19")));
        
        // 7. Click navigation button browse.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Browse"));
        we.click();
        
        // 8. Check tables and rows created.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        frameSource = driver.getPageSource();
            
        List  col = driver.findElements(By.xpath("//*[@id=\"tbl-tbls\"]/thead/tr/th"));
        System.out.println("No of cols are : " +col.size());
        List  rows = driver.findElements(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr/td[1]"));
        System.out.println("No of rows are : " + rows.size());
        
        WebElement tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[1]"));
        WebElement tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[1]/td[2]"));
        WebElement numRowsEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[1]/td[3]"));
        System.out.println("Table=" + tblNameEle.getText() + ", Numrows=" + numRowsEle.getText());

        tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[2]"));
        tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[2]/td[2]"));
        numRowsEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[2]/td[3]"));
        System.out.println("Table=" + tblNameEle.getText() + ", Numrows=" + numRowsEle.getText());

        tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[3]"));
        tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[3]/td[2]"));
        numRowsEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[3]/td[3]"));
        System.out.println("Table=" + tblNameEle.getText() + ", Numrows=" + numRowsEle.getText());
        
        tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[4]"));
        tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[4]/td[2]"));
        numRowsEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[4]/td[3]"));
        System.out.println("Table=" + tblNameEle.getText() + ", Numrows=" + numRowsEle.getText());
        
        System.out.flush();
                
        
        // 9. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();
        
        
        driver.quit();
        
        System.out.flush();

    }
}
