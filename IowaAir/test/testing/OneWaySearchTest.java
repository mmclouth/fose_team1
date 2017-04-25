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
public class OneWaySearchTest 
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
  
        driver.findElement(By.xpath("/html/body/div[2]/form/input[1]")).sendKeys("beer@iowaair.net");
        driver.findElement(By.xpath("/html/body/div[2]/form/input[2]")).sendKeys("password");
        driver.findElement(By.xpath("/html/body/div[2]/form/input[3]")).click();
        
        String url = driver.getCurrentUrl();
        if(url.equals("http://localhost:8080/IowaAir/home.jsp"))
        {
            //Select One Way
            driver.findElement(By.xpath("//*[@id=\"radioButtons\"]/input[2]")).click();
            Select origin = new Select(driver.findElement(By.xpath("//*[@id=\"form1\"]/select[1]")));
            origin.selectByVisibleText("IFC");
            Select destination = new Select(driver.findElement(By.xpath("//*[@id=\"form1\"]/select[2]")));
            destination.selectByVisibleText("ORD");
            driver.findElement(By.xpath("//*[@id=\"form1\"]/input[1]")).sendKeys("04/05/2017");
           // driver.findElement(By.xpath("//*[@id=\"form1\"]/input[3]")).sendKeys("2");
            driver.findElement(By.xpath("//*[@id=\"form1\"]/div/button")).click();
            
            url = driver.getCurrentUrl();
            if(url.equals("http://localhost:8080/IowaAir/searchResults.jsp?origin=IFC&destination=ORD&d_date=2017-04-05&r_date=&num_of_passengers=1"))
            {
                System.out.println("Search was successful");
                driver.findElement(By.xpath("//*[@id=\"inner\"]/tbody/tr[2]/td[10]/form/input[2]")).click();
                url = driver.getCurrentUrl();
                if (url.equals("http://localhost:8080/IowaAir/confirmBooking.jsp"))
                {
                    System.out.println("Selection successful");
                    driver.findElement(By.xpath("/html/body/div[2]/b/form[2]/p/input")).click();
                    url = driver.getCurrentUrl();
                    if (url.equals("http://localhost:8080/IowaAir/passengerInfo.jsp"))
                    {
                        System.out.println("Confirmed booking successful");
                        driver.findElement(By.xpath("/html/body/div[2]/form/input[1]")).sendKeys("Nick");
                        driver.findElement(By.xpath("/html/body/div[2]/form/input[2]")).sendKeys("Kutsch");
                        Select seatNum = new Select(driver.findElement(By.xpath("/html/body/div[2]/form/select")));
                        seatNum.selectByVisibleText("3A");
                        driver.findElement(By.xpath("/html/body/div[2]/form/input[3]")).sendKeys("1");
                        driver.findElement(By.xpath("/html/body/div[2]/form/input[5]")).click();
                        url = driver.getCurrentUrl();
                        
                        if(url.equals("http://localhost:8080/IowaAir/purchaseFlight.jsp"))
                        {
                            System.out.println("Passenger Info successful");
                            driver.findElement(By.xpath("/html/body/div[2]/form/input[5]")).sendKeys("0123456789");
                            Select month = new Select(driver.findElement(By.xpath("/html/body/div[2]/form/select[1]")));
                            month.selectByVisibleText("11");
                            Select year = new Select(driver.findElement(By.xpath("/html/body/div[2]/form/select[2]")));
                            year.selectByVisibleText("20");
                            driver.findElement(By.xpath("/html/body/div[2]/form/input[6]")).sendKeys("123");
                            driver.findElement(By.xpath("/html/body/div[2]/form/input[7]")).click();
                            url = driver.getCurrentUrl();
                            if(url.equals("http://localhost:8080/IowaAir/userFlightHistory.jsp"))
                            {
                                System.out.println("Purchase successful");
                            }
                            else
                            {
                                System.out.println("Purchase failed");
                            }
                        }
                        else
                        {
                            System.out.println("Passenger Info failed");
                        }
                    }
                    else
                    {
                        System.out.println("Confirmed booking failed");
                    }
                        
                }
                else
                {
                    System.out.println("Second Selection failed");
                }
            }
            else
            {
                System.out.println("Search Failed");
            }
            
            
        }
        else
        {
            System.out.println("Login Failed");
        }
        driver.quit(); 
    }
    
}
