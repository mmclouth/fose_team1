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
public class AdminAirplaneTest 
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
            driver.findElement(By.xpath("/html/body/div[2]/ul/li[3]/a")).click();
            url = driver.getCurrentUrl();
            if (url.equals("http://localhost:8080/IowaAir/adminAirplanes.jsp"))
            {
                System.out.println("Admin Airplane successful");
                Select aircraftType = new Select(driver.findElement(By.xpath("//*[@id=\"select_plane_name\"]")));
                aircraftType.selectByVisibleText("Boeing787-10");
                driver.findElement(By.xpath("/html/body/div[3]/form[1]/input")).click();
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[2]")).sendKeys("PL10007");
                driver.findElement(By.xpath("/html/body/div[3]/form[2]/input[8]")).click();
                url = driver.getCurrentUrl();
                if (url.equals("http://localhost:8080/IowaAir/adminAirplanes.jsp"))
                {
                    System.out.println("Adding of Airplane successful");
                    driver.findElement(By.xpath("/html/body/div[4]/table/tbody/tr[2]/td[9]/input")).click();
                    url = driver.getCurrentUrl();
                    if (url.equals("http://localhost:8080/IowaAir/modifyAircraft.jsp"))
                    {
                        System.out.println("Update Airplane Page Successful");
                        driver.findElement(By.xpath("//*[@id=\"downTimeID\"]")).sendKeys("65");
                        driver.findElement(By.xpath("/html/body/div[2]/form/input[15]")).click();
                        url = driver.getCurrentUrl();
                        if (url.equals("http://localhost:8080/IowaAir/adminAirplanes.jsp"))
                        {
                            System.out.println("Update Airplane Successful");
                            driver.findElement(By.xpath("/html/body/div[3]/form[2]/a")).click();
                            url = driver.getCurrentUrl();
                            if (url.equals("http://localhost:8080/IowaAir/deleteAircraft.jsp"))
                            {
                                System.out.println("Delete Airplane Page Successful");
                                driver.findElement(By.xpath("/html/body/div[2]/form/a")).click();
                                url = driver.getCurrentUrl();
                                if (url.equals("http://localhost:8080/IowaAir/adminAirplanes.jsp"))
                                {
                                    System.out.println("Go Back Successful");
                                }
                                else
                                {
                                    System.out.println("Go Back Failed");
                                }
                            }
                            else
                            {
                                System.out.println("Delete Airplane Page Failed");
                            }
                        }
                        else
                        {
                            System.out.println("Update Airplane Failed");
                        }
                    }
                    else
                    {
                        System.out.println("Update Airplane Page Failed");
                    }
                }
                else
                {
                    System.out.println("Adding of Airplane Failed");
                }
            }
            else
            {
                System.out.println("Admin Airplane Failed");
            }
        }
        else
        {
            System.out.println("Login failed");
        }
        driver.quit(); 
    }
}
