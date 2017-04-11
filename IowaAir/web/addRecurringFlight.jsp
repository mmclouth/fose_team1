<%-- 
    Document   : addRecurringFlight
    Created on : Apr 11, 2017, 10:44:49 AM
    Author     : kenziemclouth
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%
    Database db = new Database();
    String aircraftType = null;
    ArrayList<String> airplaneIDs;
    ArrayList<String> aircraftTypes = db.selectArrayList("plane_name", "aircraft_type");
    ArrayList<String> airports = db.selectArrayList("code", "airport");
    int firstClassSeats = 0, economySeats = 0;
    
    boolean formSubmitted = false;
    
    String frequency=null, start=null, end=null, airplaneID=null, origin=null, destination=null, departureTime=null,
            arrivalTime=null, duration=null, priceEconomy=null, priceFirst=null, seatsEconomy=null, seatsFirst=null;

    if (request.getParameter("aircraft_type") != null) {
        aircraftType = request.getParameter("aircraft_type");
        String aircraft_type_id = db.selectString("id", "aircraft_type", "plane_name", aircraftType);
        airplaneIDs = db.selectArrayList("id", "airplane", "aircraft_type_id", aircraft_type_id);

        firstClassSeats = Integer.parseInt(db.selectString("capacity_first_class", "aircraft_type", "plane_name", aircraftType));
        economySeats = Integer.parseInt(db.selectString("capacity_economy", "aircraft_type", "plane_name", aircraftType));
    } else {
        aircraftType = "";
        airplaneIDs = db.getAllAirplaneIDs();
    }

    if (request.getParameter("formSubmitted") != null && request.getParameter("formSubmitted").equals("true")) {
        
        formSubmitted = true;
        
        if (request.getParameter("frequency") != null) {
           frequency = request.getParameter("frequency");
        } else {
            
        }
        if (request.getParameter("recurringStart") != null) {
           start = request.getParameter("recurringStart");
        } else {
            
        }
        if (request.getParameter("recurringEnd") != null) {
           end = request.getParameter("recurringEnd");
        } else {
            
        }
        if (request.getParameter("aircraftType") != null) {
            aircraftType = request.getParameter("aircraftType");
        } else {
            
        }
        if (request.getParameter("airplaneID") != null) {
            airplaneID = request.getParameter("airplaneID");
        } else {
            
        }
        if (request.getParameter("originCode") != null) {
            origin = request.getParameter("originCode");
        } else {
            
        }
        if (request.getParameter("destinationCode") != null) {
            destination = request.getParameter("destinationCode");
        } else {
            
        }
        if (request.getParameter("departureTime") != null) {
            departureTime = request.getParameter("departureTime");
        } else {
            
        }
        if (request.getParameter("arrivalTime") != null) {
            arrivalTime = request.getParameter("arrivalTime");
        } else {
            
        }
        if (request.getParameter("duration") != null) {
            duration = request.getParameter("duration");
        } else {
            
        }
        if (request.getParameter("priceEconomy") != null) {
            priceEconomy = request.getParameter("priceEconomy");
        } else {
            
        }
        if (request.getParameter("priceFirstClass") != null) {
            priceFirst = request.getParameter("priceFirstClass");
        } else {
            
        }
        if (request.getParameter("economySeatsRemaining") != null) {
            seatsEconomy= request.getParameter("economySeatsRemaining");
        } else {
            
        }
        if (request.getParameter("firstClassSeatsRemaining") != null) {
            seatsFirst = request.getParameter("firstClassSeatsRemaining");
        } else {
            
        }
        
        
        db.addRecurringFlight(frequency, Integer.parseInt(airplaneID), start, end, origin, destination, departureTime, arrivalTime, Integer.parseInt(duration), Double.parseDouble(priceEconomy), Double.parseDouble(priceFirst), Integer.parseInt(seatsEconomy), Integer.parseInt(seatsFirst));

        db.closeConnection();
        
        response.sendRedirect("/IowaAir/adminFlights.jsp");
        return;
        
    }

    db.closeConnection();
%>    

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Search Results</title>
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

        <% } else { %>

        <% if (session.getAttribute("validation_status") != null && session.getAttribute("validation_status").equals("0")) { %>
        <div class="validate_account_bar">
            <h10>  You have not validated your account yet.  <a href="signUpConfirmation.jsp">Click here</a> to enter your confirmation code.</h10>
        </div>
        <% }%>

        <div class="title-top">
            <a class="title" href="<%= session.getAttribute("homePage")%>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName")%>'s Profile</h4></a>
        </div>

        <% } %>

        <div class="middle">
            <h1>Add Recurring Flight:</h1>
            <form action="addRecurringFlight.jsp" method="post">
                <label for="airplaneID">Aircraft Type:</label>
                <select name="aircraft_type">
                    <% for (String type : aircraftTypes) {%>
                    <option value="<%=type%>"><%=type%></option>
                    <% }%>
                </select>    
                <input type="submit" value="Update Form"> <br>
            </form>
            <br><br>
            <form action="addRecurringFlight.jsp" method="post">

                Recurring Criteria:
                <label for="frequency">Frequency:</label>
                <select name="frequency">
                    <option value="null">------</option>
                    <option value="Daily">Daily</option>
                    <option value="Weekly">Weekly</option>
                    <option value="Monthly">Monthly</option>
                </select>
                
                <br>
                <label for="recurringStart">Sequence Start:</label>
                <input type="date" name="recurringStart">
                <br>
                
                <label for="recurringEnd">Sequence End:</label>
                <input type="date" name="recurringEnd"> 
                <br>
                
                
                Aircraft Type:
                <input type="text" value="<%=aircraftType%>" name="aircraft_type">
                <br>
                <label for="airplaneID">Airplane ID:</label>
                <select name="airplaneID">
                    <option value="null">------</option>
                    <%
                        for (String ids : airplaneIDs) {
                    %>
                    <option value="<%=ids%>"><%=ids%></option>     

                    <% } %>                  
                </select>    
                <br> 
                <label for="originCode">Origin:</label>
                <select name="originCode">
                    <option value="null">------</option>
                    <%
                        for (String airport : airports) {
                    %>
                    <option value="<%=airport%>"><%=airport%></option>     

                    <% } %>                  
                </select>    
                <br> 
                <label for="destinationCode">Destination:</label>
                <select name="destinationCode">
                    <option value="null">------</option>
                    <%
                        for (String airport : airports) {
                    %>
                    <option value="<%=airport%>"><%=airport%></option>     

                    <% }%>                  
                </select>  
                <br>
                Departure Time:
                <input type="time" name="departureTime" required><br>
                Arrival Time:
                <input type="time" name="arrivalTime" required><br>
                Duration(mins):
                <input type="number" name="duration" required><br>
                Economy Price:
                <input type="number" step="0.01" name="priceEconomy" required><br>
                First Class Price:
                <input type="number" step="0.01" name="priceFirstClass" required><br>
                Economy Seats Remaining:
                <input type="number" name="economySeatsRemaining" value=<%=economySeats%> required><br>
                First Class Seats Remaining:
                <input type="number" name="firstClassSeatsRemaining" value=<%=firstClassSeats%> required><br>
                <input type="hidden" name="formSubmitted" value="true">    


                <div class="search-button">
                    <button type="submit" value="Submit">Add Flight</button>
                </div>
            </form>
        </div>

    </body>
</html>
