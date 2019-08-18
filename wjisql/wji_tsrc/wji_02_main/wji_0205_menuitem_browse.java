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
 
public class wji_0205_menuitem_browse {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String psAfterBrowseLinkClick;
        boolean res1 = false, res2 = false, res3 = false;

        try {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            WebElement we = driver.findElement(By.linkText("Browse"));
            we.click();
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            psAfterBrowseLinkClick = driver.getPageSource();
            
            if (psAfterBrowseLinkClick != null) {
                System.out.println("Browse link click passed");
            } else {
                System.out.println("psAfterBrowseLinkClick=" + psAfterBrowseLinkClick);
                System.out.println("Disconnect link click failed");
            }
            
            String currVersion = System.getenv("WJI_VERSION");
            if (psAfterBrowseLinkClick.contains("wjISQL") 
                     && psAfterBrowseLinkClick.contains(currVersion)
                     && psAfterBrowseLinkClick.contains("Home") 
                     && psAfterBrowseLinkClick.contains("Disconnect") 
                     && psAfterBrowseLinkClick.contains("Disconnect") 
                     && psAfterBrowseLinkClick.contains("Browse") 
                     && psAfterBrowseLinkClick.contains("SQL") 
                     && psAfterBrowseLinkClick.contains("Transfer") 
                     && psAfterBrowseLinkClick.contains("DBMS Info") 
                     && psAfterBrowseLinkClick.contains("Help") 
                     && psAfterBrowseLinkClick.contains("Not connected") 
                ){
                res1 = true;
                System.out.println("Navigation menu items test passed");
            } else {
                res1 = false;
                System.out.println("Navigation menu items test failed");
                System.out.println(psAfterBrowseLinkClick);
            }
    
            // Check for correct contents in left data frame.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("leftdatafr");
            psAfterBrowseLinkClick = driver.getPageSource();
            if (!psAfterBrowseLinkClick.contains("wjISQL") 
                     &&  !psAfterBrowseLinkClick.contains("Release Notes") 
                     &&  !psAfterBrowseLinkClick.contains("User's Guide") 
                     &&  !psAfterBrowseLinkClick.contains("About") 
                ){
                res2 = true;
                System.out.println("Left pane test passed");
            } else {
                res2 = false;
                System.out.println("Left pane test failed");
                System.out.println(psAfterBrowseLinkClick);
            }
    
            // Check for correct contents in right data frame.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("rightdatafr");
            psAfterBrowseLinkClick = driver.getPageSource();
            if (
                    psAfterBrowseLinkClick.contains("No active database connection exists.")
                    && psAfterBrowseLinkClick.contains("Connect to a database first and try again.")
                    ) {
                res3 = true;
                System.out.println("Right data pane test passed");
            } else {
                res3 = false;
                System.out.println("Right data pane test failed");
                System.out.println(psAfterBrowseLinkClick);
            }

            driver.quit();           
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
    }
}
