/**
 * Tests execution of multiple selected statements.
 */
import java.io.IOException;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.Alert;
import org.openqa.selenium.UnhandledAlertException;
import org.openqa.selenium.NoAlertPresentException;
 
public class wji_060708_exec_multiple_selected_stmts {
 
    private static String getStmtStr(String sqlStmtStr, int stmtNum)
    {
        String stmtStr = null;
        String[] stmtStrArr = sqlStmtStr.split("\n");
        return stmtStrArr[stmtNum-1];
        
    }
    public static void main(String[] args) throws IOException, InterruptedException { 
        WebDriver driver = null;
        WebElement we = null;
        List<WebElement> weList = null;
        String currVersion = "";
        String frameSource = "";
 
        System.setProperty("webdriver.gecko.driver", "/usr/bin/geckodriver");
        FirefoxOptions firefoxOptions = new FirefoxOptions();
        firefoxOptions.addArguments("--headless");
        firefoxOptions.addArguments("--no-sandbox");

        driver = new FirefoxDriver(firefoxOptions);
        // Invoke wjISQL
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

        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(1000);

        // 3. Click SQL menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("SQL"));
        we.click();
        
        // 4. Execute SQL script.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear stmt window
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_16_sql_scripts/tst_16_001_sql_script.sql");
        we =  driver.findElement(By.id("user_sqlstmt"));
        String sqlStmtStr = we.getAttribute("value");
        System.out.println("sqlstmt=" + sqlStmtStr);
        System.out.println();
        
        // Select multiple statements as per the test plan;
        System.out.println("Test not yet implemented as no idea how to select lines in textarea.");
        
        /*
        String reqdStmtStr = getStmtStr(sqlStmtStr, 11);
        System.out.println("SQL stmt to be executed=" + reqdStmtStr);
        we.sendKeys(sqlStmtStr, reqdStmtStr);  
        we =  driver.findElement(By.id("user_sqlstmt"));
        */
        /*
        sqlStmtStr = we.getAttribute("value");
        System.out.println("sqlstmt after selection=" + sqlStmtStr);
        
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();        
        
        // 5. Check results
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement col = null; 
        
        Thread.sleep(5000);
        for (int k=0; k < 1; ++k) {
            we = driver.findElement(By.id("text-stmt-" + k));
            System.out.println("SQL stmt:" + we.getText());
            cols = driver.findElements(By.xpath("//*[@id='tbl-rs-" + k + "']/thead/tr[1]/th"));
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
        */
        
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
