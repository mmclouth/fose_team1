<%-- 
    Document   : searchResultsMultiCity
    Created on : Apr 6, 2017, 12:26:19 PM
    Author     : kenziemclouth
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%

    ArrayList<String> origins = new ArrayList<String>();
    ArrayList<String> destinations = new ArrayList<String>();
    ArrayList<String> dates = new ArrayList<String>();
    
    int numOfPassengers = 1;
    int numberOfFlights = 0;
    
    Map<String, String[]> parameters = request.getParameterMap();
    
    for(String parameterName : parameters.keySet()){
        //add flight_id parameter names to list
        if(parameterName.startsWith("multiFlightOrigin")){
            if(request.getParameter(parameterName) != null  && !request.getParameter(parameterName).equals("null")){
                origins.add(request.getParameter(parameterName));
            }
        }
        
        if(parameterName.startsWith("multiFlightDestination")){
            if(request.getParameter(parameterName) != null && !request.getParameter(parameterName).equals("null")){
                destinations.add(request.getParameter(parameterName));
            }
        }
                
        if(parameterName.startsWith("multiFlightDepart")){
            if(request.getParameter(parameterName) != null && !request.getParameter(parameterName).equals("null")){
                dates.add(request.getParameter(parameterName));
            }
        }
    }
    
    if(request.getParameter("num_of_passengers") != null){
        numOfPassengers = Integer.parseInt(request.getParameter("num_of_passengers"));
    }
    
    numberOfFlights = origins.size();
    



%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Search Results</title>
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
        
        <% if (session.getAttribute("validation_status") != null && session.getAttribute("validation_status").equals("0")) { %>
            <div class="validate_account_bar">
                <h10>  You have not validated your account yet.  <a href="signUpConfirmation.jsp">Click here</a> to enter your confirmation code.</h10>
            </div>
        <% } %>
        
        <div class="title-top">
            <a class="title" href="<%= session.getAttribute("homePage") %>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName") %>'s Profile</h4></a>
        </div>
        
        <% } %>
        
        <div class="middle">
            
            <h1>Number of Passengers: <%=numOfPassengers %></h1>
            
            <% for(int i=0 ; i<origins.size() ; i++){  %>
             
            <h1><%=origins.get(i) %></h1>
            <h1><%= destinations.get(i)%></h1>
            <h1><%= dates.get(i)%></h1>
            <br><br>
            
            <% } %>
        </div>

    </body>
</html>
