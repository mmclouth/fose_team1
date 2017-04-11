<%-- 
    Document   : deleteEmployee
    Created on : Apr 10, 2017, 11:40:53 PM
    Author     : Nickolas
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%
    
    Database db = new Database();
    String employeeEmail = null;
    
    
    //Retrieve parameters from request if they have been sent from previous page
    if (request.getParameter("emailSelected") != null) {
        employeeEmail = request.getParameter("emailSelected");
    }
    
    if(employeeEmail != null)
    {
        int employeeID = db.findUserId(employeeEmail);
        db.deleteEmployee(employeeID);
        
        response.sendRedirect("/IowaAir/adminEmployees.jsp");
    }
    
    ArrayList<String> emails = db.getAllEmployeesEmails();
    //close database connection
    db.closeConnection();
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Delete Employee</title>
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
            
            <h1>Delete Aircraft Page</h1>

            <form action="deleteEmployee.jsp" method="post"><br>
            Select the email of the employee that you would like to delete.<br> 
            <label for="emailSelected">Email:</label>
                <select name="emailSelected" id="emailSelectedID" required>
                    <option value="null">-----</option>
                    <%
                        for(String email : emails){      
                    %>
                    <option value="<%=email%>"><%=email%></option>     
                    
                    <% } %>                  
                </select>    
                <br>
            
            <input type="submit" value="Delete Employee"><br>
            <a href="adminEmployees.jsp">Go Back</a><br>
            </form>

            </div>
        
        <% } %>

    </body>
</html>
