/**
 * Tests Disconnect link click functionality on main screen of wjISQL.
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
 
public class wji_0209_menuitem_help {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String psAfterHelpLinkClick = null;
        List<WebElement> weList = null;
        WebElement we = null;
        
        try {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            we = driver.findElement(By.linkText("Help"));
            we.click();
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            psAfterHelpLinkClick = driver.getPageSource();
            
            if (psAfterHelpLinkClick != null) {
                System.out.println("Help link click passed");
            } else {
                System.out.println("psAfterHelpLinkClick=" + psAfterHelpLinkClick);
                System.out.println("Help link click failed");
            }
            
            // Go to displayed new tab and check help text.
            ArrayList<String> windowHandles = new ArrayList<String> (driver.getWindowHandles());
            driver.switchTo().window(windowHandles.get(1));
            psAfterHelpLinkClick = driver.getPageSource();
            
            String currVersion = System.getenv("WJI_VERSION");
            if (psAfterHelpLinkClick.contains("wjISQL") 
                     && psAfterHelpLinkClick.contains(currVersion)
                     
                     && psAfterHelpLinkClick.contains("Home") 
                     && psAfterHelpLinkClick.contains("Connect") 
                     && psAfterHelpLinkClick.contains("Disconnect") 
                     && psAfterHelpLinkClick.contains("Browse") 
                     && psAfterHelpLinkClick.contains("SQL") 
                     && psAfterHelpLinkClick.contains("Transfer") 
                     && psAfterHelpLinkClick.contains("DBMS Info") 
                     && psAfterHelpLinkClick.contains("Help")
                     
                     && psAfterHelpLinkClick.contains("RDBMS") 
                     && psAfterHelpLinkClick.contains("More info") 
                     && psAfterHelpLinkClick.contains("User's Guide") 
                     && psAfterHelpLinkClick.contains("Release Notes")
                ){
                System.out.println("Help text test passed");
            } else {
                System.out.println("Help text test failed");
                System.out.println(psAfterHelpLinkClick);
            }
              
            
            driver.quit();           
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
            System.out.println(psAfterHelpLinkClick);
        }
    }
}
