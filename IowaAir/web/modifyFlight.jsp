<%-- 
    Document   : modifyFlight
    Created on : Mar 24, 2017, 9:18:36 PM
    Author     : Nickolas
--%>
<%@page import="dbResources.Database"%>
<%
    
    Database db = new Database();
    String flightNumberOrig = (String)session.getAttribute("flightNum");
    int flightID = db.findFlightID(flightNumberOrig);
    int airplaneIDOrig = db.getAirplaneID(flightID);
    String originCodeOrig = db.getOriginCode(flightID);
    String destinationCodeOrig = db.getDestinationCode(flightID);
    String flightDepartureDateOrig = db.getDepartureDate(flightID);
    String flightArrivalDateOrig = db.getArrivalDate(flightID);
    String departureTimeOrig = db.getDepartureTime(flightID);
    String arrivalTimeOrig = db.getArrivalTime(flightID);
    int durationOrig = db.getDuration(flightID);
    double priceEconomyOrig = db.getPriceEconomy(flightID);
    double priceFirstClassOrig = db.getPriceFirstClass(flightID);
    int firstClassSeatsRemainingOrig = db.getFirstClassSeatsRemaining(flightID);
    int economySeatsRemainingOrig = db.getEconomySeatsRemaining(flightID);
 
    String flightNumber = null;
    int airplaneID = 0;
    String originCode = null;
    String destinationCode = null;
    String flightDepartureDate = null;
    String flightArrivalDate = null;
    String departureTime = null;
    String arrivalTime = null;
    int duration = 0;
    double priceEconomy = 0.0;
    double priceFirstClass = 0.0;
    int firstClassSeatsRemaining = 0;
    int economySeatsRemaining = 0;
    
    
    //Retrieve parameters from request if they have been sent from previous page
    if (request.getParameter("flightNumber") != null) {
        flightNumber = request.getParameter("flightNumber");
    }
    if (request.getParameter("airplaneID") != null) {
        airplaneID = Integer.valueOf(request.getParameter("airplaneID"));
    }
    if (request.getParameter("originCode") != null) {
        originCode = request.getParameter("originCode");
    }
    if (request.getParameter("destinationCode") != null) {
        destinationCode = request.getParameter("destinationCode");
    }
    if (request.getParameter("flightDepartureDate") != null) {
        flightDepartureDate = request.getParameter("flightDepartureDate").toString();
        

        //If browser does not support HTML's date type, format the date string correctly
        if (!flightDepartureDate.matches("^(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$")) {

            String[] flightSplit = flightDepartureDate.split("/");
            String month = flightSplit[0];
            String day = flightSplit[1];
            String year = flightSplit[2];

            flightDepartureDate = year + "-" + month + "-" + day;
        }
    }
    if (request.getParameter("flightArrivalDate") != null) {
        flightArrivalDate = request.getParameter("flightArrivalDate").toString();
        

        //If browser does not support HTML's date type, format the date string correctly
        if (!flightArrivalDate.matches("^(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$")) {

            String[] flightSplit = flightArrivalDate.split("/");
            String month = flightSplit[0];
            String day = flightSplit[1];
            String year = flightSplit[2];

            flightArrivalDate = year + "-" + month + "-" + day;
        }
    }
    if (request.getParameter("departureTime") != null) {
        departureTime = request.getParameter("departureTime").toString();
    }
    if (request.getParameter("arrivalTime") != null) {
        arrivalTime = request.getParameter("arrivalTime").toString();
    }
    if (request.getParameter("duration") != null) {
        duration = Integer.valueOf(request.getParameter("duration"));
    }
    if (request.getParameter("priceEconomy") != null) {
        priceEconomy = Double.valueOf(request.getParameter("priceEconomy"));
    }
    if (request.getParameter("priceFirstClass") != null) {
        priceFirstClass = Double.valueOf(request.getParameter("priceFirstClass"));
    }
    if (request.getParameter("firstClassSeatsRemaining") != null) {
        firstClassSeatsRemaining = Integer.valueOf(request.getParameter("firstClassSeatsRemaining"));
    }
    if (request.getParameter("economySeatsRemaining") != null) {
        economySeatsRemaining = Integer.valueOf(request.getParameter("economySeatsRemaining"));
    }
    if(request.getParameter("update")!=null && request.getParameter("newFlightNumber") != null && request.getParameter("newAirplaneID") != null && request.getParameter("newOriginCode") != null
            && request.getParameter("newDestinationCode")!= null && request.getParameter("newFlightDepartureDate") != null && request.getParameter("newFlightArrivalDate") != null && request.getParameter("newDepartureTime") != null 
            && request.getParameter("newArrivalTime") != null && request.getParameter("newDuration") != null && request.getParameter("newPriceEconomy") != null && request.getParameter("newPriceFirstClass") != null 
            && request.getParameter("newFirstClassSeatsRemaining") != null && request.getParameter("newEconomySeatsRemaining") != null )
    {
        db.updateFlight(request.getParameter("newFlightNumber"),Integer.valueOf(request.getParameter("newAirplaneID")),request.getParameter("newOriginCode"),request.getParameter("newDestinationCode"),
                request.getParameter("newFlightDepartureDate"),request.getParameter("newFlightArrivalDate"),request.getParameter("newDepartureTime"),request.getParameter("newArrivalTime"),
                Integer.valueOf(request.getParameter("newDuration")),Double.valueOf(request.getParameter("newPriceEconomy")),Double.valueOf(request.getParameter("newPriceFirstClass")),
                Integer.valueOf(request.getParameter("newFirstClassSeatsRemaining")),Integer.valueOf(request.getParameter("newEconomySeatsRemaining")));
        response.sendRedirect("/IowaAir/adminFlights.jsp");
    }
    /*if(flightNumber != null && airplaneID != 0 && originCode != null && destinationCode != null && flightDepartureDate != null && flightArrivalDate != null && departureTime != null 
            && arrivalTime != null && duration != 0 && priceEconomy != 0.0 && priceFirstClass != 0.0 && firstClassSeatsRemaining != 0 && economySeatsRemaining != 0)
    {
        if (airplaneID != airplaneIDOrig || originCode != originCodeOrig || destinationCode != destinationCodeOrig)
        {
            db.updateFlight(flightNumber,airplaneID,originCode,destinationCode,flightDepartureDate,flightArrivalDate,departureTime,arrivalTime,duration,priceEconomy,priceFirstClass,firstClassSeatsRemaining,economySeatsRemaining);
            response.sendRedirect("/IowaAir/adminFlights.jsp");
        }
    }*/
    //close database connection
    db.closeConnection();
    
%>

<script>
function updateFunction() {  
    
    document.getElementById("newFlightNumberID").value = document.getElementById("flightNumberID").value;
    
    var test = document.getElementById("newFlightNumberID").value;
    console.log(test);
    
    document.getElementById("newAirplaneIDID").value = document.getElementById("airplaneIDID").value;
    
    var test = document.getElementById("newAirplaneIDID").value;
    console.log(test);
    
    document.getElementById("newOriginCodeID").value = document.getElementById("originCodeID").value;
    
    var test = document.getElementById("newOriginCodeID").value;
    console.log(test);
    
    document.getElementById("newDestinationCodeID").value = document.getElementById("destinationCodeID").value;
    
    var test = document.getElementById("newDestinationCodeID").value;
    console.log(test);
    
    document.getElementById("newFlightDepartureDateID").value = document.getElementById("flightDepartureDateID").value;
    
    var test = document.getElementById("newFlightDepartureDateID").value;
    console.log(test);
    
    document.getElementById("newFlightArrivalDateID").value = document.getElementById("flightArrivalDateID").value;
    
    var test = document.getElementById("newFlightArrivalDateID").value;
    console.log(test);
    
    document.getElementById("newDepartureTimeID").value = document.getElementById("departureTimeID").value;
    
    var test = document.getElementById("newDepartureTimeID").value;
    console.log(test);
    
    document.getElementById("newArrivalTimeID").value = document.getElementById("arrivalTimeID").value;
    
    var test = document.getElementById("newArrivalTimeID").value;
    console.log(test);
    
    document.getElementById("newDurationID").value = document.getElementById("durationID").value;
    
    var test = document.getElementById("newDurationID").value;
    console.log(test);
    
    document.getElementById("newPriceEconomyID").value = document.getElementById("priceEconomyID").value;
    
    var test = document.getElementById("newPriceEconomyID").value;
    console.log(test);
    
    document.getElementById("newPriceFirstClassID").value = document.getElementById("priceFirstClassID").value;
    
    var test = document.getElementById("newPriceFirstClassID").value;
    console.log(test);
    
    document.getElementById("newEconomySeatsRemainingID").value = document.getElementById("economySeatsRemainingID").value;
    
    var test =  document.getElementById("newEconomySeatsRemainingID").value;
    console.log(test);
    
    document.getElementById("newFirstClassSeatsRemainingID").value = document.getElementById("firstClassSeatsRemainingID").value;
    
    var test = document.getElementById("newFirstClassSeatsRemainingID").value;
    console.log(test);
    
}
</script>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Modify Flights</title>
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

            <form id="modifyForm" action="modifyFlight.jsp" method="post"><br>
            <input type="hidden" name="update" id="updateID" >
            Flight Number: 
            <input type="text" name="flightNumber" id="flightNumberID" value="<%=flightNumberOrig%>" required><br>
            <input type="hidden" name="newFlightNumber" id="newFlightNumberID" >
            Airplane ID:
            <input type="number" name="airplaneID" id="airplaneIDID" value="<%=airplaneIDOrig%>" required><br>
            <input type="hidden" name="newAirplaneID" id="newAirplaneIDID" >
            Origin Code:
            <input type="text" name="originCode" id="originCodeID" value="<%=originCodeOrig%>" required><br>
            <input type="hidden" name="newOriginCode" id="newOriginCodeID" >
            Destination Code:
            <input type="text" name="destinationCode" id="destinationCodeID" value="<%=destinationCodeOrig%>" required><br>
            <input type="hidden" name="newDestinationCode" id="newDestinationCodeID" >
            Departure Date(mm/dd/yyyy):
            <input type="date" name="flightDepartureDate" id="flightDepartureDateID" value="<%=flightDepartureDateOrig%>" required><br>
            <input type="hidden" name="newFlightDepartureDate" id="newFlightDepartureDateID" >
            Arrival Date(mm/dd/yyyy):
            <input type="date" name="flightArrivalDate" id="flightArrivalDateID" value="<%=flightArrivalDateOrig%>" required><br>
            <input type="hidden" name="newFlightArrivalDate" id="newFlightArrivalDateID" >
            Departure Time:
            <input type="time" name="departureTime" id="departureTimeID" value="<%=departureTimeOrig%>" required><br>
            <input type="hidden" name="newDepartureTime" id="newDepartureTimeID" >
            Arrival Time:
            <input type="time" name="arrivalTime" id="arrivalTimeID" value="<%=arrivalTimeOrig%>" required><br>
            <input type="hidden" name="newArrivalTime" id="newArrivalTimeID" >
            Duration(mins):
            <input type="number" name="duration" id="durationID" value="<%=durationOrig%>" required><br>
            <input type="hidden" name="newDuration" id="newDurationID" >
            Economy Price:
            <input type="number" step="0.01" name="priceEconomy" id="priceEconomyID" value="<%=priceEconomyOrig%>" required><br>
            <input type="hidden" name="newPriceEconomy" id="newPriceEconomyID" >
            First Class Price:
            <input type="number" step="0.01" name="priceFirstClass" id="priceFirstClassID" value="<%=priceFirstClassOrig%>" required><br>
            <input type="hidden" name="newPriceFirstClass" id="newPriceFirstClassID" >
            First Class Seats Remaining:
            <input type="number" name="firstClassSeatsRemaining" id="firstClassSeatsRemainingID" value="<%=firstClassSeatsRemainingOrig%>" required><br>
            <input type="hidden" name="newFirstClassSeatsRemaining" id="newFirstClassSeatsRemainingID" >
            Economy Seats Remaining:
            <input type="number" name="economySeatsRemaining" id="economySeatsRemainingID" value="<%=economySeatsRemainingOrig%>" required><br>
            <input type="hidden" name="newEconomySeatsRemaining" id="newEconomySeatsRemainingID" >
            
            <input type="submit" value="Modify Flight" onclick="updateFunction();" ><br>
            </form>

            </div>
        
        <% } %>

    </body>
</html>
