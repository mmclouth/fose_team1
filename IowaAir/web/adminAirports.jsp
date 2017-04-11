<%-- 
    Document   : adminAirports
    Created on : Feb 16, 2017, 9:39:40 PM
    Author     : kenziemclouth
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%@page import="java.util.HashMap"%>
<%
    Database db = new Database();
    
    String code = null, city = null, state = null, country = null, timeZone = null;

    //Retrieve parameters from request if they have been sent from previous page
    if (request.getParameter("airportCode") != null) {
        code = request.getParameter("airportCode");
    }
    if (request.getParameter("city") != null) {
        city = request.getParameter("city");
    }
    if (request.getParameter("state") != null) {
        state = request.getParameter("state");
    }
    if (request.getParameter("country") != null) {
        country = request.getParameter("country");
    }
    if (request.getParameter("timeZone") != null) {
        timeZone = request.getParameter("timeZone");
    }

    if (code != null && city != null && state != null && country != null && timeZone != null) {

        db.addAirportToDatabase(code,city,state,country,10,timeZone);
    }
    
    ArrayList<HashMap<String, String>> airportData = db.getAllAirportData();

    //close database connection
    db.closeConnection();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Admin Airports</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Catamaran" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>

        <% if (session.getAttribute("userID") == null) { %>

        <div class="title-top">
            <a class="title" href="index.html"><h1>Iowa Air</h1></a>
            <a class="links" href="logIn.jsp" ><h2>Log In</h2></a>
            <h3>|</h3>
            <a class="links" href="signUp.jsp" ><h2>Sign Up</h2></a>
        </div>

        <% } else {%>

        <div class="title-top">
            <a class="title" href="<%= session.getAttribute("homePage")%>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName")%>'s Profile</h4></a>
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
                <li><a href="adminFlights.jsp">Flights</a></li>
                <li><a href="adminAirplanes.jsp">Airplanes</a></li>
                <li><a class="active" href="adminAirports.jsp">Airports</a></li>
                <li><a href="adminEmployees.jsp">Employees</a></li>
            </ul>  
        </div>

        <div class="middle">
            <h1>Admin Airports</h1>
            <form action="adminAirports.jsp" method="post">
                <h2> Add New Airport</h2>
                Airport Code:
                <input type="text" name="airportCode" required><br>
                City:
                <input type="text" name="city" required><br>
                State:
                <input type="text" name="state" required><br>
                Country
                <input type="text" name="country" required><br>
                TimeZone
                <input type="text" name="timeZone" required><br>
                <input type="submit" value="Add Airport"><br>
                <a href="deleteAirport.jsp">Delete Airport</a><br>
            </form>
        </div>
        
        <div class="employee-table">

                <h2>Current Flights</h2>

                <table>
                    <tr>
                        <th>Code</th>
                        <th>City</th>
                        <th>State</th>
                        <th>Country</th>
                        <th>Time Zone</th>
                    </tr>

                    <!- Loop through each employee record and output each field in correct able column ->
                    <% for (HashMap<String, String> record : airportData) {%>
                    <tr>
                        <td><%= record.get("code")%></td>
                        <td><%= record.get("city")%></td>
                        <td><%= record.get("sstate")%></td>
                        <td><%= record.get("country")%></td>
                        <td><%= record.get("timezone")%></td>
                    </tr>

                    <% }%>

                </table>

            </div>

        <% }%>



    </body>
</html>
