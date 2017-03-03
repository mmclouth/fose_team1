<%-- 
    Document   : signUp
    Created on : Feb 16, 2017, 9:01:21 PM
    Author     : kenziemclouth
--%>

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
            <form action="signUpConfirmation.jsp">    
                First name:  
                <input type="text" name="firstname" required><br>
                Last name:  
                <input type="text" name="lastname" required><br>
                Gender:
                <input type="radio" name="gender" value="male" checked> Male
                <input type="radio" name="gender" value="female"> Female
                <input type="radio" name="gender" value="other"> Other <br>
                Birthday: 
                <!-- 
                Birthday: 
                type "data" not being recognized, HTML5 problem??
                <input type="date" name="bday" required> <br>
                -->
                E-Mail:  
                <!-- the type can be "email here" if JSP supports HTML5 -->
                <input type="text" name ="username" required> <br> 
                Password: 
                <input type="password" name ="password" required> <br>
                Confirm Password:  
                <input type="password" name ="confPassword" required> <br>
                <input type="submit" value="Sign Up"><br>
                Already have an account? 
                <a href="logIn.jsp">Log In</a><br>
                <a href="forgotPassword.jsp">Forgot Password</a>
                
        </div>

    </body>
</html>
