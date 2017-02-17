<%-- 
    Document   : logIn
    Created on : Feb 16, 2017, 9:01:14 PM
    Author     : kenziemclouth
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Log In</title>
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
            <h1>Log In Page</h1>
            
            <form action="index.html">             
                Username:
                <input type="text" name ="username"> <br> 
                Password: 
                <input type="password" name ="password"> <br>
                <input type="submit" value="Log in">
        </div>

    </body>
</html>
