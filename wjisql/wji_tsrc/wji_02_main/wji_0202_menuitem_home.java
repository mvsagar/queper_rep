/**
 * Tests Home link click functionality on main screen of wjISQL.
 */
import java.io.IOException;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;
 
public class wji_0202_menuitem_home {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String psBeforeHomeLinkClick, psAfterHomeLinkClick;
        boolean res1 = false, res2 = false, res3 = false;

        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        psBeforeHomeLinkClick = driver.getPageSource();
        WebElement we = driver.findElement(By.linkText("Home"));
        we.click();
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        psAfterHomeLinkClick = driver.getPageSource();
        
        if (psAfterHomeLinkClick.equals(psBeforeHomeLinkClick)) {
            System.out.println("Home button click passed");
        } else {
            System.out.println("psBeforeHomeLinkClick=" + psBeforeHomeLinkClick);
            System.out.println("psAfterHomeLinkClick=" + psAfterHomeLinkClick);
            System.out.println("Home button click failed");
        }
        
        String currVersion = System.getenv("WJI_VERSION");
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
            res1 = true;
        } else {
            res1 = false;
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
            res2 = true;
        } else {
            res2 = false;
            System.out.println(psAfterHomeLinkClick);
        }

        // Check for correct contents in right data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        psAfterHomeLinkClick = driver.getPageSource();
        if (psAfterHomeLinkClick.contains("Welcome to wjISQL")) {
            res3 = true;
        } else {
            res3 = false;
            System.out.println(psAfterHomeLinkClick);
        }

        driver.quit();
       
        if (res1 && res2 && res3) {
            System.out.println("Each screen component verification Passed");
        } else {
            System.out.println("Each screen component verification failed");
        }
    }
}
