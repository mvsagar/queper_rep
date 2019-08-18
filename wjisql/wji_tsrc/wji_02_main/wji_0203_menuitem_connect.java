/**
 * Tests Connect link click functionality on main screen of wjISQL.
 */
import java.io.IOException;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;
 
public class wji_0203_menuitem_connect {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String psAfterConnectLinkClick;
        boolean res1 = false, res2 = false, res3 = false;

        try {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            WebElement we = driver.findElement(By.linkText("Connect"));
            we.click();
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            psAfterConnectLinkClick = driver.getPageSource();
            
            if (psAfterConnectLinkClick != null) {
                System.out.println("Connect link click passed");
            } else {
                System.out.println("psAfterConnectLinkClick=" + psAfterConnectLinkClick);
                System.out.println("Connect link click failed");
            }
            
            String currVersion = System.getenv("WJI_VERSION");
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
                res1 = true;
            } else {
                res1 = false;
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
                res2 = true;
            } else {
                res2 = false;
                System.out.println(psAfterConnectLinkClick);
            }
    
            // Check for correct contents in right data frame.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("rightdatafr");
            psAfterConnectLinkClick = driver.getPageSource();
            if (psAfterConnectLinkClick.contains("Database Login")
                    && psAfterConnectLinkClick.contains("JDBC Driver")
                    && psAfterConnectLinkClick.contains("Database URL")
                    && psAfterConnectLinkClick.contains("URL Format")
                    && psAfterConnectLinkClick.contains("User ID")
                    && psAfterConnectLinkClick.contains("Password")
                    ) {
                res3 = true;
            } else {
                res3 = false;
                System.out.println(psAfterConnectLinkClick);
            }
            
            // Check for rightdatafr menu items.
            System.out.println("Field type, name and values:");
            List<WebElement> weList =  (List<WebElement>) driver.findElements(By.tagName("input"));
            for (WebElement lwe : weList) {
                System.out.println(lwe.getAttribute("type") 
                        + ":" + lwe.getAttribute("name")
                        + ":" + lwe.getAttribute("value"));
            }
            System.out.flush();
           
    
            driver.quit();
           
            if (res1 && res2 && res3) {
                System.out.println("Each screen component verification Passed");
            } else {
                System.out.println("Each screen component verification failed");
            }
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
    }
}
