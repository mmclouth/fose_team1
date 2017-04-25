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
public class AdminAirportsTest 
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
  
        driver.findElement(By.xpath("/html/body/div[2]/form/input[1]")).sendKeys("nickolas-kutsch@uiowa.edu");
        driver.findElement(By.xpath("/html/body/div[2]/form/input[2]")).sendKeys("password");
        driver.findElement(By.xpath("/html/body/div[2]/form/input[3]")).click();
        
        String url = driver.getCurrentUrl();
        if(url.equals("http://localhost:8080/IowaAir/adminLanding.jsp"))
        {
            System.out.println("Login Successful");
            driver.findElement(By.xpath("/html/body/div[2]/ul/li[4]/a")).click();
            url = driver.getCurrentUrl();
            if(url.equals("http://localhost:8080/IowaAir/adminAirports.jsp"))
            {
                System.out.println("Airport page successful");
                driver.findElement(By.xpath("/html/body/div[3]/form/input[1]")).sendKeys("LAX");
                driver.findElement(By.xpath("/html/body/div[3]/form/input[2]")).sendKeys("Los Angeles");
                driver.findElement(By.xpath("/html/body/div[3]/form/input[3]")).sendKeys("California");
                driver.findElement(By.xpath("/html/body/div[3]/form/input[4]")).sendKeys("USA");
                driver.findElement(By.xpath("/html/body/div[3]/form/input[5]")).sendKeys("8");
                driver.findElement(By.xpath("/html/body/div[3]/form/input[6]")).click();
                url = driver.getCurrentUrl();
                if(url.equals("http://localhost:8080/IowaAir/adminAirports.jsp"))
                {
                    System.out.println("Adding of Airport successful");
                    driver.findElement(By.xpath("/html/body/div[3]/form/a")).click();
                    url=driver.getCurrentUrl();
                    if(url.equals("http://localhost:8080/IowaAir/deleteAirport.jsp"))
                    {
                        System.out.println("Delete Page Successful");
                        Select airportCode = new Select(driver.findElement(By.xpath("//*[@id=\"airportCodeID\"]")));
                        airportCode.selectByVisibleText("LAX");
                        driver.findElement(By.xpath("/html/body/div[2]/form/input")).click();
                        url = driver.getCurrentUrl();
                        if(url.equals("http://localhost:8080/IowaAir/adminAirports.jsp"))
                        {
                            System.out.println("Deleted Aiprot Successful");
                        }
                        else
                        {
                            System.out.println("Deleted Aiprot failed");
                        }
                        
                    }
                    else
                    {
                        System.out.println("Delete Page failed");
                    }
                    
                }
                else
                {
                    System.out.println("Adding of Airport failed");
                }
                        
            }
            else
            {
                System.out.println("Airport page failed");
            }
        }
        else
        {
            System.out.println("Login failed");
        }
        driver.quit(); 
    }
    
}
