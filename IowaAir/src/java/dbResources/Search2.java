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
public class Search2 {
        boolean roundtrip;
    boolean multi_city;
    String origin;
    String destination;
    Date departure_date;
    Date return_date;
    int number_of_passengers;

    
    public Search2(String origin, String destination, Date departure_date){
        this.origin = origin;
        this.destination = destination;
        this.departure_date = departure_date;
        this.roundtrip = false;
        this.multi_city = false;
        this.number_of_passengers = 1;
    }
    
    public Search2(String origin, String destination, Date departure_date, Date return_date){
        this.origin = origin;
        this.destination = destination;
        this.departure_date = departure_date;
        this.return_date = return_date;
        this.roundtrip = true;
        this.multi_city = false;
        this.number_of_passengers = 1;
    }
    
    public Search2(String origin, String destination, Date departure_date, Date return_date, int number_of_passengers){
        this.origin = origin;
        this.destination = destination;
        this.departure_date = departure_date;
        this.return_date = return_date;
        this.roundtrip = true;
        this.multi_city = false;
        this.number_of_passengers = number_of_passengers;
    }
    
    
    /**
     * Currently uses origin, destination, and departure_date to find all possible flight options
     * between the origin and the destination on the given departure_date.  Difference from getSearhResults
     * is that it calls the getFlightDataForConnectionCombo2 method.  This eliminates limitation of only
     * returning one possible flight combo for each connection combo.
     * @return ArrayList of all possible flight connection options.  Each ArrayList contains an
     * arraylist of hashmaps. Each Arraylist of hashmaps represents 1 combination of flights that
     * will begin at the origin and end at the destination on the given date.
     */
    public SearchResults getSearchResults(){
        
        //this array list will contain the flight data for each connection in a flight combo option
        ArrayList<FlightCombo> flightOptions;
        
        //this array list will contain all possible flight combo options to get from origin to 
        //destination on the given date
        ArrayList<FlightCombo> searchResults = new ArrayList<>();
        
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
            flightOptions = this.getFlightDataForConnectionCombo2(path, departure_date);
            
            
            searchResults.addAll(flightOptions);
            
        }

        return new SearchResults(searchResults);
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
       
    /**
     * Creates a ConnectionGraph of all flights on the given date
     * @param searchDate date used to create graph
     * @return ConnectionGraph of all flights on given date
     */
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
    
    /**
     * Depth first search of given ConnectionGraph for all possible paths from origin to destination
     * @param graph ConnectionGraph to search through for possible paths 
     * @param visited
     * @param possiblePaths ArrayList of ArrayList of Strings that will be passed to each recursive call
     *                  and then returned to keep track of all possible paths instead of just printing to screen
     * @return ArrayList of ArrayLIst of Strings of all possible connection combos to get from origin to destination
     */
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
    
    
    /**
     * Generates ArrayList of Strings of path nodes of the given LinkedLIst
     * @param visited LinkedList
     * @return ArrayList of Strings
     */
    private ArrayList<String> createPathList(LinkedList<String> visited){
        ArrayList<String> path = new ArrayList<>();
        
        for (String node : visited) {
            path.add(node);    
        }
        
        return path;
    }
    
    
    /**
     * Takes all combos of connections and generates an ArrayList of all possible flight combos on the given date.
     * @param connections ArrayList of Strings - All possible connection combos to get from origin to destination
     * @param date date of search
     * @return ArrayList of ArrayList of all flight IDs for all possible flight combos that fit the search parameters
     */
    private ArrayList<ArrayList<String>> getFlightIdCombosForConnectionCombo(ArrayList<String> connections, Date date){
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = sdf.format(date);
        
        ArrayList<ArrayList<String>> flightPool = new ArrayList<>();
        ArrayList<String> flightsForCurrentConnection = new ArrayList<>();
        
        ArrayList<String> flightCombo;
        ArrayList<ArrayList<String>> allFlightCombos = new ArrayList<>();
        
        String flightID;
        
        Database db = new Database();
        
        for(int i=0 ; i<connections.size()-1 ; i++){
            
            flightsForCurrentConnection = db.selectArrayList("id", "flight", "origin_code", connections.get(i), "destination_code", connections.get(i+1), "departure_date", formattedDate);
            
            flightPool.add(flightsForCurrentConnection);
        }
        
        int numberOfCombos = 1;
        
        for(ArrayList<String> connection : flightPool){
            numberOfCombos *= connection.size();
        }
        
        
        for(int i=0 ; i<flightPool.get(0).size() ; i++){
            
            if(flightPool.size() > 1){
                for(int j=0; j<flightPool.get(1).size() ; j++){
                    
                    

                    if(flightPool.size() > 2){
                        
                        for(int k=0 ; k<flightPool.get(2).size() ; k++){

                            if(flightPool.size() > 3){
                                
                                for(int l=0 ; l<flightPool.get(3).size() ; l++){
                                    
                                    flightCombo = new ArrayList<>();
                                    flightCombo.add(flightPool.get(0).get(i));
                                    flightCombo.add(flightPool.get(1).get(j));
                                    flightCombo.add(flightPool.get(2).get(k));
                                    flightCombo.add(flightPool.get(3).get(l));
                                    
                                    allFlightCombos.add(flightCombo);
                                }

                            } else {
                                flightCombo = new ArrayList<>();
                                flightCombo.add(flightPool.get(0).get(i));
                                flightCombo.add(flightPool.get(1).get(j));
                                flightCombo.add(flightPool.get(2).get(k));
                                
                                allFlightCombos.add(flightCombo);
                            }
                            
                        }
                        
                    } else {
                        flightCombo = new ArrayList<>();
                        flightCombo.add(flightPool.get(0).get(i));
                        flightCombo.add(flightPool.get(1).get(j));
                        
                        allFlightCombos.add(flightCombo);
                    }
                    
                }
            } else {
                flightCombo = new ArrayList<>();
                flightCombo.add(flightPool.get(0).get(i));
                
                allFlightCombos.add(flightCombo);
            }
            
        }

        db.closeConnection();
        
        return allFlightCombos;
    }
    

    
    //need function that combines all flights from connection combo in to an arraylist
    private ArrayList<FlightCombo> getFlightDataForConnectionCombo2(ArrayList<String> connections, Date date){
        
        ArrayList<FlightCombo> allCombosData = new ArrayList<>();
        
        ArrayList<HashMap<String,String>> flightComboData;
        HashMap<String,String> flightData;
        
        Database db = new Database();
        
        //ArrayList<String> flightIDs = this.getFlightIdsForConnectionCombo(connections, date);
        ArrayList<ArrayList<String>> flightComboIDs = this.getFlightIdCombosForConnectionCombo(connections, date);
        
        
        for (ArrayList<String> flightCombo : flightComboIDs) {
            
            flightComboData = new ArrayList<>();
            
            for (String id : flightCombo) {
                flightData = db.getHashMapForFLight(id);

                flightComboData.add(flightData);
            }
            
            FlightCombo combo = new FlightCombo(flightComboData);
            
            if(combo.isValid(number_of_passengers)){
                allCombosData.add(combo);
            }
            
        }
        
        
        db.closeConnection();
        return allCombosData;
    }

    
}
