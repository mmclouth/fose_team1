<%-- 
    Document   : modifyFlight
    Created on : Mar 24, 2017, 9:18:36 PM
    Author     : Nickolas
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%
    
    Database db = new Database();
    ArrayList<String> airports = db.getAllAirportCodes();
    ArrayList<String> airplaneIDs = db.getAllAirplaneIDs();
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
 
    if(request.getParameter("newFlightNumber") != null && request.getParameter("newAirplaneID") != null && request.getParameter("newOriginCode") != null
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
    //close database connection
    db.closeConnection();
    
%>

<script>
function updateFunction() {  
    
    document.getElementById("newFlightNumberID").value = document.getElementById("flightNumberID").value;
    
    document.getElementById("newAirplaneIDID").value = document.getElementById("airplaneIDID").value;
    
    document.getElementById("newOriginCodeID").value = document.getElementById("originCodeID").value;
    
    document.getElementById("newDestinationCodeID").value = document.getElementById("destinationCodeID").value;
    
    document.getElementById("newFlightDepartureDateID").value = document.getElementById("flightDepartureDateID").value;
    
    document.getElementById("newFlightArrivalDateID").value = document.getElementById("flightArrivalDateID").value;
    
    document.getElementById("newDepartureTimeID").value = document.getElementById("departureTimeID").value;
    
    document.getElementById("newArrivalTimeID").value = document.getElementById("arrivalTimeID").value;
    
    document.getElementById("newDurationID").value = document.getElementById("durationID").value;
    
    document.getElementById("newPriceEconomyID").value = document.getElementById("priceEconomyID").value;
    
    document.getElementById("newPriceFirstClassID").value = document.getElementById("priceFirstClassID").value;
    
    document.getElementById("newEconomySeatsRemainingID").value = document.getElementById("economySeatsRemainingID").value;
    
    document.getElementById("newFirstClassSeatsRemainingID").value = document.getElementById("firstClassSeatsRemainingID").value;
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
            
            <label for="airplaneID">Airplane ID:</label>
            <select name="airplaneID" id="airplaneIDID" required>
                    <option value="null"><%=airplaneIDOrig%></option>
                    <%
                        for(String ids : airplaneIDs){      
                    %>
                    <option value="<%=ids%>"><%=ids%></option>     
                    
                    <% } %>                  
                </select>    
                <br> 
            <input type="hidden" name="newAirplaneID" id="newAirplaneIDID" >
            <label for="originCode">Origin:</label>
                <select name="originCode" id="originCodeID" required>
                    <option value="null"><%=originCodeOrig%></option>
                    <%
                        for(String airport : airports){      
                    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>    
                <br> 
            <input type="hidden" name="newOriginCode" id="newOriginCodeID" >
            <label for="destinationCode">Destination:</label>
            <select name="destinationCode" id="destinationCodeID" required>
                    <option value="null"><%=destinationCodeOrig%></option>
                    <%
                        for(String airport : airports){      
                    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>  
                <br>
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
            <a href="adminFlights.jsp">Go Back</a><br>
            </form>

            </div>
        
        <% } %>

    </body>
</html>
