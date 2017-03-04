<%-- 
    Document   : testJSP
    Created on : Feb 8, 2017, 6:22:31 PM
    Author     : kenziemclouth
--%>



<%@page import="dbResources.Database"%>


<%
    
    Database database = new Database();
    
    boolean test = database.tableHasRecords("airplane");
    
    String testString;
    
    if(test){
        testString = "true";
    } else {
        testString = "false";
    }
    
    database.closeConnection();
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>this should say true or false: <%= testString %></h1>
    </body>
</html>
