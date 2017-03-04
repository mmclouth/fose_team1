<%-- 
    Document   : logIn
    Created on : Feb 16, 2017, 9:01:14 PM
    Author     : kenziemclouth
--%>

<%@page import="dbResources.Database"%>
<%@page import="dbResources.LoginValidation"%>
<%@page import="java.sql.SQLException"%>
<%
    String username = null;
    String password = null;
    boolean error = false;
    boolean correctPassword = false;
    if (request.getParameter("username") != null)
    {
        username = request.getParameter("username");
    }
    if (request.getParameter("password") != null)
    {
        password = request.getParameter("password");
    }
    if (username != null && password != null)
    {
        try 
        {
            LoginValidation login = new LoginValidation(username,password);
            
            int userId = login.findUserId();
            correctPassword = login.isPasswordCorrect(userId);
            if(correctPassword)
            {
                String userType = login.getUserType(userId);
                
                Database db = new Database();
                
                session.setAttribute("userID", userId);
                session.setAttribute("userFirstName", db.selectString("first_name", "userr", "id", Integer.toString(userId)));
                session.setAttribute("userLastName", db.selectString("last_name", "userr", "id", Integer.toString(userId)));
                session.setAttribute("user_type", userType);
                
                db.closeConnection();

                if (userType.equals("admin"))
                {
                    session.setAttribute("homePage", "adminLanding.jsp");
                    response.sendRedirect("/IowaAir/adminLanding.jsp");
                }
                else if(userType.equals("customer"))
                {
                    session.setAttribute("homePage", "homePage.jsp");
                    response.sendRedirect("/IowaAir/homePage.jsp");
                }
                else if(userType.equals("employee"))
                {
                    session.setAttribute("homePage", "employeeLanding.jsp");
                    response.sendRedirect("/IowaAir/employeeLanding.jsp");
                }    
            }
            else
            {
                error = true;
            }
            login.closeConnection();
            
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
    }





%>



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
            
            <form action="logIn.jsp" method="post">             
                Username:
                <input type="text" name ="username"> <br> 
                Password: 
                <input type="password" name ="password"> <br>
                <% if(error)
                {
                    if(!correctPassword)
                    {%>
                    <div style="color:red">
                        Invalid username or password entered.
                    </div>
                    <%}
                }%>
                <input type="submit" value="Log in"> <br>
                New User? 
                <a href="signUp.jsp">Sign Up</a><br>
                <a href="forgotPassword.jsp">Forgot Password</a>
        </div>

    </body>
</html>
