/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

/**
 *
 * @author Kyle Anderson
 */
public class Payment {
    public static boolean cardNumberIsValid(String cardNumber) {
        if(cardNumber.length() != 10) {
            return false;
        }
        try  
        {  
          double d = Double.parseDouble(cardNumber);  
        }  
        catch(NumberFormatException nfe)  
        {  
          return false;  
        }  
        return true; 
    }
    
    public static boolean cvvIsValid(String cvv) {
        if(cvv.length() != 3) {
            return false;
        }
        try  
        {  
          double d = Double.parseDouble(cvv);  
        }  
        catch(NumberFormatException nfe)  
        {  
          return false;  
        }  
        return true; 
    }
}
