/**
 * Tests link 'Home' after link 'SQL' is clicked.
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
 
public class wji_0305_menuitem_sql_home {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = null;
        WebElement we = null;
        String currVersion = "";
        String frameSource = "";
 
        driver = new ChromeDriver(chromeOptions);
        driver.get(args[0]);
 
        Thread.sleep(1000);
 

        // 1. Click Connect menu link and check results.
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
        
        // 3. Click SQL menu link and check results.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("SQL"));
        we.click();
        
        // Check for correct contents in SQL statement frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        frameSource = driver.getPageSource();
        if (frameSource.contains("SQL Statement(s)")
                && frameSource.contains("Script file")
                ) {
            System.out.println("SQL: SQL Statements frame test passed");
        } else {
            System.out.println("SQL: SQL Statements frame test failed");
            System.out.println(frameSource);
        }
        
        System.out.println("Field type, name and values of the SQL Statements pane:");
        List<WebElement> weList =  (List<WebElement>) driver.findElements(By.tagName("input"));
        for (WebElement lwe : weList) {
            System.out.println("\t" + lwe.getAttribute("type") 
                    + ":" + lwe.getAttribute("name")
                    + ":" + lwe.getAttribute("value"));
        }
        System.out.flush();
                
        // 4. Click Home menu link and check results
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Home"));
        we.click();
        
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
                 && frameSource.contains("MariaDB") 
                 && frameSource.contains("mariausr") 
            ){
            System.out.println("Home: Navigation frame test passed");
        } else {
            System.out.println("Home: Navigation frame test failed");
            System.out.println(frameSource);
        }

        // Check for correct contents in left data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        frameSource = driver.getPageSource();
        if (frameSource.contains("wjISQL") 
                 &&  frameSource.contains("Release Notes") 
                 &&  frameSource.contains("User's Guide") 
                 &&  frameSource.contains("About") 
            ){
            System.out.println("Home: Left data frame test passed");
        } else {
            System.out.println("Home: Left data frame test failed");
            System.out.println(frameSource);
        }        

        // Check for correct contents in right data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        frameSource = driver.getPageSource();
        if (frameSource.contains("Welcome to wjISQL")
                && frameSource.contains("Structured Query Language")
                && frameSource.contains("connect")
                && frameSource.contains("browse")
                && frameSource.contains("select")
                && frameSource.contains("insert")
                && frameSource.contains("update")
                && frameSource.contains("delete")
                && frameSource.contains("execute")
                && frameSource.contains("transfer")
                && frameSource.contains("JDBC driver")
                && frameSource.contains("developers/programmers")
                && frameSource.contains("databases")
                ) {
            System.out.println("Home: Right data frame test passed");
        } else {
            System.out.println("Home: Right data frame test failed");
            System.out.println(frameSource);
        }

        
        
        // 5. Disconnect from the database.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();  
        
        driver.quit();
        
        System.out.flush();

    }
}
