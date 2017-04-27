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
public class MultiCityFlightSearchTest 
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
            System.out.println("Login Successful");
            driver.findElement(By.xpath("//*[@id=\"radioButtons\"]/input[3]")).click();
            driver.findElement(By.xpath("//*[@id=\"multiAddFlight\"]")).click();
            Select origin1 = new Select(driver.findElement(By.xpath("//*[@id=\"form2\"]/div[2]/select[1]")));
            origin1.selectByVisibleText("ORD");
            Select destination1 = new Select(driver.findElement(By.xpath("//*[@id=\"form2\"]/div[2]/select[2]")));
            destination1.selectByVisibleText("SFO");
            driver.findElement(By.xpath("//*[@id=\"multiFlightDepart1\"]")).sendKeys("04/05/2017");
            Select origin2 = new Select(driver.findElement(By.xpath("//*[@id=\"form2\"]/div[3]/select[1]")));
            origin2.selectByVisibleText("SFO");
            Select destination2 = new Select(driver.findElement(By.xpath("//*[@id=\"form2\"]/div[3]/select[2]")));
            destination2.selectByVisibleText("ATL");
            driver.findElement(By.xpath("//*[@id=\"multiFlightDepart2\"]")).sendKeys("04/05/2017");
            Select origin3 = new Select(driver.findElement(By.xpath("//*[@id=\"flight3div\"]/select[1]")));
            origin3.selectByVisibleText("ATL");
            Select destination3 = new Select(driver.findElement(By.xpath("//*[@id=\"flight3div\"]/select[2]")));
            destination3.selectByVisibleText("IFC");
            driver.findElement(By.xpath("//*[@id=\"multiFlightDepart3\"]")).sendKeys("04/05/2017");
            driver.findElement(By.xpath("//*[@id=\"form2\"]/div[7]/button")).click();
            url = driver.getCurrentUrl();
            if (url.equals("http://localhost:8080/IowaAir/searchResultsMultiCity.jsp?num_of_passengers=1&multiFlightOrigin1=ORD&multiFlightDestination1=SFO&multiFlightDepart1=2017-04-05&multiFlightOrigin2=SFO&multiFlightDestination2=ATL&multiFlightDepart2=2017-04-05&multiFlightOrigin3=ATL&multiFlightDestination3=IFC&multiFlightDepart3=2017-04-05&multiFlightOrigin4=null&multiFlightDestination4=null&multiFlightDepart4="))
            {
                System.out.println("Multi City Flight search was successful");
                driver.findElement(By.xpath("//*[@id=\"inner\"]/tbody/tr[2]/td[10]/form/input[3]")).click();
                url = driver.getCurrentUrl();
                if(url.equals("http://localhost:8080/IowaAir/searchResultsMultiCity.jsp?flight_id1=32&flight_id2=54"))
                {
                    System.out.println("First Selection successful");
                    driver.findElement(By.xpath("//*[@id=\"inner\"]/tbody/tr[2]/td[10]/form/input[2]")).click();
                    url = driver.getCurrentUrl();
                    if(url.equals("http://localhost:8080/IowaAir/searchResultsMultiCity.jsp?flight_id1=29"))
                    {
                        System.out.println("Second Selection successful");
                        driver.findElement(By.xpath("//*[@id=\"inner\"]/tbody/tr[2]/td[10]/form/input[3]")).click();
                        url = driver.getCurrentUrl();
                        if(url.equals("http://localhost:8080/IowaAir/confirmBookingMultiCity.jsp"))
                        {
                            System.out.println("Third Selection successful");
                            driver.findElement(By.xpath("/html/body/div[2]/b/form[1]/p/input")).click();
                            url = driver.getCurrentUrl();
                            if(url.equals("http://localhost:8080/IowaAir/passengerInfo.jsp"))
                            {
                                System.out.println("Booking Confirmed successful");
                                driver.findElement(By.xpath("/html/body/div[2]/form/input[1]")).sendKeys("Nick");
                                driver.findElement(By.xpath("/html/body/div[2]/form/input[2]")).sendKeys("Kutsch");
                                Select seatNum = new Select(driver.findElement(By.xpath("/html/body/div[2]/form/select")));
                                seatNum.selectByIndex(2);
                                driver.findElement(By.xpath("/html/body/div[2]/form/input[3]")).sendKeys("1");
                                driver.findElement(By.xpath("/html/body/div[2]/form/input[5]")).click();
                                url = driver.getCurrentUrl();
                                if(url.equals("http://localhost:8080/IowaAir/purchaseFlight.jsp"))
                                {                                
                                    System.out.println("Passenger Info Page successful");
                                    driver.findElement(By.xpath("/html/body/div[2]/form/input[13]")).sendKeys("0123456789");
                                    Select month = new Select(driver.findElement(By.xpath("/html/body/div[2]/form/select[1]")));
                                    month.selectByVisibleText("05");
                                    Select year = new Select(driver.findElement(By.xpath("/html/body/div[2]/form/select[2]")));
                                    year.selectByVisibleText("20");
                                    driver.findElement(By.xpath("/html/body/div[2]/form/input[14]")).sendKeys("123");
                                    driver.findElement(By.xpath("/html/body/div[2]/form/input[15]")).click();
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
                                    System.out.println("Passenger Info Page Failed");
                                }
                                
                            }
                            else
                            {
                                System.out.println("Booking Confirmed failed");
                            }
                        }
                        else
                        {
                            System.out.println("Third Selection failed");
                        }
                    }
                    else
                    {
                        System.out.println("Second Selection failed");
                    }
                }
                else
                {
                    System.out.println("First Slection failed");
                }
                
            }
            else
            {
                System.out.println("Multi City Flight search failed");
            }
            
            
        }
        else
        {
            System.out.println("Login failed");
        }
        driver.quit(); 
    }
    
}
