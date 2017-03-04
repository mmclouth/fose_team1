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
            LoginAndSignUp login = new LoginAndSignUp("nickolas-kutsch@uiowa.edu","5f4dcc3b5aa765d61d8327deb882cf99");
          
            int userID = login.findUserId();
            boolean correctPassword = login.isPasswordCorrect(userID);
            System.out.println(login.getUsername());
            System.out.println(login.getPassword());
            String password1 = LoginAndSignUp.generateRandomPassword();
            System.out.println(password1);
            String password2 = LoginAndSignUp.generateRandomPassword();
            System.out.println(password2);
            String password3 = LoginAndSignUp.generateRandomPassword();
            System.out.println(password3);
            String password4 = LoginAndSignUp.generateRandomPassword();
            System.out.println(password4);
            String password5 = LoginAndSignUp.generateRandomPassword();
            System.out.println(password5);
            String password6 = LoginAndSignUp.generateRandomPassword();
            System.out.println(password6);
            String password7 = LoginAndSignUp.generateRandomPassword();
            System.out.println(password7);
            String password8 = LoginAndSignUp.generateRandomPassword();
            System.out.println(password8);
            String password9 = LoginAndSignUp.generateRandomPassword();
            System.out.println(password9);
            String password10 = LoginAndSignUp.generateRandomPassword();
            System.out.println(password10);
            
            
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
