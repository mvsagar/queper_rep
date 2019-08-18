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
 
public class wji_0206_menuitem_sql {
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = new ChromeDriver(chromeOptions);
 
        driver.get(args[0]);
 
        Thread.sleep(1000);
 
        String psAfterSQLLinkClick;
        boolean res1 = false, res2 = false, res3 = false;

        try {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            WebElement we = driver.findElement(By.linkText("SQL"));
            we.click();
            driver.switchTo().defaultContent();
            driver.switchTo().frame("navifr");
            psAfterSQLLinkClick = driver.getPageSource();
            
            if (psAfterSQLLinkClick != null) {
                System.out.println("SQL link click passed");
            } else {
                System.out.println("psAfterSQLLinkClick=" + psAfterSQLLinkClick);
                System.out.println("SQL link click failed");
            }
            
            String currVersion = System.getenv("WJI_VERSION");
            if (psAfterSQLLinkClick.contains("wjISQL") 
                     && psAfterSQLLinkClick.contains(currVersion)
                     && psAfterSQLLinkClick.contains("Home") 
                     && psAfterSQLLinkClick.contains("Disconnect") 
                     && psAfterSQLLinkClick.contains("Disconnect") 
                     && psAfterSQLLinkClick.contains("Browse") 
                     && psAfterSQLLinkClick.contains("SQL") 
                     && psAfterSQLLinkClick.contains("Transfer") 
                     && psAfterSQLLinkClick.contains("DBMS Info") 
                     && psAfterSQLLinkClick.contains("Help") 
                     && psAfterSQLLinkClick.contains("Not connected") 
                ){
                res1 = true;
                System.out.println("Navigation menu items test passed");
            } else {
                res1 = false;
                System.out.println("Navigation menu items test failed");
                System.out.println(psAfterSQLLinkClick);
            }
    
            // Check for correct contents in left data frame.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("leftdatafr");
            psAfterSQLLinkClick = driver.getPageSource();
            if (!psAfterSQLLinkClick.contains("wjISQL") 
                     &&  !psAfterSQLLinkClick.contains("Release Notes") 
                     &&  !psAfterSQLLinkClick.contains("User's Guide") 
                     &&  !psAfterSQLLinkClick.contains("About") 
                ){
                res2 = true;
                System.out.println("Left pane test passed");
            } else {
                res2 = false;
                System.out.println("Left pane test failed");
                System.out.println(psAfterSQLLinkClick);
            }

            // Check for correct contents in SQL statement rame.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("sqlstmtfr");
            psAfterSQLLinkClick = driver.getPageSource();
            if (psAfterSQLLinkClick.contains("SQL Statement(s)")
                    && psAfterSQLLinkClick.contains("Script file")
                    ) {
                System.out.println("SQL Statements pane test passed");
            } else {
                System.out.println("SQL Statements pane test failed");
                System.out.println(psAfterSQLLinkClick);
            }
            
            System.out.println("Field type, name and values of the SQL Statements pane:");
            List<WebElement> weList =  (List<WebElement>) driver.findElements(By.tagName("input"));
            for (WebElement lwe : weList) {
                System.out.println("\t" + lwe.getAttribute("type") 
                        + ":" + lwe.getAttribute("name")
                        + ":" + lwe.getAttribute("value"));
            }
            System.out.flush();
            
            
            // Check for correct contents in right data frame.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("rightdatafr");
            psAfterSQLLinkClick = driver.getPageSource();            
                        
            if (psAfterSQLLinkClick.contains("No active database connection exists.")
                    && psAfterSQLLinkClick.contains("Connect to a database first and try again.")
                    ) {
                res3 = true;
                System.out.println("Right data pane test passed");
            } else {
                res3 = false;
                System.out.println("Right data pane test failed");
                System.out.println(psAfterSQLLinkClick);
            }

            driver.quit();           
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
    }
}
