/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.Map;
import java.util.Set;

/**
 *
 * @author kenziemclouth
 */
public class ConnectionGraph {

    private Map<String, LinkedHashSet<String>> map = new HashMap();

    public void addEdge(String node1, String node2) {
        LinkedHashSet<String> adjacent = map.get(node1);
        if(adjacent==null) {
            adjacent = new LinkedHashSet();
            map.put(node1, adjacent);
        }
        adjacent.add(node2);
    }

    public void addTwoWayVertex(String node1, String node2) {
        addEdge(node1, node2);
        addEdge(node2, node1);
    }

    public boolean isConnected(String node1, String node2) {
        Set adjacent = map.get(node1);
        if(adjacent==null) {
            return false;
        }
        return adjacent.contains(node2);
    }

    public LinkedList<String> adjacentNodes(String last) {
        LinkedHashSet<String> adjacent = map.get(last);
        if(adjacent==null) {
            return new LinkedList();
        }
        return new LinkedList<String>(adjacent);
    }
    

    // Driver method
    public static void main(String args[])
    {
        
        
        Database db = new Database();
        Date date = new Date();
        date.setDate(28);
        date.setMonth(2);
        date.setYear(117);

        boolean flight = db.flightBetweenExists(date, "ORD", "JFK");
        
        Search search = new Search("ORD", "JFK", date);
        
        ConnectionGraph newgraph = search.createConnectionGraph(date);
        
        LinkedList<String> visited = new LinkedList();
        visited.add("ORD");
        
        search.depthFirst(newgraph, visited);
        
        
    }
}
// This code is contributed by Aakash Hasija

    