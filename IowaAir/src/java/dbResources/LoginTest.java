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
            LoginValidation login = new LoginValidation("nickolas-kutsch@uiowa.edu","password");

            int userID = login.findUserId();
            boolean correctPassword = login.isPasswordCorrect(userID);
            System.out.println(login.getUsername());
            System.out.println(login.getPassword());
            if (correctPassword)
            {
                System.out.println("Password was correct");
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
