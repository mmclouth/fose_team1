<%-- 
    Document   : signUpConfirmation
    Created on : Feb 20, 2017, 7:56:18 PM
    Author     : Kyle Anderson
--%>

<%@page import="dbResources.Database.User_Types"%>
<%@page import="dbResources.Database"%>
<%@page import="dbResources.LoginValidation"%>
<%@page import="dbResources.MD5Hashing"%>
<%@page import="dbResources.SendMail"%>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
    String result = "failed";
    boolean success = false;
    
    Database db = new Database();

    boolean successfullyValidated = false;

    String firstName = null, lastName = null, email = null, gender = null, birthday = null, error = null, password = null, confPassword = null;
    String confirm = null;

    if (request.getParameter("confirm") != null) {
        confirm = request.getParameter("confirm");
    }
    if (request.getParameter("firstName") != null) {
        firstName = request.getParameter("firstName");
    }
    if (request.getParameter("lastName") != null) {
        lastName = request.getParameter("lastName");
    }
    if (request.getParameter("email") != null) {
        email = request.getParameter("email");
    }
    if (request.getParameter("password") != null) {
        password = request.getParameter("password");
    }
    if (request.getParameter("confPassword") != null) {
        confPassword = request.getParameter("confPassword");
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

    if (confirm != null) {
        LoginValidation user = new LoginValidation(email, password);

        if (user.isConfirmationCodeCorrect(confirm)) {
            user.setValidationStatus(true);
            successfullyValidated = true;
        }
    } else {

        //ensure that valid password was entered
        if (LoginValidation.verifyNewPassword(password)) {
            if (password.equals(confPassword)) {
                result = MD5Hashing.encryptString(password);
                success = true;
            }
        }
        SendMail mailer = new SendMail(email);
        if (success) {
            try {
                //send e-mail
                mailer.send();

                db.addUserToDatabase(firstName, lastName,
                        email, User_Types.customer, null, gender, password);
            } catch (MessagingException mex) {
                success = false;
            }
        }
    }
    
//TODO: CLOSE DB CONNECTION
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Confirmation</title>
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
            <h1>Confirmation</h1>
            
            <% if(successfullyValidated){ %>
            
            <h2> You have successfully validated your account.  Proceed to <a href=logIn.jsp >Log In</a>.</h2>
            
                
            <% } else {  %>
            
            <% if(true)
            {
            %>
            <%
                out.println("Result: " + result + "\n");
            %>
            <form action="signUpConfirmation.jsp" method="post"> 
                A confirmation link has been sent to your e-mail. Please enter
                the confirmation code provided in the e-mail into the field 
                below.
                Confirmation code:
                <input type="text" value="confirm" name="confirm"><br>
                <input type="hidden" value="<%= email %>" name="email">
                <input type="hidden" value="<%= password %>" name="password">
                <input type="submit" value="Confirm"> <br>
                
            <% } else { %>
                ERROR! There was a problem with the e-mail address you provided.
                Please click the link below to return to the sign up page and 
                enter a valid e-mail.
                <a href="signUp.jsp">Return to Sign Up Page</a><br>
            <% } 
            
            }%>
        </div>

    </body>
</html>
