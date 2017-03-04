/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author Nickolas
 */
public class LoginTest
{
    public static void main(String[] args)
    {
        try
        {
            LoginValidation login = new LoginValidation("nickolas-kutsch@uiowa.edu","Password3");
          
            int userID = login.findUserId();
            boolean correctPassword = login.isPasswordCorrect(userID);
            //boolean validPassword = login.verifyNewPassword("Pa3");
            System.out.println(login.getUsername());
            System.out.println(login.getPassword());
            //System.out.println(validPassword);
            if (correctPassword)
            {
                System.out.println("Password was correct");
                String userType = login.getUserType(userID);
                System.out.println(userType);
                
                if(!login.isValidated()){
                    login.setValidationStatus(true);
                    System.out.println("Setting validation_status to true for userID:" + userID);
                }
            }
            else 
            {
                System.out.println("Password was incorrect");
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
    }
    
}
