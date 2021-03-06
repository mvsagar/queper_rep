/**
 * Tests execution of an SQL procedure.
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
import org.openqa.selenium.Alert;
import org.openqa.selenium.UnhandledAlertException;
import org.openqa.selenium.NoAlertPresentException;

import org.testng.annotations.Test;
 
public class wji_060403_exec_proc {
 
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
        
        // 4. Execute an SQL stmt.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear stmt window
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        we =  driver.findElement(By.id("user_sqlstmt"));
        we.sendKeys("CALL proc_4_1_in_out_args(1, ?);");
        System.out.println("sqlstmt=" + we.getAttribute("value"));
        
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();        
        
        // 5. Check retrived data.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement col = null; 
        
        cols = driver.findElements(By.xpath("//*[@id='tbl-proc-result-0']/thead/tr/th"));
        System.out.println("No of html table columns: " + cols.size());
        rows = driver.findElements(By.xpath("//*[@id='tbl-proc-result-0']/tbody/tr/td[1]"));
        System.out.println("No of html table rows: " + rows.size());
        // heading
        for (int j = 2; j <= cols.size(); ++j) {
            col = driver.findElement(By.xpath("//*[@id='tbl-proc-result-0']/thead/tr[1]/th[" + j + "]"));
            System.out.print((j == 2 ? "" : ",\t") + col.getText()); 
        }
        System.out.println();
        // data
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id='tbl-proc-result-0']/tbody/tr[" + i + "]"));
            for (int j = 2; j <= cols.size(); ++j) {
                col = tr.findElement(By.xpath("//*[@id='tbl-proc-result-0']/tbody/tr[" + i + "]/td[" + j + "]"));
                System.out.print((j == 2 ? "" : ",\t") + col.getText()); 
            }
            System.out.println();
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
