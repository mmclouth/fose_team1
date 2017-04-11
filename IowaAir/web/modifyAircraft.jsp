<%-- 
    Document   : modifyAircraft
    Created on : Mar 27, 2017, 6:11:17 PM
    Author     : Nickolas
--%>

<%@page import="dbResources.Database"%>
<%
    
    Database db = new Database();
    int aircraftTypeID = Integer.valueOf((String)session.getAttribute("aircraftTypeID"));
    String planeNameOrig = db.getPlaneName(aircraftTypeID);
    int downTimeOrig =  db.getDownTime(aircraftTypeID);
    int capacityTotalOrig =  db.getCapacityTotal(aircraftTypeID);
    int capacityFirstClassOrig =  db.getCapacityFirstClass(aircraftTypeID);
    int capacityEconomyOrig =  db.getCapacityEconomy(aircraftTypeID);
    int seatsPerRowOrig =  db.getSeatsPerRow(aircraftTypeID);
    String airplaneNumOrig =  (String)session.getAttribute("airplaneNumber");
    
    if(request.getParameter("newAirplaneNum") != null && request.getParameter("newPlaneName") != null && request.getParameter("newDownTime") != null
            && request.getParameter("newCapacityTotal")!= null && request.getParameter("newCapacityFirstClass") != null && request.getParameter("newCapacityEconomy") != null && request.getParameter("newSeatsPerRow") != null)
    {
       db.updateAircraftType(aircraftTypeID,request.getParameter("newPlaneName"),Integer.valueOf(request.getParameter("newDownTime")),Integer.valueOf(request.getParameter("newCapacityTotal")),
                Integer.valueOf(request.getParameter("newCapacityFirstClass")),Integer.valueOf(request.getParameter("newCapacityEconomy")),Integer.valueOf(request.getParameter("newSeatsPerRow")));
       db.updateAirplane(aircraftTypeID,request.getParameter("newAirplaneNum"));
       response.sendRedirect("/IowaAir/adminAirplanes.jsp");
    }
    

    //close database connection
    db.closeConnection();
    
%>

<script>
function updateFunction() {  
    
    document.getElementById("newAirplaneNumID").value = document.getElementById("airplaneNumID").value;
    
    document.getElementById("newPlaneNameID").value = document.getElementById("planeNameID").value;
    
    document.getElementById("newDownTimeID").value = document.getElementById("downTimeID").value;
    
    document.getElementById("newCapacityTotalID").value = document.getElementById("capacityTotalID").value;
    
    document.getElementById("newCapacityFirstClassID").value = document.getElementById("capacityFirstClassID").value;
    
    document.getElementById("newCapacityEconomyID").value = document.getElementById("capacityEconomyID").value;
    
    document.getElementById("newSeatsPerRowID").value = document.getElementById("seatsPerRowID").value;
}
</script>
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
            <input type="text" name="airplaneNum" id="airplaneNumID" value="<%=airplaneNumOrig%>" required><br>
            <input type="hidden" name="newAirplaneNum" id="newAirplaneNumID" >
            Name of Aircraft:
            <input type="text" name="planeName" id="planeNameID" value="<%=planeNameOrig%>" required><br>
            <input type="hidden" name="newPlaneName" id="newPlaneNameID" >
            Down time between flights (mins):
            <input type="number" name="downTime" id="downTimeID" value="<%=downTimeOrig%>" required><br>
            <input type="hidden" name="newDownTime" id="newDownTimeID" >
            Total Capacity:
            <input type="number" name="capacityTotal" id="capacityTotalID" value="<%=capacityTotalOrig%>" required><br>
            <input type="hidden" name="newCapacityTotal" id="newCapacityTotalID" >
            First Class Capacity:
            <input type="number" name="capacityFirstClass" id="capacityFirstClassID" value="<%=capacityFirstClassOrig%>" required><br>
            <input type="hidden" name="newCapacityFirstClass" id="newCapacityFirstClassID" >
            Economy Capacity:
            <input type="number" name="capacityEconomy" id="capacityEconomyID" value="<%=capacityEconomyOrig%>" required><br>
            <input type="hidden" name="newCapacityEconomy" id="newCapacityEconomyID" >
            Seats Per Row:
            <input type="number" name="seatsPerRow" id="seatsPerRowID" value="<%=seatsPerRowOrig%>" required><br>
            <input type="hidden" name="newSeatsPerRow" id="newSeatsPerRowID" >
            
            <input type="submit" value="Modify Aircraft" onclick="updateFunction()" ><br>
            <a href="adminAirplanes.jsp">Go Back</a><br>
            </form>

            </div>
        
        <% } %>

    </body>
</html>
