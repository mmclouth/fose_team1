<%-- 
    Document   : userBookingHistory
    Created on : Apr 29, 2017, 3:15:53 PM
    Author     : kenziemclouth
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%
  
    Database db = new Database();
    String userID=null;
    ArrayList<String> boardingPassIDs;
    ArrayList<String> bookingIDs = new ArrayList<String>();
    ArrayList<HashMap<String,String>> bookingInfo = new ArrayList<HashMap<String,String>>();
    HashMap<String,String> info;

    if (session.getAttribute("userID") != null) {
        userID = Integer.toString((Integer) session.getAttribute("userID"));
    }
    
    boardingPassIDs = db.selectArrayList("id", "boarding_pass", "userr_id", userID);
    
    for(String id : boardingPassIDs){
        
        String bookingID = db.selectString("booking_id", "booking_has_boarding_pass", "boarding_pass_id", id);
        
        if(!bookingIDs.contains(bookingID)){
            bookingIDs.add(bookingID);
            
            info = new HashMap<String,String>();
            
            info.put("id", bookingID);
            info.put("booked_on", db.selectString("booked_on", "booking", "id", bookingID));
            info.put("passengers", db.selectString("passengers", "booking", "id", bookingID));
            info.put("number_of_boarding_passes", Integer.toString(db.getNumberOfBoardingPassesInBooking(bookingID)));
            info.put("number_of_flights", Integer.toString(db.getNumberOfFlightsInBooking(bookingID)));
            
            bookingInfo.add(info);
        }
        
    }
    
    

    db.closeConnection();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Flight History</title>
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
            <h1>User Booking History Page</h1>
            <div class="employee-table">
            <table>
                    <tr>
                        <th>Booking ID</th>
                        <th>Booked On</th>
                        <th>No. of Passengers</th>
                        <th>No. of Boarding Passes</th>
                        <th>No. of Flights</th>
 
                        <th>     </th>
                    </tr>

                    
                    <% for (HashMap<String, String> record : bookingInfo) {%>
                    <tr>
                        <td><%= record.get("id")%></td>
                        <td><%= record.get("booked_on")%></td>
                        <td><%= record.get("passengers")%></td>
                        <td><%= record.get("number_of_boarding_passes")%></td>
                        <td><%= record.get("number_of_flights")%></td>
                        
                        <td> 
                            <form action="viewBoardingPass.jsp" method="POST">
                                <input type="hidden" name="bookingID" value="<%= record.get("id")%>">
                                <input id="view-boarding-pass" type="submit" value="View Boarding Passes">
                            </form>
                        
                        </td>
                    </tr>
                    <% }%>

                </table>

            </div>        
            
                   
            
        </div>
        <div class="clear"></div> 
    </body>
</html>

