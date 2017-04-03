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
    
    public SearchResults(ArrayList<FlightCombo> flightCombos){
        this.flightCombos = flightCombos;
    }
    
    
    public ArrayList<FlightCombo> getFlightCombos(){
        return this.flightCombos;
    }
    
    public void sortBy(String sortParameter, boolean ascending){
        
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
    
        
}
