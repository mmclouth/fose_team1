/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

import java.util.ArrayList;
import java.util.Date;
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
    
    
    public ConnectionGraph createConnectionGraph(Date searchDate) {

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
    
    public ArrayList<ArrayList<String>> depthFirst(ConnectionGraph graph, LinkedList<String> visited) {
        
        ArrayList<ArrayList<String>> possiblePaths = new ArrayList<>();
        
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
            depthFirst(graph, visited);
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
    
    
    
    
}
