/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;

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

    /**
     * Currently uses origin, destination, and departure_date to find all possible flight options
     * between the origin and the destination on the given departure_date.
     * @return ArrayList of all possible flight connection options.  Each ArrayList contains an
     * arraylist of hashmaps. Each Arraylist of hashmaps represents 1 combination of flights that
     * will begin at the origin and end at the destination on the given date.
     */
    public ArrayList<ArrayList<HashMap<String,String>>> getSearchResults(){
        
        //this array list will contain the flight data for each connection in a flight combo option
        ArrayList<HashMap<String,String>> flightOption;
        
        //this array list will contain all possible flight combo options to get from origin to 
        //destination on the given date
        ArrayList<ArrayList<HashMap<String,String>>> searchResults = new ArrayList<>();
        
        //create a graph of all flights on this date
        ConnectionGraph allFlights = this.createConnectionGraph(departure_date);
        
        LinkedList<String> visited = new LinkedList<>();
        visited.add(origin);
        
        ArrayList<ArrayList<String>> possiblePaths = new ArrayList<>();
        
        //get all possible paths from origin to destination from flight graph
        //Each ArrayList<String> is the airport codes in order of their flight connections
        possiblePaths = this.depthFirst(allFlights, visited, possiblePaths);
        
        //for each flight combo (ArrayList<String>), get the flight data for each flight.
        //Then add each flight combo option with its flight data to final search results ArrayList
        for(ArrayList<String> path : possiblePaths){
            flightOption = this.getFlightDataForConnectionCombo(path, departure_date);
            
            if(this.isFlightComboValid(flightOption)){
                searchResults.add(flightOption);
            }
        }

        return searchResults;
    }
    
    public static void printSearchResults(ArrayList<ArrayList<HashMap<String,String>>> searchResults){
        
        System.out.println("ID \t\t num \t\t origin_code \t dest_code \t date \t\t\t departure \t\t arrival");
        
        String[] fields = {"id","num","origin_code","destination_code","departure_date", "arrival_date","departure_time","arrival_time"};
        
        for(ArrayList<HashMap<String,String>> result : searchResults){
            for(HashMap<String,String> flight : result){
                for(String field : fields){
                    System.out.print(flight.get(field));
                    System.out.print("\t\t");
                }
                
                System.out.println();
            }
            System.out.println("---------------------------------------------------------------------------------------");
        }
        
        
    }
       
    private ConnectionGraph createConnectionGraph(Date searchDate) {

        Database db = new Database();
        int numberOfAirports = db.getAirportQuantity();

        ConnectionGraph connections = new ConnectionGraph();
        
        ArrayList<String> origins = db.getAllAirportCodes();
        ArrayList<String> destinations = db.getAllAirportCodes();
 
        for(String origin : origins){
            for(String destination : destinations){
                
                if (db.flightBetweenExists(searchDate, origin, destination)) {
                    connections.addEdge(origin, destination);
                }
                
            }
        }

        db.closeConnection();
        return connections;
    }
    
    private ArrayList<ArrayList<String>> depthFirst(ConnectionGraph graph, LinkedList<String> visited, ArrayList<ArrayList<String>> possiblePaths) {
        
        LinkedList<String> nodes = graph.adjacentNodes(visited.getLast());
        // examine adjacent nodes
        for (String node : nodes) {
            if (visited.contains(node)) {
                continue;
            }
            if (node.equals(destination)) {
                visited.add(node);
                printPath(visited);
                possiblePaths.add(this.createPathList(visited));
                visited.removeLast();
                break;
            }
        }
        for (String node : nodes) {
            if (visited.contains(node) || node.equals(destination)) {
                continue;
            }
            visited.addLast(node);
            possiblePaths = depthFirst(graph, visited, possiblePaths);
            visited.removeLast();
        }
        
        
        return possiblePaths;
    }

    private void printPath(LinkedList<String> visited) {
        for (String node : visited) {
            System.out.print(node);
            System.out.print(" ");
        }
        System.out.println();
    }
    
    
    private ArrayList<String> createPathList(LinkedList<String> visited){
        ArrayList<String> path = new ArrayList<>();
        
        for (String node : visited) {
            path.add(node);    
        }
        
        return path;
    }
    
    //need function to retrieve flight id for flight from origin to destination on certain date
    private ArrayList<String> getFlightIdsForConnectionCombo(ArrayList<String> connections, Date date){
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = sdf.format(date);
        
        ArrayList<String> flightIDs = new ArrayList<>();
        String flightID;
        
        Database db = new Database();
        
        for(int i=0 ; i<connections.size()-1 ; i++){
            
            flightID = db.selectString("id", "flight", "origin_code", connections.get(i), "destination_code", connections.get(i+1), "departure_date", formattedDate);
            
            flightIDs.add(flightID);
        }
        
        db.closeConnection();
        
        return flightIDs;
    }
    
 
    //need function that combines all flights from connection combo in to an arraylist
    private ArrayList<HashMap<String,String>> getFlightDataForConnectionCombo(ArrayList<String> connections, Date date){
        ArrayList<HashMap<String,String>> connectionsData = new ArrayList<>();
        HashMap<String,String> flightData;
        
        Database db = new Database();
        
        ArrayList<String> flightIDs = this.getFlightIdsForConnectionCombo(connections, date);
        
        for(String id : flightIDs){
            flightData = db.getHashMapForFLight(id);
            
            connectionsData.add(flightData);
        }
        db.closeConnection();
        return connectionsData;
    }

    private boolean isFlightComboValid(ArrayList<HashMap<String, String>> flightCombo) {

        int landingHour, landingMinute, takeOffHour, takeOffMinute;
        String landingTime, takeOffTime;
        HashMap<String, String> flight1, flight2;
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        String dateString;
        Date landingDate, takeOffDate;

        for (int i = 0; i < flightCombo.size() - 1; i++) {
            flight1 = flightCombo.get(i);
            flight2 = flightCombo.get(i + 1);

            dateString = flight1.get("arrival_date");

            try {
                landingDate = formatter.parse(dateString);
                dateString = flight2.get("departure_date");
                
                takeOffDate = formatter.parse(dateString);

                landingTime = flight1.get("arrival_time");
                takeOffTime = flight2.get("departure_time");

                String[] splitTime = landingTime.split(":");
                landingHour = Integer.parseInt(splitTime[0]);
                landingMinute = Integer.parseInt(splitTime[1]);

                splitTime = takeOffTime.split(":");
                takeOffHour = Integer.parseInt(splitTime[0]);
                takeOffMinute = Integer.parseInt(splitTime[1]);

                if(landingDate.after(takeOffDate)){
                    return false;
                } else if (landingHour > takeOffHour) {
                    return false;
                } else if (landingHour == takeOffHour) {
                    if (landingMinute > takeOffMinute) {
                        return false;
                    }
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }

        }

        return true;
    }

}
