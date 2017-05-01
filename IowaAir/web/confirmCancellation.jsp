<%-- 
    Document   : confirmCancellation
    Created on : Apr 30, 2017, 9:22:34 PM
    Author     : Kyle Anderson
--%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="dbResources.Database.User_Types"%>
<%@page import="dbResources.SendMail"%>
<%@page import="dbResources.MD5Hashing"%>
<%@page import="dbResources.LoginValidation"%>
<%@page import="dbResources.Database"%>
<%
    Database db = new Database();
    boolean success = false;
    
    String bookingID = null, boardingPassID = null, flightNum;
    String flightID;
    boolean singlePass = false;
    ArrayList<String> boardingPassIDs = new ArrayList<String>();
    ArrayList<HashMap<String,String>> boardingPassesInfo = new ArrayList<HashMap<String,String>>();
    HashMap<String, String> info;
    
    //public ArrayList<HashMap<String, String>> getBoardingPassesForUser(String userID) {
    
    if(request.getParameter("boardingPassID") != null){
        boardingPassID = request.getParameter("boardingPassID");
        singlePass = true;
    }
    
    if(request.getParameter("bookingID") != null){
        bookingID = request.getParameter("bookingID");
    }
    
    if(bookingID != null) {
        boardingPassIDs = db.selectArrayList("boarding_pass_id", "booking_has_boarding_pass", "booking_id", bookingID);
        for(String passID : boardingPassIDs) {
            db.deleteBoardingPass(passID);
        }
        success = true;
    }
    
    db.closeConnection();
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Flight Cancellation</title>
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

        <% }%>

        <div class="user-toolbar">
            <ul>
                <li><a href="userFlightHistory.jsp">My Flight History</a></li>
                <li><a class="active" href="userBookingHistory.jsp">My Booking History</a></li>
                <li><a href="changePassword.jsp">Change My Password</a></li>
            </ul>  
        </div>

        <div class="middle">
            <h1>Flight Cancellation</h1>
            <% if(success) { %>
            <h4>Your flight has been canceled.</h4>
            <% } else { %>
            <h4>Not successful.</h4>
            <% } %>
            
        </div>
        <div class="clear"></div> 
    </body>
</html>


