/**
 * Sets destination db for data transfer/
 */
import java.io.BufferedReader;
import java.io.InputStreamReader;
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
 
public class wji_090000_setup_db {
    
    /*
     * Ignore the blank line returns only lines which contains value.
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
        String currVersion = "";
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
        

        // 2. Login into a database as root user.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        // select jdbc driver
        we = driver.findElement(By.name("jdriver_name"));
        Select jdbcDriverSelect = new Select(we);
        jdbcDriverSelect.selectByVisibleText(System.getenv("WJI_DEST_SUPER_JDBC_DRIVER_NAME"));
        // enter url
        we = driver.findElement(By.name("dburl"));
        we.clear();
        we.sendKeys(System.getenv("WJI_DEST_SUPER_JDBC_URL"));
        if (System.getenv("WJI_DEST_SUPER_JDBC_URL").contains("sqlite")) {
            // Do not need userid and passwords.
        } else {
            // enter user id
            we = driver.findElement(By.name("userid"));
            we.clear();
            we.sendKeys(System.getenv("WJI_DEST_SUPER_USER_ID"));
            // enter password
            we = driver.findElement(By.name("password"));
            we.clear();
            we.sendKeys(System.getenv("WJI_DEST_SUPER_USER_PASSWD"));
        }

        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(5000);

        // 3. Click SQL menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("SQL"));
        we.click();
                  
        // 4. Drop database destdb if exists.        
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5))
        .until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));
        // Clear stmt window
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();       
        // Enter SQL stmt to drop the database.
        we = driver.findElement(By.id("user_sqlstmt"));
        if (dbms.equals("mariadb")) {
            we.sendKeys("DROP DATABASE IF EXISTS destdb;" 
                + "DROP USER IF EXISTS 'destusr'@'%';");
        } else if (dbms.equals("pgsql")) {
            we.sendKeys("DROP DATABASE IF EXISTS destdb;" 
                    + "DROP USER IF EXISTS destusr;");
        } else if (dbms.equals("sqlite")) {
            executeCommand("rm -f /tmp/destdb");
        }
        
        if (!dbms.equals("sqlite")) {
            // Execute the stmt.
            we = driver.findElement(By.xpath("//input[@value='Execute']"));
            we.click();
            // wait
            driver.switchTo().defaultContent();
            driver.switchTo().frame("rightdatafr");
            waitForWe = (new WebDriverWait(driver, 10))
                    .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-1")));
            Thread.sleep(2000);
    
            // 5. Create database destdb, create user and grant permissions.      
            driver.switchTo().defaultContent();
            (new WebDriverWait(driver, 5))
            .until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));
            // Clear stmt window
            we = driver.findElement(By.xpath("//input[@value='Clear']"));
            we.click();       
            // Enter SQL stmt to create db and tmp user.
            we = driver.findElement(By.id("user_sqlstmt"));
            if (dbms.equals("mariadb")){
                we.sendKeys("CREATE DATABASE destdb CHARACTER SET=utf8;"
                    + "CREATE USER 'destusr'@'%' IDENTIFIED BY 'dest123';"
                    + "GRANT ALL ON destdb.* TO 'destusr'@'%';"
                    );
            } else if (dbms.equals("pgsql")) {
                we.sendKeys("CREATE DATABASE destdb;"
                        + "CREATE USER destusr WITH PASSWORD 'dest123';"
                        + "ALTER USER destusr WITH SUPERUSER;"
                        );
            } else if (dbms.equals("sqlite")) {
                // No need to do anything as db is created if it does not exist and no user info needed.
            }
            // Execute the stmt.
            we = driver.findElement(By.xpath("//input[@value='Execute']"));
            we.click();
            // wait till the last stmt is executed.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("rightdatafr");
            waitForWe = (new WebDriverWait(driver, 10))
                    .until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-2")));
        }
        
        // 6. Disconnect user root
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();
        
        // 7. Connect to destdb as user destusr
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
         

        // 8. Create tables by executing script stmts.
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
        // List tables
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Browse"));
        we.click();  
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        
        List cols = null;
        List rows = null;
        
        cols = driver.findElements(By.xpath("//*[@id='tbl-tbls']/thead/tr[1]/th"));
        System.out.println("No of html table columns: " + cols.size());
        rows = driver.findElements(By.xpath("//*[@id='tbl-tbls']/tbody/tr"));
        System.out.println("No of html table rows: " + rows.size());
       
        System.out.println();
        // data
        for (int i = 1; i <= rows.size(); ++i) {
            for (int j = 1; j <= 3; ++j) {
                we = driver.findElement(By.xpath("//*[@id='tbl-tbls']/tbody/tr[" + i + "]/td[" + j + "]"));
                System.out.print((j == 1 ? "" : ",\t") + we.getText()); 
            }
            System.out.println();
        }
          
        
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
