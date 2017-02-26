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
import java.util.logging.Logger;
/**
 *
 * @author Nickolas
 */
public class LoginValidation {
    
    private static final Logger logger= Util.logger;
    private String username;
    private String password;
    public LoginValidation(String username, String password) throws SQLException
    {
        this.username = username;
        this.password = password;
        conn = getConnection();
    }
    public Connection conn = null;
    
    private Connection getConnection() {
        if ( conn==null ) {
            conn = Util.getConnection( "root", "" );
        }
        return conn;
    }
    
    public int findUserId()
    {
        int userId = -1;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT id FROM userr WHERE email = '" + username + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                userId = results.getInt("id");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return userId;
    }
    
    public boolean isPasswordCorrect(int userId)
    {
        boolean correctPassword = false;
        
        try
        {
            PreparedStatement query = conn.prepareStatement("SELECT password FROM userr WHERE id = '" + userId + "'");
            ResultSet results = query.executeQuery();
            
            while(results.next())
            {
                if (results.getString("password").equals(password))
            {
                correctPassword = true;
            }
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return correctPassword;
    }
    // Only call getUserType if both username and password has been validated. 
    public String getUserType(int userId)
    {
        String userType = null;
        try
        {
            PreparedStatement query = conn.prepareStatement("SELECT user_type FROM userr WHERE id = '" + userId + "'");
            ResultSet results = query.executeQuery();
            
            while(results.next())
            {
                userType = results.getString("user_type");
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return userType;
    }
    
    public String getUsername()
    {
        return username;
    }
    public String getPassword()
    {
        return password;
    }
    
}
