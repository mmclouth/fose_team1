/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;


import java.security.SecureRandom;
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
        this.password = MD5Hashing.encryptString(this.password);
        conn = getConnection();
    }
    public Connection conn = null;
    
    private Connection getConnection() {
        if ( conn==null ) {
            conn = Util.getConnection( "root", "" );
        }
        return conn;
    }
    public void closeConnection()
    {
        try 
        {
            conn.close();
        }
        catch(SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        } 
        catch(Exception e){
            e.printStackTrace();
            throw new RuntimeException(e);
        } 
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
    
    /**
     * Checks validation status of specified user in database
     * @param userID
     * @return true if validated, false if not validated
     */
    public boolean isValidated(){
        
        int userID = this.findUserId();
        
        boolean validated = false;
        
        try {
            PreparedStatement query = conn.prepareStatement("SELECT validation_status FROM userr WHERE id = '" + userID + "'");
            ResultSet results = query.executeQuery();
            
            while(results.next())
            {
                validated = results.getBoolean("validation_status");
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return validated;
    }
    
    
    /**
     * Sets validation status of specified user
     * @param userID
     * @param validated 
     */
    public void setValidationStatus(boolean validated){
        
        int userID = this.findUserId();
        
        StringBuilder sql = new StringBuilder();
        
        sql.append("UPDATE userr SET validation_status =");
        sql.append(validated);
        sql.append(" WHERE id =");
        sql.append(userID);
        sql.append(";");
        
        try
        {
            PreparedStatement query = conn.prepareStatement(sql.toString());
            query.executeUpdate();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        
    }
    
        public static boolean verifyNewPassword(String password) {
        //checks password length
        if(password.length() < 8) { return false; }
        //checks that password contains an uppercase letter
        if(password.equals(password.toLowerCase())) { return false; }
        //checks that password contains a lowercase letter
        if(password.equals(password.toUpperCase())) { return false; }
        //checks that password contains a number
        char[] array = password.toCharArray();
        boolean containsDigit = false;
        for(int i = 0; i < array.length;i++)
        {
            if (Character.isDigit(array[i]))
            {
                containsDigit = true;
            }
        }
        if (!containsDigit)
        {
            return false;
        }
        return true;
    }
        
      
    /**
     * Checks if given code matches the confirmation_code assigned to user in database.
     * @param code
     * @return true if codes match, false if they don't
     */
    public boolean isConfirmationCodeCorrect(String code){
        StringBuilder query = new StringBuilder();
        String codeFromDatabase = null;
        
        query.append("SELECT confirmation_code FROM userr WHERE id=");
        query.append(this.findUserId());
        query.append(";");
        
        try{
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                codeFromDatabase = results.getString("confirmation_code");
            }
            
            if( codeFromDatabase.equals(code)){
                return true;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }   
    
    
     public static String generateRandomPassword()
        {
            String numbers = "0123456789";
            String capitalLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
            final int LENGTH = 8;
            SecureRandom rnd = new SecureRandom();
            StringBuilder sb = new StringBuilder(LENGTH);
            boolean number = false;
            boolean capital = false;
            boolean lowerCase = false;
            for(int i = 0; i < LENGTH; i++)
            {
                if (i < LENGTH - 3)
                {
                    int randomNumber = rnd.nextInt(3);
                    if (randomNumber == 0)
                    {
                        number = true;
                        sb.append(numbers.charAt(rnd.nextInt(numbers.length())));
                    }
                    else if(randomNumber == 1)
                    {
                        capital = true;
                        sb.append(capitalLetters.charAt(rnd.nextInt(capitalLetters.length())));
                    }
                    else
                    {
                        lowerCase = true;
                        sb.append(lowerCaseLetters.charAt(rnd.nextInt(lowerCaseLetters.length())));
                    }
                }
                else
                {
                    if (!number)
                    {
                        number = true;
                        sb.append(numbers.charAt(rnd.nextInt(numbers.length())));
                    }
                    else if (!capital)
                    {
                        capital = true;
                        sb.append(capitalLetters.charAt(rnd.nextInt(capitalLetters.length())));
                    }
                    else
                    {
                        lowerCase = true;
                        sb.append(lowerCaseLetters.charAt(rnd.nextInt(lowerCaseLetters.length())));
                    }
                }
            }
            return sb.toString();
        }
    
}
