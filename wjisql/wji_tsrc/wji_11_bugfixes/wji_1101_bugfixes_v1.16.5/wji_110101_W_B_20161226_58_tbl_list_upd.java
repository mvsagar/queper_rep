/**
 * Tests fix for the bug W_B_20161226_58 - table refresh after data transfer does not happen.
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
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
import org.openqa.selenium.NoSuchElementException;

import org.testng.annotations.Test;
 
public class wji_110101_W_B_20161226_58_tbl_list_upd {
 
    
    private static void printHtmlTable(WebDriver driver, String htmlTblId)
    {
        List cols = null;
        List rows = null;
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
    
    /*
     * 
     * Executes OS command. 
     *
     */
    public static void executeCommand(String cmd) {
        String s;
        int ret;
        int i;
        
        try {
            Process p = Runtime.getRuntime().exec(cmd);
            
            BufferedReader stdInput = new BufferedReader(new
                 InputStreamReader(p.getInputStream()));

            BufferedReader stdError = new BufferedReader(new
                 InputStreamReader(p.getErrorStream()));

            // Read each output line from the command output and put it into output array.
            i = 0;
            while ((s = stdInput.readLine()) != null) {
                if ( s.isEmpty() || s.trim().equals("") || s.trim().equals("\n")) {
                    // Don't do any thing.  
                } else {
                    System.out.println(s);
                    ++i;
                }
            }
             
            // read any errors from the attempted command
            while ((s = stdError.readLine()) != null) {
                System.out.println("Error:" + s);
            }
            
            p.waitFor();
            ret = p.exitValue();
            if (ret != 0) {
                System.out.println("Error: Waiting for command execution returned " + ret);
            }
        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
        } catch (InterruptedException ie) {
            System.out.println("Error: " + ie.getMessage());
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
        
        
        if (args.length != 2) {
            System.out.println("Error: Number of arguments passed is not 2.");
            return;
        }
        String dbms = args[1];
        if (!dbms.equals("mariadb") && !dbms.equals("pgsql") && !dbms.equals("sqlite")) {
            System.out.println("Error: Wrong dbms argument '" + dbms + "'");
            return;
        }      

        // 1. Click Connect menu link 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Connect"));
        we.click();
        
        // 2. Connect to destdb as user destusr
        // Click Connect menu link 
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
        jdbcDriverSelect.selectByVisibleText(System.getenv("WJI_DEST_JDBC_DRIVER_NAME"));
        // enter url
        we = driver.findElement(By.name("dburl"));
        we.clear();
        we.sendKeys(System.getenv("WJI_DEST_JDBC_URL"));
        if (System.getenv("WJI_DEST_JDBC_URL").contains("sqlite")) {
            // Do not need userid and passwords.
        } else {
            // enter user id
            we = driver.findElement(By.name("userid"));
            we.clear();
            we.sendKeys(System.getenv("WJI_DEST_USER_ID"));
            // enter password
            we = driver.findElement(By.name("password"));
            we.clear();
            we.sendKeys(System.getenv("WJI_DEST_USER_PASSWD"));
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
         
        // 3. Drop tables by executing script stmts.
        we = driver.findElement(By.id("script_files"));
        if (dbms.equals("mariadb")) {
            we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_18_basic_mariadb_tables/tst_18_001_tables_drop_uc.sql");       
        } else if (dbms.equals("pgsql")) {
            we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_04_basic_pgsql_tables/tst_04_001_tables_drop_uc.sql");       
        } else if (dbms.equals("sqlite")) {
            we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_13_basic_sqlite_tables/tst_13_001_tables_drop_uc.sql");       
        } else {
            System.out.println("Error: Wrong dbms argument '" + dbms + "'");
            return;
        }
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }
        // Execute stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click(); 
        // Wait till stmts are executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-7"))); 
   

        // 4. Create tables by executing script stmts.
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));        
        
        we = driver.findElement(By.id("script_files"));
        if (dbms.equals("mariadb")) {
            we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_18_basic_mariadb_tables/tst_18_002_tables_create_uc.sql");       
        } else if (dbms.equals("pgsql")) {
            we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_04_basic_pgsql_tables/tst_04_002_tables_create_uc.sql");       
        } else if (dbms.equals("sqlite")) {
            we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_13_basic_sqlite_tables/tst_13_002_tables_create_uc.sql");       
        } else {
            System.out.println("Error: Wrong dbms argument '" + dbms + "'");
            return;
        }
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }
        // Execute stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click(); 
        // Wait till stmts are executed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        if (dbms.equals("sqlite")) {
            waitForWe = (new WebDriverWait(driver, 10))
                    .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-3"))); 
        } else {
            waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-5"))); 
        }  
        
        // 5. Disconnet from destination database.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();        
       

        // 6. Click Transfer menu link 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Transfer"));
        we.click();
        Thread.sleep(2000);

        // 7. Login into source database.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("datafr");
        driver.switchTo().frame("rightdatafr");
        driver.switchTo().frame("rightdatafr1");
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
       

        // Check source tables
        // wait till SQL statement window is displayed
        driver.switchTo().defaultContent();
        driver.switchTo().frame("datafr");
        driver.switchTo().frame("leftdatafr");
        driver.switchTo().frame("leftdatafr1");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("src-tbl-list")));
        
        System.out.println("Source table list:");
        printHtmlTable(driver, "src-tbl-list");
        
        // 8. Login into destdb as user destusr
        driver.switchTo().defaultContent();
        driver.switchTo().frame("datafr");
        driver.switchTo().frame("rightdatafr");
        driver.switchTo().frame("rightdatafr2");
        // select jdbc driver
        we = driver.findElement(By.name("jdriver_name"));
        jdbcDriverSelect = new Select(we);
        jdbcDriverSelect.selectByVisibleText(System.getenv("WJI_DEST_JDBC_DRIVER_NAME"));
        // enter url
        we = driver.findElement(By.name("dburl"));
        we.clear();
        we.sendKeys(System.getenv("WJI_DEST_JDBC_URL"));
        if (System.getenv("WJI_DEST_JDBC_URL").contains("sqlite")) {
            // Do not need userid and passwords.
        } else {
            // enter user id
            we = driver.findElement(By.name("userid"));
            we.clear();
            we.sendKeys(System.getenv("WJI_DEST_USER_ID"));
            // enter password
            we = driver.findElement(By.name("password"));
            we.clear();
            we.sendKeys(System.getenv("WJI_DEST_USER_PASSWD"));
        }
        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        Thread.sleep(5000);       
        
        // Check for tables after transfer.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("datafr");
        driver.switchTo().frame("leftdatafr");
        driver.switchTo().frame("leftdatafr2");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("dest-tbl-list")));
         
        // list tables 
        System.out.println("\nDestination tables before transfer:");
        printHtmlTable(driver, "dest-tbl-list");
        
        // 9. Select all source tables for data transfer.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("datafr");
        driver.switchTo().frame("leftdatafr");
        driver.switchTo().frame("leftdatafr1");        
        we = driver.findElement(By.xpath("//*[@id='src-tbl-list']/thead/tr/th[4]/input[@name='xfrall']"));
        we.click();
        
        // 10. initiate transfer.
        we = driver.findElement(By.xpath("//input[@value='Transfer']"));
        we.click();
        // Accept pop up to confirm transfer.
        try {
            WebDriverWait wait = new WebDriverWait(driver, 30);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert message:" + errMsg);
            alert.accept();
        } catch (Exception e) {
            //System.out.println("Error:Alert:" + e.getMessage());
            //System.out.println("Execution of statements failed.");
        }          
        // Wait for some time for the transfer to complete.
        Thread.sleep(5000);
        // Display number of number of rows transafered in each table.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("datafr");
        driver.switchTo().frame("leftdatafr");
        driver.switchTo().frame("leftdatafr2");       
        // list tables for verification.
        System.out.println("\nDestination tables after transfer:");
        printHtmlTable(driver, "dest-tbl-list");   
        
        System.out.println("Successful if number of rows in destination tables is the same as that of source tables.");
        System.out.flush();
                        
        // 11. Disconnection from the databases
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect source"));
        we.click();
        we = driver.findElement(By.linkText("Disconnect destination"));
        we.click();
        
        
        driver.quit();
        
        System.out.flush();

    }
}
