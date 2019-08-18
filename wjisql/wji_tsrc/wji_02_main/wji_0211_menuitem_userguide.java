/**
 * Tests User's Guide menu item in left pane of main screen of wjISQL.
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
 
public class wji_0211_menuitem_userguide {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String psAfterUserGuideLinkClick = null;
        List<WebElement> weList = null;
        WebElement we = null;
        
        try {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("leftdatafr");
            we = driver.findElement(By.linkText("User's Guide"));
            we.click();
            
            // Go to displayed new tab and check user guide text.
            ArrayList<String> windowHandles = new ArrayList<String> (driver.getWindowHandles());
            driver.switchTo().window(windowHandles.get(1));
            psAfterUserGuideLinkClick = driver.getPageSource();
            
            
            
            if (psAfterUserGuideLinkClick != null) {
                System.out.println("UserGuide link click passed");
            } else {
                System.out.println("psAfterUserGuideLinkClick=" + psAfterUserGuideLinkClick);
                System.out.println("UserGuide link click failed");
            }
            
            
            String currVersion = System.getenv("WJI_VERSION");
            if (psAfterUserGuideLinkClick.contains("wjISQL") 
                     && psAfterUserGuideLinkClick.contains(currVersion)
                     
                     && psAfterUserGuideLinkClick.contains("User's Guide") 
                     
                     && psAfterUserGuideLinkClick.contains("Chapter 1 - Introduction") 
                     && psAfterUserGuideLinkClick.contains("Chapter 2 - Requirements") 
                     && psAfterUserGuideLinkClick.contains("Chapter 3 - Connecting to a Database") 
                     && psAfterUserGuideLinkClick.contains("Chapter 4 - Browsing Databases") 
                     && psAfterUserGuideLinkClick.contains("Chapter 5 - Executing SQL statements") 
                     && psAfterUserGuideLinkClick.contains("Chapter 6 - Data Transfer") 
                     && psAfterUserGuideLinkClick.contains("Chapter 7 - wjISQL Menu Operation Reference") 
                     && psAfterUserGuideLinkClick.contains("Overview")
                     && psAfterUserGuideLinkClick.contains("Basic Software")
                     && psAfterUserGuideLinkClick.contains("Troubleshooting Connections")
                     && psAfterUserGuideLinkClick.contains("Viewing Data of a Table")
                     && psAfterUserGuideLinkClick.contains("Multiple Statement Execution")
                     && psAfterUserGuideLinkClick.contains("Data Transfer")
                     && psAfterUserGuideLinkClick.contains("Menu operations")
                ){
                System.out.println("UserGuide text test passed");
            } else {
                System.out.println("UserGuide text test failed");
                System.out.println(psAfterUserGuideLinkClick);
            }
              
            
            driver.quit();           
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
            System.out.println(psAfterUserGuideLinkClick);
        }
    }
}
