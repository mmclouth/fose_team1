<%-- 
    Document   : userFlightHistory
    Created on : Feb 16, 2017, 9:10:34 PM
    Author     : kenziemclouth
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%
    Database db = new Database();
    //get flight data and display
    Integer userID = null;
    if(session.getAttribute("userID") != null) {
        userID = (Integer)session.getAttribute("userID");
    }
    ArrayList<HashMap<String,String>> boardingPasses = db.getBoardingPassesForUser(Integer.toString(userID));
    HashMap<String, String> info;
    
    ArrayList<HashMap<String, String>> flightInfo = new ArrayList<HashMap<String, String>>();
    for(HashMap<String, String> map : boardingPasses) {
        String flightID = map.get("flight_id");
        
        info = db.getHashMapForFLight(flightID);
        info.put("boarding_pass_id", map.get("id"));
        
        flightInfo.add(info);
    }
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
                <li><a class="active" href="userFlightHistory.jsp">My Flight History</a></li>
                <li><a href="changePassword.jsp">Change My Password</a></li>
            </ul>  
        </div>

        <div class="middle">
            <h1>User Flight History Page</h1>
            <% if(session.getAttribute("booked") != null) { %>
                <h2>Flight Successfully Booked!</h2>
                <% session.removeAttribute("booked");       
            } %>
            
            <% for(HashMap<String, String> maps : flightInfo) { %>
            <h3>
                Flight Number: <%= maps.get("num") %><br>
            </h3>
                    <div class="confirmBooking">
                        <form action="/IowaAir/viewBoardingPass.jsp" method="POST">
                            <input type="hidden" name="boardingPassID" value="<%= maps.get("boarding_pass_id")%>">
                            <input type="submit" value="View Boarding Pass" id="submit">
                        </form>
                    
                    <table>
                        <tr>
                            <td>Departure Date: <%= maps.get("departure_date") %></td>
                            <td>Departure Time: <%= maps.get("departure_time") %></td>
                            <td>Departure City: <%= maps.get("origin_code") %></td>
                        </tr>
                        <tr>
                            <td>Arrival Date: <%= maps.get("arrival_date") %></td>
                            <td>Arrival Time: <%= maps.get("arrival_time") %></td>
                            <td>Arrival City: <%= maps.get("origin_code") %></td>
                        </tr>
                        <tr>
                            <td>Duration: <%= maps.get("duration") %> minutes</td>
                            <td>Price First Class: $<%= maps.get("price_first_class") %></td>
                            <td>Price Economy: $<%= maps.get("price_economy") %></td>
                        </tr>    
                    </table>   
                        
                       <br>
                       
                    </div>
                    <div class="clear"></div> 
            <% } %>
                   
            
        </div>

    </body>
</html>
