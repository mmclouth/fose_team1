<%-- 
    Document   : forgotPassword
    Created on : Feb 18, 2017, 4:35:24 PM
    Author     : Kyle Anderson
--%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="dbResources.Database.User_Types"%>
<%@page import="dbResources.SendMail"%>
<%@page import="dbResources.LoginValidation"%>
<%@page import="dbResources.Database"%>

<%String result = "failed";
    boolean mailSuccess = false;
    String errorMessage = null;

    Database db = new Database();

    boolean successfullyValidated = false;

    String email = null;

    if (request.getParameter("email") != null) {
        email = request.getParameter("email");
    }

    //if all required fields have been set
    if (email != null) {

        boolean allFieldsValid = true;
        errorMessage = "";

        //check to see if email is already in use
        if (db.emailAlreadyUsed(email)) 
        {
            
        }
        else
        {
            errorMessage = errorMessage + "Email does not exist. <br>";
            allFieldsValid = false;
        }

        SendMail mailer = new SendMail(email);
        if (allFieldsValid) {
            
            errorMessage = null;
            
            try {
                //TODO: create a separate email for forgotten password.
                //send e-mail
                String password = mailer.send(true);
                int userId = db.findUserId(email);
                db.updatePassword(userId, password);
                //TODO: generate random confirmation code and assign it to current user in db.  Send this code in email.
                // not sure if someone else has already done this.  -Kenzie
                //redirect to signUpConfirmation with necessary fields
                session.setAttribute("emailForConfCode", email);
                session.setAttribute("passwordForConfCode", password);
                response.sendRedirect("/IowaAir/logIn.jsp");

            } catch (MessagingException mex) {
                mailSuccess = false;
            }
        }
    }

    db.closeConnection();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Forgot Password</title>
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
            
            <% if (session.getAttribute("validation_status") != null && session.getAttribute("validation_status").equals("0")) { %>
            <div class="validate_account_bar">
                <h10>  You have not validated your account yet.  <a href="signUpConfirmation.jsp">Click here</a> to enter your confirmation code.</h10>
            </div>
            <% } %>
            
            <a class="title" href="<%= session.getAttribute("homePage") %>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"> ><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName") %>'s Profile</h4></a>
        </div>
        
        <% } %>

        <div class="body">
            <h1>Forgot Password</h1>
            <form action="forgotPassword.jsp" method="post">    
                Enter your e-mail in the field below. A new temporary password 
                will be sent to this account. Please use the password to log in 
                and then navigate to your user profile to reset your password.
                <br>
                E-Mail:
                <input type="text" name="username"><br>
                <% if (errorMessage != null) {%>

            <div style="color:red">
                 Email does not exist in our database.
            </div>

            <% }%>
                <input type="submit" value="Reset Password"><br>
                
        </div>

    </body>
</html>
