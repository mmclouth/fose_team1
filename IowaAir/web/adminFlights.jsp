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
    ArrayList<String> airports = db.getAllAirportCodes();
    ArrayList<String> airplaneIDs;
    ArrayList<String> aircraftTypes = db.selectArrayList("plane_name", "aircraft_type");
    String flightNumber = null;
    int airplaneID = 0;
    String originCode = null;
    String destinationCode = null;
    String departureDate = null;
    String arrivalDate = null;
    String departureTime = null;
    String arrivalTime = null;
    int duration = 0;
    double priceEconomy = 0.0;
    double priceFirstClass = 0.0;
    int firstClassSeatsRemaining = 0;
    int economySeatsRemaining = 0;
    String aircraftType = null;
    
    
    if (request.getParameter("aircraft_type") != null) {
        aircraftType = request.getParameter("aircraft_type");
        String aircraft_type_id = db.selectString("id", "aircraft_type", "plane_name", aircraftType);
        airplaneIDs = db.selectArrayList("id", "airplane", "aircraft_type_id", aircraft_type_id);
        
        firstClassSeatsRemaining = Integer.parseInt(db.selectString("capacity_first_class", "aircraft_type", "plane_name", aircraftType));
        economySeatsRemaining = Integer.parseInt(db.selectString("capacity_economy", "aircraft_type", "plane_name", aircraftType));
    } else {
        airplaneIDs = db.getAllAirplaneIDs();
    }
    
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
    if (request.getParameter("departureDate") != null) {
        departureDate = request.getParameter("departureDate").toString();
        

        //If browser does not support HTML's date type, format the date string correctly
        if (!departureDate.matches("^(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$")) {

            String[] departureDateSplit = departureDate.split("/");
            String month = departureDateSplit[0];
            String day = departureDateSplit[1];
            String year = departureDateSplit[2];

            departureDate = year + "-" + month + "-" + day;
        }
    }
    if (request.getParameter("arrivalDate") != null) {
        arrivalDate = request.getParameter("arrivalDate").toString();
        

        //If browser does not support HTML's date type, format the date string correctly
        if (!arrivalDate.matches("^(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$")) {

            String[] arrivalDateSplit = arrivalDate.split("/");
            String month = arrivalDateSplit[0];
            String day = arrivalDateSplit[1];
            String year = arrivalDateSplit[2];

            arrivalDate = year + "-" + month + "-" + day;
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
    
    
    if(flightNumber != null && airplaneID != 0 && originCode != null && destinationCode != null && departureDate != null && arrivalDate != null && departureTime != null 
            && arrivalTime != null && duration != 0 && priceEconomy != 0.0 && priceFirstClass != 0.0 && firstClassSeatsRemaining != 0 && economySeatsRemaining != 0)
    {
        db.addFlightToDatabase(flightNumber,airplaneID,originCode,destinationCode,departureDate,arrivalDate,departureTime,arrivalTime,duration,priceEconomy,priceFirstClass,firstClassSeatsRemaining,economySeatsRemaining);
    }
    
    ArrayList<HashMap<String, String>> flightData = db.getAllFlightData();

    int flightID = db.findFlightID("AA112");
        session.setAttribute("flightID",db.selectString("id","flight","num","AA112"));
        session.setAttribute("flightNumber",db.selectString("num","flight","id",Integer.toString(flightID)));
        session.setAttribute("airplaneID",db.selectString("airplane_id","flight","id",Integer.toString(flightID)));
        session.setAttribute("originCode",db.selectString("origin_code","flight","id",Integer.toString(flightID)));
        session.setAttribute("destinationCode",db.selectString("destination_code","flight","id",Integer.toString(flightID)));
        session.setAttribute("flightDate",db.selectString("departure_date","flight","id",Integer.toString(flightID)));
        session.setAttribute("departureTime",db.selectString("departure_time","flight","id",Integer.toString(flightID)));
        session.setAttribute("arrivalTime", db.selectString("arrival_time","flight","id",Integer.toString(flightID)));
        session.setAttribute("duration",db.selectString("duration","flight","id",Integer.toString(flightID)));
        session.setAttribute("priceEconomy",db.selectString("price_economy","flight","id",Integer.toString(flightID)));
        session.setAttribute("priceFirstClass",db.selectString("price_first_class","flight","id",Integer.toString(flightID)));
        session.setAttribute("firstClassSeatsRemaining",db.selectString("first_class_remaining","flight","id",Integer.toString(flightID)));
        session.setAttribute("economySeatsRemaining",db.selectString("economy_remaining","flight","id",Integer.toString(flightID)));
    //close database connection
    db.closeConnection();
%>
<script type="text/javascript">
    function update(flightNumb)
    {
        //Database db = new Database();
        
    }
</script>
<script type="text/javascript">   
    function autoPopulateFirstClassCapacity()
    {
        var airplaneID = document.getElementsByName('airplaneID').value;
        
        var aircraftTypeID = db.getAircraftTypeID(airplaneID);
        
        var firstClassCapacity = db.getFirstClassCapacity(aircraftTypeID);
        
        document.getElementsByName('firstClassSeatsRemaining').value = firstClassCapacity;
        
    }
</script>
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
            
            <h1>Admin Flights Page</h1><br>
            <h2>Add New Flight</h2><br>
            <form action="adminFlights.jsp" method="post">
                <label for="airplaneID">Aircraft Type:</label>
                <select name="aircraft_type">
                    <% for(String type : aircraftTypes){ %>
                    <option value="<%=type%>"><%=type%></option>
                    <% } %>
                </select>    
                <input type="submit" value="Update Form"> <br>
            </form>
            <form action="adminFlights.jsp" method="post"><br>
                
                <label for="flightNumber">Flight Number:</label> 
            <input type="text" name="flightNumber" required><br>
            <label for="airplaneID">Airplane ID:</label>
            <select name="airplaneID">
                    <option value="null">------</option>
                    <%
                        for(String ids : airplaneIDs){      
                    %>
                    <option value="<%=ids%>"><%=ids%></option>     
                    
                    <% } %>                  
                </select>    
                <br> 
            <label for="origin">Origin:</label>
                <select name="originCode">
                    <option value="null">------</option>
                    <%
                        for(String airport : airports){      
                    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>    
                <br> 
                <label for="destinationCode">Destination:</label>
                <select name="destinationCode">
                    <option value="null">------</option>
                    <%
                        for(String airport : airports){      
                    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>  
                <br>
            Departure Date(mm/dd/yyyy):
            <input type="date" name="departureDate" required><br>
            Arrival Date(mm/dd/yyyy):
            <input type="date" name="arrivalDate" required><br>
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
            <input type="number" name="firstClassSeatsRemaining" value=<%=firstClassSeatsRemaining%> required><br>
            Economy Seats Remaining:
            <input type="number" name="economySeatsRemaining" value=<%=economySeatsRemaining%> required><br>
            
            <input type="submit" value="Add Flight"><br>
            <a href="modifyFlight.jsp">Modify Flight</a><br>
            </form>
            
            <form action="addRecurringFlight.jsp" method="post">
                <div class="search-button">
                    <button type="submit" value="Submit">Add Recurring Flight</button>
                </div>
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
                        <th>Departure Date</th>
                        <th>Arrival Date</th>
                        <th>Departure Time</th>
                        <th>Arrival Time</th>
                        <th>Duration</th>
                        <th>Price Economy</th>
                        <th>Price First Class</th>
                        <th>First Class Seats Remaining</th>
                        <th>Economy Seats Remaining</th>
                        <th></th>
                    </tr>

                    <!- Loop through each employee record and output each field in correct able column ->
                    <% for (HashMap<String, String> record : flightData) {%>
                    <tr>
                        <td><%= record.get("num")%></td>
                        <td><select name="airplaneID">
                        <option value="<%= record.get("airplane_id")%>"><%= record.get("airplane_id")%></option>
                        <%
                            for(String ids : airplaneIDs){      
                        %>
                            <option value="<%=ids%>"><%=ids%></option>     
                    
                        <% } %>                  
                    </select> </td>
                        <td><select name="originCode">
                        <option value="<%= record.get("origin_code")%>"><%= record.get("origin_code")%></option>
                        <%
                            for(String airport : airports){      
                        %>
                        <option value="<%=airport%>"><%=airport%></option>     

                        <% } %>                  
                        </select></td>
                        <td><select name="destinationCode">
                        <option value="<%= record.get("destination_code")%>"><%= record.get("destination_code")%></option>
                        <%
                            for(String airport : airports){      
                        %>
                        <option value="<%=airport%>"><%=airport%></option>     

                        <% } %>           
                        </select></td>
                        <td><input type="date" value="<%= record.get("departure_date")%>"></td>
                        <td><input type="date" value="<%=record.get("arrival_date")%>"></td>
                        <td><input type="time" value="<%= record.get("departure_time")%>"></td>
                        <td><input type="time" value="<%= record.get("arrival_time")%>"></td>
                        <td><input type="number" value="<%= record.get("duration")%>"></td>
                        <td><input type="number" value="<%= record.get("price_economy")%>"></td>
                        <td><input type="number" value="<%= record.get("price_first_class")%>"></td>
                        <td><input type="number" value="<%= record.get("first_class_remaining")%>"></td>
                        <td><input type="number" value="<%= record.get("economy_remaining")%>"></td>
                        <td><input type="button" value="Update"></td>
                    </tr>

                    <% }%>

                </table>

            </div>
        
        <% } %>

    </body>
</html>
