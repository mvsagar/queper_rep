/**
 * Tests successful connection and disconnection.
 */
import java.io.IOException;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;
 
public class wji_040601_succ_conn_disconn {
 
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

        // 2.1. Check for resultant navigation frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        frameSource = driver.getPageSource();
                
        currVersion = System.getenv("WJI_VERSION");
        if (frameSource.contains("wjISQL") 
                 && frameSource.contains(currVersion)
                 && frameSource.contains("Home") 
                 && frameSource.contains("Connect") 
                 && frameSource.contains("Disconnect") 
                 && frameSource.contains("Browse") 
                 && frameSource.contains("SQL") 
                 && frameSource.contains("Transfer") 
                 && frameSource.contains("DBMS Info") 
                 && frameSource.contains("Help") 
                 && frameSource.contains("SQLite") 
                 && frameSource.contains("sqlitedb") 
            ){
            System.out.println("Connect: Navigation frame test passed");
        } else {
            System.out.println("Connect: Navigation frame test failed");
        }

        // 2.2 Check for correct list of tables displayed 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        frameSource = driver.getPageSource();
                
        if (frameSource.contains("#Tables: 0") 
            ){
            System.out.println("Connect: Left data frame test passed");
        } else {
            System.out.println("Connect: Left data frame test failed");
        }
  
        // 2.3 Check for correct contents in SQL statement frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        frameSource = driver.getPageSource();
        if (frameSource.contains("SQL Statement(s)")
                && frameSource.contains("Script file")
                ) {
            System.out.println("Connect: SQL Statements frame test passed");
        } else {
            System.out.println("Connect: SQL Statements frame test failed");
        }
        
        System.out.println("Field type, name and values of the SQL Statements pane:");
        weList =  (List<WebElement>) driver.findElements(By.tagName("input"));
        for (WebElement lwe : weList) {
            System.out.println("\t" + lwe.getAttribute("type") 
                    + ":" + lwe.getAttribute("name")
                    + ":" + lwe.getAttribute("value"));
        }
        System.out.flush();
                
        // 2.4 Check for empty right data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        frameSource = driver.getPageSource();
        
        System.out.println("Field type, name and values of the right data frame:");
        weList =  (List<WebElement>) driver.findElements(By.tagName("input"));
        for (WebElement lwe : weList) {
            System.out.println("\t" + lwe.getAttribute("type") 
                    + ":" + lwe.getAttribute("name")
                    + ":" + lwe.getAttribute("value"));
        }
        if (weList.size() == 0) {
            System.out.println("\tNo fields found.");
            System.out.println("Connect: Right data frame test passed");
        } else {
            System.out.println("Connect: Right data frame test failed");
            System.out.println(frameSource);
        }
        
        // 3. Test disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();
        
        // 3.1 Check navi frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        frameSource = driver.getPageSource();
                
        currVersion = System.getenv("WJI_VERSION");
        if (frameSource.contains("wjISQL") 
                 && frameSource.contains(currVersion)
                 && frameSource.contains("Home") 
                 && frameSource.contains("Connect") 
                 && frameSource.contains("Disconnect") 
                 && frameSource.contains("Browse") 
                 && frameSource.contains("SQL") 
                 && frameSource.contains("Transfer") 
                 && frameSource.contains("DBMS Info") 
                 && frameSource.contains("Help") 
                 && frameSource.contains("Not connected") 
            ){
            System.out.println("Disconnect: Navigation frame test passed");
        } else {
            System.out.println("Disconnect: Navigation frame test failed");
        }

        // 3.2 Check for correct contents in left data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        frameSource = driver.getPageSource();
        if (frameSource.contains("wjISQL") 
                 &&  frameSource.contains("Release Notes") 
                 &&  frameSource.contains("User's Guide") 
                 &&  frameSource.contains("About") 
            ){
            System.out.println("Disconnect: Left data frame test passed");
        } else {
            System.out.println("Disconnect: Left data frame test failed");
            System.out.println(frameSource);
        }        

        // 3.3 Check for correct contents in right data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        frameSource = driver.getPageSource();
        if (frameSource.contains("Disconnected database successfully.")
                ) {
            System.out.println("Disconnect: Right data frame test passed");
        } else {
            System.out.println("Disconnect: Right data frame test failed");
        }
        
        driver.quit();
        
        System.out.flush();

    }
}
