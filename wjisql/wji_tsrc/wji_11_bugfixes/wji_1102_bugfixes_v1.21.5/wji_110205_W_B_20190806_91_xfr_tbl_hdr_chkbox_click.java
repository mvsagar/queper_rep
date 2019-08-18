/**
 * Tests fix for the bug W_B_20190806_91: Clicking of transfer check box in table header of source table list in Data Transfer screen is problematic.
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.Alert;
import org.openqa.selenium.UnhandledAlertException;
import org.openqa.selenium.NoAlertPresentException;
import org.openqa.selenium.NoSuchElementException;

import org.testng.annotations.Test;
 
public class wji_110205_W_B_20190806_91_xfr_tbl_hdr_chkbox_click {
 
    
    private static void printHtmlTable(WebDriver driver, String htmlTblId)
    {
        List cols = null;
        List rows = null;
        WebElement col = null;
        String val = null;
        
        cols = driver.findElements(By.xpath("//*[@id='" + htmlTblId + "']/thead/tr/th"));
        System.out.println("Number of html table columns: " + cols.size());
        rows = driver.findElements(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr"));
        System.out.println("Number of html table rows: " + rows.size());
        // Get columns and check color.
        // Column names
        for (int j = 1; j <= cols.size(); ++j) {
            col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/thead/tr[1]/th[" + j + "]"));
            System.out.print((j == 1 ? "" : ",\t") + col.getText());
            try {
                col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/thead/tr[1]/th[" + j + "]/input"));
                val = (col.isSelected() ? "selected" : "not-selected");
                System.out.print(val);
            } catch (NoSuchElementException nsee) {
               //
            }   
        }
        System.out.println();
        // data
        for (int i = 1; i <= rows.size(); ++i) {
            for (int j = 1; j <= cols.size(); ++j) {
                try {
                    col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]/td[" + j + "]/a/input"));
                    val = col.getAttribute("value");
                } catch (NoSuchElementException nsee) {
                    try {
                        col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]/td[" + j + "]/input"));
                        val = (col.isSelected() ? "selected" : "not-selected");
                    } catch (NoSuchElementException nsee1) {
                        col = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]/td[" + j + "]"));
                        val = col.getText();
                    }                    
                }
                System.out.print((j == 1 ? "" : ",\t") + val); 
            }
            System.out.println();
        }       
    } 
    
    public static void main(String[] args) throws IOException, InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions browserOptions = new ChromeOptions();
        //System.setProperty("webdriver.gecko.driver", "/usr/bin/geckodriver");
        //FirefoxOptions browserOptions = new FirefoxOptions();
        
        browserOptions.addArguments("--headless");
        browserOptions.addArguments("--no-sandbox");
 
        WebDriver driver = null;
        WebElement we = null;
        List<WebElement> weList = null;
        Select jdbcDriverSelect = null;
       
        String frameSource = "";
        WebElement waitForWe = null;
        int waitedTime = 0; // seconds
 
        driver = new ChromeDriver(browserOptions);
        //driver = new FirefoxDriver(browserOptions);
        
        driver.get(args[0]);
 
        Thread.sleep(1000);

        // 1. Click Transfer menu link 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Transfer"));
        we.click();
        Thread.sleep(2000);

        // 2. Login into source database.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("datafr");
        driver.switchTo().frame("rightdatafr");
        driver.switchTo().frame("rightdatafr1");
        // select jdbc driver
        we = driver.findElement(By.name("jdriver_name"));
        jdbcDriverSelect = new Select(we);
        jdbcDriverSelect.selectByVisibleText(System.getenv("WJI_JDBC_DRIVER_NAME"));
        // enter url
        we = driver.findElement(By.name("dburl"));
        we.clear();
        we.sendKeys(System.getenv("WJI_JDBC_URL"));
        if (System.getenv("WJI_JDBC_URL").contains("sqlite")) {
            // Do not need userid and passwords.
        } else {
            // enter user id
            we = driver.findElement(By.name("userid"));
            we.clear();
            we.sendKeys(System.getenv("WJI_USER_ID"));
            // enter password
            we = driver.findElement(By.name("password"));
            we.clear();
            we.sendKeys(System.getenv("WJI_USER_PASSWD"));
        }

        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(5000);
       

        // Check source tables
        // wait till SQL statement window is displayed
        driver.switchTo().defaultContent();
        driver.switchTo().frame("datafr");
        driver.switchTo().frame("leftdatafr");
        driver.switchTo().frame("leftdatafr1");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("src-tbl-list")));
        
        System.out.println("Source table list:");
        printHtmlTable(driver, "src-tbl-list");
                
        // 3. Select all source tables for data transfer by clicking check box in the table list header.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("datafr");
        driver.switchTo().frame("leftdatafr");
        driver.switchTo().frame("leftdatafr1");    
        System.out.println("\nClicking transfer check box in table list header:");
        we = driver.findElement(By.xpath("//*[@id='src-tbl-list']/thead/tr/th[4]/input[@name='xfrall']"));
        we.click();
        
  
        // 4. Display table list.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("datafr");
        driver.switchTo().frame("leftdatafr");
        driver.switchTo().frame("leftdatafr1");       
        // list tables for verification.
        System.out.println("\nSource tables with check box on all tables:");
        printHtmlTable(driver, "src-tbl-list");   
        
  
                        
        // 5. Disconnection from the source database and go back to home screen.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect source"));
        we.click();
        we = driver.findElement(By.linkText("Back"));
        we.click();
        
        
        driver.quit();
        
        System.out.flush();

    }
}
