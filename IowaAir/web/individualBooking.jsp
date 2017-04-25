<%-- 
    Document   : individualBooking
    Created on : Apr 17, 2017, 5:00:51 PM
    Author     : kenziemclouth
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%
    Database db = new Database();
    
    
    String booking_id = null, boardingPassID = null, cancelBoardingPassID=null;
    
    if(request.getParameter("booking_id") != null){
        session.setAttribute("booking_id", request.getParameter("booking_id"));
        
        
    }
    
    if(request.getParameter("checkInPassenger") != null){
        boardingPassID = request.getParameter("checkInPassenger");
        
        db.updateField("checked_in", "boarding_pass", "1", "id", boardingPassID);
    }
    
    if(request.getParameter("cancelBoardingPass") != null){
        cancelBoardingPassID = request.getParameter("cancelBoardingPass");
        
        db.deleteBoardingPass(cancelBoardingPassID);
    }
    
    booking_id = (String) session.getAttribute("booking_id");

    
    ArrayList<String> boardingPassIDs = db.selectArrayList("boarding_pass_id", "booking_has_boarding_pass", "booking_id", booking_id);
    
    ArrayList<HashMap<String,String>> boardingPassData = new ArrayList<HashMap<String,String>>();
    HashMap<String,String> data;
    
    for(String id : boardingPassIDs){
        data = new HashMap<String,String>();
        
        data.put("id", id);
        data.put("passenger_name", db.selectString("passenger_name", "boarding_pass", "id", id));
        data.put("flight_id", db.selectString("flight_id", "boarding_pass", "id", id));
        
        data.put("flight_num", db.selectString("num", "flight", "id", data.get("flight_id")));
        data.put("origin_code", db.selectString("origin_code", "flight", "id", data.get("flight_id")));
        data.put("destination_code", db.selectString("destination_code", "flight", "id", data.get("flight_id")));
        data.put("departure_date", db.selectString("departure_date", "flight", "id", data.get("flight_id")));
        data.put("departure_time", db.selectString("departure_time", "flight", "id", data.get("flight_id")));
        
        
        data.put("class", db.selectString("clas", "boarding_pass", "id", id));
        data.put("seat_num", db.selectString("seat_num", "boarding_pass", "id", id));
        
        if(db.selectString("checked_in", "boarding_pass", "id", id).equals("1")){
            data.put("checked_in", "yes");
        } else {
            data.put("checked_in", "no");
        }
        
        
        
        
        boardingPassData.add(data);
    }
    
    db.closeConnection();
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Individual Booking</title>
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
            <h1>Booking: <%=booking_id%></h1>
        </div>
        
        <% } %>

        
        <table>
            <tr>
                <th>Boarding Pass ID</th>
                <th>Passenger Name</th>
                <th>Flight Num</th>
                <th>Origin</th>
                <th>Destination</th>
                <th>Departure Date</th>
                <th>Time</th>
                <th>Class</th>
                <th>Seat Num</th>
                <th>Checked in?</th>
                <th> </th>
                <th> </th>
            </tr>
            
            <% for(int i=0 ; i<boardingPassData.size() ; i++){ %>
            <tr>
                <td><%=boardingPassData.get(i).get("id") %></td>
                <td><%=boardingPassData.get(i).get("passenger_name") %></td>
                <td><%=boardingPassData.get(i).get("flight_num") %></td>
                <td><%=boardingPassData.get(i).get("origin_code") %></td>
                <td><%=boardingPassData.get(i).get("destination_code") %></td>
                <td><%=boardingPassData.get(i).get("departure_date") %></td>
                <td><%=boardingPassData.get(i).get("departure_time") %></td>
                <td><%=boardingPassData.get(i).get("class") %></td>
                <td><%=boardingPassData.get(i).get("seat_num") %></td>
                <td><%=boardingPassData.get(i).get("checked_in") %></td>
                
            
                <% if(boardingPassData.get(i).get("checked_in").equals("no")){ %>
                <td><form action="individualBooking.jsp" method="POST">
                    <input type="hidden" name="checkInPassenger" value="<%=boardingPassData.get(i).get("id")%>">
                    <input type="submit" value="Check in Passenger"></form>
                </td>
                <% } else { %>
                <td>      </td>
                
                <% } %>
                <td><form action="individualBooking.jsp" method="POST">
                    <input type="hidden" name="cancelBoardingPass" value="<%=boardingPassData.get(i).get("id")%>">
                    <input type="submit" value="Cancel Booking"></form>
                </td>
            
            </tr>
            <% } %>
        </table>

    </body>
</html>
