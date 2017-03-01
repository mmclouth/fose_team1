package dbResources;



/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Logger;


/**
 *
 * @author kenziemclouth
 */
public class Database {

    private static final Logger logger= Util.logger;
    
    public Database( ) {
        conn= getConnection();
    }

    public Connection conn = null;

    /**
     * magically get the connection.  This will allow multiple clients to 
     * have multiple connections.
     * @return 
     */
    private Connection getConnection() {
        if ( conn==null ) {
            conn = Util.getConnection( "root", "" );
        }
        return conn;
    }
    
   

    /**
     * Generic method to test database connection.  Verifies if data is present in given table.
     * @param tableName name of table 
     * @return true if table has records false if table does not have records
     */
    public boolean tableHasRecords(String tableName) {

        int count = 0;

        try{
            PreparedStatement query = conn.prepareStatement("SELECT COUNT(id) AS 'count' FROM " + tableName + ";");
            ResultSet results = query.executeQuery();

            while (results.next()){
                count = results.getInt("count");
            } 

            if(count > 0){
                return true;
            }

        } catch (SQLException e){
            e.printStackTrace();
        }

        return false;
    }
    
    
    /**
     * Checks to see if email address already exists in the userr table
     * @param email being searched for
     * @return true if email exists in userr table, false if email does not exist
     */
    public boolean emailAlreadyUsed(String email){
        
        StringBuilder query = new StringBuilder();
        
        query.append("SELECT id FROM userr WHERE email ='");
        query.append(email);
        query.append("';");
        
        try{
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();

            while (results.next()){
                return true;
            } 


        } catch (SQLException e){
            e.printStackTrace();
        }
        
        return false;
        
    }
    
    /**
     * Adds new user to the database.  Currently sets password to "random".  Need to write method to generate random password
     * and encrypt password.  Will then call these methods from addUserToDatabase.  NOTE: This method does not check to see
     * if email already exists in DB.  Should we check that before?  Should I add it to this method?  Or should I do both for
     * safeguard?
     * @param firstName
     * @param lastName
     * @param email
     * @param user_type 
     */
    public String addUserToDatabase(String firstName, String lastName, String email, String user_type){
        return this.addUserToDatabase(firstName, lastName, email, user_type, null, null);
    }
    
    /**
     * Adds new user to the database.  Currently sets password to "password".  Need to write method to generate random password
     * and encrypt password.  Will then call these methods from addUserToDatabase.  NOTE: This method does not check to see
     * if email already exists in DB.  Should we check that before?  Should I add it to this method?  Or should I do both for
     * safeguard?
     * 
     * @param firstName
     * @param lastName
     * @param email
     * @param user_type
     * @param birthday
     * @param gender 
     */
    public String addUserToDatabase(String firstName, String lastName, String email, String user_type, Date birthday, String gender) {

        StringBuilder query = new StringBuilder();
        String password = "password";

        if (this.emailAlreadyUsed(email)) {
            return "Email already assigned to a user.";
        }

        if (user_type != "customer" && user_type != "admin" && user_type != "employee") {
            return "Invalid user type.";
        }

        password = MD5Hashing.encryptString(password);

        query.append("INSERT INTO userr (first_name, last_name, email, password, user_type, birthday, gender, validation_status) VALUES ('");
        query.append(firstName);
        query.append("', '");
        query.append(lastName);
        query.append("', '");
        query.append(email);
        query.append("', '");
        query.append(password);
        query.append("', '");
        query.append(user_type);

        if (birthday != null) {
            query.append("', '");
            query.append(birthday);
            query.append("', '");
        } else {
            query.append("', null, ");
        }

        if (gender == null) {
            query.append("null, ");
        } else {
            query.append("'");
            query.append(gender);
            query.append("', ");
        }

        query.append("FALSE) ;");

        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;

    }

    
}
