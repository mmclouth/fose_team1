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

/**
 *
 * @author kenziemclouth
 */
public class FlightCombo {
    
    private ArrayList<HashMap<String,String>> flights;
    private double price;
    private int duration;
    private String departureTime;
    private String arrivalTime;
    
    public FlightCombo(ArrayList<HashMap<String,String>> flights){
        this.flights = flights;
        this.price = this.getMinPrice();
        this.duration = this.getTotalDuration();
        this.departureTime = flights.get(0).get("departure_time");
        this.arrivalTime = flights.get(flights.size() - 1).get("arrival_time");
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
        
        for(int i=flights.size()-1 ; i>=0 ; i--){
            
            minutes = minutes + Integer.parseInt(flights.get(i).get("duration"));
            
            if(i > 0){
                time1 = flights.get(i).get("arrival_time");
                time2 = flights.get(i-1).get("departure_time");
                
                split = time1.split(":");
                hour1 = Integer.parseInt(split[0]);
                min1 = Integer.parseInt(split[1]);
                
                split = time2.split(":");
                hour2 = Integer.parseInt(split[0]);
                min2= Integer.parseInt(split[1]);
                
                layover = ((hour2*60) + min2) - ((hour1 * 60) + min1);
                
                minutes = minutes + layover;
            }
            
            
        }
        
        
        return minutes;
    }
    
    public int getArrivalTimeInMin() {
        String time = this.arrivalTime;

        String[] split = time.split(":");
        return (Integer.parseInt(split[0]) * 60) + Integer.parseInt(split[1]);
    }
    
    public int getDepartureTimeInMin() {
        String time = this.departureTime;

        String[] split = time.split(":");
        return (Integer.parseInt(split[0]) * 60) + Integer.parseInt(split[1]);
    }
    
    
    public boolean isValid(int number_of_passengers) {

        int landingHour, landingMinute, takeOffHour, takeOffMinute;
        String landingTime, takeOffTime;
        HashMap<String, String> flight1, flight2;
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        String dateString;
        Date landingDate, takeOffDate;

        for (int i = 0; i < flights.size() - 1; i++) {
            flight1 = flights.get(i);
            flight2 = flights.get(i + 1);
            
            int first_class_remaining, economy_remaining;
            
            first_class_remaining = Integer.parseInt(flight1.get("first_class_remaining"));
            economy_remaining = Integer.parseInt(flight1.get("economy_remaining"));
            
            if(first_class_remaining + economy_remaining < number_of_passengers){
                return false;
            }
            
            first_class_remaining = Integer.parseInt(flight2.get("first_class_remaining"));
            economy_remaining = Integer.parseInt(flight2.get("economy_remaining"));
            
            if(first_class_remaining + economy_remaining < number_of_passengers){
                return false;
            }

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
