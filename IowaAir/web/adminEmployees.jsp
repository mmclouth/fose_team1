<%--
    Document   : adminEmployees
    Created on : Feb 16, 2017, 9:39:20 PM
    Author     : kenziemclouth
--%>

<%@page import="dbResources.LoginValidation"%>
<%@page import="dbResources.SendMail"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database.User_Types"%>
<%@page import="dbResources.Database"%>
<%

    Database db = new Database();

    boolean successfullyAdded = false;

    String firstName = null, lastName = null, email = null, gender = null, birthday = null, error = null;

    //Retrieve parameters from request if they have been sent from previous page
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
        if (!birthday.matches("^(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$")) {

            String[] bdaySplit = birthday.split("/");
            String month = bdaySplit[0];
            String day = bdaySplit[1];
            String year = bdaySplit[2];

            birthday = year + "-" + month + "-" + day;

        }
    }

    if (firstName != null && lastName != null && email != null) {

        SendMail mailer = new SendMail(email);
        //This will generate and return a random password;
        String randomPassword = mailer.send(false);

        //TODO: only add user to database if email is sent successfully
        error = db.addUserToDatabase(firstName, lastName, email, User_Types.employee, birthday, gender, randomPassword, null);
        LoginValidation user = new LoginValidation(email, randomPassword);
        user.setValidationStatus(true);

        if (error == null) {
            successfullyAdded = true;
        }
    }

    //Retrieve all employee data from the database in order to display in the employee table on this apge
    ArrayList<HashMap<String, String>> employeeData = db.getAllEmployeeData();

    //close database connection
    db.closeConnection();

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
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"> ><h2>Log Out</h2></a>
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
                <li><a href="adminAirplanes.jsp">Airplanes</a></li>
                <li><a href="adminAirports.jsp">Airports</a></li>
                <li><a class="active" href="adminEmployees.jsp">Employees</a></li>
            </ul>  
        </div>

        <div class="middle">
            <h1>Admin Employees Page</h1>

            <% if (error == null) {

                    //if employee was successfully added to DB, display good message.  If not, display the error code in red
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

                    <!- Loop through each employee record and output each field in correct able column ->
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

        <% }%>

    </body>
</html>
