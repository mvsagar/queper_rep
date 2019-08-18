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
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.Alert;
import org.openqa.selenium.UnhandledAlertException;
import org.openqa.selenium.NoAlertPresentException;

import org.testng.annotations.Test;

/**
 * Setsup MariaDB database with Stored procedures for testing.
 * 
 * @author mvsagar
 *
 */
public class wji_050102_db_setup_procs {
 
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
        int waitedTime = 0; // seconds
 
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

        // 3. Click SQL menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("SQL"));
        we.click();
                  
        // 4. Execute proc drop script
        
        // 4.1 drop script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");

        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();

        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_02_basic_mysql_procs/tst_02_001_proc_drop_uc.sql");
        Thread.sleep(2000);
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }           
        System.out.println("sqlstmt=" + we.getAttribute("value"));
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();
        // Check for errors in execution
        try {
            WebDriverWait wait = new WebDriverWait(driver, 5);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            // Ignore errors as drop may fail for the first time.
            //System.out.println("Alert error message:");
            //System.out.println(errMsg);
            //System.out.println();
            
            alert.accept();
        } catch (Exception e) {
            // If successful not alert. Hence it is not an error.
            /*
            System.out.println("Error:Alert:" + e.getMessage());
            System.out.println("Execution of statements failed.");
            */
        }
        // Wait till last stmt of the script is executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-4")));
        
        
        // 4.2. Execute Proc create script 1
        
        // Supply proc create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();

        
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_02_basic_mysql_procs/tst_02_002_proc_create_1_1_no_args_no_results_uc.sql");
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }            System.out.println("sqlstmt=" + we.getAttribute("value"));
        
        // Execute the script stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();
        // Check for errors in execution
        try {
            WebDriverWait wait = new WebDriverWait(driver, 5);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert error message:");
            System.out.println(errMsg);
            System.out.println();
            alert.accept();
        } catch (Exception e) {
            /*
            System.out.println("Error:Alert:" + e.getMessage());
            System.out.println("Execution of statements failed.");
            */
        } 
        // Wait till last stmt of the script is executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-0")));

        // 4.2. Execute proc create script 2
        
        // Supply proc create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_02_basic_mysql_procs/tst_02_003_proc_create_2_1_no_args_with_results_uc.sql");
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }            System.out.println("sqlstmt=" + we.getAttribute("value"));
        
        // Execute the script stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();
        // Check for errors in execution
        try {
            WebDriverWait wait = new WebDriverWait(driver, 5);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert error message:");
            System.out.println(errMsg);
            System.out.println();
            alert.accept();
        } catch (Exception e) {
            /*
            System.out.println("Error:Alert:" + e.getMessage());
            System.out.println("Execution of statements failed.");
            */
        } 
        // Wait till last stmt of the script is executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-0")));
        
        
        // 4.3. Execute proc create script 3
        
        // Supply proc create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_02_basic_mysql_procs/tst_02_004_proc_create_3_1_in_args_uc.sql");
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }            System.out.println("sqlstmt=" + we.getAttribute("value"));
        
        // Execute the script stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();
        // Check for errors in execution
        try {
            WebDriverWait wait = new WebDriverWait(driver, 5);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert error message:");
            System.out.println(errMsg);
            System.out.println();
            alert.accept();
        } catch (Exception e) {
            /*
            System.out.println("Error:Alert:" + e.getMessage());
            System.out.println("Execution of statements failed.");
            */
        } 
        // Wait till last stmt of the script is executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-0")));
        
        // 4.4. Execute proc create script 4
        
        // Supply proc create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_02_basic_mysql_procs/tst_02_005_proc_create_4_1_in_out_args_uc.sql");
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
        // Check for errors in execution
        try {
            WebDriverWait wait = new WebDriverWait(driver, 5);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert error message:");
            System.out.println(errMsg);
            System.out.println();
            alert.accept();
        } catch (Exception e) {
            /*
            System.out.println("Error:Alert:" + e.getMessage());
            System.out.println("Execution of statements failed.");
            */
        } 
        // Wait till last stmt of the script is executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-0")));

        
        // 4.5. Execute proc create script 5
        
        // Supply proc create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_02_basic_mysql_procs/tst_02_006_proc_create_5_1_multi_stmt_uc.sql");
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
        // Check for errors in execution
        try {
            WebDriverWait wait = new WebDriverWait(driver, 5);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert error message:");
            System.out.println(errMsg);
            System.out.println();
            alert.accept();
        } catch (Exception e) {
            /*
            System.out.println("Error:Alert:" + e.getMessage());
            System.out.println("Execution of statements failed.");
            */
        } 
        // Wait till last stmt of the script is executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-0")));

        
        // 4.6. Execute proc execute script
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_02_basic_mysql_procs/tst_02_007_proc_exec_uc.sql");
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
        
        // Check for errors in execution
        try {
            WebDriverWait wait = new WebDriverWait(driver, 5);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert error message:");
            System.out.println(errMsg);
            System.out.println();
            alert.accept();
        } catch (Exception e) {
            /*
            System.out.println("Error:Alert:" + e.getMessage());
            System.out.println("Execution of statements failed.");
            */
        } 
        // Wait till last stmt of the script is executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-4")));
        
         

        // 5. Click navigation button browse and after that Procedures and Function
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Browse"));
        we.click();
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        //we = driver.findElement(By.xpath("//input[@value='Procedures & Functions']"));
        we = driver.findElement(By.xpath("//input[contains(@value, 'Procedures')]"));
        we.click();
        
        // 6. Check procedure created        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement cell2 = null;
        WebElement cell3 = null;
        
        System.out.println("List of Stored Proedures:");
        cols = driver.findElements(By.xpath("//*[@id=\"tbl-procs\"]/thead/tr/th"));
        System.out.println("No of cols are : " +cols.size());
        rows = driver.findElements(By.xpath("//*[@id=\"tbl-procs\"]/tbody/tr"));
        System.out.println("No of rows are : " + rows.size());
        
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id=\"tbl-procs\"]/tbody/tr[" + i + "]"));
            cell2 = tr.findElement(By.xpath("//*[@id=\"tbl-procs\"]/tbody/tr[" + i + "]/td[2]"));
            cell3 = tr.findElement(By.xpath("//*[@id=\"tbl-procs\"]/tbody/tr[" + i + "]/td[3]"));
            System.out.println("Name=" + cell2.getText() + ", proc/func=" + cell3.getText());
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
