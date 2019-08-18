import java.io.IOException;
 
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;
 
public class wji_0102_invoke_in_chrome {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
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
