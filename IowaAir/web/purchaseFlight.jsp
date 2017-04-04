<%-- 
    Document   : purchaseFlight
    Created on : Apr 2, 2017, 5:54:46 PM
    Author     : Kyle Anderson
--%>
<%@page import="dbResources.Database"%>
<%@page import="java.util.Map"%>
<%  Map<String,String[]> parameters = request.getParameterMap();
    //String[] price = parameters.get("price");
    
    String cardNum = null, cvv = null, price = null;
    
    //Retrieve parameters from request if they have been sent from previous page
    if (request.getParameter("price") != null) {
        price = request.getParameter("price");
    }
    if (request.getParameter("cardNumber") != null) {
        cardNum = request.getParameter("cardNumber");
    }
    if (request.getParameter("cvv") != null) {
        cvv = request.getParameter("lastName");
    }
    
    
    Database db = new Database();
    String errorMessage = null;
%>



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
        
        <% if (errorMessage != null) {%>

            <h2 class="failure"><%= errorMessage%></h2> <br>

        <% }%>
        
        <div class="middle">
            <form action="purchaseFlight.jsp" method="post">
                <h1>Purchase Flight</h1>
                <h3> Total Price $<%=price%> </h3>
                <input type="hidden" name="price">
                
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
