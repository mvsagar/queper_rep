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

/**
 * Tests properties of procedures and functions.
 * 
 * @author mvsagar
 *
 */
public class wji_050211_procfunc_prop {
 
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
        // Invoke wjISQL.
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
                  
        // 4. Go to table list frame and click  Procedures & Functions button,        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        we = driver.findElement(By.xpath("//input[contains(@value, 'Procedures')]"));
        we.click();

        List cols = null;
        List rows = null;

        // 5.1 Display properties of procedure proc_1_1_no_args_no_results   
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        we = driver.findElement(By.linkText("proc_1_1_no_args_no_results"));
        we.click();

        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        we = driver.findElement(By.xpath("//*[@id='procfunc-name']"));
        System.out.println("Properties of Procedure: " + we.getText());

        // Display proc params
        rows = driver.findElements(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr"));
        if (rows.size() == 0) {
            System.out.println("The procedure has no parameters");
        }

        // 5.2 Display properties of procedure procedure proc_5_1_multi_stmt    
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        we = driver.findElement(By.linkText("proc_5_1_multi_stmt"));
        we.click();


        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        we = driver.findElement(By.xpath("//*[@id='procfunc-name']"));
        System.out.println("\nProperties of Procedure: " + we.getText());

        // Display proc params
        cols = driver.findElements(By.xpath("//*[@id='tbl-procfunc-params']/thead/tr/th"));
        rows = driver.findElements(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr"));
        System.out.println("Number of html table columns:   " + cols.size());
        System.out.println("Number of html table rows:      " + rows.size());
        System.out.println("Number of procedure parameters: " + rows.size());

        System.out.println("Parameters and properties:");
        // Display column headings.
        we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/thead/tr[1]/th[1]/input"));
        System.out.print(we.getAttribute("value"));
        we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/thead/tr[1]/th[2]"));
        System.out.print("\t" + we.getText());
        we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/thead/tr[1]/th[3]"));
        System.out.print("\t" + we.getText());
        we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/thead/tr[1]/th[5]"));
        System.out.println("\t" + we.getText());
        // Display parameters.
        for (int i = 1; i <= rows.size(); ++i) {
            we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr[" + i + "]/td[1]"));
            System.out.print(we.getText());
            we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr[" + i + "]/td[2]"));
            System.out.print("\t" + we.getText());
            we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr[" + i + "]/td[3]"));
            System.out.print("\t" + we.getText());
            we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr[" + i + "]/td[5]"));
            System.out.println("\t" + we.getText());            
        }

        // 5.3 Display properties of function func_1_1_compute_tax    
        
        driver.switchTo().defaultContent();
        driver.switchTo().frame("leftdatafr");
        we = driver.findElement(By.linkText("func_1_1_compute_tax"));
        we.click();


        driver.switchTo().defaultContent();
        driver.switchTo().frame("rightdatafr");
        we = driver.findElement(By.xpath("//*[@id='procfunc-name']"));
        System.out.println("\nProperties of Function: " + we.getText());

        // Display proc params
        cols = driver.findElements(By.xpath("//*[@id='tbl-procfunc-params']/thead/tr/th"));
        rows = driver.findElements(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr"));
        System.out.println("Number of html table columns:   " + cols.size());
        System.out.println("Number of html table rows:      " + rows.size());
        System.out.println("Number of function parameters:  " + rows.size());

        System.out.println("Parameters and properties:");
        // Display column headings.
        we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/thead/tr[1]/th[1]/input"));
        System.out.print(we.getAttribute("value"));
        we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/thead/tr[1]/th[2]"));
        System.out.print("\t" + we.getText());
        we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/thead/tr[1]/th[3]"));
        System.out.print("\t" + we.getText());
        we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/thead/tr[1]/th[5]"));
        System.out.println("\t" + we.getText());
        // Display parameters.
        for (int i = 1; i <= rows.size(); ++i) {
            we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr[" + i + "]/td[1]"));
            System.out.print(we.getText());
            we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr[" + i + "]/td[2]"));
            System.out.print("\t" + we.getText());
            we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr[" + i + "]/td[3]"));
            System.out.print("\t" + we.getText());
            we = driver.findElement(By.xpath("//*[@id='tbl-procfunc-params']/tbody/tr[" + i + "]/td[5]"));
            System.out.println("\t" + we.getText());            
        }
        
        
        System.out.flush();
        
        // 6. Disconnection from the database
        driver.switchTo().defaultContent();
        driver.switchTo().frame("navifr");
        we = driver.findElement(By.linkText("Disconnect"));
        we.click();
        
        
        driver.quit();
        
        System.out.flush();

    }
}
