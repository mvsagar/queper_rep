/**
 * Tests link 'Home' after link 'Disconnect' is clicked.
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
 
public class wji_0307_menuitem_disconnect_home {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = null;
        WebElement we = null;
        String term = "";
        String frameSource = "";
        boolean successFlag = true;
 
        driver = new ChromeDriver(chromeOptions);
        driver.get(args[0]);
 
        Thread.sleep(1000);
 

        // 1. Click Transfer menu link and check results.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();
              
         
        // Check for correct contents in right data  frame .
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        frameSource = driver.getPageSource();
        if (frameSource.contains("No database is active")
                ) {
            System.out.println("Disconnect: Right data frame test passed");
        } else {
            System.out.println("Disconnect: Right data frame test failed");
        }
                
        // 2. Click Home menu link and check results
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Home"));
        we.click();
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        frameSource = driver.getPageSource();

        term = "wjISQL";
        if (!frameSource.contains(term)) {
            successFlag = false;
            System.out.println("Home: Navigation frame test failed - '" 
                + term + "' not found");
        }
        term = System.getenv("WJI_VERSION");
        if (!frameSource.contains(term)) {
            successFlag = false;
            System.out.println("Home: Navigation frame test failed - '"
                + term + "' not found");
        }
        term = "Home";
        if (!frameSource.contains(term)) {
            successFlag = false;
            System.out.println("Home: Navigation frame test failed - '"
                    + term + "' not found");
        }
        term = "Connect";
        if (!frameSource.contains(term)) {
            successFlag = false;
            System.out.println("Home: Navigation frame test failed - '"
                    + term + "' not found");
        }
        term = "Disconnect";
        if (!frameSource.contains(term)) {
            successFlag = false;
            System.out.println("Home: Navigation frame test failed - '"
                    + term + "' not found");
        }
        term = "Browse";
        if (!frameSource.contains(term)) {
            successFlag = false;
            System.out.println("Home: Navigation frame test failed - '"
                    + term + "' not found");
        }
        term = "SQL";
        if (!frameSource.contains(term)) {
            successFlag = false;
            System.out.println("Home: Navigation frame test failed - '"
                    + term + "' not found");
        }
        term = "Transfer";
        if (!frameSource.contains(term)) {
            successFlag = false;
            System.out.println("Home: Navigation frame test failed - '"
                    + term + "' not found");
        }
        term = "DBMS Info";
        if (!frameSource.contains(term)) {
            successFlag = false;
            System.out.println("Home: Navigation frame test failed - '"
                    + term + "' not found");
        }
        term = "Help";
        if (!frameSource.contains(term)) {
            successFlag = false;
            System.out.println("Home: Navigation frame test failed - '"
                    + term + "' not found");
        }
        if (successFlag) {
            System.out.println("Home: Navigation frame test passed");
        } else {
            System.out.println("Home: Navigation frame test failed");
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
        }
        
        driver.quit();
        
        System.out.flush();

    }
}
