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
    String first = request.getParameter("firstname");
    String last = request.getParameter("lastname");
    String email = request.getParameter("username");
    String password = request.getParameter("password");
    String gender = request.getParameter("gender");
    
    //ensure that valid password was entered
    if(LoginValidation.verifyNewPassword(password)) {
        if(password.equals(request.getParameter("confPassword"))) {
            result = MD5Hashing.encryptString(password);
            success = true;
        }
    }
    SendMail mailer = new SendMail(email);
    if(success) {
        try {
            //send e-mail
            mailer.send();
        } catch (MessagingException mex) {
            success = false;
        }
    }
    /*if(success) {
        Database db = new Database();
        db.addUserToDatabase(first, last,
                email, User_Types.customer, null, gender, password);
    } */
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
                <input type="text" value="confirm"><br>
                
            <% } else { %>
                ERROR! There was a problem with the e-mail address you provided.
                Please click the link below to return to the sign up page and 
                enter a valid e-mail.
                <a href="signUp.jsp">Return to Sign Up Page</a><br>
            <% } %>
        </div>

    </body>
</html>
