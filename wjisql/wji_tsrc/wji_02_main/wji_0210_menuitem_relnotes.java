/**
 * Tests Release Notes menu item in left pane of main screen of wjISQL.
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;
 
public class wji_0210_menuitem_relnotes {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String psAfterReleaseNotesLinkClick = null;
        List<WebElement> weList = null;
        WebElement we = null;
        
        try {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("leftdatafr");
            we = driver.findElement(By.linkText("Release Notes"));
            we.click();
            
            // Go to displayed new tab and check help text.
            ArrayList<String> windowHandles = new ArrayList<String> (driver.getWindowHandles());
            driver.switchTo().window(windowHandles.get(1));
            psAfterReleaseNotesLinkClick = driver.getPageSource();
            
            
            
            if (psAfterReleaseNotesLinkClick != null) {
                System.out.println("ReleaseNotes link click passed");
            } else {
                System.out.println("psAfterReleaseNotesLinkClick=" + psAfterReleaseNotesLinkClick);
                System.out.println("ReleaseNotes link click failed");
            }
            
            
            String currVersion = System.getenv("WJI_VERSION");
            if (psAfterReleaseNotesLinkClick.contains("wjISQL") 
                     && psAfterReleaseNotesLinkClick.contains(currVersion)
                     
                     && psAfterReleaseNotesLinkClick.contains("Release Notes") 
                     
                     && psAfterReleaseNotesLinkClick.contains("List of Supported Primary Software Platforms") 
                     && psAfterReleaseNotesLinkClick.contains("List of Supported Relational Database Management Systems") 
                     && psAfterReleaseNotesLinkClick.contains("List of Supported JDBC Drivers") 
                     && psAfterReleaseNotesLinkClick.contains("List of Supported OS and RDBMS Combinations") 
                     && psAfterReleaseNotesLinkClick.contains("List of Supported Browsers") 
                     && psAfterReleaseNotesLinkClick.contains("List of Enhancements") 
                     && psAfterReleaseNotesLinkClick.contains("List of Bugs Fixed") 
                     && psAfterReleaseNotesLinkClick.contains("List of Major Known Issues")
                     
                ){
                System.out.println("ReleaseNotes text test passed");
            } else {
                System.out.println("ReleaseNotes text test failed");
            }
              
            
            driver.quit();           
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
            System.out.println(psAfterReleaseNotesLinkClick);
        }
    }
}
