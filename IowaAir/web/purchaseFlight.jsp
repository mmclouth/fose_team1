<%-- 
    Document   : purchaseFlight
    Created on : Apr 2, 2017, 5:54:46 PM
    Author     : Kyle Anderson
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Purchase Flight</title>
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
        
        <div class="middle">
            In order to purchase your flight, you must be signed into your account.
            Please click here to
            <a class="links" href="signUp.jsp" >sign up</a> or 
            <a class="links" href="logIn.jsp" >log in.</a> 
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
        
        <div class="middle">
            <h1>Purchase Flight</h1>
            <form action="home.jsp" method="post">
                    Credit card number: 
                    <input type="text" name="cardNumber" required><br>
                    Expiration date:
                    <input type="date" name="expiration" required> <br>
                    CVV: 
                    <input type="text" name="cvv" required><br>
                    <input type="submit" value="Finalize purchase"><br>
            </form>
        </div>
        <% } %>
    </body>
</html>
