<%-- 
    Document   : adminAirplanes
    Created on : Feb 16, 2017, 9:39:31 PM
    Author     : kenziemclouth
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Admin Airplanes</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Catamaran" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        
        <div class="title-top">
            <a class="title" href="index.html"><h1>Iowa Air</h1></a>
            <a class="links" href="logIn.jsp" ><h2>Log In</h2></a>
            <h3>|</h3>
            <a class="links" href="signUp.jsp" ><h2>Sign Up</h2></a>
        </div>
        
        <div class="admin-toolbar">
            <ul>
                <li><a href="adminLanding.jsp">Home</a></li>
                <li><a href="adminFlights.jsp">Flights</a></li>
                <li><a class="active" href="adminAirplanes.jsp">Airplanes</a></li>
                <li><a href="adminAirports.jsp">Airports</a></li>
                <li><a href="adminEmployees.jsp">Employees</a></li>
            </ul>  
        </div>

        <div class="middle">
            <h1>Admin Airplanes</h1>
        </div>

    </body>
</html>
