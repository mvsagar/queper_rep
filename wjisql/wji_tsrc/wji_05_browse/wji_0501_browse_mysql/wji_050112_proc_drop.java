/**
 * Tests procedure/functions properties screen button 'Drop' for procedures.
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
import org.openqa.selenium.NoSuchElementException;

import org.testng.annotations.Test;
 
public class wji_050112_proc_drop {
 
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
        String he = null; // HTML element.
 
        driver = new ChromeDriver(chromeOptions);
        driver.get(args[0]);
 
        Thread.sleep(1000);
 

        // 1. Click Connect menu link 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Connect"));
        we.click();
        

        // 2. Login into a database
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
        
        // 4. Go to proclist frame and click  Procedures & Functions button,        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        we = driver.findElement(By.xpath("//input[contains(@value, 'Procedures')]"));
        we.click();     
        
                  
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement tblNameEle = null; 
        WebElement col = null; 
        WebElement button = null;

        // 5. Display currenr procedure count
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");

        he = "//*[@id='tbl-procs']/tbody/tr/td[1]";
        rows = driver.findElements(By.xpath(he));
        System.out.println("No of html tbl rows: " + rows.size());
        System.out.println("Number of procedures before dropping: " + rows.size());
        
        
        
        // 6. Display properties of procedure proc_5_1_multi_stmt 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        we = driver.findElement(By.linkText("proc_5_1_multi_stmt"));
        we.click();
        
        // 7. Click drop button.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        button = driver.findElement(By.xpath("//input[@value='Drop']"));
        button.click();
        
        // 8. Click OK on the pop-up
        // Check for errors in execution
        try {
            WebDriverWait wait = new WebDriverWait(driver, 5);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert message:" + errMsg);
            alert.accept();
        } catch (Exception e) {
            //System.out.println("Error:Alert:" + e.getMessage());
            //System.out.println("Execution of statements failed.");
        }
        
        
        // 9. Make sure right dataframe is empty by checking no html table by id 'tbl-procfunc-params'
        Thread.sleep(1000);
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
           
        try {
            he = "//*[@id='tbl-procfunc-params']/thead/tr/th";
            cols = driver.findElements(By.xpath(he));
            if (cols.size() >= 1) {
                System.out.println("Error: Found HTML element tbl-procfunc-params; probably procedure/function was not dropped");
            }
        } catch (NoSuchElementException nsee) {
            System.out.println("No HTML element tbl-procfunc-params found as expected.");
        }
        
        // 10. Make sure procedure count is reduced by 1.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");

        he = "//*[@id='tbl-procs']/tbody/tr/td[1]";
        rows = driver.findElements(By.xpath(he));
        System.out.println("No of html tbl rows: " + rows.size());
        System.out.println("Number of procedures after dropping: " + rows.size());
        
        System.out.flush();               
        
        // 11. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();     
        
        driver.quit();
        
        System.out.flush();

    }
}
