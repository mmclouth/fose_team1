<%-- 
    Document   : modifyFlight
    Created on : Mar 24, 2017, 9:18:36 PM
    Author     : Nickolas
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
        

        <div class="middle">
            
            <h1>Modify Flight Page</h1>
            <form action="adminFlights.jsp" method="post"><br>
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
            Price:
            <input type="number" step="0.01" name="price" required><br>
            
            <input type="submit" value="Modify Flight"><br>
            </form>

            </div>
        
        <% } %>

    </body>
</html>
