/**
 * Tests unsuccessful connection with invalid password in url.
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.Alert;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.Test;
 
public class wji_040106_unsucc_conn_with_inv_passwd_in_url{
 
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        WebDriver driver = null;
        WebElement we = null;
        List<WebElement> weList = null;
        String currVersion = "";
        String frameSource = "";
 
        driver = new ChromeDriver(chromeOptions);
        driver.get(args[0]);
 
        Thread.sleep(1000);
 

        // 1. Click Connect menu link 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Connect"));
        we.click();
        

        // 2. Login into a database and check results
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        
        // select jdbc driver
        we = driver.findElement(By.name("jdriver_name"));
        Select jdbcDriverSelect = new Select(we);
        jdbcDriverSelect.selectByVisibleText(System.getenv("WJI_JDBC_DRIVER_NAME"));
        
        // enter url
        we = driver.findElement(By.name("dburl"));
        we.clear();
        we.sendKeys(System.getenv("WJI_JDBC_URL"));
        
        // enter user id
        we = driver.findElement(By.name("userid"));
        we.sendKeys(System.getenv("WJI_USER_ID"));
        
        // enter password
        we = driver.findElement(By.name("password"));
        // Pass invalid password.
        we.sendKeys("xyz");
        
        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        
        // 2.1 Check for error msg.
        try {
            WebDriverWait wait = new WebDriverWait(driver, 5);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert error message:");
            System.out.println(errMsg);
            System.out.println();
            if (errMsg.contains("Connection to database URL '" 
                + System.getenv("WJI_JDBC_URL")
                +"' failed")){
                System.out.println("Connect: Unsuccessful login with invalid password in url test passed.");
            } else {
                System.out.println("Connect: Unsuccessful login with invalid password in url test failed.");
            }
            System.out.flush();
            alert.accept();
        } catch (Exception e) {
            System.out.println("Error:Alert:" + e.getMessage());
            System.out.println("Connect: Unsuccessful login with invalid password in url failed.");
        }            
         
        driver.quit();
        
        System.out.flush();

    }
}
