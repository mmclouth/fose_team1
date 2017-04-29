<%-- 
    Document   : changePassword
    Created on : Feb 16, 2017, 9:10:00 PM
    Author     : kenziemclouth
--%>
<%@page import="dbResources.LoginValidation"%>
<%@page import="dbResources.Database"%>

<%
    String errorMessage = null;

    Database db = new Database();
    
    String email = null;
    String oldPassword = null;
    String newPassword = null;
    String confirmNewPassword = null;
    
    if (request.getParameter("oldPassword") != null) 
    {
        oldPassword = request.getParameter("oldPassword");
    }
    if (request.getParameter("newPassword")!= null)
    {
        newPassword = request.getParameter("newPassword");
    }
    if (request.getParameter("confirmNewPassword")!= null)
    {
        confirmNewPassword = request.getParameter("confirmNewPassword");
    }
    if (request.getParameter("email")!= null)
    {
        email = request.getParameter("email");
    }
    

    if (oldPassword != null && newPassword != null && confirmNewPassword != null && email != null)
    {
        errorMessage = "";
        boolean passwordValid = false;
        boolean correctOldPassword = false;
     
        int userID = db.findUserId(email);
        correctOldPassword = db.isPasswordCorrect(oldPassword, userID);
        if (correctOldPassword)
        {
            if (!(newPassword.equals(oldPassword)))
            {
                if (newPassword.equals(confirmNewPassword))
                {
                    if(LoginValidation.verifyNewPassword(newPassword))
                    {
                        passwordValid = true;
                    }
                    else
                    {
                        errorMessage = errorMessage + " Password does not meet criteria of one capital, one lowercase, one number and at least 8 characters long.";
                    }
                }
                else
                {
                    errorMessage = errorMessage + "New Password does not match the confirmNewPassword.";
                }
            }
            else
            {
                errorMessage = errorMessage + "New password must differ by at least one character from old password";
            }
        }
        else
        {
            errorMessage = errorMessage + "The oldPassword entered is incorrect.";
        }
        if (passwordValid)
        {
            db.updatePassword(userID, newPassword);
            response.sendRedirect("/IowaAir/index.html");
        }
    }
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Change Password</title>
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
                <li><a href="userBookingHistory.jsp">My Booking History</a></li>
                <li><a class="active" href="changePassword.jsp">Change My Password</a></li>
            </ul>  
        </div>

        <div class="middle">
            
            <h1>Change Password Page</h1>
            
            <% if (errorMessage != null) {%>

            <h2 class="failure"><%= errorMessage%></h2> <br>

            <% }%>
            <form action="changePassword.jsp" method="post">    
                <br>
                
                Email:
                <input type="text" name="email"><br>
                Old Password:
                <input type="password" name="oldPassword"><br>
                New Password:
                <input type="password" name="newPassword"><br>
                Confirm New Password
                <input type="password" name="confirmNewPassword"><br>
                <input type="submit" value="Update Password"><br>
        </div>

    </body>
</html>
