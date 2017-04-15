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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;
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
    
    public String selectString(String field, String table, String constraintField1, String constraintValue1) {
        return selectString(field,table,constraintField1, constraintValue1, "", "", "", "");
    }
    
    public String selectString(String field, String table, String constraintField1, String constraintValue1, String constraintField2, String constraintValue2) {
        return selectString(field,table,constraintField1, constraintValue1, constraintField2, constraintValue2, "", "");
    }
    
    /**
     * Query that returns any string from database given certain table constraints
     * @param field
     * @param table
     * @param constraintField
     * @param constraintValue
     * @return results of SELECT query
     */
    public String selectString(String field, String table, String constraintField1, String constraintValue1, String constraintField2, String constraintValue2, String constraintField3, String constraintValue3) {

        StringBuilder query = new StringBuilder();

        if (!constraintValue3.equals("")) {
            query.append("SELECT ");
            query.append(field);
            query.append(" FROM ");
            query.append(table);
            query.append(" WHERE ");
            query.append(constraintField1);
            query.append("='");
            query.append(constraintValue1);
            query.append("' AND ");
            query.append(constraintField2);
            query.append("='");
            query.append(constraintValue2);
            query.append("' AND ");
            query.append(constraintField3);
            query.append("='");
            query.append(constraintValue3);
            query.append("';");
        } else if (!constraintValue2.equals("")) {
            query.append("SELECT ");
            query.append(field);
            query.append(" FROM ");
            query.append(table);
            query.append(" WHERE ");
            query.append(constraintField1);
            query.append("='");
            query.append(constraintValue1);
            query.append("' AND ");
            query.append(constraintField2);
            query.append("='");
            query.append(constraintValue2);
            query.append("';");
        } else {
            query.append("SELECT ");
            query.append(field);
            query.append(" FROM ");
            query.append(table);
            query.append(" WHERE ");
            query.append(constraintField1);
            query.append("='");
            query.append(constraintValue1);
            query.append("';");
        }

        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();

            while (results.next()) {
                return results.getString(field);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    
    public ArrayList<String> selectArrayList(String field, String table) {
        return selectArrayList(field,table,"", "", "", "", "", "");
    }
    
    public ArrayList<String> selectArrayList(String field, String table, String constraintField1, String constraintValue1) {
        return selectArrayList(field,table,constraintField1, constraintValue1, "", "", "", "");
    }
    
    public ArrayList<String> selectarrayList(String field, String table, String constraintField1, String constraintValue1, String constraintField2, String constraintValue2) {
        return selectArrayList(field,table,constraintField1, constraintValue1, constraintField2, constraintValue2, "", "");
    }
    
        /**
     * Query that returns any string from database given certain table constraints
     * @param field
     * @param table
     * @param constraintField
     * @param constraintValue
     * @return results of SELECT query
     */
    public ArrayList<String> selectArrayList(String field, String table, String constraintField1, String constraintValue1, String constraintField2, String constraintValue2, String constraintField3, String constraintValue3) {
        
        ArrayList<String> strings = new ArrayList<>();
        
                StringBuilder query = new StringBuilder();

        if (!constraintValue3.equals("")) {
            query.append("SELECT ");
            query.append(field);
            query.append(" FROM ");
            query.append(table);
            query.append(" WHERE ");
            query.append(constraintField1);
            query.append("='");
            query.append(constraintValue1);
            query.append("' AND ");
            query.append(constraintField2);
            query.append("='");
            query.append(constraintValue2);
            query.append("' AND ");
            query.append(constraintField3);
            query.append("='");
            query.append(constraintValue3);
            query.append("';");
        } else if (!constraintValue2.equals("")) {
            query.append("SELECT ");
            query.append(field);
            query.append(" FROM ");
            query.append(table);
            query.append(" WHERE ");
            query.append(constraintField1);
            query.append("='");
            query.append(constraintValue1);
            query.append("' AND ");
            query.append(constraintField2);
            query.append("='");
            query.append(constraintValue2);
            query.append("';");
        } else if(!constraintValue1.equals("")){
            query.append("SELECT ");
            query.append(field);
            query.append(" FROM ");
            query.append(table);
            query.append(" WHERE ");
            query.append(constraintField1);
            query.append("='");
            query.append(constraintValue1);
            query.append("';");
        } else {
            query.append("SELECT ");
            query.append(field);
            query.append(" FROM ");
            query.append(table);
            query.append(";");
        }
        
        try{
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                strings.add(results.getString(field));
            }
            
            
        } catch (SQLException e){
            e.printStackTrace();
        }    

        return strings;
    }
    
    
    public ArrayList<String> getAllAirportCodes(){
        
        ArrayList<String> strings = new ArrayList<>();
        String query = "SELECT code FROM airport;";
        
        try{
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                strings.add(results.getString("code"));
            }
            
            
        } catch (SQLException e){
            e.printStackTrace();
        }    

        return strings;
    }
    
    public ArrayList<String> getAllAirplaneIDs(){
        
        ArrayList<String> strings = new ArrayList<>();
        String query = "SELECT id FROM airplane;";
        
        try{
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                strings.add(results.getString("id"));
            }
            
            
        } catch (SQLException e){
            e.printStackTrace();
        }    

        return strings;
    }
    public int getFirstClassCapacity(int id)
    {
        int firstClassCapacity = -1;
        String query = "SELECT capacity_first_class FROM aircraft_type WHERE id ="+ id +";";
        
        try{
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();
            
            while(results.next())
            {
                firstClassCapacity = results.getInt("id");
            }
            
        } catch (SQLException e){
            e.printStackTrace();
        }
        return firstClassCapacity;
    }
    public int getAircraftTypeID(int id)
    {
        int aircraftTypeID = -1;
        String query = "SELECT aircraft_type_id FROM airplane WHERE id ="+ id +";";
        
        try{
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();
            
            while(results.next())
            {
                aircraftTypeID = results.getInt("id");
            }
            
        } catch (SQLException e){
            e.printStackTrace();
        }
        return aircraftTypeID;
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

    public void updatePassword(int userID, String password)
    {
        password = MD5Hashing.encryptString(password);
        StringBuilder query = new StringBuilder();
        query.append("UPDATE userr SET password= '" + password + "'WHERE id = '" + userID + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public int findUserId(String email)
    {
        int userId = -1;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT id FROM userr WHERE email = '" + email + "'");
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
    
     public boolean isPasswordCorrect(String password, int userId)
    {
        boolean correctPassword = false;
        password = MD5Hashing.encryptString(password);
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
     
     public ArrayList<HashMap<String, String>> getAllFlightData(){
        
        ArrayList<HashMap<String,String>> allFlightData = new ArrayList<>();
        HashMap<String, String> flightData;
        
        String query = "SELECT * FROM flight;";
        
        String[] fields = {"num", "airplane_id", "origin_code", "destination_code", "departure_date", "arrival_date", "departure_time", "arrival_time", "duration", "price_economy","price_first_class","first_class_remaining","economy_remaining"};
        
        try {
            PreparedStatement sql = conn.prepareStatement(query);
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                
                flightData = new HashMap<String, String>();
                
                flightData.put("id", Integer.toString(results.getInt("id")));
                
                for(String field : fields){
                    flightData.put(field, results.getString(field));
                         
                }

                allFlightData.add(flightData);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return allFlightData;
    }
     
     public ArrayList<HashMap<String, String>> getAllAirportData(){
        
        ArrayList<HashMap<String,String>> allAirportData = new ArrayList<>();
        HashMap<String, String> airportData;
        
        String query = "SELECT * FROM airport;";
        
        String[] fields = {"code","city", "sstate", "country", "timezone"};
        
        try {
            PreparedStatement sql = conn.prepareStatement(query);
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                
                airportData = new HashMap<String, String>();
                
                for(String field : fields){
                    airportData.put(field, results.getString(field));
                    
                }
                allAirportData.add(airportData);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
       
        return allAirportData;
    }
     
      public void addFlightToDatabase(String num, int airplaneID, String originCode, String destinationCode, String departureDate, String arrivalDate, String departureTime, String arrivalTime,
                                    int duration, double priceEconomy, double priceFirstClass, int firstClassSeatsRemaining, int economySeatsRemaining) {

        StringBuilder query = new StringBuilder();

        query.append("INSERT INTO flight (num, airplane_id, origin_code, destination_code, departure_date,arrival_date, departure_time, arrival_time, duration, price_economy,price_first_class,first_class_remaining,economy_remaining) VALUES ('");
        query.append(num);
        query.append("', '");
        query.append(airplaneID);
        query.append("', '");
        query.append(originCode);
        query.append("', '");
        query.append(destinationCode);
        query.append("', '");
        query.append(departureDate);
        query.append("', '");
        query.append(arrivalDate);
        query.append("', '");
        query.append(departureTime);
        query.append("', '");
        query.append(arrivalTime);
        query.append("', '");  
        query.append(duration);
        query.append("', '");
        query.append(priceEconomy);
        query.append("', '");
        query.append(priceFirstClass);
        query.append("', '");
        query.append(firstClassSeatsRemaining);
        query.append("', '");
        query.append(economySeatsRemaining);

        query.append("') ;");

        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
    
    public void updateFlight(String num, int airplaneID, String originCode, String destinationCode, String departureDate, String arrivalDate, String departureTime, String arrivalTime,
                                    int duration, double priceEconomy, double priceFirstClass, int firstClassSeatsRemaining, int economySeatsRemaining) {

        StringBuilder query = new StringBuilder();

        query.append("UPDATE flight SET airplane_id = '");
        query.append(airplaneID);
        query.append("', origin_code = '");
        query.append(originCode);
        query.append("', destination_code= '");
        query.append(destinationCode);
        query.append("',departure_date= '");
        query.append(departureDate);
        query.append("',arrival_date= '");
        query.append(arrivalDate);
        query.append("',departure_time= '");
        query.append(departureTime);
        query.append("',arrival_time= '");
        query.append(arrivalTime);
        query.append("',duration= '");  
        query.append(duration);
        query.append("',price_economy= '");
        query.append(priceEconomy);
        query.append("',price_first_class= '");
        query.append(priceFirstClass);
        query.append("', first_class_remaining='");
        query.append(firstClassSeatsRemaining);
        query.append("',economy_remaining= '");
        query.append(economySeatsRemaining);
        query.append("' WHERE num = '");
        query.append(num);
        query.append("';");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
    public int findFlightID(String flightNumber)
    {
        int flightID = -1;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT id FROM flight WHERE num = '" + flightNumber + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                flightID = results.getInt("id");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return flightID;
    }
    public int getAirplaneID(int flightID)
    {
        int airplaneID = 0;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT airplane_id FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                airplaneID = results.getInt("airplane_id");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return airplaneID;
    }
    public String getOriginCode(int flightID)
    {
        String originCode = null;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT origin_code FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                originCode = results.getString("origin_code");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return originCode;
    }
    public String getDestinationCode(int flightID)
    {
        String destinationCode = null;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT destination_code FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                destinationCode = results.getString("destination_code");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return destinationCode;
    }
    public String getDepartureDate(int flightID)
    {
        String departureDate = null;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT departure_date FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                departureDate = results.getString("departure_date");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return departureDate;
    }
    public String getArrivalDate(int flightID)
    {
        String arrivalDate = null;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT arrival_date FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                arrivalDate = results.getString("arrival_date");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return arrivalDate;
    }
    public String getDepartureTime(int flightID)
    {
        String departureTime = null;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT departure_time FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                departureTime = results.getString("departure_time");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return departureTime;
    }
    public String getArrivalTime(int flightID)
    {
        String arrivalTime = null;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT arrival_time FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                arrivalTime = results.getString("arrival_time");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return arrivalTime;
    }
    public int getDuration(int flightID)
    {
        int duration = 0;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT duration FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                duration = results.getInt("duration");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return duration;
    }
    public double getPriceEconomy(int flightID)
    {
        double priceEconomy = 0;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT price_economy FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                priceEconomy = results.getDouble("price_economy");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return priceEconomy;
    }
    public double getPriceFirstClass(int flightID)
    {
        int priceFirstClass = 0;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT price_first_class FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                priceFirstClass = results.getInt("price_first_class");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return priceFirstClass;
    }
    public int getFirstClassSeatsRemaining(int flightID)
    {
        int seatsRemaining = 0;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT first_class_remaining FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                seatsRemaining = results.getInt("first_class_remaining");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return seatsRemaining;
    }
    public int getEconomySeatsRemaining(int flightID)
    {
        int seatsRemaining = 0;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT economy_remaining FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                seatsRemaining = results.getInt("economy_remaining");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return seatsRemaining;
    }
    /*
    public String getFlightInfoString(int flightID, String field)
    {
        String flightInfo = null;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT '"+field+"' FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                flightInfo = results.getString(field);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return flightInfo;
    }
    public int getFlightInfoInt(int flightID, String field)
    {
        int flightInfo = -1;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT '"+field+"' FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                flightInfo = results.getInt(field);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return flightInfo;
    }
    public double getFlightInfoDouble(int flightID, String field)
    {
        double flightInfo = -1;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT '"+field+"' FROM flight WHERE id = '" + flightID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                flightInfo = results.getDouble(field);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return flightInfo;
    }
    */
    public void deleteFlight(int flightID)
    {
        StringBuilder query = new StringBuilder();
        query.append("DELETE FROM flight WHERE id = '" + flightID + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void addAircraftType(String planeName, int downTime, int capacityTotal, int capacityFirstClass,
            int capacityEconomy, int seatsPerRow)
    {
        StringBuilder query = new StringBuilder();

        query.append("INSERT INTO aircraft_type (plane_name, down_time, capacity_total, capacity_first_class, capacity_economy, seats_per_row) VALUES ('");
        query.append(planeName);
        query.append("', '");
        query.append(downTime);
        query.append("', '");
        query.append(capacityTotal);
        query.append("', '");
        query.append(capacityFirstClass);
        query.append("', '");
        query.append(capacityEconomy);
        query.append("', '");
        query.append(seatsPerRow);

        query.append("') ;");

        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void addAirportToDatabase(String code, String city, String state, String country, int nodeNum, String timeZone)
    {
        StringBuilder query = new StringBuilder();

        query.append("INSERT INTO airport (code, city, sstate, country,node_num, timezone) VALUES ('");
        query.append(code);
        query.append("', '");
        query.append(city);
        query.append("', '");
        query.append(state);
        query.append("', '");
        query.append(country);
        query.append("', '");
        query.append(nodeNum);
        query.append("', '");
        query.append(timeZone);

        query.append("') ;");

        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void addAirplane(int aircraftTypeID, String num)
    {
        StringBuilder query = new StringBuilder();

        query.append("INSERT INTO airplane (aircraft_type_id, num) VALUES ('");
        query.append(aircraftTypeID);
        query.append("', '");
        query.append(num);
        query.append("') ;");

        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void addBoardingPass(int flight_id, int user_id, String flightClass) {
        StringBuilder query = new StringBuilder();
        
        query.append("INSERT INTO boarding_pass (flight_id, userr_id, clas, seat_num, luggage_count) VALUES ('");
        query.append(flight_id);
        query.append("', '");
        query.append(user_id);
        query.append("', '");
        if(flightClass.equals("economy")) {
            query.append("economy");
        } else {
            query.append("first_class");
        }
        query.append("', '");
        query.append(generateRandomSeat(flight_id, flightClass));
        query.append("', '");
        query.append(ThreadLocalRandom.current().nextInt(1, 5));
        query.append("') ;");
        
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public ArrayList<HashMap<String, String>> getBoardingPassesForUser(String userID) {
        ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
        String[] fields = {"flight_id", "userr_id", "seat_num", "luggage_count", "clas"};
        String query = "SELECT * FROM boarding_pass WHERE userr_id='" + userID + "';";
        
        try {
            PreparedStatement sql = conn.prepareStatement(query);
            ResultSet results = sql.executeQuery();
            while(results.next()){
                HashMap<String, String> map = new HashMap<String,String>();
                for(String field : fields){
                    map.put(field, results.getString(field));
                    
                }
                list.add(map);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    
    public String generateRandomSeat(int flightID, String flightClass) {
        HashMap<String, String> flight = this.getHashMapForFLight(Integer.toString(flightID));
        String[] fields = {"id","num","airplane_id","origin_code","destination_code","departure_date", 
            "arrival_date","departure_time","arrival_time","duration",
            "price_economy","price_first_class","first_class_remaining", "economy_remaining"};
        /****RANDOM GENERATING A LETTER AND NUMBER, THIS WILL BE CHANGED
            if(flightClass.equals("economy")) {
                String seatsLeft = flight.get("economy_remaining");

            }
        *****/
        String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String digits = "123456789";
        char letter = alphabet.charAt(ThreadLocalRandom.current().nextInt(0, alphabet.length()));
        char num = digits.charAt(ThreadLocalRandom.current().nextInt(1, digits.length()));
        return Character.toString(num) + Character.toString(letter);
    }
    
    public int findAircraftTypeID(String planeName)
    {
        int aircraftTypeID = -1;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT id FROM aircraft_type WHERE plane_name = '" + planeName + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                aircraftTypeID = results.getInt("id");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return aircraftTypeID;
    }
    public int findAirplaneID(String airplaneNum)
    {
        int airplaneID = -1;
        
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT id FROM airplane WHERE num = '" + airplaneNum + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                airplaneID = results.getInt("id");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        
        return airplaneID;
    }
    
    public ArrayList<HashMap<String, String>> getAllAircraftData(){
        
        ArrayList<HashMap<String,String>> allAircraftData = new ArrayList<>();
        HashMap<String, String> aircraftData;
        
        String query = "SELECT * FROM aircraft_type,airplane WHERE aircraft_type.id=airplane.aircraft_type_id;";
        
        String[] fields = {"plane_name","down_time", "capacity_total", "capacity_first_class", "capacity_economy","seats_per_row","aircraft_type_id","num"};
        
        try {
            PreparedStatement sql = conn.prepareStatement(query);
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                
                aircraftData = new HashMap<String, String>();
                
                for(String field : fields){
                    aircraftData.put(field, results.getString(field));
                    
                }
                allAircraftData.add(aircraftData);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
       
        return allAircraftData;
    }
    
    public void updateAircraftTypePlaneName(String planeName, int id)
    {
        StringBuilder query = new StringBuilder();
        query.append("UPDATE aircraft_type SET planeName= '" + planeName + "'WHERE id = '" + id + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateAircraftTypeDownTime(int downTime, int id)
    {
        StringBuilder query = new StringBuilder();
        query.append("UPDATE aircraft_type SET down_time= '" + downTime + "'WHERE id = '" + id + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateAircraftTypeCapacityTotal(int total, int id)
    {
        StringBuilder query = new StringBuilder();
        query.append("UPDATE aircraft_type SET capacity_total= '" + total + "'WHERE id = '" + id + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateAircraftTypeCapacityFirstClass(int capacityFirstClass, int id)
    {
        StringBuilder query = new StringBuilder();
        query.append("UPDATE aircraft_type SET capacity_first_class= '" + capacityFirstClass + "'WHERE id = '" + id + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateAircraftTypeCapacityEconomy(int capacityEconomy, int id)
    {
        StringBuilder query = new StringBuilder();
        query.append("UPDATE aircraft_type SET capacity_economy= '" + capacityEconomy + "'WHERE id = '" + id + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateAircraftTypeSeatsPerRow(int seatsPerRow, int id)
    {
        StringBuilder query = new StringBuilder();
        query.append("UPDATE aircraft_type SET seats_per_row= '" + seatsPerRow + "'WHERE id = '" + id + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateAirplaneNum(String num, int id)
    {
        StringBuilder query = new StringBuilder();
        query.append("UPDATE airplane SET num= '" + num + "'WHERE id = '" + id + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteAircraft(int aircraftTypeID)
    {
        StringBuilder query = new StringBuilder();
        query.append("DELETE FROM aircraft_type WHERE id = '" + aircraftTypeID + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void deleteAirplanes(int aircraftTypeID)
    {
        StringBuilder query = new StringBuilder();
        query.append("DELETE FROM airplane WHERE aircraft_type_id = '" + aircraftTypeID + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
    public int getAirportQuantity(){
        
        String query = "SELECT COUNT(code) FROM airport;";
        int quantity = 0;
        
        try {
            PreparedStatement sql = conn.prepareStatement(query);
            ResultSet results = sql.executeQuery();

            while(results.next()){
                quantity = results.getInt("COUNT(code)");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return quantity;
    }
    
    public boolean flightBetweenExists(Date date, String origin, String destination){
        
        StringBuilder query = new StringBuilder();
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = sdf.format(date);
        
        query.append("SELECT id FROM flight WHERE departure_date = '");
        query.append(formattedDate);
        query.append("' AND origin_code = '");
        query.append(origin);
        query.append("' AND destination_code ='");
        query.append(destination);
        query.append("';");
        
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false; 
    }
    
    
    public HashMap<String, String> getHashMapForFLight(String flight_id){
        HashMap<String,String> flightData = new HashMap<>();
        
        String query = "SELECT * FROM flight WHERE id=" + flight_id + ";";
        
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                
                String[] fields = {"id","num","airplane_id","origin_code","destination_code","departure_date", "arrival_date","departure_time","arrival_time","duration","price_economy","price_first_class","first_class_remaining", "economy_remaining"};
                
                for(String field : fields){
                    flightData.put(field, results.getString(field));
                }    
                
                String time = flightData.get("departure_time");
                time = time.substring(0, time.length() - 3);
                flightData.put("departure_time", time);
                
                time = flightData.get("arrival_time");
                time = time.substring(0, time.length() - 3);
                flightData.put("arrival_time", time);
                
            }
            
        } catch (SQLException e){
            e.printStackTrace();
        }    
        
        return flightData;
        
    }
   
    
    public HashMap<String,String> getHashMapForAircraftType(String name){
        HashMap<String,String> aircraftData = new HashMap<String,String>();

        String query = "SELECT * FROM aircraft_type WHERE plane_name ='" + name + "';";
        
        try{
            PreparedStatement sql = conn.prepareStatement(query);
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                
                aircraftData.put("id", results.getString("id"));
                aircraftData.put("plane_name", results.getString("plane_name"));
                aircraftData.put("down_time", results.getString("down_time"));
                aircraftData.put("capacity_total", results.getString("capacity_total"));
                aircraftData.put("capacity_first_class", results.getString("capacity_first_class"));
                aircraftData.put("capacity_economy", results.getString("capacity_economy"));
                aircraftData.put("seats_per_row", results.getString("seats_per_row"));
                
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        
        return aircraftData;
    }
    
    public String getUserEMail(String userID) {
        String query = "SELECT * FROM userr WHERE id ='" + userID + "';";
        String email = null;
        try{
            PreparedStatement sql = conn.prepareStatement(query);
            ResultSet results = sql.executeQuery();
            
            while(results.next()) {
                email = results.getString("email");
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        if(email == null) return "This didn't work!";
        return email;
    } 
    
    public void addRecurringFlight(String frequency, int airplaneID, String start, String end, String origin, String destination, String departureTime, String arrivalTime, int duration, double priceEconomy, double priceFirstClass, int seatsEconomy, int seatsFirstClass){
        
        try{
            Date startDate=new SimpleDateFormat("yyyy-MM-dd").parse(start);
            Date endDate=new SimpleDateFormat("yyyy-MM-dd").parse(end);
            
            addRecurringFlight(frequency, airplaneID, startDate, endDate, origin, destination, departureTime, arrivalTime, duration, priceEconomy, priceFirstClass, seatsEconomy, seatsFirstClass);
            
        } catch (ParseException e){
            e.printStackTrace();
        }
        
    }
    
    public void addRecurringFlight(String frequency, int airplaneID, Date start, Date end, String origin, String destination, String departureTime, String arrivalTime, int duration, double priceEconomy, double priceFirstClass, int seatsEconomy, int seatsFirstClass) {

        Calendar c = Calendar.getInstance();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedStart = sdf.format(start);
        String formattedEnd = sdf.format(end);
        SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm");
        boolean arrivalOnNextDay = false;

        int flightNum = this.getMaxFlightNum() + 1;

        try {

            Date time1 = timeFormatter.parse(departureTime);
            Date time2 = timeFormatter.parse(arrivalTime);
            String dt = formattedStart;

            if (time2.before(time1)) {
                arrivalOnNextDay = true;
            }

            while (sdf.parse(dt).before(end)) {

                String dt2 = dt;

                if (arrivalOnNextDay) {
                    c.setTime(sdf.parse(dt));
                    c.add(Calendar.DATE, 1);  // number of days to add
                    dt2 = sdf.format(c.getTime());
                }

                String fullNum = "AA" + Integer.toString(flightNum);

                this.addFlightToDatabase(fullNum, airplaneID, origin, destination, dt, dt2, departureTime, arrivalTime, duration, priceEconomy, priceFirstClass, seatsEconomy, seatsFirstClass);

                c.setTime(sdf.parse(dt));

                if(frequency.equals("Daily")) {
                    c.add(Calendar.DATE, 1);  // number of days to add
                } else if (frequency.equals("Weekly")) {
                    c.add(Calendar.DATE, 7);  // number of days to add
                } else if (frequency.equals("Monthly")) {
                    c.add(Calendar.MONTH, 1);  // number of days to add
                }

                dt = sdf.format(c.getTime());  // dt is now the new date
                flightNum++;

            }

        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    
    private int getMaxFlightNum(){
        
        String query = "SELECT num FROM flight ORDER BY num DESC LIMIT 1;";
        
        try{
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet results = ps.executeQuery();
            
            while(results.next()){
                return Integer.parseInt(results.getString("num").substring(2));
    
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        
        
        return -1;
    }

    public String getPlaneName(int aircraftTypeID)
    {
        String planeName = null;
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT plane_name FROM aircraft_type WHERE id = '" + aircraftTypeID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                planeName = results.getString("plane_name");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return planeName;
    }
    public int getDownTime(int aircraftTypeID)
    {
        int downTime = 0;
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT down_time FROM aircraft_type WHERE id = '" + aircraftTypeID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                downTime = results.getInt("down_time");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return downTime;
    }
    public int getCapacityTotal(int aircraftTypeID)
    {
        int capacityTotal = 0;
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT capacity_total FROM aircraft_type WHERE id = '" + aircraftTypeID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                capacityTotal = results.getInt("capacity_total");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return capacityTotal;
    }
    public int getCapacityFirstClass(int aircraftTypeID)
    {
        int firstClassCapacity = 0;
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT capacity_first_class FROM aircraft_type WHERE id = '" + aircraftTypeID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                firstClassCapacity = results.getInt("capacity_first_class");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return firstClassCapacity;
    }
    public int getCapacityEconomy(int aircraftTypeID)
    {
        int economyCapacity = 0;
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT capacity_economy FROM aircraft_type WHERE id = '" + aircraftTypeID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                economyCapacity = results.getInt("capacity_economy");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return economyCapacity;
    }
    public int getSeatsPerRow(int aircraftTypeID)
    {
        int seatsPerRow = 0;
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT seats_per_row FROM aircraft_type WHERE id = '" + aircraftTypeID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                seatsPerRow = results.getInt("seats_per_row");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return seatsPerRow;
    }
    public String getAirplaneNum(int aircraftTypeID)
    {
        String airplaneNum = null;
        try 
        {
            PreparedStatement query = conn.prepareStatement("SELECT num FROM airplane WHERE aircraft_type_id = '" + aircraftTypeID + "'");
            ResultSet results = query.executeQuery();
            
            if (results.next())
            {
                airplaneNum = results.getString("num");
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return airplaneNum;
    }
    public void updateFlightFirstClassSeatsRemaining(int firstClassSeatsRemaining, int id)
    {
        StringBuilder query = new StringBuilder();
        query.append("UPDATE flight SET first_class_remaining= '" + firstClassSeatsRemaining + "'WHERE id = '" + id + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateFlightEconomySeatsRemaining(int economySeatsRemaining, int id)
    {
        StringBuilder query = new StringBuilder();
        query.append("UPDATE flight SET economy_remaining= '" + economySeatsRemaining + "'WHERE id = '" + id + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateAircraftType(int aircraftTypeID,String planeName,int downTime, int capacityTotal, int capacityFirstClass,int capacityEconomy,int seatsPerRow)
    {

        StringBuilder query = new StringBuilder();

        query.append("UPDATE aircraft_type SET plane_name = '");
        query.append(planeName);
        query.append("', down_time = '");
        query.append(downTime);
        query.append("', capacity_total= '");
        query.append(capacityTotal);
        query.append("',capacity_first_class= '");
        query.append(capacityFirstClass);
        query.append("',capacity_economy= '");
        query.append(capacityEconomy);
        query.append("',seats_per_row= '");
        query.append(seatsPerRow);
        query.append("' WHERE id = '");
        query.append(aircraftTypeID);
        query.append("';");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateAirplane(int aircraftTypeID,String airplaneNum)
    {

        StringBuilder query = new StringBuilder();

        query.append("UPDATE airplane SET num = '");
        query.append(airplaneNum);
        query.append("' WHERE aircraft_type_id = '");
        query.append(aircraftTypeID);
        query.append("';");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
     public void deleteAirport(String airportCode)
    {
        StringBuilder query = new StringBuilder();
        query.append("DELETE FROM airport WHERE code = '" + airportCode + "'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void deleteEmployee(int id)
    {
        StringBuilder query = new StringBuilder();
        query.append("DELETE FROM userr WHERE id = '");
        query.append(id);
        query.append("'");
        try {
            PreparedStatement sql = conn.prepareStatement(query.toString());
            sql.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
      
    public ArrayList<String> getAllEmployeesEmails(){
        
        ArrayList<String> strings = new ArrayList<>();
        String query = "SELECT email FROM userr WHERE user_type='employee';";
        
        try{
            PreparedStatement sql = conn.prepareStatement(query);
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                strings.add(results.getString("email"));
            }
            
            
        } catch (SQLException e){
            e.printStackTrace();
        }    

        return strings;
    }
    public ArrayList<String> getAllFlightNumbers(){
        
        ArrayList<String> strings = new ArrayList<>();
        String query = "SELECT num FROM flight;";
        
        try{
            PreparedStatement sql = conn.prepareStatement(query);
            ResultSet results = sql.executeQuery();
            
            while(results.next()){
                strings.add(results.getString("num"));
            }
            
            
        } catch (SQLException e){
            e.printStackTrace();
        }    

        return strings;
    }
    
    
    public void createBooking(ArrayList<String> boardingPassIDs, int numberOfPassengers){
        
        int idNum = this.getLastBookingIDNum() + 1;
        StringBuilder query = new StringBuilder();
        query.append("INSERT INTO booking (id, booked_on, passengers) VALUES ('IAB");
        query.append(idNum);
        query.append("', CURRENT_DATE, ");
        query.append(numberOfPassengers);
        query.append(");");

        try{
            PreparedStatement ps = conn.prepareStatement(query.toString());
            ps.executeUpdate();
            
            
            query = new StringBuilder();
            query.append("INSERT INTO booking_has_boarding_pass (booking_id, boarding_pass_id) VALUES ");

            for(int i=0 ; i<boardingPassIDs.size() ; i++){
                query.append("('IAB");
                query.append(idNum);
                query.append("', ");
                query.append(boardingPassIDs.get(i));
                query.append(")");
                
                if(i!=boardingPassIDs.size()-1){
                    query.append(",");
                }
            }
            
            query.append(";");
            
            ps = conn.prepareStatement(query.toString());
            ps.executeUpdate();
            
        } catch (SQLException e){
            e.printStackTrace();
        }
        
        
    }
    
    
    private int getLastBookingIDNum(){
        
        String query = "SELECT id FROM booking ORDER BY id DESC LIMIT 1;";
        
        try{
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet results = ps.executeQuery();
            
            while(results.next()){
                String string = results.getString("id");
                return Integer.parseInt(string.substring(3));
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        
        
        return -1;
    }
    
    public ArrayList<HashMap<String,String>> getBookingSearchResults(String searchCriteria){
        ArrayList<HashMap<String,String>> searchResults = new ArrayList<>();
        HashMap<String,String> booking;
        
        StringBuilder query = new StringBuilder();
        
        query.append("SELECT * FROM booking WHERE id LIKE '%");
        query.append(searchCriteria);
        query.append("%';");
        
        try{
            PreparedStatement ps = conn.prepareStatement(query.toString());
            ResultSet results = ps.executeQuery();
            
            while(results.next()){
                booking = new HashMap<>();
                
                booking.put("id", results.getString("id"));
                booking.put("booked_on", results.getString("booked_on"));
                booking.put("passengers", results.getString("passengers"));
                
                searchResults.add(booking);
            }
            
        } catch(SQLException e){
            e.printStackTrace();
        }
        
        return searchResults;
    }
    
}   


