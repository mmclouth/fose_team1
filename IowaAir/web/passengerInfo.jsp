<%-- 
    Document   : passengerInfo
    Created on : Apr 19, 2017, 4:09:40 PM
    Author     : kenziemclouth
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="dbResources.Database"%>
<%
    Database db = new Database();
    String errorMessage = null;
    
    //Handle all the variables passed from previous page and store as session variables
    Map<String,String[]> parameters = request.getParameterMap();
    if(parameters.get("numSeats") != null) {
        session.setAttribute("numSeats", parameters.get("numSeats"));
    }
    
    if(session.getAttribute("userID") != null) {
        //userID = (Integer)session.getAttribute("userID");
        //session.setAttribute("userID", parameters.get("userID"));
    }
    
    if(parameters.get("type_of_tickets") != null) {
        //ticketType = request.getParameter("type_of_tickets");
        session.setAttribute("type_of_tickets", parameters.get("type_of_tickets"));
    }
    
    if(parameters.get("flight_ids") != null) {
        //flightIDs = parameters.get("flight_ids");
        session.setAttribute("flight_ids", parameters.get("flight_ids"));
    }
    //Retrieve parameters from request if they have been sent from previous page
    if (request.getParameter("price") != null) {
        //price = request.getParameter("price");
        session.setAttribute("price", parameters.get("price"));
        
    }
    
    int numPassengers = (Integer) session.getAttribute("num_of_passengers");


    ArrayList<String> firstNames = new ArrayList<String>();
    ArrayList<String> lastNames = new ArrayList<String>();
    ArrayList<String> seatNums = new ArrayList<String>();
    ArrayList<String> luggageCounts = new ArrayList<String>();
    
    boolean flag1 = false, flag2 = false, flag3 = false, flag4=false;
    
    if(request.getParameter("submitted") != null && request.getParameter("submitted").equals("true")){
    
        for(String key : parameters.keySet()){
            if(key.startsWith("firstName")){
                if(request.getParameter(key) !=null){
                    firstNames.add(request.getParameter(key));
                } else {
                    flag1 = true;
                }    
            }
            if(key.startsWith("lastName")){
                if(request.getParameter(key) !=null){
                    lastNames.add(request.getParameter(key));
                } else {
                    flag2 = true;
                }  
            }
            if(key.startsWith("seat")){
                if(request.getParameter(key) !=null){
                    seatNums.add(request.getParameter(key));
                } else {
                    flag3 = true;
                }  
            }
            if(key.startsWith("luggage")){
                if(request.getParameter(key) !=null){
                    luggageCounts.add(request.getParameter(key));
                } else {
                    flag4 = true;
                }  
            }
        }
        
        if(flag1 || flag2 || flag3 || flag4){
            
            if(flag1){
                errorMessage = errorMessage + "Please fill out all first name fields. \n";
            } 
            if(flag2){
                errorMessage = errorMessage + "Please fill out all last name fields. \n";
            }
            if(flag3){
                errorMessage = errorMessage + "Please fill out all Seat fields. \n";
            }
            if(flag4){
                errorMessage = errorMessage + "Please fill out all luggage count fields. \n";
            }
            
        } else {
            session.setAttribute("firstNames", firstNames);
            session.setAttribute("lastNames", lastNames);
            session.setAttribute("seatNums", seatNums);
            session.setAttribute("luggageCounts", luggageCounts);
            
            response.sendRedirect("/IowaAir/purchaseFlight.jsp");
            return;
        }
        

    }

    db.closeConnection();
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Purchase Flight</title>
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
        
        <div class="middle">
            In order to purchase your flight, you must be signed into your account.
            Please click here to
            <a class="links" href="signUp.jsp" >sign up</a> or 
            <a class="links" href="logIn.jsp" >log in.</a> 
        </div>
        
        <% } else { %>
        
        <div class="title-top">

            <% if (session.getAttribute("validation_status") != null && session.getAttribute("validation_status").equals("0")) { %>
            <div class="validate_account_bar">
                <h10>  You have not validated your account yet.  <a href="signUpConfirmation.jsp">Click here</a> to enter your confirmation code.</h10>
            </div>
            <% }%>

            <a class="title" href="<%= session.getAttribute("homePage")%>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName")%>'s Profile</h4></a>
        </div>
        
        <% if (errorMessage != null) {%>

            <h2 class="failure"><%= errorMessage%></h2> <br>

        <% }%>
        
        <div class="middle">
            <form action="passengerInfo.jsp" method="post">
                <% for(int i=0 ; i<numPassengers ; i++){ %>
                <h1>Passenger <%=i+1%> Info</h1>
                First Name:
                <input type="text" name ="firstName<%=i%>">
                
                Last Name:
                <input type="text" name ="lastName<%=i%>">
                <br>
                Seat:
                <select name ="seat<%=i%>">
                    <option value="1A">1A</option>
                    <option value="2A">2A</option>
                    <option value="3A">3A</option>
                    <option value="1B">1B</option>
                </select>
                <br>
                Luggage Count:
                <input type="number" name ="luggage<%=i%>">
                <% } %>
                <input type="hidden" name="submitted" value="true">
                <input type="submit" value="Continue"><br>
            </form>
                
        </div>
        <% } %>
    </body>
</html>
