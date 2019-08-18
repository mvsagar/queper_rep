/**
 * Tests browse menu item
 */
import java.io.IOException;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.Alert;
import org.openqa.selenium.UnhandledAlertException;
import org.openqa.selenium.NoAlertPresentException;

import org.testng.annotations.Test;
 
public class wji_050204_browse_menu {
 
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
        we.sendKeys(System.getenv("WJI_USER_PASSWD"));
        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(1000);

        // 3. Click Browse menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Browse"));
        we.click();
                  
        
        // 4. Check tables and rows displayed.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        frameSource = driver.getPageSource();
            
        List  cols = driver.findElements(By.xpath("//*[@id=\"tbl-tbls\"]/thead/tr/th"));
        System.out.println("No of cols are : " +cols.size());
        List  rows = driver.findElements(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr/td[1]"));
        System.out.println("No of rows are : " + rows.size());
        
        WebElement tr = null;
        WebElement tblNameEle = null; 
        WebElement numRowsEle = null; 
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[" + i + "]"));
            tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[" + i + "]/td[2]"));
            numRowsEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[" + i + "]/td[3]"));
            System.out.println("Table=" + tblNameEle.getText() + ", Numrows=" + numRowsEle.getText());
        }
        
        System.out.flush();
                
        
        // 5. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();
        
        
        driver.quit();
        
        System.out.flush();

    }
}
