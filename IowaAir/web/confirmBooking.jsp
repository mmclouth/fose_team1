<%-- 
    Document   : confirmBooking
    Created on : Mar 29, 2017, 8:45:10 AM
    Author     : Kyle Anderson
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%@page import="java.util.HashMap"%>
<%
    
    double economyPrice = 0;
    double firstClassPrice = 0;
    Database db = new Database();
    
    //get all parameters from request
    Map<String, String[]> parameters = request.getParameterMap();
    
    ArrayList<String> flight_ID_parameters = new ArrayList<String>();
    ArrayList<String> flight_IDs = new ArrayList<String>();
    ArrayList<HashMap<String,String>> flightsData = new ArrayList<HashMap<String,String>>();
    
    //iterate through each parameter name in request parameter map
    for(String parameterName : parameters.keySet()){
        
        //add flight_id parameter names to list
        if(parameterName.startsWith("flight_id")){
            flight_ID_parameters.add(parameterName);
        }
    }
    
    //loop through each flight_id paramter name and retrieve the actual ID passed from searchResults.jsp
    for(String parameter : flight_ID_parameters){
        if(request.getParameter(parameter) != null){
            flight_IDs.add(request.getParameter(parameter));
        }
    }

    
    

    ArrayList<String> depart_flight = new ArrayList<String>();
    ArrayList<String> return_flight = new ArrayList<String>();

    if(session.getAttribute("depart_flight") != null){
        depart_flight = (ArrayList<String>) session.getAttribute("depart_flight");
        System.out.println("Departing flights");
    }
    if(session.getAttribute("return_flight") != null){
        return_flight = (ArrayList<String>) session.getAttribute("return_flight");
        System.out.println("Return flights");
    }
    
    flight_IDs = depart_flight;
    flight_IDs.addAll(return_flight);
    

    //get all flight data for each flight from database based on flight_ids
    for(String flight_id : flight_IDs){
        flightsData.add(db.getHashMapForFLight(flight_id));
    }
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Confirm Booking</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Catamaran" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>

        <% if (session.getAttribute("userID") == null) { %>

        <div class="title-top">

            <a class="title" href="index.html"><h1>Iowa Air</h1></a>
            <a class="links" href="logIn.jsp" ><h2>Log In</h2></a>
            <h3>|</h3>
            <a class="links" href="signUp.jsp" ><h2>Sign Up</h2></a>
        </div>
        
        <div class="middle">
            In order to confirm your booking, you must be signed into your account.
            Please click here to
            <a class="links" href="signUp.jsp" >sign up</a> or 
            <a class="links" href="logIn.jsp" >log in.</a> 
        </div>
        

        <% } else { %>

        <div class="title-top">

            <% if (session.getAttribute("validation_status") != null && session.getAttribute("validation_status").equals("0")) { %>
            <div class="validate_account_bar">
                <h10>  You have not validated your account yet.  <a href="signUpConfirmation.jsp">Click here</a> to enter your confirmation code.</h10>
            </div>
            <% }%>

            <a class="title" href="<%= session.getAttribute("homePage")%>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName")%>'s Profile</h4></a>
        </div>


        <div class="middle">
            <h1>Confirm Booking</h1>

            <% for(HashMap<String, String> maps : flightsData) {
                   String tempFirstClass = maps.get("price_first_class");
                   String tempEconomy = maps.get("price_economy");
                   firstClassPrice += Double.parseDouble(tempFirstClass);
                   economyPrice += Double.parseDouble(tempEconomy);
            %>
            <h3>
                Flight Number: <%= maps.get("num") %><br>
            </h3>
            <h4>
                    <table id="confirmBooking">
                        <tr>
                            <td>Departure Date: <%= maps.get("departure_date") %></td>
                            <td>Departure Time: <%= maps.get("departure_time") %></td>
                            <td>Departure City: <%= maps.get("origin_code") %></td>
                        </tr>
                        <tr>
                            <td>Arrival Date: <%= maps.get("arrival_date") %></td>
                            <td>Arrival Time: <%= maps.get("arrival_time") %></td>
                            <td>Arrival City: <%= maps.get("origin_code") %></td>
                        </tr>
                        <tr>
                            <td>Duration: <%= maps.get("duration") %> minutes</td>
                            <td>Price First Class: $<%= maps.get("price_first_class") %></td>
                            <td>Price Economy: $<%= maps.get("price_economy") %></td>
                        </tr>    
                    </table><br>
            </h4>   

            <% } %>
            <form action="purchaseFlight.jsp" method="post">
                <p align="right"><input type="submit" value="Book Economy: $<%= economyPrice %>0" ></p>
                <input type="hidden" name="price" value="<%= economyPrice %>">
            </form>
            
            <form action="purchaseFlight.jsp" method="post">
                <p align="right"><input type="submit" value="Book First Class: $<%= firstClassPrice %>0" ></p>
                <input type="hidden" name="price" value="<%= firstClassPrice %>">
            </form>
        </div>
        <% } %>
    </body>
</html>
