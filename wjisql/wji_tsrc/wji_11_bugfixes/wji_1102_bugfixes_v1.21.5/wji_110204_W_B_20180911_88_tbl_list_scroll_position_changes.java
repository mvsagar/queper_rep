/**
 * Tests fix for the bug W_B_20180911_88: Table list scroll position changes when select stmt is executed.
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
import org.openqa.selenium.NoSuchElementException;
import org.testng.annotations.Test;

import org.openqa.selenium.JavascriptExecutor;
 
public class wji_110204_W_B_20180911_88_tbl_list_scroll_position_changes {
    
    private static void printHtmlTable(WebDriver driver, String htmlTblId, boolean all)
    {
        List<WebElement> cols = null;
        List<WebElement> rows = null;
        WebElement col = null;
        WebElement row = null;
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
            try {
                col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/thead/tr[1]/th[" + j + "]/input"));
                val = (col.isSelected() ? "selected" : "not-selected");
                System.out.print(val);
            } catch (NoSuchElementException nsee) {
               //
            }   
        }
        System.out.println();
        // data
        for (int i = 1; i <= rows.size(); ++i) {
            row = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]"));
            if (!row.isDisplayed()) {
                continue;
            }

            for (int j = 1; j <= cols.size(); ++j) {
                try {
                    col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]/td[" + j + "]/a/input"));
                    val = col.getAttribute("value");
                } catch (NoSuchElementException nsee) {
                    try {
                        col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]/td[" + j + "]/input"));
                        val = (col.isSelected() ? "selected" : "not-selected");
                    } catch (NoSuchElementException nsee1) {
                        col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]/td[" + j + "]"));
                        val = col.getText();
                    }                    
                }
                if (all || col.isDisplayed() ) {
                    System.out.print((j == 1 ? "" : ",\t") + val); 
                }
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
        String currVersion = "";
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
        

        // 2. Login into a database.
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

        // 3. Create many tables.
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("navifr"));
        we = driver.findElement(By.linkText("SQL"));
        we.click(); 
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));        
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("user_sqlstmt")));
        // Drop tables  
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_17_bug_fix_scripts/tst_17_002_W_B_20180911_88_drop_many_tables.sql");       
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
        waitForWe = (new WebDriverWait(driver, 10)).until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-29"))); 
        
        // Create tables.
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));        
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("user_sqlstmt")));
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_17_bug_fix_scripts/tst_17_003_W_B_20180911_88_create_many_tables.sql");       
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
        waitForWe = (new WebDriverWait(driver, 10)).until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-29"))); 

        
        // List tables
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        System.out.println("Table list 1: All tables");
        printHtmlTable(driver, "tbl-tbls", true);
  
        // 4. Scroll to table tst_t5 which is by default out of view at the bottom.
        we = driver.findElement(By.linkText("tst_t5"));
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].scrollIntoView();", we);
        
        System.out.println("Table list 2: Visible table list after scrolling to tst_t5");
        // Currently the last argument does not work. Hence the following method 
        // returns all rows instead of displaying only visible rows.
        printHtmlTable(driver, "tbl-tbls", false);
        
        
        // 5. Execute a few select statements to check if table list gets disturbed.
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));        
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("user_sqlstmt")));
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_17_bug_fix_scripts/tst_17_004_W_B_20180911_88_select_many_tables.sql");       
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
        waitForWe = (new WebDriverWait(driver, 10)).until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-2"))); 

        // 6. List visible tables.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        System.out.println("Table list 3: Visible table list after executing many selects:");
        printHtmlTable(driver, "tbl-tbls", false); 
        System.out.println("Success if table list3 matches with table list 2.");
        System.out.flush();
          
        
        // 7. Drop created tables.
        driver.switchTo().defaultContent();
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("navifr"));
        we = driver.findElement(By.linkText("SQL"));
        we.click(); 
        (new WebDriverWait(driver, 5)).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("sqlstmtfr"));        
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("user_sqlstmt")));
        // Drop tables  
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_17_bug_fix_scripts/tst_17_002_W_B_20180911_88_drop_many_tables.sql");       
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
        waitForWe = (new WebDriverWait(driver, 10)).until(ExpectedConditions.presenceOfElementLocated(By.id("text-stmt-29"))); 
                
       
        // 8. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();
        
        
        driver.quit();
        
        System.out.flush();

    }
}
