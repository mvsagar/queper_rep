import java.io.IOException;
import java.util.List;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.testng.annotations.Test;
 
public class wji_0103_invoke_in_firefox {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        //System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        //ChromeOptions browserOptions = new ChromeOptions();
        System.setProperty("webdriver.gecko.driver", "/usr/bin/geckodriver");
        FirefoxOptions browserOptions = new FirefoxOptions();
        
        browserOptions.addArguments("--headless");
        browserOptions.addArguments("--no-sandbox");
 
        WebDriver driver = null;
        WebElement we = null;
        List<WebElement> weList = null;
        Select jdbcDriverSelect = null;
       
        String frameSource = "";
        WebElement waitForWe = null;
        int waitedTime = 0; // seconds
 
        //driver = new ChromeDriver(browserOptions);
        driver = new FirefoxDriver(browserOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String pageSource;
        boolean res1 = false, res2 = false, res3 = false;

        // Check for correct contents in left data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        pageSource = driver.getPageSource();
        if (pageSource.contains("wjISQL") 
                 &&  pageSource.contains("Home") 
                 &&  pageSource.contains("Connect") 
                 &&  pageSource.contains("Disconnect") 
                 &&  pageSource.contains("Browse") 
                 &&  pageSource.contains("SQL") 
                 &&  pageSource.contains("Transfer") 
                 &&  pageSource.contains("DBMS Info") 
                 &&  pageSource.contains("Help") 
                 &&  pageSource.contains("Not connected") 
            ){
            res1 = true;
        } else {
            res1 = false;
            System.out.println(pageSource);
        }

        // Check for correct contents in left data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        pageSource = driver.getPageSource();
        if (pageSource.contains("wjISQL") 
                 &&  pageSource.contains("Release Notes") 
                 &&  pageSource.contains("User's Guide") 
                 &&  pageSource.contains("About") 
            ){
            res2 = true;
        } else {
            res2 = false;
            System.out.println(pageSource);
        }

        // Check for correct contents in right data frame.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        pageSource = driver.getPageSource();
        if (pageSource.contains("Welcome to wjISQL")) {
            res3 = true;
        } else {
            res3 = false;
            System.out.println(pageSource);
        }

        driver.quit();
       
        if (res1 && res2 && res3) {
            System.out.println("Passed");
        } else {
            System.out.println("Failed");
        }
    }
}
