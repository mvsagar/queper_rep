/**
 * Tests successful connection and disconnection.
 */
import java.io.IOException;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.Alert;
import org.openqa.selenium.UnhandledAlertException;
import org.openqa.selenium.NoAlertPresentException;

import org.testng.annotations.Test;
 
public class wji_060701_sql_menu_item {
 
    public static void main(String[] args) throws IOException, InterruptedException { 
        WebDriver driver = null;
        WebElement we = null;
        List<WebElement> weList = null;
        String currVersion = "";
        String frameSource = "";
 
        System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("--headless");
        chromeOptions.addArguments("--no-sandbox");
 
        driver = new ChromeDriver(chromeOptions);
        
        // Invoke wjISQL
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
        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(1000);

        // 3. Click SQL menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("SQL"));
        we.click();
        
        // 4. Check tables and rows created.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        frameSource = driver.getPageSource();
            
        List  col = driver.findElements(By.xpath("//*[@id=\"tbl-tbls\"]/thead/tr/th"));
        System.out.println("No of cols are : " +col.size());
        List  rows = driver.findElements(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr/td[1]"));
        System.out.println("No of rows are : " + rows.size());
        
        WebElement tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[1]"));
        WebElement tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[1]/td[2]"));
        WebElement numRowsEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[1]/td[3]"));
        System.out.println("Table=" + tblNameEle.getText() + ", Numrows=" + numRowsEle.getText());

        tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[2]"));
        tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[2]/td[2]"));
        numRowsEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[2]/td[3]"));
        System.out.println("Table=" + tblNameEle.getText() + ", Numrows=" + numRowsEle.getText());

        tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[3]"));
        tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[3]/td[2]"));
        numRowsEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[3]/td[3]"));
        System.out.println("Table=" + tblNameEle.getText() + ", Numrows=" + numRowsEle.getText());
        
        tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[4]"));
        tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[4]/td[2]"));
        numRowsEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[4]/td[3]"));
        System.out.println("Table=" + tblNameEle.getText() + ", Numrows=" + numRowsEle.getText());
        
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
