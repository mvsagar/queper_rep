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
 
public class wji_0207_menuitem_transfer {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String psAfterTransferLinkClick = null;
        List<WebElement> weList = null;
        WebElement we = null;
        
        try {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            we = driver.findElement(By.linkText("Transfer"));
            we.click();
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            psAfterTransferLinkClick = driver.getPageSource();
            
            if (psAfterTransferLinkClick != null) {
                System.out.println("Transfer link click passed");
            } else {
                System.out.println("psAfterTransferLinkClick=" + psAfterTransferLinkClick);
                System.out.println("Transfer link click failed");
            }
            
            String currVersion = System.getenv("WJI_VERSION");
            if (psAfterTransferLinkClick.contains("wjISQL") 
                     && psAfterTransferLinkClick.contains(currVersion)
                     && psAfterTransferLinkClick.contains("Home") 
                     && psAfterTransferLinkClick.contains("Connect source") 
                     && psAfterTransferLinkClick.contains("Disconnect source") 
                     && psAfterTransferLinkClick.contains("Connect destination") 
                     && psAfterTransferLinkClick.contains("Disconnect destination") 
                     && psAfterTransferLinkClick.contains("Back") 
                     && psAfterTransferLinkClick.contains("Help") 
                     && psAfterTransferLinkClick.contains("Not connected") 
                ){
                System.out.println("Navigation menu items test passed");
            } else {
                System.out.println("Navigation menu items test failed");
                System.out.println(psAfterTransferLinkClick);
            }
    
            // Check for correct contents in left data frame 1.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("datafr");
            driver.switchTo().frame("leftdatafr");
            driver.switchTo().frame("leftdatafr1");
            psAfterTransferLinkClick = driver.getPageSource();
            if (psAfterTransferLinkClick.contains("Source Database System") 
                ){
                System.out.println("Left pane 1 test passed");
            } else {
                System.out.println("Left pane test failed");
                System.out.println(psAfterTransferLinkClick);
            }

            // Check for buttons.            
            System.out.println("Field type, name and values of left data frame 1:");
            weList =  (List<WebElement>) driver.findElements(By.tagName("input"));
            for (WebElement lwe : weList) {
                System.out.println("\t" + lwe.getAttribute("type") 
                        + ":" + lwe.getAttribute("name")
                        + ":" + lwe.getAttribute("value"));
            }
            System.out.flush();
            
            // Check for correct contents in left data frame 2.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("datafr");
            driver.switchTo().frame("leftdatafr");
            driver.switchTo().frame("leftdatafr2");
            psAfterTransferLinkClick = driver.getPageSource();
            if (psAfterTransferLinkClick.contains("Destination Database System") 
                ){
                System.out.println("Left pane 2 test passed");
            } else {
                System.out.println("Left pane 2 test failed");
                System.out.println(psAfterTransferLinkClick);
            }

            // Check for buttons.            
            System.out.println("Field type, name and values of left data pane 2:");
            weList =  (List<WebElement>) driver.findElements(By.tagName("input"));
            for (WebElement lwe : weList) {
                System.out.println("\t" + lwe.getAttribute("type") 
                        + ":" + lwe.getAttribute("name")
                        + ":" + lwe.getAttribute("value"));
            }
            System.out.flush();
            
            // Check for correct contents in right data frame 1.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("datafr");
            driver.switchTo().frame("rightdatafr");
            driver.switchTo().frame("rightdatafr1");
            psAfterTransferLinkClick = driver.getPageSource();            
                        
            
            if (psAfterTransferLinkClick.contains("Database Login")
                && psAfterTransferLinkClick.contains("Login into Source Database")
                && psAfterTransferLinkClick.contains("JDBC Driver")
                && psAfterTransferLinkClick.contains("Database URL")
                && psAfterTransferLinkClick.contains("URL Format")
                && psAfterTransferLinkClick.contains("User ID")
                && psAfterTransferLinkClick.contains("Password")) {
                System.out.println("Right data pane 1 text passed");
            }  else {
                System.out.println("Right data pane 1 text failed");
            }
            // Check for fields.            
            System.out.println("Field type, name and values of right data pane 1:");
            weList =  (List<WebElement>) driver.findElements(By.tagName("input"));
            for (WebElement lwe : weList) {
                System.out.println("\t" + lwe.getAttribute("type") 
                        + ":" + lwe.getAttribute("name")
                        + ":" + lwe.getAttribute("value"));
            }
            System.out.flush();

            // Check for correct contents in right data frame 2.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("datafr");
            driver.switchTo().frame("rightdatafr");
            driver.switchTo().frame("rightdatafr2");
            psAfterTransferLinkClick = driver.getPageSource();            
                        
            if (psAfterTransferLinkClick.contains("Database Login")
                    && psAfterTransferLinkClick.contains("Login into Destination Database")
                    && psAfterTransferLinkClick.contains("JDBC Driver")
                    && psAfterTransferLinkClick.contains("Database URL")
                    && psAfterTransferLinkClick.contains("URL Format")
                    && psAfterTransferLinkClick.contains("User ID")
                    && psAfterTransferLinkClick.contains("Password")) {
                    System.out.println("Right data pane 2 text passed");
                }  else {
                    System.out.println("Right data pane 2 text failed");
                }
            // Check for fields.            
            System.out.println("Field type, name and values of right data pane 2:");
            weList =  (List<WebElement>) driver.findElements(By.tagName("input"));
            for (WebElement lwe : weList) {
                System.out.println("\t" + lwe.getAttribute("type") 
                        + ":" + lwe.getAttribute("name")
                        + ":" + lwe.getAttribute("value"));
            }
            System.out.flush();
            
            
            driver.quit();           
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
            System.out.println(psAfterTransferLinkClick);
        }
    }
}
