/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package testing;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.Select;

/**
 *
 * @author Nickolas
 */
public class EmployeeSearchFlightTest 
{
    private static WebDriver driver = null;
    public static void main(String[] args) 
    {
        System.setProperty("webdriver.chrome.driver","web/WEB-INF/chromedriver.exe");
        // TODO code application logic here
         // Initialize driver      
        driver = new ChromeDriver();  
          
        //Go to URL      
        driver.get("http://localhost:8080/IowaAir/logIn.jsp"); 
        driver.manage().window().maximize();
  
        driver.findElement(By.xpath("/html/body/div[2]/form/input[1]")).sendKeys("johndoe@iowaair.net");
        driver.findElement(By.xpath("/html/body/div[2]/form/input[2]")).sendKeys("password");
        driver.findElement(By.xpath("/html/body/div[2]/form/input[3]")).click();
        
        String url = driver.getCurrentUrl();
        if(url.equals("http://localhost:8080/IowaAir/employeeLanding.jsp"))
        {
            System.out.println("Login Successful");
            driver.findElement(By.xpath("/html/body/div[2]/ul/li[2]/a")).click();
            url = driver.getCurrentUrl();
            if(url.equals("http://localhost:8080/IowaAir/employeeFlightSearch.jsp"))
            {
                System.out.println("Search Flight page successful");
                driver.findElement(By.xpath("//*[@id=\"radioButtons\"]/input[2]")).click();
                Select origin = new Select(driver.findElement(By.xpath("//*[@id=\"form1\"]/select[1]")));
                origin.selectByVisibleText("ORD");
                Select destination = new Select(driver.findElement(By.xpath("//*[@id=\"form1\"]/select[2]")));
                destination.selectByVisibleText("SFO");
                driver.findElement(By.xpath("//*[@id=\"form1\"]/input[1]")).sendKeys("04/05/2017");
                driver.findElement(By.xpath("//*[@id=\"form1\"]/div/button")).click();
                url = driver.getCurrentUrl();
                if(url.equals("http://localhost:8080/IowaAir/searchResults.jsp?origin=ORD&destination=SFO&d_date=2017-04-05&r_date=&num_of_passengers=1"))
                {
                    System.out.println("Search successful");
                    driver.findElement(By.xpath("//*[@id=\"inner\"]/tbody/tr[2]/td[10]/form/input[3]")).click();
                    url = driver.getCurrentUrl();
                    if(url.equals("http://localhost:8080/IowaAir/confirmBooking.jsp"))
                    {
                        System.out.println("Selection successful");
                        driver.findElement(By.xpath("/html/body/div[2]/b/form[1]/p/input")).click();
                        url=driver.getCurrentUrl();
                        if(url.equals("http://localhost:8080/IowaAir/purchaseFlight.jsp"))
                        {
                            System.out.println("Confirmed successful");
                        }
                        else
                        {
                            System.out.println("Confirmed failed");
                        }
                    }
                    else
                    {
                        System.out.println("Selection failed");
                    }
                }
                else
                {
                    System.out.println("Seach failed");
                }
            }
            else
            {
                System.out.println("Search Flight page failed");
            }
        }
        else
        {
            System.out.println("Login failed");
        }
        driver.quit(); 
    }
    
}
