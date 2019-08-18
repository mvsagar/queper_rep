/**
 * Tests About menu item in left pane of main screen of wjISQL.
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
 
public class wji_0212_menuitem_about {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String psAfterAboutLinkClick = null;
        List<WebElement> weList = null;
        WebElement we = null;
        
        try {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("leftdatafr");
            we = driver.findElement(By.linkText("About"));
            we.click();
            
            // Go to displayed new tab and check user guide text.
            ArrayList<String> windowHandles = new ArrayList<String> (driver.getWindowHandles());
            driver.switchTo().window(windowHandles.get(1));
            psAfterAboutLinkClick = driver.getPageSource();
            
            
            
            if (psAfterAboutLinkClick != null) {
                System.out.println("About link click passed");
            } else {
                System.out.println("psAfterAboutLinkClick=" + psAfterAboutLinkClick);
                System.out.println("About link click failed");
            }
            
            
            String currVersion = System.getenv("WJI_VERSION");
            if (psAfterAboutLinkClick.contains("wjISQL") 
                     && psAfterAboutLinkClick.contains(currVersion)
                     
                     && psAfterAboutLinkClick.contains("Structured Query Language") 
                     && psAfterAboutLinkClick.contains("select") 
                     && psAfterAboutLinkClick.contains("Internet browser") 
                     && psAfterAboutLinkClick.contains("developers/programmers") 
                     && psAfterAboutLinkClick.contains("Apache License 2.0") 
                     && psAfterAboutLinkClick.contains("wjisql@queper.in") 
                ){
                System.out.println("About text test passed");
            } else {
                System.out.println("About text test failed");
                System.out.println(psAfterAboutLinkClick);
            }
              
            
            driver.quit();           
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
            System.out.println(psAfterAboutLinkClick);
        }
    }
}
