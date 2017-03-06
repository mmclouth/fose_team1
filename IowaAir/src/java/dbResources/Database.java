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
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
    
    public void closeConnection(){
        try{
            conn.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
    }
    
    /**
     * Possible types of user accounts.
     */
    public enum User_Types {
        customer, employee, admin
    }
    
    /**
     * Query that returns any string from database given certain table constraints
     * @param field
     * @param table
     * @param constraintField
     * @param constraintValue
     * @return results of SELECT query
     */
    public String selectString(String field, String table, String constraintField, String constraintValue){
        
        StringBuilder query = new StringBuilder();
        
        query.append("SELECT ");
        query.append(field);
        query.append(" FROM ");
        query.append(table);
        query.append(" WHERE ");
        query.append(constraintField);
        query.append("='");
        query.append(constraintValue);
        query.append("';");
        
        try{
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                return results.getString(field);
            }
            
            
        } catch (SQLException e){
            e.printStackTrace();
        }    

        return null;
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
    public String addUserToDatabase(String firstName, String lastName, String email, String password, User_Types type){
        return this.addUserToDatabase(firstName, lastName, email, type, null, null, password, null);
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
     * @param type
     * @param birthday
     * @param password
     * @param confirmationCode
     * @param gender 
     */
    public String addUserToDatabase(String firstName, String lastName, String email, User_Types type, String birthday, String gender, String password,
                                    String confirmationCode) {

        StringBuilder query = new StringBuilder();

        if (this.emailAlreadyUsed(email)) {
            return "Email already assigned to a user.";
        }

        password = MD5Hashing.encryptString(password);

        query.append("INSERT INTO userr (first_name, last_name, email, password, user_type, birthday, gender, confirmation_code, validation_status) VALUES ('");
        query.append(firstName);
        query.append("', '");
        query.append(lastName);
        query.append("', '");
        query.append(email);
        query.append("', '");
        query.append(password);
        query.append("', '");
        query.append(type.toString());

        if (birthday != null) {
            query.append("', '");
            query.append(birthday);
            query.append("', ");
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
        
        query.append("'");
        query.append(confirmationCode);

        query.append("', FALSE) ;");

        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return e.toString();
        }

        return null;

    }
    
    
    public ArrayList<HashMap<String, String>> getAllEmployeeData(){
        
        ArrayList<HashMap<String,String>> allEmployeeData = new ArrayList<>();
        HashMap<String, String> employeeData;
        
        String query = "SELECT * FROM userr WHERE user_type = 'employee';";
        
        String[] fields = {"first_name", "last_name", "email", "password", "user_type", "birthday", "gender", "confirmation_code", "validation_status"};
        
        try {
            PreparedStatement sql = conn.prepareStatement(query);
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                
                employeeData = new HashMap<String, String>();
                
                employeeData.put("id", Integer.toString(results.getInt("id")));
                
                for(String field : fields){
                    employeeData.put(field, results.getString(field));
                    
                    if(field == "validation_status"){
                        if(results.getString(field).equals("0")){
                            employeeData.put(field, "false");
                        } else {
                            employeeData.put(field, "true");
                        } 
                    }
                    
                }

                allEmployeeData.add(employeeData);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        
        
        
        return allEmployeeData;
    }

    
}
