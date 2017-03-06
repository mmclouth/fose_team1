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
    Database db = new Database();

    boolean successfullyValidated = false;

    String confirm = null, email = null, password=null;

    //Retrieve parameters from request if they have been sent from previous page
    if (request.getParameter("confirm") != null) {
        confirm = request.getParameter("confirm");
    }
    
    //retrieve email and password from session to use for LoginValidation object
    email = session.getAttribute("emailForConfCode").toString();
    password = session.getAttribute("passwordForConfCode").toString();
    
    
    //if confirm is not null, this means the user just tried to enter a confirmation code
    if (confirm != null) {
        LoginValidation user = new LoginValidation(email, password);

        //if the code matches the user's assigned confirmation_code, set user's validation_status to true
        if (user.isConfirmationCodeCorrect(confirm)) {
            user.setValidationStatus(true);
            successfullyValidated = true;
        }
    } 
    
    db.closeConnection();
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
