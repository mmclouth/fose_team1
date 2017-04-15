<%-- 
    Document   : bookingResults
    Created on : Apr 15, 2017, 6:19:27 PM
    Author     : kenziemclouth
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%
    Database db = new Database();
    
    String searchCriteria = "";

    if(request.getParameter("booking_id") != null){
        searchCriteria = request.getParameter("booking_id");
    }
    
    ArrayList<HashMap<String,String>> searchResults = db.getBookingSearchResults(searchCriteria);
    db.closeConnection();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Employee Booking Results</title>
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
        
        <% if(session.getAttribute("user_type") == null || !session.getAttribute("user_type").equals("employee")){ %>
        
        <div class="middle">
            <h2 class="failure">You do not have permission to view this page.  Sign in as employee to view.</h2>
        </div>
        
        <% } else { %>

        <div class="middle">
            <h1>Employee Home</h1>
        </div>
        
        <% } %>
        
        <table>
            <tr>
                <th>Booking ID</th>
                <th># of Passengers</th>
                <th>Date Booked</th>
            </tr>
            
            <% for(int i=0 ; i<searchResults.size() ; i++) { %>
            <tr>
                <td><%=searchResults.get(i).get("id") %></td>
                <td><%=searchResults.get(i).get("passengers") %></td>
                <td><%=searchResults.get(i).get("booked_on") %></td>
            </tr>
            <% } %>
        </table>
        
    </body>
</html>
