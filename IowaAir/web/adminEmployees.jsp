<%-- 
    Document   : adminEmployees
    Created on : Feb 16, 2017, 9:39:20 PM
    Author     : kenziemclouth
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database.User_Types"%>
<%@page import="dbResources.Database"%>
<%

    Database db = new Database();

    boolean successfullyAdded = false;

    String firstName = null, lastName = null, email = null, gender = null, birthday = null, error = null;

    if (request.getParameter("firstName") != null) {
        firstName = request.getParameter("firstName");
    }
    if (request.getParameter("lastName") != null) {
        lastName = request.getParameter("lastName");
    }
    if (request.getParameter("email") != null) {
        email = request.getParameter("email");
    }
    if (request.getParameter("gender") != null) {
        gender = request.getParameter("gender");
    }
    if (request.getParameter("birthday") != null) {
        birthday = request.getParameter("birthday");
        
        //If browser does not support HTML's date type, format the date string correctly
        if( !birthday.matches("^(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$")){
            
            String[] bdaySplit = birthday.split("/");
            String month = bdaySplit[0];
            String day = bdaySplit[1];
            String year = bdaySplit[2];
            
            birthday = year + "-" + month + "-" + day;

        }
    }

    //TODO: CALL TO METHOD THAT GENERATES RANDOM PASSWORD
    if (firstName != null && lastName != null && email != null) {

        error = db.addUserToDatabase(firstName, lastName, email, User_Types.employee, birthday, gender, "password");

        if (error == null) {
            successfullyAdded = true;
        }
    }

    ArrayList<HashMap<String, String>> employeeData = db.getAllEmployeeData();

%>    

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Admin Employees</title>
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
            <a class="title" href="index.html"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"> ><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName") %>'s Profile</h4></a>
        </div>
        
        <% } %>

        <div class="admin-toolbar">
            <ul>
                <li><a href="adminLanding.jsp">Home</a></li>
                <li><a href="adminFlights.jsp">Flights</a></li>
                <li><a href="adminAirplanes.jsp">Airplanes</a></li>
                <li><a href="adminAirports.jsp">Airports</a></li>
                <li><a class="active" href="adminEmployees.jsp">Employees</a></li>
            </ul>  
        </div>

        <div class="middle">
            <h1>Admin Employees Page</h1>

            <% if (error == null) {

                    if (successfullyAdded) { %>

            <h2 class="success">Employee successfully added.</h2>

                    <% } %> 
                <% } else {%>

            <h2 class="failure">Error code: <%= error%></h2>

            <% } %>
            

            <div class="form-block">

                <h2>Add New Employee: </h2>

                <form action="adminEmployees.jsp" method="post">             
                    <label for="firstName">First Name:</label>
                    <input type="text" name ="firstName"> <br> 

                    <label for="lastName">Last Name:</label>
                    <input type="text" name ="lastName"> <br>

                    <label for="email">Email: </label>
                    <input type="text" name ="email"> <br> 

                    <label for="gender">Gender:</label>
                    <input type="radio" name="gender" value="male" checked> Male
                    <input type="radio" name="gender" value="female"> Female
                    <input type="radio" name="gender" value="other"> Other <br>

                    <label for="birthday">Birthday (mm/dd/yyyy):</label>
                    <input type="date" name ="birthday"> <br> 

                    <input type="submit" value="Add Employee"> <br>
                </form> 
            </div>

            

            <div class="employee-table">

                <h2>Current Employees</h2>
                
                <table>
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Gender</th>
                        <th>Birthday</th>
                        <th>Validated</th>
                    </tr>

                    <% for (HashMap<String, String> record : employeeData) {%>
                    <tr>
                        <td><%= record.get("first_name")%></td>
                        <td><%= record.get("last_name")%></td>
                        <td><%= record.get("email")%></td>
                        <td><%= record.get("gender")%></td>
                        <td><%= record.get("birthday")%></td>
                        <td><%= record.get("validation_status")%></td>
                    </tr>
                    
                    <% }%>

                </table>

            </div>
                    
        </div>    


    </body>
</html>
