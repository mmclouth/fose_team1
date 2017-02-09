

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;


/**
 *
 * @author kenziemclouth
 */
public class Database {

    private static final Logger logger= Util.logger;
    
    public Database( ) throws SQLException{
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

    
}
