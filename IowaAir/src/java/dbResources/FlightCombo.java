/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author kenziemclouth
 */
public class FlightCombo {
    
    private ArrayList<HashMap<String,String>> flights;
    private double price;
    private int duration;
    
    
    public FlightCombo(ArrayList<HashMap<String,String>> flights){
        this.flights = flights;
        this.price = this.getMinPrice();
        this.duration = this.getTotalDuration();
    }
    
    
    public ArrayList<HashMap<String,String>> getFlights(){
        return this.flights;
    }
    
    public double getPrice(){
        return this.price;
    }
    
    public int getDuration(){
        return this.duration;
    }
    
    public int getNumberOfFlights(){
        return flights.size();
    }
    
    private double getMinPrice(){
        double price = 0.0;
        
        for(HashMap<String, String> flight : flights){
            price = price + Double.parseDouble(flight.get("price_economy"));
        }
        
        return price;
    }
    
    public double getFirstClassPrice(){
        double price = 0.0;
        
        for(HashMap<String, String> flight : flights){
            price = price + Double.parseDouble(flight.get("price_first_class"));
        }
        
        return price;
    }
    
    private int getTotalDuration(){
        int minutes = 0;
        int layover, hour1, hour2, min1, min2;
        String time1, time2;
        String[] split;
        
        for(int i=0 ; i<flights.size() ; i++){
            
            minutes = minutes + Integer.parseInt(flights.get(i).get("duration"));
            
            if(i < flights.size() - 1){
                time1 = flights.get(i).get("arrival_time");
                time2 = flights.get(i+1).get("Departure_time");
                
                split = time1.split(";");
                hour1 = Integer.parseInt(split[0]);
                min1 = Integer.parseInt(split[1]);
                
                split = time2.split(";");
                hour2 = Integer.parseInt(split[0]);
                min2= Integer.parseInt(split[1]);
                
                layover = ((hour2*60) + min2) - ((hour1 * 60) + min1);
                
                minutes = minutes + layover;
            }
            
            
        }
        
        
        return minutes;
    }
    
}
