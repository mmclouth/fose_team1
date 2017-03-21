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
            <input type="text" name="departureTime" required><br>
            Arrival Time:
            <input type="text" name="=arrivalTime" required><br>
            Price:
            <input type="number" name="price" required><br>
            
            <input type="submit" value="Add Flight"><br>
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
                        <th>Price</th>
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
                        <td><%= record.get("price")%></td>
                    </tr>

                    <% }%>

                </table>

            </div>
        
        <% } %>

    </body>
</html>
