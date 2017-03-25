/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

import java.util.Date;

/**
 *
 * @author kenziemclouth
 */
public class Search {
    
    boolean roundtrip;
    boolean multi_city;
    String origin;
    String destination;
    Date departure_date;
    Date return_date;
    
    
    
    
    
    public Search(String origin, String destination, Date departure_date){
        this.origin = origin;
        this.destination = destination;
        this.departure_date = departure_date;
        this.roundtrip = false;
        this.multi_city = false;
    }
    
    public Search(String origin, String destination, Date departure_date, Date return_date){
        this.origin = origin;
        this.destination = destination;
        this.departure_date = departure_date;
        this.return_date = return_date;
        this.roundtrip = true;
        this.multi_city = false;
    }
    
    
    private ConnectionGraph createConnectionGraph(Date searchDate) {

        Database db = new Database();
        int numberOfAirports = db.getAirportQuantity();

        ConnectionGraph connections = new ConnectionGraph(numberOfAirports);

        for (int i = 0; i < numberOfAirports; i++) {

            String origin_code = db.selectString("code", "airport", "node_num", Integer.toString(i));

            for (int j = 0; j < numberOfAirports; j++) {

                if (i != j) {
                    String dest_code = db.selectString("code", "airport", "node_num", Integer.toString(j));

                    if (db.flightBetweenExists(searchDate, origin_code, dest_code)) {
                        connections.addEdge(i, j);
                    }
                }

            }
        }

        db.closeConnection();
        return connections;
    }
    
    
    
    
}
