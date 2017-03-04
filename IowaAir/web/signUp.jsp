<%-- 
    Document   : signUp
    Created on : Feb 16, 2017, 9:01:21 PM
    Author     : kenziemclouth
--%>

<%@page import="javax.mail.MessagingException"%>
<%@page import="dbResources.Database.User_Types"%>
<%@page import="dbResources.SendMail"%>
<%@page import="dbResources.MD5Hashing"%>
<%@page import="dbResources.LoginValidation"%>
<%@page import="dbResources.Database"%>
<%
    String result = "failed";
    boolean mailSuccess = false;
    String errorMessage = null;

    Database db = new Database();

    boolean successfullyValidated = false;

    String firstName = null, lastName = null, email = null, gender = null, birthday = null, error = null, password = null, confPassword = null;
    String confirm = null;

    //Retrieve parameters from request if they have been sent from previous page
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

    //if all required fields have been set
    if (firstName != null && lastName != null && email != null && password != null && confPassword != null) {

        boolean allFieldsValid = true;
        errorMessage = "";

        //check to see if email is already in use
        if (db.emailAlreadyUsed(email)) {
            errorMessage = errorMessage + "Email is already assigned to an account. <br>";
            allFieldsValid = false;
        }
        //ensure that valid password was entered
        if (!LoginValidation.verifyNewPassword(password)) {
            errorMessage = errorMessage + "Password does not meet requirements. <br>";
            allFieldsValid = false;
        }
        //ensure passwords match
        if (!password.equals(confPassword)) {
            errorMessage = errorMessage + "Passwords do not match.<br>";
            allFieldsValid = false;
        }

        SendMail mailer = new SendMail(email);
        if (allFieldsValid) {
            
            errorMessage = null;
            
            try {
                //send e-mail
                mailer.send();

                //add user to database
                db.addUserToDatabase(firstName, lastName,
                        email, User_Types.customer, null, gender, password);

                //TODO: generate random confirmation code and assign it to current user in db.  Send this code in email.
                // not sure if someone else has already done this.  -Kenzie
                //redirect to signUpConfirmation with necessary fields
                session.setAttribute("emailForConfCode", email);
                session.setAttribute("passwordForConfCode", password);
                response.sendRedirect("/IowaAir/signUpConfirmation.jsp");

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
        <title>Iowa Air: Sign Up</title>
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
            <h1>Sign Up Page</h1>

            <% if (errorMessage != null) {%>

            <h2 class="failure"><%= errorMessage%></h2> <br>

            <% }%>

            <div class="form-block">


                <form action="signUp.jsp" method="post">    
                    First name:  
                    <input type="text" name="firstName" required><br>
                    Last name:  
                    <input type="text" name="lastName" required><br>
                    Gender:
                    <input type="radio" name="gender" value="male" checked> Male
                    <input type="radio" name="gender" value="female"> Female
                    <input type="radio" name="gender" value="other"> Other <br>
                    Birthday (mm/dd/yyyy): 
                    <input type="date" name="bday" > <br>
                    E-Mail:  
                    <!-- the type can be "email here" if JSP supports HTML5 -->
                    <input type="text" name ="email" required> <br> 
                    Password: 
                    <input type="password" name ="password" required> <br>
                    Confirm Password:  
                    <input type="password" name ="confPassword" required> <br>
                    <input type="submit" value="Sign Up"><br>
                    Already have an account? 
                    <a href="logIn.jsp">Log In</a><br>
                    <a href="forgotPassword.jsp">Forgot Password</a>
            </div>
        </div>

    </body>
</html>
