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
public class AdminEmployeeTest 
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
            driver.findElement(By.xpath("/html/body/div[2]/ul/li[5]/a")).click();
            url = driver.getCurrentUrl();
            if(url.equals("http://localhost:8080/IowaAir/adminEmployees.jsp"))
            {
                System.out.println("Employee Page successful");
                driver.findElement(By.xpath("/html/body/div[3]/div[1]/form/input[1]")).sendKeys("Dylan");
                driver.findElement(By.xpath("/html/body/div[3]/div[1]/form/input[2]")).sendKeys("Kutsch");
                driver.findElement(By.xpath("/html/body/div[3]/div[1]/form/input[3]")).sendKeys("nickkutsch3@gmail.com");
                driver.findElement(By.xpath("/html/body/div[3]/div[1]/form/input[7]")).sendKeys("05/17/2000");
                driver.findElement(By.xpath("/html/body/div[3]/div[1]/form/input[8]")).click();
                url = driver.getCurrentUrl();
                if(url.equals("http://localhost:8080/IowaAir/adminEmployees.jsp"))
                {
                    System.out.println("Adding of Employee successful");
                    driver.findElement(By.xpath("/html/body/div[3]/div[1]/form/a")).click();
                    url = driver.getCurrentUrl();
                    if(url.equals("http://localhost:8080/IowaAir/deleteEmployee.jsp"))
                    {
                        System.out.println("Delete Employee Page successful");
                        Select email = new Select(driver.findElement(By.xpath("//*[@id=\"emailSelectedID\"]")));
                        email.selectByVisibleText("nickkutsch3@gmail.com");
                        driver.findElement(By.xpath("/html/body/div[2]/form/input")).click();
                        url = driver.getCurrentUrl();
                        if(url.equals("http://localhost:8080/IowaAir/adminEmployees.jsp"))
                        {
                            System.out.println("Delete Employee Successful");
                            
                        }
                        else
                        {
                            System.out.println("Delete Employee Failed");
                        }
                    }
                    else
                    {
                        System.out.println("Delete Employee Page failed");
                    }
                }
                else
                {
                    System.out.println("Adding of Employee failed");
                }
            }
            else
            {
                System.out.println("Employee Page failed");
            }
            
        }
        else
        {
            System.out.println("Login failed");
        }
        driver.quit(); 
    }
    
}
