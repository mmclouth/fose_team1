/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package testing;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

/**
 *
 * @author Nickolas
 */
public class SignUpErrorTest 
{
    private static WebDriver driver = null;
    public static void main(String[] args) 
    {
        System.setProperty("webdriver.chrome.driver","web/WEB-INF/chromedriver.exe");
        // TODO code application logic here
         // Initialize driver      
        driver = new ChromeDriver();  
          
        //Go to URL      
        driver.get("http://localhost:8080/IowaAir/signUp.jsp"); 
        driver.manage().window().maximize();
  
        driver.findElement(By.xpath("/html/body/div[2]/div/form/input[1]")).sendKeys("Billy");
        driver.findElement(By.xpath("/html/body/div[2]/div/form/input[2]")).sendKeys("Bob");
        driver.findElement(By.xpath("/html/body/div[2]/div/form/input[6]")).sendKeys("04/26/1990");
        driver.findElement(By.xpath("/html/body/div[2]/div/form/input[7]")).sendKeys("nickkutsch3@gmail.com");
        driver.findElement(By.xpath("/html/body/div[2]/div/form/input[8]")).sendKeys("Hawks");
        driver.findElement(By.xpath("/html/body/div[2]/div/form/input[9]")).sendKeys("Hawkeyes123");
        driver.findElement(By.xpath("/html/body/div[2]/div/form/input[10]")).click();
        
        String url = driver.getCurrentUrl();
        if(url.equals("http://localhost:8080/IowaAir/home.jsp"))
        {
            System.out.println("Sign up Successful");
        }
        else
        {
            System.out.println("Sign up failed");
        }
        driver.quit(); 
    }
    
}
