/**
 * Tests table properties feature.
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
 
public class wji_050605_tbl_prop {
 
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
        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(1000);

        // 3. Click Browse menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Browse"));
        we.click();
                  
        
        // 4. Table propery tests.
        
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement tblNameEle = null; 
        WebElement colName = null; 
        WebElement typeName = null;
        WebElement colSize = null;        
        
        // 4.1 Click on the first table to display its properties.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
                
        // Click first table to get the table properties.
        tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[1]"));
        tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[1]/td[2]"));
        System.out.println("Table=" + tblNameEle.getText());
        we = driver.findElement(By.linkText(tblNameEle.getText()));
        we.click();

        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        
        // Display a few table properies.
        cols = driver.findElements(By.xpath("//*[@id=\"tbl-dbtblcols\"]/thead/tr/th"));
        System.out.println("No of table properies: " +cols.size());
        rows = driver.findElements(By.xpath("//*[@id=\"tbl-dbtblcols\"]/tbody/tr/td[1]"));
        System.out.println("No of table columns: " + rows.size());
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id=\"tbl-dbtblcols\"]/tbody/tr[" + i + "]"));
            colName = tr.findElement(By.xpath("//*[@id=\"tbl-dbtblcols\"]/tbody/tr[" + i + "]/td[2]"));
            typeName = tr.findElement(By.xpath("//*[@id=\"tbl-dbtblcols\"]/tbody/tr[" + i + "]/td[4]"));
            colSize = tr.findElement(By.xpath("//*[@id=\"tbl-dbtblcols\"]/tbody/tr[" + i + "]/td[5]"));
            System.out.println(i + ")\tColumn name: " + colName.getText() 
                + ",\t\tColumn type: " + typeName.getText()
                + ",\t\tColumn size: " + colSize.getText());
        }
        
        // 4.2 Click on the second table to display its properties.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
                
        // Click second table to get the table properties.
        tr = driver.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[2]"));
        tblNameEle = tr.findElement(By.xpath("//*[@id=\"tbl-tbls\"]/tbody/tr[2]/td[2]"));
        System.out.println("Table=" + tblNameEle.getText());
        tblNameEle.click();
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        
        // Display a few table properies.
        cols = driver.findElements(By.xpath("//*[@id=\"tbl-dbtblcols\"]/thead/tr/th"));
        System.out.println("No of table properies: " +cols.size());
        rows = driver.findElements(By.xpath("//*[@id=\"tbl-dbtblcols\"]/tbody/tr/td[1]"));
        System.out.println("No of table columns: " + rows.size());
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id=\"tbl-dbtblcols\"]/tbody/tr[" + i + "]"));
            colName = tr.findElement(By.xpath("//*[@id=\"tbl-dbtblcols\"]/tbody/tr[" + i + "]/td[2]"));
            typeName = tr.findElement(By.xpath("//*[@id=\"tbl-dbtblcols\"]/tbody/tr[" + i + "]/td[4]"));
            colSize = tr.findElement(By.xpath("//*[@id=\"tbl-dbtblcols\"]/tbody/tr[" + i + "]/td[5]"));
            System.out.println(i + ")\tColumn name: " + colName.getText() 
                + ",\t\tColumn type: " + typeName.getText()
                + ",\t\tColumn size: " + colSize.getText());
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
