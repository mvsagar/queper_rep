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
 * Setsup MariaDB database with Stored functions for testing.
 * 
 * @author mvsagar
 *
 */
public class wji_050303_db_setup_funcs {
 
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
                  
        // 4. Execute func drop script
        
        // 4.1 drop script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_06_basic_pgsql_funcs/tst_06_001_func_drop_uc.sql");
        Thread.sleep(2000);
        we =  driver.findElement(By.id("user_sqlstmt"));
        System.out.println("sqlstmt=" + we.getAttribute("value"));
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();
        // Check for errors in execution
        try {
            WebDriverWait wait = new WebDriverWait(driver, 5);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            // Ignore errors because drop command may fail.
            //System.out.println("Alert error message:");
            //System.out.println(errMsg);
            //System.out.println();
            
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
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-5")));
        
        
        // 4.2.1 Execute function create script 1
        
        // Supply func create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");

        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();

        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_06_basic_pgsql_funcs/tst_06_002_func_create_1_1_no_args_no_results_uc.sql");
        Thread.sleep(2000);
        we =  driver.findElement(By.id("user_sqlstmt"));
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

        // 4.2.2 Execute function create script 2
        
        // Supply func create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");

        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();

        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_06_basic_pgsql_funcs/tst_06_003_func_create_2_1_no_args_with_results_uc.sql");
        Thread.sleep(2000);
        we =  driver.findElement(By.id("user_sqlstmt"));
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
        
        // 4.2.3 Execute function create script 3
        
        // Supply func create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");

        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();

        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_06_basic_pgsql_funcs/tst_06_004_func_create_3_1_in_args_uc.sql");
        Thread.sleep(2000);
        we =  driver.findElement(By.id("user_sqlstmt"));
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

        
        // 4.2.4 Execute function create script 4
        
        // Supply func create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");

        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();

        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_06_basic_pgsql_funcs/tst_06_005_func_create_4_1_in_out_args_uc.sql");
        Thread.sleep(2000);
        we =  driver.findElement(By.id("user_sqlstmt"));
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
        
        // 4.2.5 Execute function create script 5
        
        // Supply func create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");

        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();

        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_06_basic_pgsql_funcs/tst_06_006_func_create_4_2_in_out_inout_args_uc.sql");
        Thread.sleep(2000);
        we =  driver.findElement(By.id("user_sqlstmt"));
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

        // 4.2.6 Execute function create script 6
        
        // Supply func create script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");

        // Clear the frame from any sql stmts.
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();

        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_06_basic_pgsql_funcs/tst_06_007_func_create_5_1_in_multi_stmt_uc.sql");
        Thread.sleep(2000);
        we =  driver.findElement(By.id("user_sqlstmt"));
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
        
        
        // 4.3. Execute func execute script
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_06_basic_pgsql_funcs/tst_06_008_func_exec_uc.sql");
        Thread.sleep(2000);
        we =  driver.findElement(By.id("user_sqlstmt"));
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
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-5")));
        
         

        // 5. Click navigation button browse and after that Procedures and Function
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Browse"));
        we.click();
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        we = driver.findElement(By.xpath("//input[contains(@value, 'Procedures')]"));
        we.click();
        
        // 6. Check funcedure created        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement cell2 = null;
        WebElement cell3 = null;
        
        System.out.println("List of Stored Functions:");
        cols = driver.findElements(By.xpath("//*[@id=\"tbl-funcs\"]/thead/tr/th"));
        System.out.println("No of cols are : " +cols.size());
        rows = driver.findElements(By.xpath("//*[@id=\"tbl-funcs\"]/tbody/tr"));
        System.out.println("No of rows are : " + rows.size());
        
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id=\"tbl-funcs\"]/tbody/tr[" + i + "]"));
            cell2 = tr.findElement(By.xpath("//*[@id=\"tbl-funcs\"]/tbody/tr[" + i + "]/td[2]"));
            cell3 = tr.findElement(By.xpath("//*[@id=\"tbl-funcs\"]/tbody/tr[" + i + "]/td[3]"));
            System.out.println("Name=" + cell2.getText() + ", func/func=" + cell3.getText());
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
