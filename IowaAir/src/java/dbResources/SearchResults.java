/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

/**
 *
 * @author kenziemclouth
 */
public class SearchResults {
    
    private ArrayList<FlightCombo> flightCombos;
    
    public SearchResults(){
        
    }
    
    public SearchResults(ArrayList<FlightCombo> flightCombos){
        this.flightCombos = flightCombos;
    }
    
    
    public ArrayList<FlightCombo> getFlightCombos(){
        return this.flightCombos;
    }
    
    public void sortBy(String sortParameter, boolean ascending){
        if(sortParameter.equals("price")){
            this.sortByPrice(ascending);
        } else if(sortParameter.equals("duration")){
            this.sortByDuration(ascending);
        } else if(sortParameter.equals("arrival_time")){
            this.sortByArrivalTime(ascending);
        } else if(sortParameter.equals("departure_time")){
            this.sortByDepartureTime(ascending);
        }
    }
    
    
    public void sortByPrice(boolean ascending){
        
        // Sorting
        Collections.sort(flightCombos, new Comparator<FlightCombo>() {
            @Override
            public int compare(FlightCombo combo1, FlightCombo combo2)
            {
                if(ascending){
                    return Double.compare(combo1.getPrice(), combo2.getPrice());
                } else {
                    return Double.compare(combo2.getPrice(), combo1.getPrice());
                }    
            }
        });

    }
    
    public void sortByDuration(boolean ascending){
        // Sorting
        Collections.sort(flightCombos, new Comparator<FlightCombo>() {
            @Override
            public int compare(FlightCombo combo1, FlightCombo combo2)
            {
                if(ascending){
                    return Integer.compare(combo1.getDuration(), combo2.getDuration());
                } else {
                    return Integer.compare(combo2.getDuration(), combo1.getDuration());
                }    
            }
        });
    }
    
    public void sortByDepartureTime(boolean ascending){
        
        Collections.sort(flightCombos, new Comparator<FlightCombo>() {
            @Override
            public int compare(FlightCombo combo1, FlightCombo combo2) {
                if(ascending){
                    return Integer.compare(combo2.getDepartureTimeInMin(), combo1.getDepartureTimeInMin());    
                } else {
                    return Integer.compare(combo1.getDepartureTimeInMin(), combo2.getDepartureTimeInMin());
                }
            }
        });
        
    }
    
    public void sortByArrivalTime(boolean ascending){
        
        Collections.sort(flightCombos, new Comparator<FlightCombo>() {
            @Override
            public int compare(FlightCombo combo1, FlightCombo combo2)
            {
                if(ascending){
                    return Integer.compare(combo1.getArrivalTimeInMin(), combo2.getArrivalTimeInMin());
                } else {
                    return Integer.compare(combo2.getArrivalTimeInMin(), combo1.getArrivalTimeInMin());
                }    
            }
        });
        
    }
    
        
}
