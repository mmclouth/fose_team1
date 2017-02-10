package dbResources;




import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kenziemclouth
 */
public class Util {

 public static final Logger logger= Logger.getLogger( "test_database" );
    
    /**
     * temporary code with default password
     * @return 
     */
    public static Connection getConnection( ) {
        return getConnection( "root", "" );
    }
    
    /**
     * make sure close it.
     * @param username the database username
     * @param password the database password
     * @return 
     */
    public static Connection getConnection( String username, String password) {
        String CONNECTION_STRING= "jdbc:mysql://localhost:3306/IowaAir";
        Connection conn;
        
        //logger.log(Level.INFO, "create connection on {0}", Thread.currentThread());
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(CONNECTION_STRING, username, password);
            System.err.println("Connected.");
            return conn;
        } catch(SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        } catch(Exception e){
            e.printStackTrace();
            throw new RuntimeException(e);
        } 


    }
    
}
