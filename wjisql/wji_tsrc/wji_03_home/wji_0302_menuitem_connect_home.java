/**
 * Tests Connect and Home link click sequence functionality on main screen of wjISQL.
 */
import java.io.IOException;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;
 
public class wji_0302_menuitem_connect_home {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = null;
        WebElement we = null;
        String currVersion = "";
        String psAfterConnectLinkClick = "", psAfterHomeLinkClick = "";
 
        driver = new ChromeDriver(chromeOptions);
        driver.get(args[0]);
 
        Thread.sleep(1000);
 

        // 1. Click Connect menu link and check results.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Connect"));
        we.click();
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        psAfterConnectLinkClick = driver.getPageSource();
      
        
        currVersion = System.getenv("WJI_VERSION");
        if (psAfterConnectLinkClick.contains("wjISQL") 
                 && psAfterConnectLinkClick.contains(currVersion)
                 && psAfterConnectLinkClick.contains("Home") 
                 && psAfterConnectLinkClick.contains("Connect") 
                 && psAfterConnectLinkClick.contains("Disconnect") 
                 && psAfterConnectLinkClick.contains("Browse") 
                 && psAfterConnectLinkClick.contains("SQL") 
                 && psAfterConnectLinkClick.contains("Transfer") 
                 && psAfterConnectLinkClick.contains("DBMS Info") 
                 && psAfterConnectLinkClick.contains("Help") 
                 && psAfterConnectLinkClick.contains("Not connected") 
            ){
            System.out.println("Connect: Navigation frame test passed");
        } else {
            System.out.println("Connect: Navigation frame test failed");
            System.out.println(psAfterConnectLinkClick);
        }

        // Check for correct contents in left data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        psAfterConnectLinkClick = driver.getPageSource();
        if (psAfterConnectLinkClick.contains("wjISQL") 
                 &&  psAfterConnectLinkClick.contains("Release Notes") 
                 &&  psAfterConnectLinkClick.contains("User's Guide") 
                 &&  psAfterConnectLinkClick.contains("About") 
            ){
            System.out.println("Connect: Left data frame test passed");
        } else {
            System.out.println("Connect: Left data frame test failed");
            System.out.println(psAfterConnectLinkClick);
        }
        
        // Check for correct contents in right data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        psAfterConnectLinkClick = driver.getPageSource();
        if (psAfterConnectLinkClick.contains("JDBC Driver") 
                 &&  psAfterConnectLinkClick.contains("Database URL") 
                 &&  psAfterConnectLinkClick.contains("User ID") 
                 &&  psAfterConnectLinkClick.contains("Password") 
            ){
            System.out.println("Connect: Right data frame test passed");
        } else {
            System.out.println("Connect: Right data frame test failed");
            System.out.println(psAfterConnectLinkClick);
        }
        
        // 2. Click Home menu link and check results
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Home"));
        we.click();
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        psAfterHomeLinkClick = driver.getPageSource();
                
        currVersion = System.getenv("WJI_VERSION");
        if (psAfterHomeLinkClick.contains("wjISQL") 
                 && psAfterHomeLinkClick.contains(currVersion)
                 && psAfterHomeLinkClick.contains("Home") 
                 && psAfterHomeLinkClick.contains("Connect") 
                 && psAfterHomeLinkClick.contains("Disconnect") 
                 && psAfterHomeLinkClick.contains("Browse") 
                 && psAfterHomeLinkClick.contains("SQL") 
                 && psAfterHomeLinkClick.contains("Transfer") 
                 && psAfterHomeLinkClick.contains("DBMS Info") 
                 && psAfterHomeLinkClick.contains("Help") 
                 && psAfterHomeLinkClick.contains("Not connected") 
            ){
            System.out.println("Home: Navigation frame test passed");
        } else {
            System.out.println("Home: Navigation frame test passed");
            System.out.println(psAfterHomeLinkClick);
        }

        // Check for correct contents in left data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        psAfterHomeLinkClick = driver.getPageSource();
        if (psAfterHomeLinkClick.contains("wjISQL") 
                 &&  psAfterHomeLinkClick.contains("Release Notes") 
                 &&  psAfterHomeLinkClick.contains("User's Guide") 
                 &&  psAfterHomeLinkClick.contains("About") 
            ){
            System.out.println("Home: Left data frame test passed");
        } else {
            System.out.println("Home: Left data frame test failed");
            System.out.println(psAfterHomeLinkClick);
        }        

        // Check for correct contents in right data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        psAfterHomeLinkClick = driver.getPageSource();
        if (psAfterHomeLinkClick.contains("Welcome to wjISQL")
                && psAfterHomeLinkClick.contains("Structured Query Language")
                && psAfterHomeLinkClick.contains("connect")
                && psAfterHomeLinkClick.contains("browse")
                && psAfterHomeLinkClick.contains("select")
                && psAfterHomeLinkClick.contains("insert")
                && psAfterHomeLinkClick.contains("update")
                && psAfterHomeLinkClick.contains("delete")
                && psAfterHomeLinkClick.contains("execute")
                && psAfterHomeLinkClick.contains("transfer")
                && psAfterHomeLinkClick.contains("JDBC driver")
                && psAfterHomeLinkClick.contains("developers/programmers")
                && psAfterHomeLinkClick.contains("databases")
                ) {
            System.out.println("Home: Right data frame test passed");
        } else {
            System.out.println("Home: Right data frame test failed");
            System.out.println(psAfterHomeLinkClick);
        }

        driver.quit();       
    }
}
