<%-- 
    Document   : modifyFlight
    Created on : Mar 24, 2017, 9:18:36 PM
    Author     : Nickolas
--%>
<%@page import="dbResources.Database"%>
<%
    
    Database db = new Database();
    int flightID = Integer.valueOf((String)session.getAttribute("flightID"));
    String flightNumberOrig = (String)session.getAttribute("flightNumber");
    int airplaneIDOrig = Integer.valueOf((String)(session.getAttribute("airplaneID")));
    String originCodeOrig = (String)session.getAttribute("originCode");
    String destinationCodeOrig = (String)session.getAttribute("destinationCode");
    String flightDateOrig = (String)session.getAttribute("flightDate");
    String departureTimeOrig = (String)session.getAttribute("departureTime");
    String arrivalTimeOrig = (String)session.getAttribute("arrivalTime");
    int durationOrig = Integer.valueOf((String)(session.getAttribute("duration")));
    double priceEconomyOrig = Double.valueOf((String)session.getAttribute("priceEconomy"));
    double priceFirstClassOrig = Double.valueOf((String)session.getAttribute("priceFirstClass"));
    int firstClassSeatsRemainingOrig = Integer.valueOf((String)session.getAttribute("firstClassSeatsRemaining"));
    int economySeatsRemainingOrig = Integer.valueOf((String)session.getAttribute("economySeatsRemaining"));
 
    String flightNumber = null;
    int airplaneID = 0;
    String originCode = null;
    String destinationCode = null;
    String flightDate = null;
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
    if (request.getParameter("flightDate") != null) {
        flightDate = request.getParameter("flightDate").toString();
        

        //If browser does not support HTML's date type, format the date string correctly
        if (!flightDate.matches("^(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$")) {

            String[] flightSplit = flightDate.split("/");
            String month = flightSplit[0];
            String day = flightSplit[1];
            String year = flightSplit[2];

            flightDate = year + "-" + month + "-" + day;
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
    
    if(flightNumber != null && airplaneID != 0 && originCode != null && destinationCode != null && flightDate != null && departureTime != null 
            && arrivalTime != null && duration != 0 && priceEconomy != 0.0 && priceFirstClass != 0.0 && firstClassSeatsRemaining != 0 && economySeatsRemaining != 0)
    {
        if(!(flightNumberOrig.equals(request.getParameter("flightNumber"))))
        {
            db.updateFlightNum(request.getParameter("flightNumber"),flightID);
        }
        if(airplaneIDOrig != (Integer.parseInt(request.getParameter("airplaneID"))))
        {
            db.updateFlightAirplaneID(Integer.parseInt(request.getParameter("airplaneID")),flightID);
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
        if(durationOrig != (Integer.parseInt(request.getParameter("duration"))))
        {
            db.updateFlightDuration(Integer.parseInt(request.getParameter("duration")),flightID);
        }
        if(priceEconomyOrig != (Double.valueOf(request.getParameter("priceEconomy"))))
        {
            db.updateFlightPriceEconomy(Double.valueOf(request.getParameter("priceEconomy")),flightID);
        }
        if(priceFirstClassOrig != (Double.valueOf(request.getParameter("priceFirstClass"))))
        {
            db.updateFlightPriceFirstClass(Double.valueOf(request.getParameter("priceFirstClass")),flightID);
        }
        if(firstClassSeatsRemainingOrig != (Integer.valueOf(request.getParameter("firstClassSeatsRemaining"))))
        {
            db.updateFlightFirstClassSeatsRemaining(Integer.valueOf(request.getParameter("firstClassSeatsRemaining")),flightID);
        }
        if(economySeatsRemainingOrig != (Integer.valueOf(request.getParameter("economySeatsRemaining"))))
        {
            db.updateFlightEconomySeatsRemaining(Integer.valueOf(request.getParameter("economySeatsRemaining")),flightID);
        }
        response.sendRedirect("/IowaAir/adminFlights.jsp");
    }
    
    //close database connection
    db.closeConnection();
    
%>

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

            <form action="modifyFlight.jsp" method="post"><br>
            Flight Number: 
            <input type="text" name="flightNumber" value="<%=session.getAttribute("flightNumber")%>" required><br>
            Airplane ID:
            <input type="number" name="airplaneID" value="<%=session.getAttribute("airplaneID")%>" required><br>
            Origin Code:
            <input type="text" name="originCode" value="<%=session.getAttribute("originCode")%>" required><br>
            Destination Code:
            <input type="text" name="destinationCode" value="<%=session.getAttribute("destinationCode")%>" required><br>
            Flight Date(mm/dd/yyyy):
            <input type="date" name="flightDate" value="2017-<%=session.getAttribute("flightDate")%>-28" required><br>
            Departure Time:
            <input type="time" name="departureTime" value="<%=session.getAttribute("departureTime")%>" required><br>
            Arrival Time:
            <input type="time" name="arrivalTime" value="<%=session.getAttribute("arrivalTime")%>" required><br>
            Duration(mins):
            <input type="number" name="duration" value="<%=session.getAttribute("duration")%>" required><br>
            Economy Price:
            <input type="number" step="0.01" name="priceEconomy" value="<%=session.getAttribute("priceEconomy")%>" required><br>
            First Class Price:
            <input type="number" step="0.01" name="priceFirstClass" value="<%=session.getAttribute("priceFirstClass")%>" required><br>
            First Class Seats Remaining:
            <input type="number" name="firstClassSeatsRemaining" value="<%=session.getAttribute("firstClassSeatsRemaining")%>" required><br>
            Economy Seats Remaining:
            <input type="number" name="economySeatsRemaining" value="<%=session.getAttribute("economySeatsRemaining")%>" required><br>
            
            <input type="submit" value="Modify Flight"><br>
            <a href="deleteFlight.jsp">Delete Flight</a><br>
            </form>

            </div>
        
        <% } %>

    </body>
</html>
