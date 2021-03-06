<%-- 
    Document   : deleteFlight
    Created on : Mar 27, 2017, 2:32:19 PM
    Author     : Nickolas
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%
    
    Database db = new Database();
    ArrayList<String> flightNumbers = db.getAllFlightNumbers();
    String flightNumber = null;
    
    
    //Retrieve parameters from request if they have been sent from previous page
    if (request.getParameter("flightNum") != null) {
        flightNumber = request.getParameter("flightNum");
    }
    
    if(flightNumber != null)
    {
        int flightID = db.findFlightID(flightNumber);
        db.deleteFlight(flightID);
        response.sendRedirect("/IowaAir/adminFlights.jsp");
    }
    //close database connection
    db.closeConnection();
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Delete Flight</title>
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
            
            <h1>Delete Flight Page</h1>

            <form action="deleteFlight.jsp" method="post"><br>
                Enter the flight number of the flight that you would like to delete.<br> 
            <label for="flightNum">Flight Number:</label>
                <select name="flightNum" id="flightNumID" required>
                    <option value="null">-----</option>
                    <%
                        for(String num : flightNumbers){      
                    %>
                    <option value="<%=num%>"><%=num%></option>     
                    
                    <% } %>                  
                </select>    
                <br>
            
            <input type="submit" value="Delete Flight"><br>
            <a href="adminFlights.jsp">Go back</a><br>
            </form>

            </div>
        
        <% } %>

    </body>
</html>
