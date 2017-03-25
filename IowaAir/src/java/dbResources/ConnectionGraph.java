/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;
import java.io.*;
import java.util.*;
import java.util.LinkedList;

/**
 *
 * @author kenziemclouth
 */
public class ConnectionGraph {

 
    private int V;   // No. of vertices
    private LinkedList<Integer> adj[]; //Adjacency List
 
    //Constructor
    ConnectionGraph(int v)
    {
        V = v;
        adj = new LinkedList[v];
        for (int i=0; i<v; ++i)
            adj[i] = new LinkedList();
    }
 
    //Function to add an edge into the graph
    public void addEdge(int v,int w)  {   adj[v].add(w);   }
 
    //prints BFS traversal from a given source s
    public Boolean isReachable(int s, int d)
    {
        LinkedList<Integer>temp;
 
        // Mark all the vertices as not visited(By default set
        // as false)
        boolean visited[] = new boolean[V];
 
        // Create a queue for BFS
        LinkedList<Integer> queue = new LinkedList<Integer>();
 
        // Mark the current node as visited and enqueue it
        visited[s]=true;
        queue.add(s);
 
        // 'i' will be used to get all adjacent vertices of a vertex
        Iterator<Integer> i;
        while (queue.size()!=0)
        {
            // Dequeue a vertex from queue and print it
            s = queue.poll();
 
            int n;
            i = adj[s].listIterator();
 
            // Get all adjacent vertices of the dequeued vertex s
            // If a adjacent has not been visited, then mark it
            // visited and enqueue it
            while (i.hasNext())
            {
                n = i.next();
 
                // If this adjacent node is the destination node,
                // then return true
                if (n==d)
                    return true;
 
                // Else, continue to do BFS
                if (!visited[n])
                {
                    visited[n] = true;
                    queue.add(n);
                }
            }
        }
 
        // If BFS is complete without visited d
        return false;
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
        
        // Create a graph given in the above diagram
        ConnectionGraph g = new ConnectionGraph(4);
        g.addEdge(0, 1);
        g.addEdge(0, 2);
        g.addEdge(1, 2);
        g.addEdge(2, 0);
        g.addEdge(2, 3);
        g.addEdge(3, 3);
 
        int u = 1;
        int v = 3;
        if (g.isReachable(u, v))
            System.out.println("There is a path from " + u +" to " + v);
        else
            System.out.println("There is no path from " + u +" to " + v);;
 
        u = 3;
        v = 1;
        if (g.isReachable(u, v))
            System.out.println("There is a path from " + u +" to " + v);
        else
            System.out.println("There is no path from " + u +" to " + v);;
    }
}
// This code is contributed by Aakash Hasija

    