<%-- 
    Document   : adminFlights
    Created on : Feb 16, 2017, 9:39:08 PM
    Author     : kenziemclouth
--%>

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
            Departure Time:
            <input type="text" name="departureTime" required><br>
            Arrival Time:
            <input type="text" name="=arrivalTime" required><br>
            Price:
            <input type="text" name="price" required><br>
            
            <input type="submit" value="Add Flight"><br>
            
        </div>
        
        <% } %>

    </body>
</html>
