<%-- 
    Document   : modifyAircraft
    Created on : Mar 27, 2017, 6:11:17 PM
    Author     : Nickolas
--%>

<%@page import="dbResources.Database"%>
<%
    
    Database db = new Database();
    int aircraftTypeID = db.findAircraftTypeID("ERJ-140");
    int airplaneID = db.findAirplaneID("PL50001");
    String planeNameOrig = (String)session.getAttribute("planeName");
    int downTimeOrig = Integer.valueOf((String)session.getAttribute("downTime"));
    int capacityTotalOrig = Integer.valueOf((String)session.getAttribute("capacityTotal"));
    int capacityFirstClassOrig = Integer.valueOf((String)session.getAttribute("capacityFirstClass"));
    int capacityEconomyOrig = Integer.valueOf((String)session.getAttribute("capacityEconomy"));
    int seatsPerRowOrig = Integer.valueOf((String)session.getAttribute("seatsPerRow"));
    String airplaneNumOrig = (String)session.getAttribute("airplaneNum");
    
    String planeName = null;
    int downTime = 0;
    int capacityTotal = 0;
    int capacityFirstClass = 0;
    int capacityEconomy = 0;
    int seatsPerRow = 0;
    String airplaneNum = null;
    
    
    //Retrieve parameters from request if they have been sent from previous page
    if (request.getParameter("planeName") != null) {
        planeName = request.getParameter("planeName");
    }
    if (request.getParameter("downTime") != null) {
        downTime = Integer.valueOf(request.getParameter("downTime"));
    }
    if (request.getParameter("capacityTotal") != null) {
        capacityTotal = Integer.valueOf(request.getParameter("capacityTotal"));
    }
    if (request.getParameter("capacityFirstClass") != null) {
        capacityFirstClass = Integer.valueOf(request.getParameter("capacityFirstClass"));
    }
    if (request.getParameter("capacityEconomy") != null) {
        capacityEconomy = Integer.valueOf(request.getParameter("capacityEconomy"));
    }
    if (request.getParameter("seatsPerRow") != null) {
        seatsPerRow = Integer.valueOf(request.getParameter("seatsPerRow"));
    }
    if (request.getParameter("airplaneNum") != null) {
        airplaneNum = request.getParameter("airplaneNum").toString();
    }
    
    if(planeName != null && downTime != 0 && capacityTotal != 0 && capacityFirstClass != 0 && capacityEconomy != 0 && seatsPerRow != 0 
            && airplaneNum != null)
    {
        if(!(planeNameOrig.equals(request.getParameter("planeName"))))
        {
            db.updateAircraftTypePlaneName(request.getParameter("planeName"),aircraftTypeID);
        }
        if(downTimeOrig != (Integer.parseInt(request.getParameter("downTime"))))
        {
            db.updateAircraftTypeDownTime(Integer.parseInt(request.getParameter("downTime")),aircraftTypeID);
        }
        if(capacityTotalOrig != (Integer.parseInt(request.getParameter("capacityTotal"))))
        {
            db.updateAircraftTypeCapacityTotal(Integer.parseInt(request.getParameter("capacityTotal")),aircraftTypeID);
        }
        if(capacityFirstClassOrig != (Integer.parseInt(request.getParameter("capacityFirstClass"))))
        {
            db.updateAircraftTypeCapacityFirstClass(Integer.parseInt(request.getParameter("capacityFirstClass")),aircraftTypeID);
        }
        if(capacityEconomyOrig != (Integer.parseInt(request.getParameter("capacityEconomy"))))
        {
            db.updateAircraftTypeCapacityEconomy(Integer.parseInt(request.getParameter("capacityEconomy")),aircraftTypeID);
        }
        if(seatsPerRowOrig != (Integer.parseInt(request.getParameter("seatsPerRow"))))
        {
            db.updateAircraftTypeSeatsPerRow(Integer.parseInt(request.getParameter("seatsPerRow")),aircraftTypeID);
        }
        if(!(airplaneNumOrig.equals(request.getParameter("airplaneNum"))))
        {
            db.updateAirplaneNum(request.getParameter("airplaneNum"),aircraftTypeID);
        }
        response.sendRedirect("/IowaAir/adminAirplanes.jsp");
    }
    

    //close database connection
    db.closeConnection();
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Modify Aircraft</title>
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
            
            <h1>Modify Aircraft Page</h1>

            <form action="modifyAircraft.jsp" method="post" ><br>
            Airplane Number:
            <input type="text" name="airplaneNum" value="<%=session.getAttribute("airplaneNum")%>" required><br>
            Name of Aircraft:
            <input type="text" name="planeName" value="<%=session.getAttribute("planeName")%>" required><br>
            Down time between flights (hrs):
            <input type="number" name="downTime" value="<%=session.getAttribute("downTime")%>" required><br>
            Total Capacity:
            <input type="number" name="capacityTotal" value="<%=session.getAttribute("capacityTotal")%>" required><br>
            First Class Capacity:
            <input type="number" name="capacityFirstClass" value="<%=session.getAttribute("capacityFirstClass")%>" required><br>
            Economy Capacity:
            <input type="number" name="capacityEconomy" value="<%=session.getAttribute("capacityEconomy")%>" required><br>
            Seats Per Row:
            <input type="number" name="seatsPerRow" value="<%=session.getAttribute("seatsPerRow")%>" required><br>
            
            <input type="submit" value="Modify Aircraft"><br>
            <a href="deleteAircraft.jsp">Delete Aircraft</a><br>
            </form>

            </div>
        
        <% } %>

    </body>
</html>
