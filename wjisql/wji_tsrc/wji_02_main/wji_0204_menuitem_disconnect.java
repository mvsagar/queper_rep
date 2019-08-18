/**
 * Tests Disconnect link click functionality on main screen of wjISQL.
 */
import java.io.IOException;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;
 
public class wji_0204_menuitem_disconnect {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String psAfterDisconnectLinkClick;
        boolean res1 = false, res2 = false, res3 = false;

        try {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            WebElement we = driver.findElement(By.linkText("Disconnect"));
            we.click();
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            psAfterDisconnectLinkClick = driver.getPageSource();
            
            if (psAfterDisconnectLinkClick != null) {
                System.out.println("Disconnect link click passed");
            } else {
                System.out.println("psAfterDisconnectLinkClick=" + psAfterDisconnectLinkClick);
                System.out.println("Disconnect link click failed");
            }
            
            String currVersion = System.getenv("WJI_VERSION");
            if (psAfterDisconnectLinkClick.contains("wjISQL") 
                     && psAfterDisconnectLinkClick.contains(currVersion)
                     && psAfterDisconnectLinkClick.contains("Home") 
                     && psAfterDisconnectLinkClick.contains("Disconnect") 
                     && psAfterDisconnectLinkClick.contains("Disconnect") 
                     && psAfterDisconnectLinkClick.contains("Browse") 
                     && psAfterDisconnectLinkClick.contains("SQL") 
                     && psAfterDisconnectLinkClick.contains("Transfer") 
                     && psAfterDisconnectLinkClick.contains("DBMS Info") 
                     && psAfterDisconnectLinkClick.contains("Help") 
                     && psAfterDisconnectLinkClick.contains("Not connected") 
                ){
                res1 = true;
            } else {
                res1 = false;
                System.out.println(psAfterDisconnectLinkClick);
            }
    
            // Check for correct contents in left data frame.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("leftdatafr");
            psAfterDisconnectLinkClick = driver.getPageSource();
            if (psAfterDisconnectLinkClick.contains("wjISQL") 
                     &&  psAfterDisconnectLinkClick.contains("Release Notes") 
                     &&  psAfterDisconnectLinkClick.contains("User's Guide") 
                     &&  psAfterDisconnectLinkClick.contains("About") 
                ){
                res2 = true;
            } else {
                res2 = false;
                System.out.println(psAfterDisconnectLinkClick);
            }
    
            // Check for correct contents in right data frame.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("rightdatafr");
            psAfterDisconnectLinkClick = driver.getPageSource();
            if (psAfterDisconnectLinkClick.contains("No database is active.")
                    ) {
                res3 = true;
            } else {
                res3 = false;
                System.out.println(psAfterDisconnectLinkClick);
            }
            
    
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
