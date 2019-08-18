/**
 * Tests Cancellation of Update operation.
 */
import java.io.IOException;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.Color;
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

import org.testng.annotations.Test;
 
class wji_080317_cancel_update {
    
    private static void printHtmlTable(WebDriver driver, String htmlTblId)
    {
        List cols = null;
        List rows = null;
        WebElement tr = null, col = null;
        
        cols = driver.findElements(By.xpath("//*[@id='" + htmlTblId + "']/thead/tr/th"));
        System.out.println("Number of html tbl columns: " + cols.size());
        rows = driver.findElements(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr"));
        System.out.println("Number of html table rows: " + rows.size());
        // Get columns and check color.
        // Column names
        tr = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/thead/tr[1]"));
        for (int j = 3; j <= cols.size(); ++j) {
            col = tr.findElement(By.xpath("//*[@id='" + htmlTblId + "']/thead/tr[1]/th[" + j + "]"));
            System.out.print((j == 3 ? "" : ",\t") + col.getText());
        }
        System.out.println();
        // Column values and color.
        for (int i = 1; i <= rows.size(); ++i) {
            tr = driver.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]"));
            System.out.print("(row value color:" 
                + (tr.getAttribute("style").contains("color") ? tr.getAttribute("style") : "None") + ") ");
            // Get key columns and check color.
            for (int j = 3; j <= cols.size(); ++j) {
                col = tr.findElement(By.xpath("//*[@id='" + htmlTblId + "']/tbody/tr[" + i + "]/td[" + j + "]"));
                System.out.print((j == 3 ? "" : ",\t") + col.getText()
                 + "(color:" + (col.getAttribute("style").contains("color") ? tr.getAttribute("style") : "None") + ")");
            }
            System.out.println();
        }           
    }
 
    public static void main(String[] args) throws IOException, InterruptedException {
        //System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
        //ChromeOptions browserOptions = new ChromeOptions();
        System.setProperty("webdriver.gecko.driver", "/usr/bin/geckodriver");
        FirefoxOptions browserOptions = new FirefoxOptions();
        
        browserOptions.addArguments("--headless");
        browserOptions.addArguments("--no-sandbox");
 
        WebDriver driver = null;
        WebElement we = null;
        List<WebElement> weList = null;
        String currVersion = "";
        String frameSource = "";
        WebElement waitForWe = null;
        int waitedTime = 0;

 
        //driver = new ChromeDriver(browserOptions);
        driver = new FirefoxDriver(browserOptions);

        driver.get(args[0]);
 
        Thread.sleep(1000);
 

        // 1. Click Connect menu link 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Connect"));
        we.click();
        
        Thread.sleep(5000);

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
        if (System.getenv("WJI_JDBC_URL").contains("sqlite")) {
            // Do not need userid and passwords.
        } else {
            // enter user id
            we = driver.findElement(By.name("userid"));
            we.sendKeys(System.getenv("WJI_USER_ID"));
            // enter password
            we = driver.findElement(By.name("password"));
            we.sendKeys(System.getenv("WJI_USER_PASSWD"));
        }

        // Click login button
        we = driver.findElement(By.name("login"));
        we.click();
        
        Thread.sleep(1000);

        // 3. Click SQL menu item
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("SQL"));
        we.click();

        
        // 4. Execute script to create tables emp and dept.     
        driver.switchTo().defaultContent();
        driver.switchTo().frame("sqlstmtfr");
        
        // Clear stmt window
        we = driver.findElement(By.xpath("//input[@value='Clear']"));
        we.click();
        
        // Create tables emp and dept.
        we = driver.findElement(By.id("script_files"));
        we.sendKeys(System.getenv("WJI_TSRC_HOME") + "/wji_scripts/wji_16_sql_scripts/tst_16_002_sql_script_deptemp.sql");
        we =  driver.findElement(By.id("user_sqlstmt"));
        waitedTime = 0;
        while (we.getAttribute("value").trim().isEmpty() && waitedTime <= 5) {
            we =  driver.findElement(By.id("user_sqlstmt"));
            Thread.sleep(1000);
            waitedTime += 1;
        }
        
        // Execute the script stmts
        we = driver.findElement(By.xpath("//input[@value='Execute']"));
        we.click();
        
        Thread.sleep(10000);
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        /*
        List<WebElement> el = driver.findElements(By.cssSelector("*"));
        for (WebElement e: el ) {
            System.out.println(e.getTagName() + ":" + e.getAttribute("id") 
                + e.getAttribute("name") + e.getAttribute("value")+ ":" + e.getText());
        }
        */
        
        // Wait till the script stmt is executed completely.
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-14")));       
            
        // 5. Click on table emp.
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-tbls")));
        we = driver.findElement(By.linkText("emp"));
        we.click();
        
  
        WebElement tr = null;
        WebElement tblNameEle = null; 
        WebElement col = null; 
        WebElement button = null;
        
        // 6. Click on 'Data'  button
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.xpath("//input[@value='Data']")));
        button = driver.findElement(By.xpath("//input[@value='Data']"));
        button.click();
        
        // Wait for html result set table is displayed 
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-0")));
        
        // 7. Rows before update.
        System.out.println("Rows before clicking Update button...");
        printHtmlTable(driver, "tbl-rs-0");    
        
        
        // 8. Select row 3 for updating
        button = driver.findElement(By.xpath("//input[@name='vr3c0']"));
        button.click();
        
        // 9. Click buttion 'Update'
        button = driver.findElement(By.xpath("//input[@value='Update']"));
        button.click();
        
        // 10.Wait for html result set table is re-displayed.
        Thread.sleep(3000);
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-0")));
        
        // 11. Supply data for the row.
        col = driver.findElement(By.xpath("//textarea[@name='vr3c2']")); 
        col.sendKeys("Shiva");
   
        // 12. Rows after data entry on the screen.
        System.out.println("\nRows after updating 3rd row on the screen...");
        printHtmlTable(driver, "tbl-rs-0"); 
        
        // 13. Click buttion 'Cancel' to cancel update operation.
        button = driver.findElement(By.xpath("//input[@value='Cancel']"));
        button.click();
        
        // 14. Accept pop up to confirm cancellation.
        try {
            WebDriverWait wait = new WebDriverWait(driver, 30);
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            String errMsg = alert.getText();
            System.out.println("Alert message:" + errMsg);
            alert.accept();
        } catch (Exception e) {
            //System.out.println("Error:Alert:" + e.getMessage());
            //System.out.println("Execution of statements failed.");
        }              
        
        // 15. Wait for  reetrieving table data for display.
        Thread.sleep(2000);
        
        // 16. Wait for html result set table is displayed.
        waitForWe = (new WebDriverWait(driver, 10))
                .until(ExpectedConditions.presenceOfElementLocated(By.id("tbl-rs-0")));  
        
        // 17. Make sure rows are as before insert operation.
        System.out.println("\nRows after clicking Cancel button...");
        printHtmlTable(driver, "tbl-rs-0");
       
        System.out.flush();   
        
        // 18. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();     
        
        driver.quit();
        
        System.out.flush();

    }
}
