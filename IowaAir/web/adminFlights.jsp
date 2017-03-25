<%-- 
    Document   : adminFlights
    Created on : Feb 16, 2017, 9:39:08 PM
    Author     : kenziemclouth
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%@page import="java.util.HashMap"%>
<%
    Database db = new Database();
    
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
        db.addFlightToDatabase(flightNumber,airplaneID,originCode,destinationCode,flightDate,departureTime,arrivalTime,duration,priceEconomy,priceFirstClass,firstClassSeatsRemaining,economySeatsRemaining);
    }
    int flightID = db.findFlightID("AA111");
    session.setAttribute("flightNumber",db.selectString("num","flight","id",Integer.toString(flightID)));
    session.setAttribute("airplaneID",db.selectString("airplane_id","flight","id",Integer.toString(flightID)));
    session.setAttribute("originCode",db.selectString("origin_code","flight","id",Integer.toString(flightID)));
    session.setAttribute("destinationCode",db.selectString("destination_code","flight","id",Integer.toString(flightID)));
    session.setAttribute("flightDate",db.selectString("flight_date","flight","id",Integer.toString(flightID)));
    session.setAttribute("departureTime",db.selectString("departure_time","flight","id",Integer.toString(flightID)));
    session.setAttribute("arrivalTime", db.selectString("arrival_time","flight","id",Integer.toString(flightID)));
    session.setAttribute("duration",db.selectString("duration","flight","id",Integer.toString(flightID)));
    session.setAttribute("priceEconomy",db.selectString("price_economy","flight","id",Integer.toString(flightID)));
    session.setAttribute("priceFirstClass",db.selectString("price_first_class","flight","id",Integer.toString(flightID)));
    session.setAttribute("firstClassSeatsRemaining",db.selectString("first_class_remaining","flight","id",Integer.toString(flightID)));
    session.setAttribute("economySeatsRemaining",db.selectString("economy_remaining","flight","id",Integer.toString(flightID)));
    ArrayList<HashMap<String, String>> flightData = db.getAllFlightData();

    //close database connection
    db.closeConnection();
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
        
        <div class="admin-toolbar">
            <ul>
                <li><a href="adminLanding.jsp">Home</a></li>
                <li> <a class="active" href="adminFlights.jsp">Flights</a></li>
                <li><a href="adminAirplanes.jsp">Airplanes</a></li>
                <li><a href="adminAirports.jsp">Airports</a></li>
                <li><a href="adminEmployees.jsp">Employees</a></li>
            </ul>  
        </div>

        <div class="middle">
            
            <h1>Admin Flights Page</h1>
            <form action="adminFlights.jsp" method="post"><br>
                <h2>Add New Flight</h2><br>
            Flight Number: 
            <input type="text" name="flightNumber" required><br>
            Airplane ID:
            <input type="text" name="airplaneID" required><br>
            Origin Code:
            <input type="text" name="originCode" required><br>
            Destination Code:
            <input type="text" name="destinationCode" required><br>
            Flight Date(mm/dd/yyyy):
            <input type="date" name="flightDate" required><br>
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
            First Class Seats Remaining:
            <input type="number" name="firstClassSeatsRemaining" required><br>
            Economy Seats Remaining:
            <input type="number" name="economySeatsRemaining" required><br>
            
            <input type="submit" value="Add Flight"><br>
            <a href="modifyFlight.jsp">Modify Flight</a><br>
            </form>
            
        </div>
        
        <div class="employee-table">

                <h2>Current Flights</h2>

                <table>
                    <tr>
                        <th>Number</th>
                        <th>Airplane ID</th>
                        <th>Origin Code</th>
                        <th>Destination Code</th>
                        <th>Flight Date</th>
                        <th>Departure Time</th>
                        <th>Arrival Time</th>
                        <th>Duration</th>
                        <th>Price Economy</th>
                        <th>Price First Class</th>
                        <th>First Class Seats Remaining</th>
                        <th>Economy Seats Remaining</th>
                    </tr>

                    <!- Loop through each employee record and output each field in correct able column ->
                    <% for (HashMap<String, String> record : flightData) {%>
                    <tr>
                        <td><%= record.get("num")%></td>
                        <td><%= record.get("airplane_id")%></td>
                        <td><%= record.get("origin_code")%></td>
                        <td><%= record.get("destination_code")%></td>
                        <td><%= record.get("flight_date")%></td>
                        <td><%= record.get("departure_time")%></td>
                        <td><%= record.get("arrival_time")%></td>
                        <td><%= record.get("duration")%></td>
                        <td><%= record.get("price_economy")%></td>
                        <td><%= record.get("price_first_class")%></td>
                        <td><%= record.get("first_class_remaining")%></td>
                        <td><%= record.get("economy_remaining")%></td>
                    </tr>

                    <% }%>

                </table>

            </div>
        
        <% } %>

    </body>
</html>
