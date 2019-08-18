/**
 * Tests DBMSInfo link click functionality on main screen of wjISQL.
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
 
public class wji_0208_menuitem_dbmsinfo {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String frameSource = null;
        WebElement we = null;
        
        try {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            we = driver.findElement(By.linkText("DBMS Info"));
            we.click();
            System.out.println("DBMSInfo link click test passed");
            
            Thread.sleep(2000);
              
            // Go to displayed new tab and check alert text.
            // 2 Check for error msg.
            ArrayList<String> windowHandles = new ArrayList<String> (driver.getWindowHandles());
            driver.switchTo().window(windowHandles.get(1));
            /* 
            try {
                WebDriverWait wait = new WebDriverWait(driver, 5);
                wait.until(ExpectedConditions.alertIsPresent());
                Alert alert = driver.switchTo().alert();
                String errMsg = alert.getText();
                System.out.println("Alert error message:");
                System.out.println(errMsg);
                System.out.println();
                if (errMsg.contains("Database connection is not active")){
                    System.out.println("DBMSInfo: test passed.");
                } else {
                    System.out.println("DBMSInfo: test failed.");
                }
                System.out.flush();
                alert.accept();
            } catch (Exception e) {
                System.out.println("Error:Alert:" + e.getMessage());
                System.out.println("DBMSInfo: test failed.");
            } 
            */  
            
            // As waiting for alert code is not working, done the following
            // to circumvent it
            frameSource = driver.getPageSource();
            if (frameSource.contains("Database connection is not active")){
                System.out.println("DBMSInfo: test passed.");
            } else {
                System.out.println("DBMSInfo: test failed.");
            }
            
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
        driver.quit();           
    }
}
