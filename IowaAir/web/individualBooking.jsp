<%-- 
    Document   : individualBooking
    Created on : Apr 17, 2017, 5:00:51 PM
    Author     : kenziemclouth
--%>
<%

    String booking_id = null;
    
    if(request.getParameter("booking_id") != null){
        booking_id = request.getParameter("booking_id");
    }

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Employee Home</title>
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
        
        
        <div class="admin-toolbar">
            <ul>
                <li><a href="employeeLanding.jsp">Search for Booking</a></li>
                <li><a href="employeeFlightSearch.jsp">Search for Flight</a></li>
            </ul>  
        </div>
        
        <% if(session.getAttribute("user_type") == null || !session.getAttribute("user_type").equals("employee")){ %>
        
        <div class="middle">
            <h2 class="failure">You do not have permission to view this page.  Sign in as admin to view.</h2>
        </div>
        
        <% } else { %>

        <div class="middle">
            <h1>Employee Home</h1>
        </div>
        
        <% } %>
        
        <h1><%=booking_id%></h1>

    </body>
</html>
