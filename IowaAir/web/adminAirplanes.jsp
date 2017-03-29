<%-- 
    Document   : adminAirplanes
    Created on : Feb 16, 2017, 9:39:31 PM
    Author     : kenziemclouth
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%@page import="java.util.HashMap"%>
<%
    Database db = new Database();
    
    String planeName = null;
    int downTime = 0;
    int capacityTotal = 0;
    int capacityFirstClass = 0;
    int capacityEconomy = 0;
    int seatsPerRow = 0;
    String aircraftNum = null;
    
    
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
        aircraftNum = request.getParameter("airplaneNum").toString();
    }
    if(planeName != null && downTime != 0 && capacityTotal != 0 && capacityFirstClass != 0 && capacityEconomy != 0 && seatsPerRow != 0 
            && aircraftNum != null)
    {
        db.addAircraftType(planeName,downTime,capacityTotal,capacityFirstClass,capacityEconomy,seatsPerRow);
        int aircraftTypeID = db.findAircraftTypeID(planeName);
        db.addAirplane(aircraftTypeID,aircraftNum);
        
    }
    
    int aircraftTypeID = db.findAircraftTypeID("ERJ-140");
    int airplaneID = db.findAirplaneID("PL50001");
    session.setAttribute("planeName",db.selectString("plane_name","aircraft_type","id",Integer.toString(aircraftTypeID)));
    session.setAttribute("downTime",db.selectString("down_time","aircraft_type","id",Integer.toString(aircraftTypeID)));
    session.setAttribute("capacityTotal",db.selectString("capacity_total","aircraft_type","id",Integer.toString(aircraftTypeID)));
    session.setAttribute("capacityFirstClass",db.selectString("capacity_first_class","aircraft_type","id",Integer.toString(aircraftTypeID)));
    session.setAttribute("capacityEconomy",db.selectString("capacity_economy","aircraft_type","id",Integer.toString(aircraftTypeID)));
    session.setAttribute("seatsPerRow",db.selectString("seats_per_row","aircraft_type","id",Integer.toString(aircraftTypeID)));
    session.setAttribute("airplaneNum", db.selectString("num","airplane","id",Integer.toString(airplaneID)));
    
    
    ArrayList<HashMap<String, String>> aircraftData = db.getAllAircraftData();
    

    //close database connection
    db.closeConnection();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Admin Airplanes</title>
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

        <% } else {%>

        <div class="title-top">
            <a class="title" href="<%= session.getAttribute("homePage")%>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName")%>'s Profile</h4></a>
        </div>

        <% } %>

        <% if(session.getAttribute("user_type") == null || !session.getAttribute("user_type").equals("admin")){ %>

        <div class="middle">
            <h2 class="failure">You do not have permission to view this page.  Sign in as admin to view.</h2>
        </div>

        <% } else { %>

        <div class="admin-toolbar">
            <ul>
                <li><a href="adminLanding.jsp">Home</a></li>
                <li><a href="adminFlights.jsp">Flights</a></li>
                <li><a class="active" href="adminAirplanes.jsp">Airplanes</a></li>
                <li><a href="adminAirports.jsp">Airports</a></li>
                <li><a href="adminEmployees.jsp">Employees</a></li>
            </ul>  
        </div>

        <div class="middle">
            <h1>Admin Airplanes</h1>
            <form action="adminAirplanes.jsp" method="post">
                <h2>Add New Aircraft</h2>
                Airplane Number:
                <input type="text" name="airplaneNum" required><br>
                Name of Aircraft:
                <input type="text" name="planeName" required><br>
                Down time between flights (hrs):
                <input type="number" name="downTime" required><br>
                Total Capacity:
                <input type="number" name="capacityTotal" required><br>
                First Class Capacity:
                <input type="number" name="capacityFirstClass" required><br>
                Economy Capacity:
                <input type="number" name="capacityEconomy" required><br>
                Seats Per Row:
                <input type="number" name="seatsPerRow" required><br>
                <input type="submit" value="Add Aircraft"><br>
                <a href="modifyAircraft.jsp">Modify Aircraft</a><br>
            </form>
        </div>
        
        <div class="employee-table">

                <h2>Current Aircrafts</h2>

                <table>
                    <tr>
                        <th>Plane Name</th>
                        <th>Down Time</th>
                        <th>Total Capacity</th>
                        <th>First Class Capacity</th>
                        <th>Economy Capacity</th>
                        <th>Seats Per Row</th>
                        <th>Aircraft Type ID</th>
                        <th>Aircraft Number</th>
                        <th></th>
                    </tr>

                    <!- Loop through each employee record and output each field in correct able column ->
                    <% for (HashMap<String, String> record : aircraftData) {%>
                    <tr>
                        <td><input type="text" value="<%= record.get("plane_name")%>"></td>
                        <td><input type="text" value="<%= record.get("down_time")%>"></td>
                        <td><input type="text" value="<%= record.get("capacity_total")%>"></td>
                        <td><input type="text" value="<%= record.get("capacity_first_class")%>"></td>
                        <td><input type="text" value="<%= record.get("capacity_economy")%>"></td>
                        <td><input type="text" value="<%= record.get("seats_per_row")%>"></td>
                        <td><input type="text" value="<%= record.get("aircraft_type_id")%>"></td>
                        <td><input type="text" value="<%= record.get("num")%>"></td>
                        <td><input type="button" value="Update"></td>
                    </tr>

                    <% }%>

                </table>

            </div>


        <% }%>



    </body>
</html>
