<%-- 
    Document   : modifyFlight
    Created on : Mar 24, 2017, 9:18:36 PM
    Author     : Nickolas
--%>
<%@page import="dbResources.Database"%>
<%
    /*
    Database db = new Database();
    if(request.getParameter("flightNumber") != null && request.getParameter("airplaneID") != null && request.getParameter("originCode") != null && 
            request.getParameter("destinationCode") != null && request.getParameter("flightDate") != null && request.getParameter("departureTime") != null 
            && request.getParameter("arrivalTime") != null && request.getParameter("duration") != null && request.getParameter("price") != null)
    {
        String flightNumberOrig = request.getParameter("flightNumber");
        int airplaneIDOrig = Integer.valueOf(request.getParameter("airplaneID"));
        String originCodeOrig = request.getParameter("originCode");
        String destinationCodeOrig = request.getParameter("destinationCode");
        String flightDateOrig = request.getParameter("flightDate").toString();
        String departureTimeOrig = request.getParameter("departureTime").toString();
        String arrivalTimeOrig = request.getParameter("arrivalTime").toString();
        int durationOrig = Integer.valueOf(request.getParameter("duration"));
        double priceOrig = Double.valueOf(request.getParameter("price"));

        int flightID = db.findFlightID(flightNumberOrig, airplaneIDOrig, originCodeOrig, destinationCodeOrig, flightDateOrig, departureTimeOrig, arrivalTimeOrig, durationOrig, priceOrig);

        if(!(flightNumberOrig.equals(request.getParameter("flightNumber"))))
        {
            db.updateFlightNum(request.getParameter("flightNumber"),flightID);
        }
        if(airplaneIDOrig != (Integer.valueOf(request.getParameter("airplaneID"))))
        {
            db.updateFlightAirplaneID(Integer.valueOf(request.getParameter("airplaneID")),flightID);
        }
        if(!(originCodeOrig.equals(request.getParameter("originCode"))))
        {
            db.updateFlightOriginCode(request.getParameter("originCode"),flightID);
        }
        if(!(destinationCodeOrig.equals(request.getParameter("destinationCode"))))
        {
            db.updateFlightDestinationCode(request.getParameter("destinationCode"),flightID);
        }
        if(!(flightDateOrig.equals(request.getParameter("flightDate"))))
        {
            db.updateFlightDate(request.getParameter("flightDate"),flightID);
        }
        if(!(departureTimeOrig.equals(request.getParameter("departureTime"))))
        {
            db.updateFlightDepartureTime(request.getParameter("departureTime"),flightID);
        }
        if(!(arrivalTimeOrig.equals(request.getParameter("arrivalTime"))))
        {
            db.updateFlightArrivalTime(request.getParameter("arrivalTime"),flightID);
        }
        if(durationOrig != (Integer.valueOf(request.getParameter("duration"))))
        {
            db.updateFlightDuration(Integer.valueOf(request.getParameter("duration")),flightID);
        }
        if(priceOrig != (Double.valueOf(request.getParameter("price"))))
        {
            db.updateFlightPrice(Double.valueOf(request.getParameter("price")),flightID);
        }
    }

    //close database connection
    db.closeConnection();
    */
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Admin Flights</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Catamaran" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        
        <% if(session.getAttribute("userID") == null){ %>
        
        <div class="title-top">
            <a class="title" href="index.html"><h1>Iowa Air</h1></a>
            <a class="links" href="logIn.jsp" ><h2>Log In</h2></a>
            <h3>|</h3>
            <a class="links" href="signUp.jsp" ><h2>Sign Up</h2></a>
        </div>
        
        <% } else { %>
        
        <div class="title-top">
            <a class="title" href="<%= session.getAttribute("homePage") %>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName") %>'s Profile</h4></a>
        </div>
        
        <% } %>
        
        <% if(session.getAttribute("user_type") == null || !session.getAttribute("user_type").equals("admin")){ %>
        
        <div class="middle">
            <h2 class="failure">You do not have permission to view this page.  Sign in as admin to view.</h2>
        </div>
        
        <% } else { %>
        

        <div class="middle">
            
            <h1>Modify Flight Page</h1>
            <form action="adminFlights.jsp" method="post"><br>
            Flight Number: 
            <input type="text" name="flightNumber" value="AA151" required><br>
            Airplane ID:
            <input type="number" name="airplaneID" value="10000" required><br>
            Origin Code:
            <input type="text" name="originCode" value="ORD" required><br>
            Destination Code:
            <input type="text" name="destinationCode" value="SFO" required><br>
            Flight Date(mm/dd/yyyy):
            <input type="date" name="flightDate" value="2017-03-28" required><br>
            Departure Time:
            <input type="time" name="departureTime" value="15:00" required><br>
            Arrival Time:
            <input type="time" name="arrivalTime" value="18:00" required><br>
            Duration(mins):
            <input type="number" name="duration" value="180" required><br>
            Price:
            <input type="number" step="0.01" name="price" value="350.00" required><br>
            
            <input type="submit" value="Modify Flight"><br>
            </form>

            </div>
        
        <% } %>

    </body>
</html>
