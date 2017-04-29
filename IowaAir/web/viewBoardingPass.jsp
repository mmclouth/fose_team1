<%-- 
    Document   : viewBoardingPass
    Created on : Apr 29, 2017, 12:17:47 PM
    Author     : kenziemclouth
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
    
    String bookingID = null, boardingPassID = null, flightNum;
    String flightID;
    boolean singlePass = false;
    ArrayList<String> boardingPassIDs = new ArrayList<String>();
    ArrayList<HashMap<String,String>> boardingPassesInfo = new ArrayList<HashMap<String,String>>();
    HashMap<String, String> info;
    
    if(request.getParameter("boardingPassID") != null){
        boardingPassID = request.getParameter("boardingPassID");
        singlePass = true;
    }
    
    if(request.getParameter("bookingID") != null){
        bookingID = request.getParameter("bookingID");
    }
    
    if(!singlePass){
        boardingPassIDs = db.selectArrayList("boarding_pass_id", "booking_has_boarding_pass", "booking_id", bookingID);
    } else {
        boardingPassIDs.add(boardingPassID);
    }
    
    for(String id : boardingPassIDs){
        
        info = new HashMap<String,String>();
        
        info.put("id", id);
        
        flightID = db.selectString("flight_id", "boarding_pass", "id", id);
        
        info.put("flight_num", db.selectString("num", "flight", "id", flightID));
        info.put("flight_date", db.selectString("departure_date", "flight", "id", flightID));
        info.put("origin", db.selectString("origin_code", "flight", "id", flightID));
        info.put("destination", db.selectString("destination_code", "flight", "id", flightID));
        info.put("departure_time", db.selectString("departure_time", "flight", "id", flightID));
        
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        Date date = sdf.parse(info.get("departure_time"));
        Calendar cal = Calendar.getInstance();
        // remove next line if you're always using the current time.
        cal.setTime(date);
        cal.add(Calendar.MINUTE, -45);
        date = cal.getTime();
        
        String formattedDate = date.toString().substring(0,date.toString().length()-10);
        formattedDate = formattedDate.substring(10);
        
        info.put("boarding_time", formattedDate);
        
        
        info.put("arrival_time", db.selectString("arrival_time", "flight", "id", flightID));     
        
        info.put("passenger_name", db.selectString("passenger_name", "boarding_pass", "id", id));
        info.put("clas", db.selectString("clas", "boarding_pass", "id", id));
        info.put("seat_num", db.selectString("seat_num", "boarding_pass", "id", id));

        boardingPassesInfo.add(info);
    }
    
        

    db.closeConnection();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Sign Up</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Catamaran" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>

        <div class="title-top">
            <a class="title" href="index.html"><h1>Iowa Air</h1></a>
            <a class="links" href="logIn.jsp" ><h2>Log In</h2></a>
            <h3>|</h3>
            <a class="links" href="signUp.jsp" ><h2>Sign Up</h2></a>
        </div>

        <div class="middle">
            <h1>View Boarding Passes</h1>
            <div class="boardingPass">
            <% for(HashMap bpInfo : boardingPassesInfo){ %>
            
            <table>
                <tr class="bigheader">
                    <th>Iowa Air</th>
                    <th class="name"><%=bpInfo.get("passenger_name") %></th>
                    <th><%=bpInfo.get("origin") %> --> <%=bpInfo.get("destination") %></th>
                    
                </tr>
                <tr>
                    <td>   </td>
                    <td>   </td>
                    <td>    </td>
                    <td rowspan="4"><img src="barcode.jpg" alt="" height=220 width=75></img></td>
                </tr>
                <tr class="header">
                    <td class="header">Flight</td>
                    <td class="header">Boarding Time</td>
                    <td class="header">Seat</td>
                </tr>
                
                <tr>
                    <td><%=bpInfo.get("flight_num") %></td>
                    <td><%=bpInfo.get("boarding_time") %></td>
                    <td><%=bpInfo.get("seat_num") %></td>
                </tr>
                <tr>
                    <td><%=bpInfo.get("flight_date") %></td>
                    <td>Depart <%=bpInfo.get("departure_time") %></td>
                    <td>Arrive <%=bpInfo.get("arrival_time") %></td>
                </tr>

            </table>
            
            
            <% } %>
            
            
            </div>
            
            <div class="clear"></div> 
        </div>
    </body>
</html>