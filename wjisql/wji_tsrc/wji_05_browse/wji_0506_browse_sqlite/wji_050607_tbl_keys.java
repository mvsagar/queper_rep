/**
 * Tests table properties screen button 'Keys'.
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
 
public class wji_050607_tbl_keys {
 
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
        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(1000);

        // 3. Click Browse menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Browse"));
        we.click();
                  
        // Test table properties Keys button.
        List cols = null;
        List rows = null;
        WebElement tr = null;
        WebElement tblNameEle = null; 
        WebElement col = null; 
        WebElement button = null;
        
        // 4.1 Test data button for the first table.
        
        for (int k = 1; k <= 1; ++k) {
            driver.switchTo().defaultContent();
            driver.switchTo().frame("leftdatafr");
                    
            // Click table to get the table properties.
            tr = driver.findElement(By.xpath("//*[@id='tbl-tbls']/tbody/tr[" + k + "]"));
            tblNameEle = tr.findElement(By.xpath("//*[@id='tbl-tbls']/tbody/tr[" + k + "]/td[2]"));
            System.out.println("Table=" + tblNameEle.getText());
            we = driver.findElement(By.linkText(tblNameEle.getText()));
            we.click();
            
            // Click keys button.
            driver.switchTo().defaultContent();
            driver.switchTo().frame("rightdatafr");
            button = driver.findElement(By.xpath("//input[@value='Keys']"));
            button.click();
            
            // Go to displayed keys.
            Thread.sleep(1000);
            driver.switchTo().defaultContent();
            driver.switchTo().frame("rightdatafr");
                    
            cols = driver.findElements(By.xpath("//*[@id='tbl-pkey']/thead/tr/th"));
            System.out.println("No of html tbl columns: " + cols.size());
            rows = driver.findElements(By.xpath("//*[@id='tbl-pkey']/tbody/tr/td[1]"));
            System.out.println("No of html tbl rows: " + rows.size());
            System.out.println("No of primary key columns: " + rows.size());
            System.out.println("List of primary key columns:");
            for (int j = 1; j <= cols.size(); ++j) {
                col = driver.findElement(By.xpath("//*[@id='tbl-pkey']/thead/tr/th[" + j + "]"));
                System.out.print((j == 1 ? "" : ",\t") + col.getText()); 
            }
            System.out.println();
            for (int i = 1; i <= rows.size(); ++i) {
                for (int j = 1; j <= cols.size(); ++j) {
                    col = driver.findElement(By.xpath("//*[@id='tbl-pkey']/tbody/tr[" + i + "]/td[" + j + "]"));
                    System.out.print((j == 1 ? "" : ",\t") + col.getText()); 
                }
                System.out.println();
                System.out.println();
            }
            
            // List indexes.
            int x = 1;
            while (true){
                try {
                    // Get index name
                    he = "//*[@id='td-idxname" + x + "']";
                    we = driver.findElement(By.xpath(he));
                    System.out.println(we.getText());
                    
                    // Get index properties;
                    he = "//*[@id='tbl-idxprops" + x + "']/thead/tr/th";
                    cols = driver.findElements(By.xpath(he));
                    if (cols.size() == 0) {
                        break;
                    }
                    System.out.println("Index properties...");
                    System.out.println("No of html tbl columns: " + cols.size());
                    he = "//*[@id='tbl-idxprops" + x + "']/tbody/tr/td[1]";
                    rows = driver.findElements(By.xpath(he));
                    System.out.println("No of html tbl rows: " + rows.size());
                    System.out.println("No of index properties: " + rows.size());
                    System.out.println("List of index properties:");
                    for (int j = 1; j <= cols.size(); ++j) {
                        he = "//*[@id='tbl-idxprops" + x + "']/thead/tr/th[" + j + "]";
                        col = driver.findElement(By.xpath(he));
                        System.out.print((j == 1 ? "" : ",\t") + col.getText()); 
                    }
                    System.out.println();
                    for (int i = 1; i <= rows.size(); ++i) {
                        for (int j = 1; j <= cols.size(); ++j) {
                            he = "//*[@id='tbl-idxprops" + x + "']/tbody/tr[" + i + "]/td[" + j + "]";
                            col = driver.findElement(By.xpath(he));
                            System.out.print((j == 1 ? "" : ",\t") + col.getText()); 
                        }
                        System.out.println();
                        System.out.println();
                    }
                    
                    // Get index columns;
                    he = "//*[@id='tbl-idxcols" + x + "']/thead/tr/th";
                    cols = driver.findElements(By.xpath(he));
                    if (cols.size() == 0) {
                        break;
                    }
                    System.out.println("Index columns...");
                    System.out.println("No of html tbl columns: " + cols.size());
                    he = "//*[@id='tbl-idxcols" + x + "']/tbody/tr/td[1]";
                    rows = driver.findElements(By.xpath(he));
                    System.out.println("No of html tbl rows: " + rows.size());
                    System.out.println("No of index columns: " + rows.size());
                    System.out.println("List of index columns:");
                    for (int j = 1; j <= cols.size(); ++j) {
                        he = "//*[@id='tbl-idxcols" + x + "']/thead/tr/th[" + j + "]";
                        col = driver.findElement(By.xpath(he));
                        System.out.print((j == 1 ? "" : ",\t") + col.getText()); 
                    }
                    System.out.println();
                    for (int i = 1; i <= rows.size(); ++i) {
                        for (int j = 1; j <= cols.size(); ++j) {
                            he = "//*[@id='tbl-idxcols" + x + "']/tbody/tr[" + i + "]/td[" + j + "]";
                            col = driver.findElement(By.xpath(he));
                            System.out.print((j == 1 ? "" : ",\t") + col.getText()); 
                        }
                        System.out.println();
                        System.out.println();
                    }
                } catch (NoSuchElementException  nse) {
                    // Do not throw error index name cell is not found.
                    if (!he.contains("td-idxname")) { 
                        System.out.println("Error: No such html element '" + he + "';" + nse.getMessage());
                    }
                    break;
                }
                ++x;
            }
        } // k
                
        
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
