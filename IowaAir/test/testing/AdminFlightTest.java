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
public class AdminFlightTest 
{
    private static WebDriver driver = null;
    public static void main(String[] args) 
    {


        System.setProperty("webdriver.chrome.driver","C:\\IowaAir\\ChromeDriver\\chromedriver.exe");
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
            driver.findElement(By.xpath("/html/body/div[2]/ul/li[2]/a")).click();
            url = driver.getCurrentUrl();
            if (url.equals("http://localhost:8080/IowaAir/adminFlights.jsp"))
            {
                System.out.println("Admin Flights Successful");
                Select aircraftType = new Select(driver.findElement(By.xpath("/html/body/div[3]/form[1]/select")));
                aircraftType.selectByVisibleText("Boeing787-10");
                driver.findElement(By.xpath("/html/body/div[3]/form[1]/input")).click();
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[1]")).sendKeys("AA301");
                Select airplaneID = new Select(driver.findElement(By.xpath("//*[@id=\"aircraftID\"]")));
                airplaneID.selectByVisibleText("10003");
                Select originCode = new Select(driver.findElement(By.xpath("/html/body/div[3]/form[2]/select[2]")));
                originCode.selectByVisibleText("ORD");
                Select destinationCode = new Select(driver.findElement(By.xpath("/html/body/div[3]/form[2]/select[3]")));
                destinationCode.selectByVisibleText("SFO");
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[2]")).sendKeys("04/17/2017");
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[3]")).sendKeys("04/17/2017");
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[4]")).sendKeys("0600PM");
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[5]")).sendKeys("1000PM");
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[6]")).sendKeys("240");
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[7]")).sendKeys("300");
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[8]")).sendKeys("450");
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[11]")).click();
                url = driver.getCurrentUrl();
                if (url.equals("http://localhost:8080/IowaAir/adminFlights.jsp"))
                {
                    System.out.println("Adding of Flight Successful");
                    driver.findElement(By.xpath("/html/body/div[4]/table/tbody/tr[2]/td[14]/input")).click();
                    url = driver.getCurrentUrl();
                    if(url.equals("http://localhost:8080/IowaAir/modifyFlight.jsp"))
                    {
                        System.out.println("Update flight page successful");
                        driver.findElement(By.xpath("//*[@id=\"priceEconomyID\"]")).sendKeys("250");
                        driver.findElement(By.xpath("//*[@id=\"priceFirstClassID\"]")).sendKeys("450");
                        driver.findElement(By.xpath("//*[@id=\"modifyForm\"]/input[25]")).click();
                        url = driver.getCurrentUrl();
                        if(url.equals("http://localhost:8080/IowaAir/adminFlights.jsp"))
                        {
                            System.out.println("Updated Flight Successful");
                            driver.findElement(By.xpath("/html/body/div[3]/form[2]/a")).click();
                            url = driver.getCurrentUrl();
                            if(url.equals("http://localhost:8080/IowaAir/deleteFlight.jsp"))
                            {
                                System.out.println("Admin Flight Delete Page Successful");
                                Select flightNumber = new Select(driver.findElement(By.xpath("//*[@id=\"flightNumID\"]")));
                                flightNumber.selectByVisibleText("AA301");
                                driver.findElement(By.xpath("/html/body/div[2]/form/input")).click();
                                url = driver.getCurrentUrl();
                                if (url.equals("http://localhost:8080/IowaAir/adminFlights.jsp"))
                                {
                                    System.out.println("Flight Deleted Successfully");
                                }
                                else
                                {
                                    System.out.println("Flight Deleted Failed");
                                }
                            }
                            else
                            {
                                System.out.println("Admin Flight Delete Page Failed");
                            }
                        }
                        else
                        {
                            System.out.println("Updated Flight Failed");
                        }
                    }
                    else
                    {
                        System.out.println("Update flight page failed");
                    }
                }
                else
                {
                    System.out.println("Adding of Flight Failed");
                }
                
            }
            else
            {
                System.out.println("Admin Flights Failed");
            }
        }
        else
        {
            System.out.println("Login failed");
        }
        driver.quit(); 
    }
}
