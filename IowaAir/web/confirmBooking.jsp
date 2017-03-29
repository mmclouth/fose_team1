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
            <h3>Flight number<br>
            Origin: 
            <p style="text-align:center">Time of Departure:</p><br>
            Destination:  
            <p style="text-align:center">Time of Arrival:</p><br>
            Price:
            </h3>  

        </div>
        
        <!--
        <div class="middle">
            <h1>Confirm Booking</h1>
            <h3>Flight number<br>
            <div class="confirmTable">
                <div class="tr">
                <div class="d1">Origin:</div>
                <div class="d2">Time of Departure:</div><br>
                <div class="d1">Destination:</div>
                <div class="d2">Time of Arrival:</div><br>
                <div class="d1">Price:</div>
                </div>
            </div>
            </h3>
        </div>
        -->
        
        <% }%>
        
        <div class="middle">
        <%
            //iterate through each flightId retrieved from searchResults.jsp
            for(String flight_id : flight_IDs){
        %>    
        
        <!-- just testing to make sure the flight_id is getting passed correctly -->
            <h2>Flight ID: <%= flight_id %></h2>
        

        <% }%>
        </div>
    </body>
</html>